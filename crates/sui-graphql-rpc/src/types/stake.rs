// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use crate::{connection::ScanConnection, context_data::db_data_provider::PgManager, data::Db, error::Error};

use super::{
    balance::{self, Balance},
    base64::Base64,
    big_int::BigInt,
    coin::Coin,
    cursor::Page,
    display::DisplayEntry,
    dynamic_field::{DynamicField, DynamicFieldName},
    epoch::Epoch,
    move_object::{MoveObject, MoveObjectImpl},
    move_value::MoveValue,
    object,
    object::{Object, ObjectFilter, ObjectImpl, ObjectOwner, ObjectStatus},
    owner::OwnerImpl,
    sui_address::SuiAddress,
    suins_registration::{DomainFormat, SuinsRegistration},
    transaction_block::{self, TransactionBlock, TransactionBlockFilter},
    type_filter::ExactTypeFilter,
    uint53::UInt53,
};
use async_graphql::{connection::Connection, *};
use move_core_types::language_storage::StructTag;
use sui_json_rpc_types::{Stake as RpcStakedOct, StakeStatus as RpcStakeStatus};
use sui_types::{base_types::MoveObjectType, governance::StakedOct as NativeStakedOct};

#[derive(Copy, Clone, Enum, PartialEq, Eq)]
/// The stake's possible status: active, pending, or unstaked.
pub(crate) enum StakeStatus {
    /// The stake object is active in a staking pool and it is generating rewards.
    Active,
    /// The stake awaits to join a staking pool in the next epoch.
    Pending,
    /// The stake is no longer active in any staking pool.
    Unstaked,
}

pub(crate) enum StakedOctDowncastError {
    NotAStakedOct,
    Bcs(bcs::Error),
}

#[derive(Clone)]
pub(crate) struct StakedOct {
    /// Representation of this StakedOct as a generic Move Object.
    pub super_: MoveObject,

    /// Deserialized representation of the Move Object's contents as a
    /// `0x3::staking_pool::StakedOct`.
    pub native: NativeStakedOct,
}

/// Represents a `0x3::staking_pool::StakedOct` Move object on-chain.
#[Object]
impl StakedOct {
    pub(crate) async fn address(&self) -> SuiAddress {
        OwnerImpl::from(&self.super_.super_).address().await
    }

    /// Objects owned by this object, optionally `filter`-ed.
    pub(crate) async fn objects(
        &self,
        ctx: &Context<'_>,
        first: Option<u64>,
        after: Option<object::Cursor>,
        last: Option<u64>,
        before: Option<object::Cursor>,
        filter: Option<ObjectFilter>,
    ) -> Result<Connection<String, MoveObject>> {
        OwnerImpl::from(&self.super_.super_).objects(ctx, first, after, last, before, filter).await
    }

    /// Total balance of all coins with marker type owned by this object. If type is not supplied,
    /// it defaults to `0x2::oct::OCT`.
    pub(crate) async fn balance(&self, ctx: &Context<'_>, type_: Option<ExactTypeFilter>) -> Result<Option<Balance>> {
        OwnerImpl::from(&self.super_.super_).balance(ctx, type_).await
    }

    /// The balances of all coin types owned by this object.
    pub(crate) async fn balances(
        &self,
        ctx: &Context<'_>,
        first: Option<u64>,
        after: Option<balance::Cursor>,
        last: Option<u64>,
        before: Option<balance::Cursor>,
    ) -> Result<Connection<String, Balance>> {
        OwnerImpl::from(&self.super_.super_).balances(ctx, first, after, last, before).await
    }

    /// The coin objects for this object.
    ///
    ///`type` is a filter on the coin's type parameter, defaulting to `0x2::oct::OCT`.
    pub(crate) async fn coins(
        &self,
        ctx: &Context<'_>,
        first: Option<u64>,
        after: Option<object::Cursor>,
        last: Option<u64>,
        before: Option<object::Cursor>,
        type_: Option<ExactTypeFilter>,
    ) -> Result<Connection<String, Coin>> {
        OwnerImpl::from(&self.super_.super_).coins(ctx, first, after, last, before, type_).await
    }

