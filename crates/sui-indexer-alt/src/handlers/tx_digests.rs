// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use std::sync::Arc;

use anyhow::Result;
use diesel_async::RunQueryDsl;
use sui_indexer_alt_framework::{
    db,
    pipeline::{concurrent::Handler, Processor},
};
use sui_types::full_checkpoint_content::CheckpointData;

use crate::{models::transactions::StoredTxDigest, schema::tx_digests};

pub(crate) struct TxDigests;

impl Processor for TxDigests {
    type Value = StoredTxDigest;

    const NAME: &'static str = "tx_digests";

    fn process(&self, checkpoint: &Arc<CheckpointData>) -> Result<Vec<Self::Value>> {
        let CheckpointData { transactions, checkpoint_summary, .. } = checkpoint.as_ref();

        let first_tx = checkpoint_summary.network_total_transactions as usize - transactions.len();

        Ok(transactions
            .iter()
            .enumerate()
            .map(|(i, tx)| StoredTxDigest {
                tx_sequence_number: (first_tx + i) as i64,
                tx_digest: tx.transaction.digest().inner().to_vec(),
            })
            .collect())
    }
}

#[async_trait::async_trait]
impl Handler for TxDigests {
    const MAX_PENDING_ROWS: usize = 10000;
    const MIN_EAGER_ROWS: usize = 100;

    async fn commit(values: &[Self::Value], conn: &mut db::Connection<'_>) -> Result<usize> {
        Ok(diesel::insert_into(tx_digests::table).values(values).on_conflict_do_nothing().execute(conn).await?)
    }
}
