// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use std::ops::RangeInclusive;

use async_trait::async_trait;

use crate::database::ConnectionPool;

#[async_trait]
pub trait BackfillTask: Send + Sync {
    /// Backfill the database for a specific range.
    async fn backfill_range(&self, pool: ConnectionPool, range: &RangeInclusive<usize>);
}
