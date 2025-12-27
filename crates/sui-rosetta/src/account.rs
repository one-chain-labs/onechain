// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0
//! This module implements the [Mesh Account API](https://docs.cdp.coinbase.com/mesh/mesh-api-spec/api-reference#account)
use axum::{extract::State, Extension, Json};
use axum_extra::extract::WithRejection;
use futures::future::join_all;
use sui_json_rpc_types::StakeStatus;
use sui_sdk::{SuiClient, SUI_COIN_TYPE};
use sui_types::{base_types::SuiAddress, messages_checkpoint::CheckpointSequenceNumber};

use crate::{
    errors::Error,
    types::{
        AccountBalanceRequest,
        AccountBalanceResponse,
        AccountCoinsRequest,
        AccountCoinsResponse,
        Amount,
        Coin,
        CoinID,
        CoinIdentifier,
        Currencies,
        Currency,
        SubAccountType,
        SubBalance,
    },
    OnlineServerContext,
    SuiEnv,
};

/// Get an array of all AccountBalances for an AccountIdentifier and the BlockIdentifier
/// at which the balance lookup was performed.
/// [Mesh API Spec](https://docs.cdp.coinbase.com/api-reference/mesh/account/get-an-account-balance)
pub async fn balance(
    State(ctx): State<OnlineServerContext>,
    Extension(env): Extension<SuiEnv>,
    WithRejection(Json(request), _): WithRejection<Json<AccountBalanceRequest>, Error>,
) -> Result<AccountBalanceResponse, Error> {
    env.check_network_identifier(&request.network_identifier)?;
    let address = request.account_identifier.address;
    let currencies = &request.currencies;

    let checkpoint = get_checkpoint(&ctx).await?;
    let balances = get_balances(&ctx, &request, address, currencies.clone()).await?;

    Ok(AccountBalanceResponse { block_identifier: ctx.blocks().create_block_identifier(checkpoint).await?, balances })
}

async fn get_checkpoint(ctx: &OnlineServerContext) -> Result<CheckpointSequenceNumber, Error> {
    Ok(ctx.client.read_api().get_latest_checkpoint_sequence_number().await?)
}

async fn get_balances(
    ctx: &OnlineServerContext,
    request: &AccountBalanceRequest,
    address: SuiAddress,
    currencies: Currencies,
) -> Result<Vec<Amount>, Error> {
    if let Some(sub_account) = &request.account_identifier.sub_account {
        let account_type = sub_account.account_type.clone();
        get_sub_account_balances(account_type, &ctx.client, address).await
    } else if !currencies.0.is_empty() {
        let balance_futures = currencies.0.iter().map(|currency| {
            let coin_type = currency.metadata.clone().coin_type.clone();
            let client = ctx.client.clone();
            async move { (currency.clone(), get_account_balances(&client, address, &coin_type).await) }
        });
        let balances: Vec<(Currency, Result<i128, Error>)> = join_all(balance_futures).await;
        let mut amounts = Vec::new();
        for (currency, balance_result) in balances {
            match balance_result {
                Ok(value) => amounts.push(Amount::new(value, Some(currency))),
                Err(_e) => {
                    return Err(Error::InvalidInput(format!("{:?}", currency.metadata.coin_type)));
                }
            }
        }
        Ok(amounts)
    } else {
        Err(Error::InvalidInput("Coin type is required for this request".to_string()))
    }
}

async fn get_account_balances(client: &SuiClient, address: SuiAddress, coin_type: &str) -> Result<i128, Error> {
    let response = client.coin_read_api().get_balance(address, Some(coin_type.to_string())).await?;
    Ok(response.total_balance as i128)
}

async fn get_sub_account_balances(
    account_type: SubAccountType,
    client: &SuiClient,
    address: SuiAddress,
) -> Result<Vec<Amount>, Error> {
    let delegated_stakes = client.governance_api().get_stakes(address).await?;

    let mut amounts = Vec::new();
    for stake in delegated_stakes {
        let validator = stake.validator_address;
        for staked in stake.stakes {
            match (&account_type, staked.status) {
                (SubAccountType::Stake, StakeStatus::Active { .. }) => amounts.push(SubBalance {
                    stake_id: staked.staked_oct_id,
                    validator,
                    value: staked.principal as i128,
                }),
                (SubAccountType::PendingStake, StakeStatus::Pending) => amounts.push(SubBalance {
                    stake_id: staked.staked_oct_id,
                    validator,
                    value: staked.principal as i128,
                }),
                (SubAccountType::EstimatedReward, StakeStatus::Active { estimated_reward }) => amounts
                    .push(SubBalance { stake_id: staked.staked_oct_id, validator, value: estimated_reward as i128 }),
                _ => {}
            }
        }
    }

    Ok(if amounts.is_empty() { vec![Amount::new(0, None)] } else { vec![Amount::new_from_sub_balances(amounts)] })
}

/// Get an array of all unspent coins for an AccountIdentifier and the BlockIdentifier at which the lookup was performed. .
/// [Mesh API Spec](https://docs.cdp.coinbase.com/api-reference/mesh/account/get-an-account-unspent-coins)
/// TODO This API is supposed to return coins of all types, not just SUI. It also has a 'currencies' parameter that we
/// are igorning which can be used to filter the type of coins that are returned.
pub async fn coins(
    State(context): State<OnlineServerContext>,
    Extension(env): Extension<SuiEnv>,
    WithRejection(Json(request), _): WithRejection<Json<AccountCoinsRequest>, Error>,
) -> Result<AccountCoinsResponse, Error> {
    env.check_network_identifier(&request.network_identifier)?;

    let coins = context
        .client
        .coin_read_api()
        .get_coins(request.account_identifier.address, Some(SUI_COIN_TYPE.to_string()), None, Some(5000))
        .await?
        .data
        .into_iter()
        .map(|coin| Coin {
            coin_identifier: CoinIdentifier { identifier: CoinID { id: coin.coin_object_id, version: coin.version } },
            amount: Amount::new(coin.balance as i128, None),
        })
        .collect();

    Ok(AccountCoinsResponse { block_identifier: context.blocks().current_block_identifier().await?, coins })
}
