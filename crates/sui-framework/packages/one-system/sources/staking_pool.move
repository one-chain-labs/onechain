// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_const)]
module one_system::staking_pool {
    use one::balance::{Self, Balance};
    use one::oct::OCT;
    use one::table::{Self, Table};
    use one::bag::Bag;
    use one::bag;

    /// StakedOct objects cannot be split to below this amount.
    const MIN_STAKING_THRESHOLD: u64 = 1_000_000_000; // 1 SUI

    const EInsufficientPoolTokenBalance: u64 = 0;
    const EWrongPool: u64 = 1;
    const EWithdrawAmountCannotBeZero: u64 = 2;
    const EInsufficientSuiTokenBalance: u64 = 3;
    const EInsufficientRewardsPoolBalance: u64 = 4;
    const EDestroyNonzeroBalance: u64 = 5;
    const ETokenTimeLockIsSome: u64 = 6;
    const EWrongDelegation: u64 = 7;
    const EPendingDelegationDoesNotExist: u64 = 8;
    const ETokenBalancesDoNotMatchExchangeRate: u64 = 9;
    const EDelegationToInactivePool: u64 = 10;
    const EDeactivationOfInactivePool: u64 = 11;
    const EIncompatibleStakedOct: u64 = 12;
    const EWithdrawalInSameEpoch: u64 = 13;
    const EPoolAlreadyActive: u64 = 14;
    const EPoolNotPreactive: u64 = 15;
    const EActivationOfInactivePool: u64 = 16;
    const EDelegationOfZeroSui: u64 = 17;
    const EStakedOctBelowThreshold: u64 = 18;
    const ECannotMintFungibleStakedOctYet: u64 = 19;
    const EInvariantFailure: u64 = 20;

    /// A staking pool embedded in each validator struct in the system state object.
    public struct StakingPool has key, store {
        id: UID,
        /// The epoch at which this pool became active.
        /// The value is `None` if the pool is pre-active and `Some(<epoch_number>)` if active or inactive.
        activation_epoch: Option<u64>,
        /// The epoch at which this staking pool ceased to be active. `None` = {pre-active, active},
        /// `Some(<epoch_number>)` if in-active, and it was de-activated at epoch `<epoch_number>`.
        deactivation_epoch: Option<u64>,
        /// The total number of OCT tokens in this pool, including the OCT in the rewards_pool, as well as in all the principal
        /// in the `StakedOct` object, updated at epoch boundaries.
        sui_balance: u64,
        /// The epoch stake rewards will be added here at the end of each epoch.
        rewards_pool: Balance<OCT>,
        /// Total number of pool tokens issued by the pool.
        pool_token_balance: u64,
        /// Exchange rate history of previous epochs. Key is the epoch number.
        /// The entries start from the `activation_epoch` of this pool and contains exchange rates at the beginning of each epoch,
        /// i.e., right after the rewards for the previous epoch have been deposited into the pool.
        exchange_rates: Table<u64, PoolTokenExchangeRate>,
        /// Pending stake amount for this epoch, emptied at epoch boundaries.
        pending_stake: u64,
        /// Pending stake withdrawn during the current epoch, emptied at epoch boundaries.
        /// This includes both the principal and rewards SUI withdrawn.
        pending_total_sui_withdraw: u64,
        /// Pending pool token withdrawn during the current epoch, emptied at epoch boundaries.
        pending_pool_token_withdraw: u64,
        /// Any extra fields that's not defined statically.
        extra_fields: Bag,
    }

    /// Struct representing the exchange rate of the stake pool token to SUI.
    public struct PoolTokenExchangeRate has store, copy, drop {
        sui_amount: u64,
        pool_token_amount: u64,
    }

    /// A self-custodial object holding the staked OCT tokens.
    public struct StakedOct has key, store {
        id: UID,
        /// ID of the staking pool we are staking with.
        pool_id: ID,
        /// The epoch at which the stake becomes active.
        stake_activation_epoch: u64,
        /// The staked OCT tokens.
        principal: Balance<OCT>,
        /// coin lock
        lock: bool,
    }

