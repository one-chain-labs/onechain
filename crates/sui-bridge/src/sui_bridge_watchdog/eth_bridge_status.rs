// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

//! The EthBridgeStatus observable monitors whether the Eth Bridge is paused.

use std::sync::Arc;

use async_trait::async_trait;
use ethers::{providers::Provider, types::Address as EthAddress};
use prometheus::IntGauge;
use tokio::time::Duration;
use tracing::{error, info};

use crate::{abi::EthSuiBridge, metered_eth_provider::MeteredEthHttpProvider, sui_bridge_watchdog::Observable};

pub struct EthBridgeStatus {
    bridge_contract: EthSuiBridge<Provider<MeteredEthHttpProvider>>,
    metric: IntGauge,
}

impl EthBridgeStatus {
    pub fn new(provider: Arc<Provider<MeteredEthHttpProvider>>, bridge_address: EthAddress, metric: IntGauge) -> Self {
        let bridge_contract = EthSuiBridge::new(bridge_address, provider.clone());
        Self { bridge_contract, metric }
    }
}

#[async_trait]
impl Observable for EthBridgeStatus {
    fn name(&self) -> &str {
        "EthBridgeStatus"
    }

    async fn observe_and_report(&self) {
        let status = self.bridge_contract.paused().call().await;
        match status {
            Ok(status) => {
                self.metric.set(status as i64);
                info!("Eth Bridge Status: {:?}", status);
            }
            Err(e) => {
                error!("Error getting eth bridge status: {:?}", e);
            }
        }
    }

    fn interval(&self) -> Duration {
        Duration::from_secs(10)
    }
}