    /// The `0x3::staking_pool::StakedOct` objects owned by this object.
    pub(crate) async fn staked_octs(
        &self,
        ctx: &Context<'_>,
        first: Option<u64>,
        after: Option<object::Cursor>,
        last: Option<u64>,
        before: Option<object::Cursor>,
    ) -> Result<Connection<String, StakedOct>> {
        OwnerImpl::from(&self.super_.super_).staked_octs(ctx, first, after, last, before).await
    }

    /// The domain explicitly configured as the default domain pointing to this object.
    pub(crate) async fn default_suins_name(
        &self,
        ctx: &Context<'_>,
        format: Option<DomainFormat>,
    ) -> Result<Option<String>> {
        OwnerImpl::from(&self.super_.super_).default_suins_name(ctx, format).await
    }

    /// The SuinsRegistration NFTs owned by this object. These grant the owner the capability to
    /// manage the associated domain.
    pub(crate) async fn suins_registrations(
        &self,
        ctx: &Context<'_>,
        first: Option<u64>,
        after: Option<object::Cursor>,
        last: Option<u64>,
        before: Option<object::Cursor>,
    ) -> Result<Connection<String, SuinsRegistration>> {
        OwnerImpl::from(&self.super_.super_).suins_registrations(ctx, first, after, last, before).await
    }

    pub(crate) async fn version(&self) -> UInt53 {
        ObjectImpl(&self.super_.super_).version().await
    }

    /// The current status of the object as read from the off-chain store. The possible states are:
    /// NOT_INDEXED, the object is loaded from serialized data, such as the contents of a genesis or
    /// system package upgrade transaction. LIVE, the version returned is the most recent for the
    /// object, and it is not deleted or wrapped at that version. HISTORICAL, the object was
    /// referenced at a specific version or checkpoint, so is fetched from historical tables and may
    /// not be the latest version of the object. WRAPPED_OR_DELETED, the object is deleted or
    /// wrapped and only partial information can be loaded."
    pub(crate) async fn status(&self) -> ObjectStatus {
        ObjectImpl(&self.super_.super_).status().await
    }

    /// 32-byte hash that identifies the object's contents, encoded as a Base58 string.
    pub(crate) async fn digest(&self) -> Option<String> {
        ObjectImpl(&self.super_.super_).digest().await
    }

    /// The owner type of this object: Immutable, Shared, Parent, Address
    pub(crate) async fn owner(&self) -> Option<ObjectOwner> {
        ObjectImpl(&self.super_.super_).owner().await
    }

    /// The transaction block that created this version of the object.
    pub(crate) async fn previous_transaction_block(&self, ctx: &Context<'_>) -> Result<Option<TransactionBlock>> {
        ObjectImpl(&self.super_.super_).previous_transaction_block(ctx).await
    }

    /// The amount of SUI we would rebate if this object gets deleted or mutated. This number is
    /// recalculated based on the present storage gas price.
    pub(crate) async fn storage_rebate(&self) -> Option<BigInt> {
        ObjectImpl(&self.super_.super_).storage_rebate().await
    }

    /// The transaction blocks that sent objects to this object.
    ///
    /// `scanLimit` restricts the number of candidate transactions scanned when gathering a page of
    /// results. It is required for queries that apply more than two complex filters (on function,
    /// kind, sender, recipient, input object, changed object, or ids), and can be at most
    /// `serviceConfig.maxScanLimit`.
    ///
    /// When the scan limit is reached the page will be returned even if it has fewer than `first`
    /// results when paginating forward (`last` when paginating backwards). If there are more
    /// transactions to scan, `pageInfo.hasNextPage` (or `pageInfo.hasPreviousPage`) will be set to
    /// `true`, and `PageInfo.endCursor` (or `PageInfo.startCursor`) will be set to the last
    /// transaction that was scanned as opposed to the last (or first) transaction in the page.
    ///
    /// Requesting the next (or previous) page after this cursor will resume the search, scanning
    /// the next `scanLimit` many transactions in the direction of pagination, and so on until all
    /// transactions in the scanning range have been visited.
    ///
    /// By default, the scanning range includes all transactions known to GraphQL, but it can be
    /// restricted by the `after` and `before` cursors, and the `beforeCheckpoint`,
    /// `afterCheckpoint` and `atCheckpoint` filters.
    pub(crate) async fn received_transaction_blocks(
        &self,
        ctx: &Context<'_>,
        first: Option<u64>,
        after: Option<transaction_block::Cursor>,
        last: Option<u64>,
        before: Option<transaction_block::Cursor>,
        filter: Option<TransactionBlockFilter>,
        scan_limit: Option<u64>,
    ) -> Result<ScanConnection<String, TransactionBlock>> {
        ObjectImpl(&self.super_.super_)
            .received_transaction_blocks(ctx, first, after, last, before, filter, scan_limit)
            .await
    }