    /// An alternative to `StakedOct` that holds the pool token amount instead of the SUI balance.
    /// StakedOct objects can be converted to FungibleStakedOcts after the initial warmup period.
    /// The advantage of this is that you can now merge multiple StakedOct objects from different
    /// activation epochs into a single FungibleStakedOct object.
    public struct FungibleStakedOct has key, store {
        id: UID,
        /// ID of the staking pool we are staking with.
        pool_id: ID,
        /// The pool token amount.
        value: u64,
    }

    /// Holds useful information
    public struct FungibleStakedOctData has key, store {
        id: UID,
        /// fungible_staked_oct supply
        total_supply: u64,
        /// principal balance. Rewards are withdrawn from the reward pool
        principal: Balance<OCT>,
    }

    // === dynamic field keys ===
    public struct FungibleStakedOctDataKey has copy, store, drop {}

    // ==== initializer ====

    /// Create a new, empty staking pool.
    public(package) fun new(ctx: &mut TxContext) : StakingPool {
        let exchange_rates = table::new(ctx);
        StakingPool {
            id: object::new(ctx),
            activation_epoch: option::none(),
            deactivation_epoch: option::none(),
            sui_balance: 0,
            rewards_pool: balance::zero(),
            pool_token_balance: 0,
            exchange_rates,
            pending_stake: 0,
            pending_total_sui_withdraw: 0,
            pending_pool_token_withdraw: 0,
            extra_fields: bag::new(ctx),
        }
    }

    // ==== stake requests ====

    /// Request to stake to a staking pool. The stake starts counting at the beginning of the next epoch,
    public(package) fun request_add_stake(
        pool: &mut StakingPool,
        stake: Balance<OCT>,
        stake_activation_epoch: u64,
        lock: bool,
        ctx: &mut TxContext
    ) : StakedOct {
        let sui_amount = stake.value();
        assert!(!is_inactive(pool), EDelegationToInactivePool);
        assert!(sui_amount > 0, EDelegationOfZeroSui);
        let staked_oct = StakedOct {
            id: object::new(ctx),
            pool_id: object::id(pool),
            stake_activation_epoch,
            principal: stake,
            lock,
        };
        pool.pending_stake = pool.pending_stake + sui_amount;
        staked_oct
    }

    /// Request to withdraw the given stake plus rewards from a staking pool.
    /// Both the principal and corresponding rewards in SUI are withdrawn.
    /// A proportional amount of pool token withdraw is recorded and processed at epoch change time.
    public(package) fun request_withdraw_stake(
        pool: &mut StakingPool,
        staked_oct: StakedOct,
        ctx: &TxContext
    ) : Balance<OCT> {
        // stake is inactive
        if (staked_oct.stake_activation_epoch > ctx.epoch()) {
            let principal = unwrap_staked_oct(staked_oct);
            pool.pending_stake = pool.pending_stake - principal.value();

            return principal
        };

        let (pool_token_withdraw_amount, mut principal_withdraw) =
            withdraw_from_principal(pool, staked_oct);
        let principal_withdraw_amount = principal_withdraw.value();

        let rewards_withdraw = withdraw_rewards(
            pool, principal_withdraw_amount, pool_token_withdraw_amount, ctx.epoch()
        );
        let total_sui_withdraw_amount = principal_withdraw_amount + rewards_withdraw.value();

        pool.pending_total_sui_withdraw = pool.pending_total_sui_withdraw + total_sui_withdraw_amount;
        pool.pending_pool_token_withdraw = pool.pending_pool_token_withdraw + pool_token_withdraw_amount;

        // If the pool is inactive, we immediately process the withdrawal.
        if (is_inactive(pool)) process_pending_stake_withdraw(pool);

        // TODO: implement withdraw bonding period here.
        principal_withdraw.join(rewards_withdraw);
        principal_withdraw
    }

