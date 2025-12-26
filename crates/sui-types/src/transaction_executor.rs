// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use std::collections::BTreeMap;

use crate::{
    base_types::ObjectID,
    effects::{TransactionEffects, TransactionEvents},
    error::{ExecutionError, SuiError},
    execution::ExecutionResult,
    object::Object,
    quorum_driver_types::{ExecuteTransactionRequestV3, ExecuteTransactionResponseV3, QuorumDriverError},
    transaction::TransactionData,
};

/// Trait to define the interface for how the REST service interacts with a a QuorumDriver or a
/// simulated transaction executor.
#[async_trait::async_trait]
pub trait TransactionExecutor: Send + Sync {
    async fn execute_transaction(
        &self,
        request: ExecuteTransactionRequestV3,
        client_addr: Option<std::net::SocketAddr>,
    ) -> Result<ExecuteTransactionResponseV3, QuorumDriverError>;

    fn simulate_transaction(
        &self,
        transaction: TransactionData,
        checks: TransactionChecks,
    ) -> Result<SimulateTransactionResult, SuiError>;
}

pub struct SimulateTransactionResult {
    pub effects: TransactionEffects,
    pub events: Option<TransactionEvents>,
    pub input_objects: BTreeMap<ObjectID, Object>,
    pub output_objects: BTreeMap<ObjectID, Object>,
    pub execution_result: Result<Vec<ExecutionResult>, ExecutionError>,
    pub mock_gas_id: Option<ObjectID>,
}

#[derive(Default, Debug, Copy, Clone)]
pub enum TransactionChecks {
    #[default]
    Enabled,
    Disabled,
}

impl TransactionChecks {
    pub fn disabled(self) -> bool {
        matches!(self, Self::Disabled)
    }

    pub fn enabled(self) -> bool {
        matches!(self, Self::Enabled)
    }
}
