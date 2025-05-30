// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module one_system::one_system {
    use std::vector;

    use one::balance::Balance;
    use one::object::UID;
    use one::oct::OCT;
    use one::transfer;
    use one::tx_context::{Self, TxContext};
    use one::dynamic_field;

    use one_system::validator::Validator;
    use one_system::sui_system_state_inner::SuiSystemStateInner;
    use one_system::sui_system_state_inner;

    public struct SuiSystemState has key {
        id: UID,
        version: u64,
    }

    public(package) fun create(
        id: UID,
        validators: vector<Validator>,
        storage_fund: Balance<OCT>,
        protocol_version: u64,
        epoch_start_timestamp_ms: u64,
        epoch_duration_ms: u64,
        ctx: &mut TxContext,
    ) {
        let system_state = sui_system_state_inner::create(
            validators,
            storage_fund,
            protocol_version,
            epoch_start_timestamp_ms,
            epoch_duration_ms,
            ctx,
        );
        let version = sui_system_state_inner::genesis_system_state_version();
        let mut self = SuiSystemState {
            id,
            version,
        };
        dynamic_field::add(&mut self.id, version, system_state);
        transfer::share_object(self);
    }

    fun advance_epoch(
        storage_reward: Balance<OCT>,
        computation_reward: Balance<OCT>,
        wrapper: &mut SuiSystemState,
        _new_epoch: u64,
        _next_protocol_version: u64,
        storage_rebate: u64,
        _non_refundable_storage_fee: u64,
        _storage_fund_reinvest_rate: u64,
        _reward_slashing_rate: u64,
        _epoch_start_timestamp_ms: u64,
        ctx: &mut TxContext,
    ) : Balance<OCT> {
        let self = load_system_state_mut(wrapper);
        assert!(tx_context::sender(ctx) == @0x1, 0); // aborts here
        sui_system_state_inner::advance_epoch(
            self,
            storage_reward,
            computation_reward,
            storage_rebate,
        )
    }

    public fun active_validator_addresses(wrapper: &mut SuiSystemState): vector<address> {
        vector::empty()
    }

    fun load_system_state_mut(self: &mut SuiSystemState): &mut SuiSystemStateInner {
        let version = self.version;
        dynamic_field::borrow_mut(&mut self.id, version)
    }
}