    public(package) fun redeem_fungible_staked_oct(
        pool: &mut StakingPool,
        fungible_staked_oct: FungibleStakedOct,
        ctx: &TxContext
    ) : Balance<OCT> {
        let FungibleStakedOct { id, pool_id, value } = fungible_staked_oct;
        assert!(pool_id == object::id(pool), EWrongPool);

        object::delete(id);

        let latest_exchange_rate = pool_token_exchange_rate_at_epoch(pool, tx_context::epoch(ctx));
        let fungible_staked_oct_data: &mut FungibleStakedOctData = bag::borrow_mut(
            &mut pool.extra_fields,
            FungibleStakedOctDataKey {}
        );

        let (principal_amount, rewards_amount) = calculate_fungible_staked_oct_withdraw_amount(
            latest_exchange_rate,
            value,
            balance::value(&fungible_staked_oct_data.principal),
            fungible_staked_oct_data.total_supply
        );

        fungible_staked_oct_data.total_supply = fungible_staked_oct_data.total_supply - value;

        let mut sui_out = balance::split(&mut fungible_staked_oct_data.principal, principal_amount);
        balance::join(
            &mut sui_out,
            balance::split(&mut pool.rewards_pool, rewards_amount)
        );

        pool.pending_total_sui_withdraw = pool.pending_total_sui_withdraw + balance::value(&sui_out);
        pool.pending_pool_token_withdraw = pool.pending_pool_token_withdraw + value;

        sui_out
    }

    /// written in separate function so i can test with random values
    /// returns (principal_withdraw_amount, rewards_withdraw_amount)
    fun calculate_fungible_staked_oct_withdraw_amount(
        latest_exchange_rate: PoolTokenExchangeRate,
        fungible_staked_oct_value: u64,
        fungible_staked_oct_data_principal_amount: u64, // fungible_staked_oct_data.principal.value()
        fungible_staked_oct_data_total_supply: u64, // fungible_staked_oct_data.total_supply
    ) : (u64, u64) {
        // 1. if the entire FungibleStakedOctData supply is redeemed, how much sui should we receive?
        let total_sui_amount = get_sui_amount(&latest_exchange_rate, fungible_staked_oct_data_total_supply);

        // min with total_sui_amount to prevent underflow
        let fungible_staked_oct_data_principal_amount = std::u64::min(
            fungible_staked_oct_data_principal_amount,
            total_sui_amount
        );

        // 2. how much do we need to withdraw from the rewards pool?
        let total_rewards = total_sui_amount - fungible_staked_oct_data_principal_amount;

        // 3. proportionally withdraw from both wrt the fungible_staked_oct_value.
        let principal_withdraw_amount = ((fungible_staked_oct_value as u128)
            * (fungible_staked_oct_data_principal_amount as u128)
            / (fungible_staked_oct_data_total_supply as u128)) as u64;

        let rewards_withdraw_amount = ((fungible_staked_oct_value as u128)
            * (total_rewards as u128)
            / (fungible_staked_oct_data_total_supply as u128)) as u64;

        // invariant check, just in case
        let expected_sui_amount = get_sui_amount(&latest_exchange_rate, fungible_staked_oct_value);
        assert!(principal_withdraw_amount + rewards_withdraw_amount <= expected_sui_amount, EInvariantFailure);

        (principal_withdraw_amount, rewards_withdraw_amount)
    }

    /// Convert the given staked OCT to an FungibleStakedOct object
    public(package) fun convert_to_fungible_staked_oct(
        pool: &mut StakingPool,
        staked_oct: StakedOct,
        ctx: &mut TxContext
    ) : FungibleStakedOct {
        let StakedOct { id, pool_id, stake_activation_epoch, principal ,lock:_} = staked_oct;

        assert!(pool_id == object::id(pool), EWrongPool);
        assert!(
            tx_context::epoch(ctx) >= stake_activation_epoch,
            ECannotMintFungibleStakedOctYet
        );

        object::delete(id);


        let exchange_rate_at_staking_epoch = pool_token_exchange_rate_at_epoch(
            pool,
            stake_activation_epoch
        );

        let pool_token_amount = get_token_amount(
            &exchange_rate_at_staking_epoch,
            balance::value(&principal)
        );

        if (!bag::contains(&pool.extra_fields, FungibleStakedOctDataKey {})) {
            bag::add(
                &mut pool.extra_fields,
                FungibleStakedOctDataKey {},
                FungibleStakedOctData {
                    id: object::new(ctx),
                    total_supply: pool_token_amount,
                    principal
                }
            );
        }
        else {
            let fungible_staked_oct_data: &mut FungibleStakedOctData = bag::borrow_mut(
                &mut pool.extra_fields,
                FungibleStakedOctDataKey {}
            );
            fungible_staked_oct_data.total_supply = fungible_staked_oct_data.total_supply + pool_token_amount;
            balance::join(&mut fungible_staked_oct_data.principal, principal);
        };

        FungibleStakedOct {
            id: object::new(ctx),
            pool_id,
            value: pool_token_amount,
        }
    }

