use crate::validator_commands::{call_0x5, get_cap_object_ref, write_transaction_response};
use anyhow::{anyhow, Result};
use clap::Parser;
use colored::Colorize;
use serde::Serialize;
use std::fmt::{Debug, Display, Formatter, Write};
use std::str::FromStr;
use sui_json_rpc_types::{SuiObjectDataOptions, SuiTransactionBlockResponse};
use sui_sdk::wallet_context::WalletContext;
use sui_types::object::Owner::Shared;
use sui_types::{
    base_types::{ObjectID, SuiAddress},
    transaction::{CallArg, ObjectArg},
};
use tracing::info;

const DEFAULT_GAS_BUDGET: u64 = 200_000_000; // 0.2 SUI
#[derive(Parser)]
#[clap(rename_all = "kebab-case")]
pub enum SuiSupperCommitteeCommand {
    #[clap(name = "update-trusted-validator-proposal")]
    CreateUpdateTrustedValidatorProposal {
        #[clap(name = "operation-cap-id", long)]
        operation_cap_id: Option<ObjectID>,
        #[clap(name = "operate")]
        operate: String,
        #[clap(name = "validator")]
        validator: SuiAddress,
        /// Gas budget for this transaction.
        #[clap(name = "gas-budget", long)]
        gas_budget: Option<u64>,
    },
    #[clap(name = "update-only-trusted-validator-proposal")]
    CreateUpdateOnlyTrustedValidatorProposal {
        #[clap(name = "operation-cap-id", long)]
        operation_cap_id: Option<ObjectID>,
        #[clap(name = "only-trusted-validator")]
        only_trusted_validator: String,
        /// Gas budget for this transaction.
        #[clap(name = "gas-budget", long)]
        gas_budget: Option<u64>,
    },
    #[clap(name = "update-only-validator-staking-proposal")]
    CreateUpdateOnlyValidatorStakingProposal {
        #[clap(name = "operation-cap-id", long)]
        operation_cap_id: Option<ObjectID>,
        #[clap(name = "only-validator-staking")]
        only_validator_staking: String,
        /// Gas budget for this transaction.
        #[clap(name = "gas-budget", long)]
        gas_budget: Option<u64>,
    },
    #[clap(name = "vote-proposal")]
    VoteProposal {
        #[clap(name = "operation-cap-id", long)]
        operation_cap_id: Option<ObjectID>,
        #[clap(name = "proposal-id")]
        proposal_id: ObjectID,
        #[clap(name = "agree")]
        agree: String,
        /// Gas budget for this transaction.
        #[clap(name = "gas-budget", long)]
        gas_budget: Option<u64>,
    },
}

#[derive(Serialize)]
#[serde(untagged)]
pub enum SuiSupperCommitteeResponse {
    CreateUpdateTrustedValidatorProposal(SuiTransactionBlockResponse),
    CreateUpdateOnlyTrustedValidatorProposal(SuiTransactionBlockResponse),
    CreateUpdateOnlyValidatorStakingProposal(SuiTransactionBlockResponse),
    VoteProposal(SuiTransactionBlockResponse),
}