    /// The Base64-encoded BCS serialization of the object's content.
    pub(crate) async fn bcs(&self) -> Result<Option<Base64>> {
        ObjectImpl(&self.super_.super_).bcs().await
    }

    /// Displays the contents of the Move object in a JSON string and through GraphQL types. Also
    /// provides the flat representation of the type signature, and the BCS of the corresponding
    /// data.
    pub(crate) async fn contents(&self) -> Option<MoveValue> {
        MoveObjectImpl(&self.super_).contents().await
    }

    /// Determines whether a transaction can transfer this object, using the TransferObjects
    /// transaction command or `sui::transfer::public_transfer`, both of which require the object to
    /// have the `key` and `store` abilities.
    pub(crate) async fn has_public_transfer(&self, ctx: &Context<'_>) -> Result<bool> {
        MoveObjectImpl(&self.super_).has_public_transfer(ctx).await
    }

    /// The set of named templates defined on-chain for the type of this object, to be handled
    /// off-chain. The server substitutes data from the object into these templates to generate a
    /// display string per template.
    pub(crate) async fn display(&self, ctx: &Context<'_>) -> Result<Option<Vec<DisplayEntry>>> {
        ObjectImpl(&self.super_.super_).display(ctx).await
    }

    /// Access a dynamic field on an object using its name. Names are arbitrary Move values whose
    /// type have `copy`, `drop`, and `store`, and are specified using their type, and their BCS
    /// contents, Base64 encoded.
    ///
    /// Dynamic fields on wrapped objects can be accessed by using the same API under the Owner
    /// type.
    pub(crate) async fn dynamic_field(&self, ctx: &Context<'_>, name: DynamicFieldName) -> Result<Option<DynamicField>> {
        OwnerImpl::from(&self.super_.super_).dynamic_field(ctx, name, Some(self.super_.root_version())).await
    }

    /// Access a dynamic object field on an object using its name. Names are arbitrary Move values
    /// whose type have `copy`, `drop`, and `store`, and are specified using their type, and their
    /// BCS contents, Base64 encoded. The value of a dynamic object field can also be accessed
    /// off-chain directly via its address (e.g. using `Query.object`).
    ///
    /// Dynamic fields on wrapped objects can be accessed by using the same API under the Owner
    /// type.
    pub(crate) async fn dynamic_object_field(
        &self,
        ctx: &Context<'_>,
        name: DynamicFieldName,
    ) -> Result<Option<DynamicField>> {
        OwnerImpl::from(&self.super_.super_).dynamic_object_field(ctx, name, Some(self.super_.root_version())).await
    }

    /// The dynamic fields and dynamic object fields on an object.
    ///
    /// Dynamic fields on wrapped objects can be accessed by using the same API under the Owner
    /// type.
    pub(crate) async fn dynamic_fields(
        &self,
        ctx: &Context<'_>,
        first: Option<u64>,
        after: Option<object::Cursor>,
        last: Option<u64>,
        before: Option<object::Cursor>,
    ) -> Result<Connection<String, DynamicField>> {
        OwnerImpl::from(&self.super_.super_)
            .dynamic_fields(ctx, first, after, last, before, Some(self.super_.root_version()))
            .await
    }