    /// Withdraw the principal SUI stored in the StakedOct object, and calculate the corresponding amount of pool
    /// tokens using exchange rate at staking epoch.
    /// Returns values are amount of pool tokens withdrawn and withdrawn principal portion of SUI.
    public(package) fun withdraw_from_principal(
        pool: &StakingPool,
        staked_oct: StakedOct,
    ) : (u64, Balance<OCT>) {

        // Check that the stake information matches the pool.
        assert!(staked_oct.pool_id == object::id(pool), EWrongPool);

        let exchange_rate_at_staking_epoch = pool_token_exchange_rate_at_epoch(pool, staked_oct.stake_activation_epoch);
        let principal_withdraw = unwrap_staked_oct(staked_oct);
        let pool_token_withdraw_amount = get_token_amount(
		&exchange_rate_at_staking_epoch,
		principal_withdraw.value()
	);

        (
            pool_token_withdraw_amount,
            principal_withdraw,
        )
    }

    fun unwrap_staked_oct(staked_oct: StakedOct): Balance<OCT> {
        let StakedOct {
            id,
            pool_id: _,
            stake_activation_epoch: _,
            principal,
            lock: _,
        } = staked_oct;
        object::delete(id);
        principal
    }

    /// Allows calling `.into_balance()` on `StakedOct` to invoke `unwrap_staked_oct`
    public use fun unwrap_staked_oct as StakedOct.into_balance;

    // ==== functions called at epoch boundaries ===

    /// Called at epoch advancement times to add rewards (in SUI) to the staking pool.
    public(package) fun deposit_rewards(pool: &mut StakingPool, rewards: Balance<OCT>) {
        pool.sui_balance = pool.sui_balance + rewards.value();
        pool.rewards_pool.join(rewards);
    }

    public(package) fun process_pending_stakes_and_withdraws(pool: &mut StakingPool, ctx: &TxContext) {
        let new_epoch = ctx.epoch() + 1;
        process_pending_stake_withdraw(pool);
        process_pending_stake(pool);
        pool.exchange_rates.add(
            new_epoch,
            PoolTokenExchangeRate { sui_amount: pool.sui_balance, pool_token_amount: pool.pool_token_balance },
        );
        check_balance_invariants(pool, new_epoch);
    }

    /// Called at epoch boundaries to process pending stake withdraws requested during the epoch.
    /// Also called immediately upon withdrawal if the pool is inactive.
    fun process_pending_stake_withdraw(pool: &mut StakingPool) {
        pool.sui_balance = pool.sui_balance - pool.pending_total_sui_withdraw;
        pool.pool_token_balance = pool.pool_token_balance - pool.pending_pool_token_withdraw;
        pool.pending_total_sui_withdraw = 0;
        pool.pending_pool_token_withdraw = 0;
    }

    /// Called at epoch boundaries to process the pending stake.
    public(package) fun process_pending_stake(pool: &mut StakingPool) {
        // Use the most up to date exchange rate with the rewards deposited and withdraws effectuated.
        let latest_exchange_rate =
            PoolTokenExchangeRate { sui_amount: pool.sui_balance, pool_token_amount: pool.pool_token_balance };
        pool.sui_balance = pool.sui_balance + pool.pending_stake;
        pool.pool_token_balance = get_token_amount(&latest_exchange_rate, pool.sui_balance);
        pool.pending_stake = 0;
    }

