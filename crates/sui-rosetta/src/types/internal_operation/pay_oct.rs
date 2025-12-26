// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use async_trait::async_trait;
use serde::{Deserialize, Serialize};
use sui_sdk::SuiClient;
use sui_types::{
    base_types::{ObjectRef, SuiAddress},
    programmable_transaction_builder::ProgrammableTransactionBuilder,
    transaction::{Argument, Command, ObjectArg, ProgrammableTransaction},
};

use super::{
    collect_coins_until_budget_met,
    TransactionObjectData,
    TryConstructTransaction,
    MAX_COMMAND_ARGS,
    MAX_GAS_COINS,
};
use crate::errors::Error;

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct PayOct {
    pub sender: SuiAddress,
    pub recipients: Vec<SuiAddress>,
    pub amounts: Vec<u64>,
}

#[async_trait]
impl TryConstructTransaction for PayOct {
    async fn try_fetch_needed_objects(
        self,
        client: &SuiClient,
        gas_price: Option<u64>,
        budget: Option<u64>,
    ) -> Result<TransactionObjectData, Error> {
        let Self { sender, recipients, amounts } = self;

        let total_amount = amounts.iter().sum::<u64>();
        if let Some(budget) = budget {
            // We have a constant budget, so no need to dry-run
            let all_coins =
                client.coin_read_api().select_coins(sender, None, (total_amount + budget) as u128, vec![]).await?;

            let total_oct_balance = all_coins.iter().map(|c| c.balance).sum::<u64>() as i128;

            let mut iter = all_coins.into_iter().map(|c| c.object_ref());
            let gas_coins: Vec<_> = iter.by_ref().take(MAX_GAS_COINS).collect();
            let extra_gas_coins: Vec<_> = iter.collect();

            return Ok(TransactionObjectData { gas_coins, extra_gas_coins, objects: vec![], total_oct_balance, budget });
        };

        let total_amount = amounts.iter().sum::<u64>();
        let pay_oct_pt =
            |extra_gas_coins: &[ObjectRef]| pay_oct_pt(recipients.clone(), amounts.clone(), extra_gas_coins);
        collect_coins_until_budget_met(client, sender, pay_oct_pt, total_amount, gas_price).await
    }
}

/// Creates the `ProgrammableTransaction` for a pay-oct operation.
/// In case pay-oct needs more than 255 gas-coins to be smashed, it tries to merge the surplus
/// coins into the gas coin as regular transaction inputs - not gas-payment.
/// This approach has the limit at around 1650 coins in total which triggers transaction-size
/// limit (see also test_limit_many_small_coins test).
pub fn pay_oct_pt(
    recipients: Vec<SuiAddress>,
    amounts: Vec<u64>,
    coins_to_merge: &[ObjectRef],
) -> anyhow::Result<ProgrammableTransaction> {
    let mut builder = ProgrammableTransactionBuilder::new();
    if !coins_to_merge.is_empty() {
        // We need to merge the rest of the coins.
        // Each merge has a limit of 511 arguments.
        coins_to_merge.chunks(MAX_COMMAND_ARGS).try_for_each(|chunk| -> anyhow::Result<()> {
            let to_merge = chunk
                .iter()
                .map(|&o| builder.obj(ObjectArg::ImmOrOwnedObject(o)))
                .collect::<Result<Vec<Argument>, anyhow::Error>>()?;
            builder.command(Command::MergeCoins(Argument::GasCoin, to_merge));
            Ok(())
        })?;
    };
    builder.pay_oct(recipients, amounts)?;
    Ok(builder.finish())
}