impl SuiSupperCommitteeCommand {
    pub async fn execute(
        self,
        context: &mut WalletContext,
    ) -> anyhow::Result<SuiSupperCommitteeResponse, anyhow::Error> {
        let ret = Ok(match self {
            SuiSupperCommitteeCommand::CreateUpdateTrustedValidatorProposal {
                operation_cap_id,
                operate,
                validator,
                gas_budget,
            } => {
                let operate = bool::from_str(&operate).map_err(|_| anyhow!("operate invalid boolean value"))?;
                let gas_budget = gas_budget.unwrap_or(DEFAULT_GAS_BUDGET);
                let (_status, _summary, cap_obj_ref) = get_cap_object_ref(context, operation_cap_id).await?;

                let args = vec![
                    CallArg::Object(ObjectArg::ImmOrOwnedObject(cap_obj_ref)),
                    CallArg::Pure(bcs::to_bytes(&operate).unwrap()),
                    CallArg::Pure(bcs::to_bytes(&validator).unwrap()),
                    CallArg::CLOCK_IMM,
                ];
                let response = call_0x5(context, "create_update_trusted_validator_proposal", args, gas_budget).await?;
                SuiSupperCommitteeResponse::CreateUpdateTrustedValidatorProposal(response)
            }
            SuiSupperCommitteeCommand::CreateUpdateOnlyTrustedValidatorProposal {
                operation_cap_id,
                only_trusted_validator,
                gas_budget,
            } => {
                let only_trusted_validator = bool::from_str(&only_trusted_validator)
                    .map_err(|_| anyhow!("only-trusted-validator invalid boolean value"))?;
                let gas_budget = gas_budget.unwrap_or(DEFAULT_GAS_BUDGET);
                let (_status, _summary, cap_obj_ref) = get_cap_object_ref(context, operation_cap_id).await?;

                let args = vec![
                    CallArg::Object(ObjectArg::ImmOrOwnedObject(cap_obj_ref)),
                    CallArg::Pure(bcs::to_bytes(&only_trusted_validator).unwrap()),
                    CallArg::CLOCK_IMM,
                ];
                let response =
                    call_0x5(context, "create_update_only_trusted_validator_proposal", args, gas_budget).await?;
                SuiSupperCommitteeResponse::CreateUpdateOnlyTrustedValidatorProposal(response)
            }
            SuiSupperCommitteeCommand::CreateUpdateOnlyValidatorStakingProposal {
                operation_cap_id,
                only_validator_staking,
                gas_budget,
            } => {
                let only_validator_staking = bool::from_str(&only_validator_staking)
                    .map_err(|_| anyhow!("only-validator-staking invalid boolean value"))?;
                let gas_budget = gas_budget.unwrap_or(DEFAULT_GAS_BUDGET);
                let (_status, _summary, cap_obj_ref) = get_cap_object_ref(context, operation_cap_id).await?;

                let args = vec![
                    CallArg::Object(ObjectArg::ImmOrOwnedObject(cap_obj_ref)),
                    CallArg::Pure(bcs::to_bytes(&only_validator_staking).unwrap()),
                    CallArg::CLOCK_IMM,
                ];
                let response =
                    call_0x5(context, "create_update_only_validator_staking_proposal", args, gas_budget).await?;
                SuiSupperCommitteeResponse::CreateUpdateOnlyValidatorStakingProposal(response)
            }
            SuiSupperCommitteeCommand::VoteProposal { operation_cap_id, proposal_id, agree, gas_budget } => {
                let agree = bool::from_str(&agree).map_err(|_| anyhow!("only-agree-staking invalid boolean value"))?;
                let gas_budget = gas_budget.unwrap_or(DEFAULT_GAS_BUDGET);
                let (_status, _summary, cap_obj_ref) = get_cap_object_ref(context, operation_cap_id).await?;
                let proposal_obj_mut = get_proposal_mut(context, proposal_id).await?;

                let args = vec![
                    CallArg::Object(ObjectArg::ImmOrOwnedObject(cap_obj_ref)),
                    CallArg::Object(proposal_obj_mut),
                    CallArg::Pure(bcs::to_bytes(&agree).unwrap()),
                    CallArg::CLOCK_IMM,
                ];
                let response = call_0x5(context, "vote_proposal", args, gas_budget).await?;

                SuiSupperCommitteeResponse::VoteProposal(response)
            }
        });
        ret
    }
}

async fn get_proposal_mut(context: &mut WalletContext, proposal_id: ObjectID) -> Result<ObjectArg> {
    let sui_client = context.get_client().await?;
    let proposal_obj_owner = sui_client
        .read_api()
        .get_object_with_options(proposal_id, SuiObjectDataOptions::default().with_owner())
        .await?
        .owner()
        .ok_or_else(|| anyhow!("OperationCap {} does not exist", proposal_id))?;

    if let Shared { initial_shared_version } = proposal_obj_owner {
        Ok(ObjectArg::SharedObject { id: proposal_id, initial_shared_version, mutable: true })
    } else {
        Err(anyhow!("Proposal object {} is not a shared object", proposal_id))
    }
}

impl Display for SuiSupperCommitteeResponse {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let mut writer = String::new();
        match self {
            SuiSupperCommitteeResponse::CreateUpdateTrustedValidatorProposal(response) => {
                write!(writer, "{}", write_transaction_response(response)?)?;
            }
            SuiSupperCommitteeResponse::CreateUpdateOnlyTrustedValidatorProposal(response) => {
                write!(writer, "{}", write_transaction_response(response)?)?;
            }
            SuiSupperCommitteeResponse::CreateUpdateOnlyValidatorStakingProposal(response) => {
                write!(writer, "{}", write_transaction_response(response)?)?;
            }
            SuiSupperCommitteeResponse::VoteProposal(response) => {
                write!(writer, "{}", write_transaction_response(response)?)?;
            }
        }
        write!(f, "{}", writer.trim_end_matches('\n'))
    }
}

impl SuiSupperCommitteeResponse {
    pub fn print(&self, pretty: bool) {
        let line = if pretty { format!("{self}") } else { format!("{:?}", self) };
        // Log line by line
        for line in line.lines() {
            // Logs write to a file on the side.  Print to stdout and also log to file, for tests to pass.
            println!("{line}");
            info!("{line}")
        }
    }
}

impl Debug for SuiSupperCommitteeResponse {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let string = serde_json::to_string_pretty(self);
        let s = string.unwrap_or_else(|err| format!("{err}").red().to_string());
        write!(f, "{}", s)
    }
}