    /// This function does the following:
    ///     1. Calculates the total amount of SUI (including principal and rewards) that the provided pool tokens represent
    ///        at the current exchange rate.
    ///     2. Using the above number and the given `principal_withdraw_amount`, calculates the rewards portion of the
    ///        stake we should withdraw.
    ///     3. Withdraws the rewards portion from the rewards pool at the current exchange rate. We only withdraw the rewards
    ///        portion because the principal portion was already taken out of the staker's self custodied StakedOct.
    fun withdraw_rewards(
        pool: &mut StakingPool,
        principal_withdraw_amount: u64,
        pool_token_withdraw_amount: u64,
        epoch: u64,
    ) : Balance<OCT> {
        let exchange_rate = pool_token_exchange_rate_at_epoch(pool, epoch);
        let total_sui_withdraw_amount = get_sui_amount(&exchange_rate, pool_token_withdraw_amount);
        let mut reward_withdraw_amount =
            if (total_sui_withdraw_amount >= principal_withdraw_amount)
                total_sui_withdraw_amount - principal_withdraw_amount
            else 0;
        // This may happen when we are withdrawing everything from the pool and
        // the rewards pool balance may be less than reward_withdraw_amount.
        // TODO: FIGURE OUT EXACTLY WHY THIS CAN HAPPEN.
        reward_withdraw_amount = reward_withdraw_amount.min(pool.rewards_pool.value());
        pool.rewards_pool.split(reward_withdraw_amount)
    }

    // ==== preactive pool related ====

    /// Called by `validator` module to activate a staking pool.
    public(package) fun activate_staking_pool(pool: &mut StakingPool, activation_epoch: u64) {
        // Add the initial exchange rate to the table.
        pool.exchange_rates.add(
            activation_epoch,
            initial_exchange_rate()
        );
        // Check that the pool is preactive and not inactive.
        assert!(is_preactive(pool), EPoolAlreadyActive);
        assert!(!is_inactive(pool), EActivationOfInactivePool);
        // Fill in the active epoch.
        pool.activation_epoch.fill(activation_epoch);
    }

    // ==== inactive pool related ====

    /// Deactivate a staking pool by setting the `deactivation_epoch`. After
    /// this pool deactivation, the pool stops earning rewards. Only stake
    /// withdraws can be made to the pool.
    public(package) fun deactivate_staking_pool(pool: &mut StakingPool, deactivation_epoch: u64) {
        // We can't deactivate an already deactivated pool.
        assert!(!is_inactive(pool), EDeactivationOfInactivePool);
        pool.deactivation_epoch = option::some(deactivation_epoch);
    }

    // ==== getters and misc utility functions ====

    public fun sui_balance(pool: &StakingPool): u64 { pool.sui_balance }

    public fun pool_id(staked_oct: &StakedOct): ID { staked_oct.pool_id }

    public use fun fungible_staked_oct_pool_id as FungibleStakedOct.pool_id;
    public fun fungible_staked_oct_pool_id(fungible_staked_oct: &FungibleStakedOct): ID { fungible_staked_oct.pool_id }

    public fun staked_oct_amount(staked_oct: &StakedOct): u64 { staked_oct.principal.value() }

    public fun lock(staked_oct:&StakedOct):bool{staked_oct.lock}

    /// Allows calling `.amount()` on `StakedOct` to invoke `staked_oct_amount`
    public use fun staked_oct_amount as StakedOct.amount;

    public fun stake_activation_epoch(staked_oct: &StakedOct): u64 {
        staked_oct.stake_activation_epoch
    }

    /// Returns true if the input staking pool is preactive.
    public fun is_preactive(pool: &StakingPool): bool{
        pool.activation_epoch.is_none()
    }

    /// Returns true if the input staking pool is inactive.
    public fun is_inactive(pool: &StakingPool): bool {
        pool.deactivation_epoch.is_some()
    }

    public use fun fungible_staked_oct_value as FungibleStakedOct.value;
    public fun fungible_staked_oct_value(fungible_staked_oct: &FungibleStakedOct): u64 { fungible_staked_oct.value }

