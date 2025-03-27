// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0
mod bigtable;
use anyhow::Result;
use async_trait::async_trait;
pub use bigtable::{client::BigTableClient, worker::KvWorker};
use sui_types::{
    base_types::ObjectID,
    crypto::AuthorityStrongQuorumSignInfo,
    digests::{CheckpointDigest, TransactionDigest},
    effects::{TransactionEffects, TransactionEvents},
    full_checkpoint_content::CheckpointData,
    messages_checkpoint::{CheckpointContents, CheckpointSequenceNumber, CheckpointSummary},
    object::Object,
    storage::ObjectKey,
    transaction::Transaction,
};

#[async_trait]
pub trait KeyValueStoreReader {
    async fn get_objects(&mut self, objects: &[ObjectKey]) -> Result<Vec<Object>>;
    async fn get_transactions(&mut self, transactions: &[TransactionDigest]) -> Result<Vec<TransactionData>>;
    async fn get_checkpoints(&mut self, sequence_numbers: &[CheckpointSequenceNumber]) -> Result<Vec<Checkpoint>>;
    async fn get_checkpoint_by_digest(&mut self, digest: CheckpointDigest) -> Result<Option<Checkpoint>>;
    async fn get_latest_checkpoint(&mut self) -> Result<CheckpointSequenceNumber>;
    async fn get_latest_object(&mut self, object_id: &ObjectID) -> Result<Option<Object>>;
}

#[async_trait]
pub trait KeyValueStoreWriter {
    async fn save_objects(&mut self, objects: &[&Object]) -> Result<()>;
    async fn save_transactions(&mut self, transactions: &[TransactionData]) -> Result<()>;
    async fn save_checkpoint(&mut self, checkpoint: &CheckpointData) -> Result<()>;
}

#[derive(Clone, Debug)]
pub struct Checkpoint {
    pub summary: CheckpointSummary,
    pub contents: CheckpointContents,
    pub signatures: AuthorityStrongQuorumSignInfo,
}

#[derive(Clone, Debug)]
pub struct TransactionData {
    pub transaction: Transaction,
    pub effects: TransactionEffects,
    pub events: Option<TransactionEvents>,
    pub checkpoint_number: CheckpointSequenceNumber,
    pub timestamp: u64,
}