    /// A stake can be pending, active, or unstaked
    async fn stake_status(&self, ctx: &Context<'_>) -> Result<StakeStatus> {
        Ok(match self.rpc_stake(ctx).await.extend()?.status {
            RpcStakeStatus::Pending => StakeStatus::Pending,
            RpcStakeStatus::Active { .. } => StakeStatus::Active,
            RpcStakeStatus::Unstaked => StakeStatus::Unstaked,
        })
    }

    /// The epoch at which this stake became active.
    async fn activated_epoch(&self, ctx: &Context<'_>) -> Result<Option<Epoch>> {
        Epoch::query(ctx, Some(self.native.activation_epoch()), self.super_.super_.checkpoint_viewed_at).await.extend()
    }

    /// The epoch at which this object was requested to join a stake pool.
    async fn requested_epoch(&self, ctx: &Context<'_>) -> Result<Option<Epoch>> {
        Epoch::query(ctx, Some(self.native.request_epoch()), self.super_.super_.checkpoint_viewed_at).await.extend()
    }

    /// The object id of the validator staking pool this stake belongs to.
    async fn pool_id(&self) -> Option<SuiAddress> {
        Some(self.native.pool_id().into())
    }

    /// The SUI that was initially staked.
    async fn principal(&self) -> Option<BigInt> {
        Some(BigInt::from(self.native.principal()))
    }

    /// The estimated reward for this stake object, calculated as:
    ///
    ///  principal * (initial_stake_rate / current_stake_rate - 1.0)
    ///
    /// Or 0, if this value is negative, where:
    ///
    /// - `initial_stake_rate` is the stake rate at the epoch this stake was activated at.
    /// - `current_stake_rate` is the stake rate in the current epoch.
    ///
    /// This value is only available if the stake is active.
    async fn estimated_reward(&self, ctx: &Context<'_>) -> Result<Option<BigInt>, Error> {
        let RpcStakeStatus::Active { estimated_reward } = self.rpc_stake(ctx).await?.status else {
            return Ok(None);
        };

        Ok(Some(BigInt::from(estimated_reward)))
    }
}

impl StakedOct {
    /// Query the database for a `page` of Staked OCT. The page uses the same cursor type as is used
    /// for `Object`, and is further filtered to a particular `owner`.
    ///
    /// `checkpoint_viewed_at` represents the checkpoint sequence number at which this page was
    /// queried for. Each entity returned in the connection will inherit this checkpoint, so that
    /// when viewing that entity's state, it will be as if it was read at the same checkpoint.
    pub(crate) async fn paginate(
        db: &Db,
        page: Page<object::Cursor>,
        owner: SuiAddress,
        checkpoint_viewed_at: u64,
    ) -> Result<Connection<String, StakedOct>, Error> {
        let type_: StructTag = MoveObjectType::staked_oct().into();

        let filter = ObjectFilter { type_: Some(type_.into()), owner: Some(owner), ..Default::default() };

        Object::paginate_subtype(db, page, filter, checkpoint_viewed_at, |object| {
            let address = object.address;
            let move_object = MoveObject::try_from(&object).map_err(|_| {
                Error::Internal(format!("Expected {address} to be a StakedOct, but it's not a Move Object.",))
            })?;

            StakedOct::try_from(&move_object)
                .map_err(|_| Error::Internal(format!("Expected {address} to be a StakedOct, but it is not.")))
        })
        .await
    }

    /// The JSON-RPC representation of a StakedOct so that we can "cheat" to implement fields that
    /// are not yet implemented directly for GraphQL.
    ///
    /// TODO: Make this obsolete
    async fn rpc_stake(&self, ctx: &Context<'_>) -> Result<RpcStakedOct, Error> {
        ctx.data_unchecked::<PgManager>().fetch_rpc_staked_oct(self.native.clone()).await
    }
}

impl TryFrom<&MoveObject> for StakedOct {
    type Error = StakedOctDowncastError;

    fn try_from(move_object: &MoveObject) -> Result<Self, Self::Error> {
        if !move_object.native.is_staked_oct() {
            return Err(StakedOctDowncastError::NotAStakedOct);
        }

        Ok(Self {
            super_: move_object.clone(),
            native: bcs::from_bytes(move_object.native.contents()).map_err(StakedOctDowncastError::Bcs)?,
        })
    }
}