    public use fun split_fungible_staked_oct as FungibleStakedOct.split;
    public fun split_fungible_staked_oct(
        fungible_staked_oct: &mut FungibleStakedOct,
        split_amount: u64,
        ctx: &mut TxContext
    ): FungibleStakedOct {
        assert!(split_amount <= fungible_staked_oct.value, EInsufficientPoolTokenBalance);

        fungible_staked_oct.value = fungible_staked_oct.value - split_amount;

        FungibleStakedOct {
            id: object::new(ctx),
            pool_id: fungible_staked_oct.pool_id,
            value: split_amount,
        }
    }

    public use fun join_fungible_staked_oct as FungibleStakedOct.join;
    public fun join_fungible_staked_oct(self: &mut FungibleStakedOct, other: FungibleStakedOct) {
        let FungibleStakedOct { id, pool_id, value } = other;
        assert!(self.pool_id == pool_id, EWrongPool);

        object::delete(id);

        self.value = self.value + value;
    }

    /// Split StakedOct `self` to two parts, one with principal `split_amount`,
    /// and the remaining principal is left in `self`.
    /// All the other parameters of the StakedOct like `stake_activation_epoch` or `pool_id` remain the same.
    public fun split(self: &mut StakedOct, split_amount: u64, ctx: &mut TxContext): StakedOct {
        let original_amount = self.principal.value();
        assert!(split_amount <= original_amount, EInsufficientSuiTokenBalance);
        let remaining_amount = original_amount - split_amount;
        // Both resulting parts should have at least MIN_STAKING_THRESHOLD.
        assert!(remaining_amount >= MIN_STAKING_THRESHOLD, EStakedOctBelowThreshold);
        assert!(split_amount >= MIN_STAKING_THRESHOLD, EStakedOctBelowThreshold);
        StakedOct {
            id: object::new(ctx),
            pool_id: self.pool_id,
            stake_activation_epoch: self.stake_activation_epoch,
            principal: self.principal.split(split_amount),
            lock:self.lock,
        }
    }

    /// Split the given StakedOct to the two parts, one with principal `split_amount`,
    /// transfer the newly split part to the sender address.
    public entry fun split_staked_oct(stake: &mut StakedOct, split_amount: u64, ctx: &mut TxContext) {
        transfer::transfer(split(stake, split_amount, ctx), ctx.sender());
    }

    /// Allows calling `.split_to_sender()` on `StakedOct` to invoke `split_staked_oct`
    public use fun split_staked_oct as StakedOct.split_to_sender;

    /// Consume the staked oct `other` and add its value to `self`.
    /// Aborts if some of the staking parameters are incompatible (pool id, stake activation epoch, etc.)
    public entry fun join_staked_oct(self: &mut StakedOct, other: StakedOct) {
        assert!(is_equal_staking_metadata(self, &other), EIncompatibleStakedOct);
        let StakedOct {
            id,
            pool_id: _,
            stake_activation_epoch: _,
            principal,
            lock:_
        } = other;

        id.delete();
        self.principal.join(principal);
    }

    /// Allows calling `.join()` on `StakedOct` to invoke `join_staked_oct`
    public use fun join_staked_oct as StakedOct.join;

    /// Returns true if all the staking parameters of the staked oct except the principal are identical
    public fun is_equal_staking_metadata(self: &StakedOct, other: &StakedOct): bool {
        (self.pool_id == other.pool_id) &&
        (self.stake_activation_epoch == other.stake_activation_epoch) &&
        (self.lock == other.lock)
    }

    public fun pool_token_exchange_rate_at_epoch(pool: &StakingPool, epoch: u64): PoolTokenExchangeRate {
        // If the pool is preactive then the exchange rate is always 1:1.
        if (is_preactive_at_epoch(pool, epoch)) {
            return initial_exchange_rate()
        };
        let clamped_epoch = pool.deactivation_epoch.get_with_default(epoch);
        let mut epoch = clamped_epoch.min(epoch);
        let activation_epoch = *pool.activation_epoch.borrow();

        // Find the latest epoch that's earlier than the given epoch with an entry in the table
        while (epoch >= activation_epoch) {
            if (pool.exchange_rates.contains(epoch)) {
                return pool.exchange_rates[epoch]
            };
            epoch = epoch - 1;
        };
        // This line really should be unreachable. Do we want an assert false here?
        initial_exchange_rate()
    }

    /// Returns the total value of the pending staking requests for this staking pool.
    public fun pending_stake_amount(staking_pool: &StakingPool): u64 {
        staking_pool.pending_stake
    }

    /// Returns the total withdrawal from the staking pool this epoch.
    public fun pending_stake_withdraw_amount(staking_pool: &StakingPool): u64 {
        staking_pool.pending_total_sui_withdraw
    }

    public(package) fun exchange_rates(pool: &StakingPool): &Table<u64, PoolTokenExchangeRate> {
        &pool.exchange_rates
    }

    public fun sui_amount(exchange_rate: &PoolTokenExchangeRate): u64 {
        exchange_rate.sui_amount
    }

    public fun pool_token_amount(exchange_rate: &PoolTokenExchangeRate): u64 {
        exchange_rate.pool_token_amount
    }

    /// Returns true if the provided staking pool is preactive at the provided epoch.
    fun is_preactive_at_epoch(pool: &StakingPool, epoch: u64): bool{
        // Either the pool is currently preactive or the pool's starting epoch is later than the provided epoch.
        is_preactive(pool) || (*pool.activation_epoch.borrow() > epoch)
    }

    fun get_sui_amount(exchange_rate: &PoolTokenExchangeRate, token_amount: u64): u64 {
        // When either amount is 0, that means we have no stakes with this pool.
        // The other amount might be non-zero when there's dust left in the pool.
        if (exchange_rate.sui_amount == 0 || exchange_rate.pool_token_amount == 0) {
            return token_amount
        };
        let res = exchange_rate.sui_amount as u128
                * (token_amount as u128)
                / (exchange_rate.pool_token_amount as u128);
        res as u64
    }

    fun get_token_amount(exchange_rate: &PoolTokenExchangeRate, sui_amount: u64): u64 {
        // When either amount is 0, that means we have no stakes with this pool.
        // The other amount might be non-zero when there's dust left in the pool.
        if (exchange_rate.sui_amount == 0 || exchange_rate.pool_token_amount == 0) {
            return sui_amount
        };
        let res = exchange_rate.pool_token_amount as u128
                * (sui_amount as u128)
                / (exchange_rate.sui_amount as u128);
        res as u64
    }

    fun initial_exchange_rate(): PoolTokenExchangeRate {
        PoolTokenExchangeRate { sui_amount: 0, pool_token_amount: 0 }
    }

    fun check_balance_invariants(pool: &StakingPool, epoch: u64) {
        let exchange_rate = pool_token_exchange_rate_at_epoch(pool, epoch);
        // check that the pool token balance and sui balance ratio matches the exchange rate stored.
        let expected = get_token_amount(&exchange_rate, pool.sui_balance);
        let actual = pool.pool_token_balance;
        assert!(expected == actual, ETokenBalancesDoNotMatchExchangeRate)
    }

    // ==== test-related functions ====

    // Given the `staked_oct` receipt calculate the current rewards (in terms of SUI) for it.
    #[test_only]
    public fun calculate_rewards(
        pool: &StakingPool,
        staked_oct: &StakedOct,
        current_epoch: u64,
    ): u64 {
        let staked_amount = staked_oct_amount(staked_oct);
        let pool_token_withdraw_amount = {
            let exchange_rate_at_staking_epoch = pool_token_exchange_rate_at_epoch(pool, staked_oct.stake_activation_epoch);
            get_token_amount(&exchange_rate_at_staking_epoch, staked_amount)
        };

        let new_epoch_exchange_rate = pool_token_exchange_rate_at_epoch(pool, current_epoch);
        let total_sui_withdraw_amount = get_sui_amount(&new_epoch_exchange_rate, pool_token_withdraw_amount);

        let mut reward_withdraw_amount =
            if (total_sui_withdraw_amount >= staked_amount)
                total_sui_withdraw_amount - staked_amount
            else 0;
        reward_withdraw_amount = reward_withdraw_amount.min(pool.rewards_pool.value());

        staked_amount + reward_withdraw_amount
    }

    #[test_only]
    public(package) fun fungible_staked_oct_data(pool: &StakingPool): &FungibleStakedOctData {
        bag::borrow(&pool.extra_fields, FungibleStakedOctDataKey {})
    }

    #[test_only]
    public use fun fungible_staked_oct_data_total_supply as FungibleStakedOctData.total_supply;

    #[test_only]
    public(package) fun fungible_staked_oct_data_total_supply(fungible_staked_oct_data: &FungibleStakedOctData): u64 {
        fungible_staked_oct_data.total_supply
    }

    #[test_only]
    public use fun fungible_staked_oct_data_principal_value as FungibleStakedOctData.principal_value;

    #[test_only]
    public(package) fun fungible_staked_oct_data_principal_value(fungible_staked_oct_data: &FungibleStakedOctData): u64 {
        fungible_staked_oct_data.principal.value()
    }

    #[test_only]
    public(package) fun pending_pool_token_withdraw_amount(pool: &StakingPool): u64 {
        pool.pending_pool_token_withdraw
    }

    #[test_only]
    public(package) fun create_fungible_staked_oct_for_testing(
        self: &StakingPool,
        value: u64,
        ctx: &mut TxContext
    ) : FungibleStakedOct {
        FungibleStakedOct {
            id: object::new(ctx),
            pool_id: object::id(self),
            value,
        }
    }

    // ==== tests ====

    #[random_test]
    fun test_calculate_fungible_staked_oct_withdraw_amount(
        mut total_sui_amount: u64,
        // these are all in basis points
        mut pool_token_frac: u16,
        mut fungible_staked_oct_data_total_supply_frac: u16,
        mut fungible_staked_oct_data_principal_frac: u16,
        mut fungible_staked_oct_value_bps: u16
    ) {
        use std::u128::max;

        total_sui_amount = std::u64::max(total_sui_amount, 1);

        pool_token_frac = pool_token_frac % 10000;
        fungible_staked_oct_data_total_supply_frac = fungible_staked_oct_data_total_supply_frac % 10000;
        fungible_staked_oct_data_principal_frac = fungible_staked_oct_data_principal_frac % 10000;
        fungible_staked_oct_value_bps = fungible_staked_oct_value_bps % 10000;


        let total_pool_token_amount = max(
            (total_sui_amount as u128) * (pool_token_frac as u128) / 10000,
            1
        );

        let exchange_rate = PoolTokenExchangeRate {
            sui_amount: total_sui_amount,
            pool_token_amount: total_pool_token_amount as u64,
        };

        let fungible_staked_oct_data_total_supply = max(
            total_pool_token_amount * (fungible_staked_oct_data_total_supply_frac as u128) / 10000,
            1
        );
        let fungible_staked_oct_value = fungible_staked_oct_data_total_supply
            * (fungible_staked_oct_value_bps as u128) / 10000;

        let max_principal = get_sui_amount(&exchange_rate, fungible_staked_oct_data_total_supply as u64);
        let fungible_staked_oct_data_principal_amount = max(
            (max_principal as u128) * (fungible_staked_oct_data_principal_frac as u128) / 10000,
            1
        );

        let (principal_amount, rewards_amount) = calculate_fungible_staked_oct_withdraw_amount(
            exchange_rate,
            fungible_staked_oct_value as u64,
            fungible_staked_oct_data_principal_amount as u64,
            fungible_staked_oct_data_total_supply as u64,
        );

        let expected_out = get_sui_amount(&exchange_rate, fungible_staked_oct_value as u64);

        assert!(principal_amount + rewards_amount <= expected_out, 0);

        let min_out = if (expected_out > 2) expected_out - 2 else 0;
        assert!(principal_amount + rewards_amount >= min_out, 0);
    }


}
