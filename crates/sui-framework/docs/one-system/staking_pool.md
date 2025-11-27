---
title: Module `0x3::staking_pool`
---



-  [Resource `StakingPool`](#0x3_staking_pool_StakingPool)
-  [Struct `PoolTokenExchangeRate`](#0x3_staking_pool_PoolTokenExchangeRate)
-  [Resource `StakedOct`](#0x3_staking_pool_StakedOct)
-  [Resource `FungibleStakedOct`](#0x3_staking_pool_FungibleStakedOct)
-  [Resource `FungibleStakedOctData`](#0x3_staking_pool_FungibleStakedOctData)
-  [Struct `FungibleStakedOctDataKey`](#0x3_staking_pool_FungibleStakedOctDataKey)
-  [Constants](#@Constants_0)
-  [Function `new`](#0x3_staking_pool_new)
-  [Function `request_add_stake`](#0x3_staking_pool_request_add_stake)
-  [Function `request_withdraw_stake`](#0x3_staking_pool_request_withdraw_stake)
-  [Function `redeem_fungible_staked_oct`](#0x3_staking_pool_redeem_fungible_staked_oct)
-  [Function `calculate_fungible_staked_oct_withdraw_amount`](#0x3_staking_pool_calculate_fungible_staked_oct_withdraw_amount)
-  [Function `convert_to_fungible_staked_oct`](#0x3_staking_pool_convert_to_fungible_staked_oct)
-  [Function `withdraw_from_principal`](#0x3_staking_pool_withdraw_from_principal)
-  [Function `unwrap_staked_oct`](#0x3_staking_pool_unwrap_staked_oct)
-  [Function `deposit_rewards`](#0x3_staking_pool_deposit_rewards)
-  [Function `process_pending_stakes_and_withdraws`](#0x3_staking_pool_process_pending_stakes_and_withdraws)
-  [Function `process_pending_stake_withdraw`](#0x3_staking_pool_process_pending_stake_withdraw)
-  [Function `process_pending_stake`](#0x3_staking_pool_process_pending_stake)
-  [Function `withdraw_rewards`](#0x3_staking_pool_withdraw_rewards)
-  [Function `activate_staking_pool`](#0x3_staking_pool_activate_staking_pool)
-  [Function `deactivate_staking_pool`](#0x3_staking_pool_deactivate_staking_pool)
-  [Function `sui_balance`](#0x3_staking_pool_sui_balance)
-  [Function `pool_id`](#0x3_staking_pool_pool_id)
-  [Function `fungible_staked_oct_pool_id`](#0x3_staking_pool_fungible_staked_oct_pool_id)
-  [Function `lock`](#0x3_staking_pool_lock)
-  [Function `staked_oct_amount`](#0x3_staking_pool_staked_oct_amount)
-  [Function `stake_activation_epoch`](#0x3_staking_pool_stake_activation_epoch)
-  [Function `is_preactive`](#0x3_staking_pool_is_preactive)
-  [Function `activation_epoch`](#0x3_staking_pool_activation_epoch)
-  [Function `is_inactive`](#0x3_staking_pool_is_inactive)
-  [Function `fungible_staked_oct_value`](#0x3_staking_pool_fungible_staked_oct_value)
-  [Function `split_fungible_staked_oct`](#0x3_staking_pool_split_fungible_staked_oct)
-  [Function `join_fungible_staked_oct`](#0x3_staking_pool_join_fungible_staked_oct)
-  [Function `split`](#0x3_staking_pool_split)
-  [Function `split_staked_oct`](#0x3_staking_pool_split_staked_oct)
-  [Function `join_staked_oct`](#0x3_staking_pool_join_staked_oct)
-  [Function `is_equal_staking_metadata`](#0x3_staking_pool_is_equal_staking_metadata)
-  [Function `pool_token_exchange_rate_at_epoch`](#0x3_staking_pool_pool_token_exchange_rate_at_epoch)
-  [Function `pending_stake_amount`](#0x3_staking_pool_pending_stake_amount)
-  [Function `pending_stake_withdraw_amount`](#0x3_staking_pool_pending_stake_withdraw_amount)
-  [Function `exchange_rates`](#0x3_staking_pool_exchange_rates)
-  [Function `sui_amount`](#0x3_staking_pool_sui_amount)
-  [Function `pool_token_amount`](#0x3_staking_pool_pool_token_amount)
-  [Function `is_preactive_at_epoch`](#0x3_staking_pool_is_preactive_at_epoch)
-  [Function `get_sui_amount`](#0x3_staking_pool_get_sui_amount)
-  [Function `get_token_amount`](#0x3_staking_pool_get_token_amount)
-  [Function `initial_exchange_rate`](#0x3_staking_pool_initial_exchange_rate)
-  [Function `check_balance_invariants`](#0x3_staking_pool_check_balance_invariants)
-  [Function `calculate_rewards`](#0x3_staking_pool_calculate_rewards)


<pre><code><b>use</b> <a href="../move-stdlib/option.md#0x1_option">0x1::option</a>;
<b>use</b> <a href="../move-stdlib/u64.md#0x1_u64">0x1::u64</a>;
<b>use</b> <a href="../one-framework/bag.md#0x2_bag">0x2::bag</a>;
<b>use</b> <a href="../one-framework/balance.md#0x2_balance">0x2::balance</a>;
<b>use</b> <a href="../one-framework/object.md#0x2_object">0x2::object</a>;
<b>use</b> <a href="../one-framework/oct.md#0x2_oct">0x2::oct</a>;
<b>use</b> <a href="../one-framework/table.md#0x2_table">0x2::table</a>;
<b>use</b> <a href="../one-framework/transfer.md#0x2_transfer">0x2::transfer</a>;
<b>use</b> <a href="../one-framework/tx_context.md#0x2_tx_context">0x2::tx_context</a>;
</code></pre>



<a name="0x3_staking_pool_StakingPool"></a>

## Resource `StakingPool`

A staking pool embedded in each validator struct in the system state object.


<pre><code><b>struct</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a> <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <a href="../one-framework/object.md#0x2_object_UID">object::UID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>activation_epoch: <a href="../move-stdlib/option.md#0x1_option_Option">option::Option</a>&lt;<a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;</code>
</dt>
<dd>
 The epoch at which this pool became active.
 The value is <code>None</code> if the pool is pre-active and <code>Some(&lt;epoch_number&gt;)</code> if active or inactive.
</dd>
<dt>
<code>deactivation_epoch: <a href="../move-stdlib/option.md#0x1_option_Option">option::Option</a>&lt;<a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;</code>
</dt>
<dd>
 The epoch at which this staking pool ceased to be active. <code>None</code> = {pre-active, active},
 <code>Some(&lt;epoch_number&gt;)</code> if in-active, and it was de-activated at epoch <code>&lt;epoch_number&gt;</code>.
</dd>
<dt>
<code>sui_balance: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 The total number of SUI tokens in this pool, including the SUI in the rewards_pool, as well as in all the principal
 in the <code><a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a></code> object, updated at epoch boundaries.
</dd>
<dt>
<code>rewards_pool: <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;</code>
</dt>
<dd>
 The epoch stake rewards will be added here at the end of each epoch.
</dd>
<dt>
<code>pool_token_balance: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 Total number of pool tokens issued by the pool.
</dd>
<dt>
<code>exchange_rates: <a href="../one-framework/table.md#0x2_table_Table">table::Table</a>&lt;<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>&gt;</code>
</dt>
<dd>
 Exchange rate history of previous epochs. Key is the epoch number.
 The entries start from the <code>activation_epoch</code> of this pool and contains exchange rates at the beginning of each epoch,
 i.e., right after the rewards for the previous epoch have been deposited into the pool.
</dd>
<dt>
<code>pending_stake: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 Pending stake amount for this epoch, emptied at epoch boundaries.
</dd>
<dt>
<code>pending_total_oct_withdraw: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 Pending stake withdrawn during the current epoch, emptied at epoch boundaries.
 This includes both the principal and rewards SUI withdrawn.
</dd>
<dt>
<code>pending_pool_token_withdraw: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 Pending pool token withdrawn during the current epoch, emptied at epoch boundaries.
</dd>
<dt>
<code>extra_fields: <a href="../one-framework/bag.md#0x2_bag_Bag">bag::Bag</a></code>
</dt>
<dd>
 Any extra fields that's not defined statically.
</dd>
</dl>


</details>

<a name="0x3_staking_pool_PoolTokenExchangeRate"></a>

## Struct `PoolTokenExchangeRate`

Struct representing the exchange rate of the stake pool token to SUI.


<pre><code><b>struct</b> <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>sui_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
<dt>
<code>pool_token_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x3_staking_pool_StakedOct"></a>

## Resource `StakedOct`

A self-custodial object holding the staked OCT tokens.


<pre><code><b>struct</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <a href="../one-framework/object.md#0x2_object_UID">object::UID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>pool_id: <a href="../one-framework/object.md#0x2_object_ID">object::ID</a></code>
</dt>
<dd>
 ID of the staking pool we are staking with.
</dd>
<dt>
<code>stake_activation_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 The epoch at which the stake becomes active.
</dd>
<dt>
<code>principal: <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;</code>
</dt>
<dd>
 The staked OCT tokens.
</dd>
<dt>
<code>lock: bool</code>
</dt>
<dd>
 coin lock
</dd>
</dl>


</details>

<a name="0x3_staking_pool_FungibleStakedOct"></a>

## Resource `FungibleStakedOct`

An alternative to <code><a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a></code> that holds the pool token amount instead of the SUI balance.
StakedOct objects can be converted to FungibleStakedOcts after the initial warmup period.
The advantage of this is that you can now merge multiple StakedOct objects from different
activation epochs into a single FungibleStakedOct object.


<pre><code><b>struct</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a> <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <a href="../one-framework/object.md#0x2_object_UID">object::UID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>pool_id: <a href="../one-framework/object.md#0x2_object_ID">object::ID</a></code>
</dt>
<dd>
 ID of the staking pool we are staking with.
</dd>
<dt>
<code>value: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 The pool token amount.
</dd>
</dl>


</details>

<a name="0x3_staking_pool_FungibleStakedOctData"></a>

## Resource `FungibleStakedOctData`

Holds useful information


<pre><code><b>struct</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctData">FungibleStakedOctData</a> <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <a href="../one-framework/object.md#0x2_object_UID">object::UID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>total_supply: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 fungible_staked_oct supply
</dd>
<dt>
<code>principal: <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;</code>
</dt>
<dd>
 principal balance. Rewards are withdrawn from the reward pool
</dd>
</dl>


</details>

<a name="0x3_staking_pool_FungibleStakedOctDataKey"></a>

## Struct `FungibleStakedOctDataKey`



<pre><code><b>struct</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctDataKey">FungibleStakedOctDataKey</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>dummy_field: bool</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="0x3_staking_pool_EActivationOfInactivePool"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EActivationOfInactivePool">EActivationOfInactivePool</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 16;
</code></pre>



<a name="0x3_staking_pool_ECannotMintFungibleStakedOctYet"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_ECannotMintFungibleStakedOctYet">ECannotMintFungibleStakedOctYet</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 19;
</code></pre>



<a name="0x3_staking_pool_EDeactivationOfInactivePool"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EDeactivationOfInactivePool">EDeactivationOfInactivePool</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 11;
</code></pre>



<a name="0x3_staking_pool_EDelegationOfZeroSui"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EDelegationOfZeroSui">EDelegationOfZeroSui</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 17;
</code></pre>



<a name="0x3_staking_pool_EDelegationToInactivePool"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EDelegationToInactivePool">EDelegationToInactivePool</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 10;
</code></pre>



<a name="0x3_staking_pool_EDestroyNonzeroBalance"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EDestroyNonzeroBalance">EDestroyNonzeroBalance</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 5;
</code></pre>



<a name="0x3_staking_pool_EIncompatibleStakedOct"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EIncompatibleStakedOct">EIncompatibleStakedOct</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 12;
</code></pre>



<a name="0x3_staking_pool_EInsufficientPoolTokenBalance"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EInsufficientPoolTokenBalance">EInsufficientPoolTokenBalance</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 0;
</code></pre>



<a name="0x3_staking_pool_EInsufficientRewardsPoolBalance"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EInsufficientRewardsPoolBalance">EInsufficientRewardsPoolBalance</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 4;
</code></pre>



<a name="0x3_staking_pool_EInsufficientSuiTokenBalance"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EInsufficientSuiTokenBalance">EInsufficientSuiTokenBalance</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 3;
</code></pre>



<a name="0x3_staking_pool_EInvariantFailure"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EInvariantFailure">EInvariantFailure</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 20;
</code></pre>



<a name="0x3_staking_pool_EPendingDelegationDoesNotExist"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EPendingDelegationDoesNotExist">EPendingDelegationDoesNotExist</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 8;
</code></pre>



<a name="0x3_staking_pool_EPoolAlreadyActive"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EPoolAlreadyActive">EPoolAlreadyActive</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 14;
</code></pre>



<a name="0x3_staking_pool_EPoolPreactiveOrInactive"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EPoolPreactiveOrInactive">EPoolPreactiveOrInactive</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 15;
</code></pre>



<a name="0x3_staking_pool_EStakedOctBelowThreshold"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EStakedOctBelowThreshold">EStakedOctBelowThreshold</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 18;
</code></pre>



<a name="0x3_staking_pool_ETokenBalancesDoNotMatchExchangeRate"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_ETokenBalancesDoNotMatchExchangeRate">ETokenBalancesDoNotMatchExchangeRate</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 9;
</code></pre>



<a name="0x3_staking_pool_ETokenTimeLockIsSome"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_ETokenTimeLockIsSome">ETokenTimeLockIsSome</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 6;
</code></pre>



<a name="0x3_staking_pool_EWithdrawAmountCannotBeZero"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EWithdrawAmountCannotBeZero">EWithdrawAmountCannotBeZero</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 2;
</code></pre>



<a name="0x3_staking_pool_EWithdrawalInSameEpoch"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EWithdrawalInSameEpoch">EWithdrawalInSameEpoch</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 13;
</code></pre>



<a name="0x3_staking_pool_EWrongDelegation"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EWrongDelegation">EWrongDelegation</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 7;
</code></pre>



<a name="0x3_staking_pool_EWrongPool"></a>



<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_EWrongPool">EWrongPool</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 1;
</code></pre>



<a name="0x3_staking_pool_MIN_STAKING_THRESHOLD"></a>

StakedOct objects cannot be split to below this amount.


<pre><code><b>const</b> <a href="staking_pool.md#0x3_staking_pool_MIN_STAKING_THRESHOLD">MIN_STAKING_THRESHOLD</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 1000000000;
</code></pre>



<a name="0x3_staking_pool_new"></a>

## Function `new`

Create a new, empty staking pool.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_new">new</a>(ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_new">new</a>(ctx: &<b>mut</b> TxContext): <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a> {
    <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a> {
        id: <a href="../one-framework/object.md#0x2_object_new">object::new</a>(ctx),
        activation_epoch: <a href="../move-stdlib/option.md#0x1_option_none">option::none</a>(),
        deactivation_epoch: <a href="../move-stdlib/option.md#0x1_option_none">option::none</a>(),
        sui_balance: 0,
        rewards_pool: <a href="../one-framework/balance.md#0x2_balance_zero">balance::zero</a>(),
        pool_token_balance: 0,
        exchange_rates: <a href="../one-framework/table.md#0x2_table_new">table::new</a>(ctx),
        pending_stake: 0,
        pending_total_oct_withdraw: 0,
        pending_pool_token_withdraw: 0,
        extra_fields: <a href="../one-framework/bag.md#0x2_bag_new">bag::new</a>(ctx),
    }
}
</code></pre>



</details>

<a name="0x3_staking_pool_request_add_stake"></a>

## Function `request_add_stake`

Request to stake to a staking pool. The stake starts counting at the beginning of the next epoch,


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_request_add_stake">request_add_stake</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, stake: <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;, stake_activation_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, lock: bool, ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_request_add_stake">request_add_stake</a>(
    pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    stake: Balance&lt;OCT&gt;,
    stake_activation_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    lock: bool,//add
    ctx: &<b>mut</b> TxContext,
): <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> {
    <b>let</b> sui_amount = stake.value();
    <b>assert</b>!(!pool.<a href="staking_pool.md#0x3_staking_pool_is_inactive">is_inactive</a>(), <a href="staking_pool.md#0x3_staking_pool_EDelegationToInactivePool">EDelegationToInactivePool</a>);
    <b>assert</b>!(sui_amount &gt; 0, <a href="staking_pool.md#0x3_staking_pool_EDelegationOfZeroSui">EDelegationOfZeroSui</a>);

    pool.pending_stake = pool.pending_stake + sui_amount;
    <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> {
        id: <a href="../one-framework/object.md#0x2_object_new">object::new</a>(ctx),
        pool_id: <a href="../one-framework/object.md#0x2_object_id">object::id</a>(pool),
        stake_activation_epoch,
        principal: stake,
        lock, //add
    }
}
</code></pre>



</details>

<a name="0x3_staking_pool_request_withdraw_stake"></a>

## Function `request_withdraw_stake`

Request to withdraw the given stake plus rewards from a staking pool.
Both the principal and corresponding rewards in SUI are withdrawn.
A proportional amount of pool token withdraw is recorded and processed at epoch change time.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_request_withdraw_stake">request_withdraw_stake</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>, ctx: &<a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_request_withdraw_stake">request_withdraw_stake</a>(
    pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>,
    ctx: &TxContext,
): Balance&lt;OCT&gt; {
    // stake is inactive and the pool is not preactive - allow direct withdraw
    // the reason why we exclude preactive pools is <b>to</b> avoid potential underflow
    // on subtraction, and we need <b>to</b> enforce `pending_stake_withdraw` call.
    <b>if</b> (staked_oct.stake_activation_epoch &gt; ctx.epoch() && !pool.<a href="staking_pool.md#0x3_staking_pool_is_preactive">is_preactive</a>()) {
        <b>let</b> principal = staked_oct.into_balance();
        pool.pending_stake = pool.pending_stake - principal.value();
        <b>return</b> principal
    };

    <b>let</b> (pool_token_withdraw_amount, <b>mut</b> principal_withdraw) = pool.<a href="staking_pool.md#0x3_staking_pool_withdraw_from_principal">withdraw_from_principal</a>(
        staked_oct,
    );
    <b>let</b> principal_withdraw_amount = principal_withdraw.value();

    <b>let</b> rewards_withdraw = pool.<a href="staking_pool.md#0x3_staking_pool_withdraw_rewards">withdraw_rewards</a>(
        principal_withdraw_amount,
        pool_token_withdraw_amount,
        ctx.epoch(),
    );
    <b>let</b> total_sui_withdraw_amount = principal_withdraw_amount + rewards_withdraw.value();

    pool.pending_total_oct_withdraw = pool.pending_total_oct_withdraw + total_sui_withdraw_amount;
    pool.pending_pool_token_withdraw =
        pool.pending_pool_token_withdraw + pool_token_withdraw_amount;

    // If the pool is inactive or preactive, we immediately process the withdrawal.
    <b>if</b> (pool.<a href="staking_pool.md#0x3_staking_pool_is_inactive">is_inactive</a>() || pool.<a href="staking_pool.md#0x3_staking_pool_is_preactive">is_preactive</a>()) pool.<a href="staking_pool.md#0x3_staking_pool_process_pending_stake_withdraw">process_pending_stake_withdraw</a>();

    // TODO: implement withdraw bonding period here.
    principal_withdraw.join(rewards_withdraw);
    principal_withdraw
}
</code></pre>



</details>

<a name="0x3_staking_pool_redeem_fungible_staked_oct"></a>

## Function `redeem_fungible_staked_oct`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_redeem_fungible_staked_oct">redeem_fungible_staked_oct</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, fungible_staked_oct: <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>, ctx: &<a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_redeem_fungible_staked_oct">redeem_fungible_staked_oct</a>(
    pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    fungible_staked_oct: <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a>,
    ctx: &TxContext,
): Balance&lt;OCT&gt; {
    <b>let</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a> { id, pool_id, value } = fungible_staked_oct;
    <b>assert</b>!(pool_id == <a href="../one-framework/object.md#0x2_object_id">object::id</a>(pool), <a href="staking_pool.md#0x3_staking_pool_EWrongPool">EWrongPool</a>);

    id.delete();

    <b>let</b> latest_exchange_rate = pool.<a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(ctx.epoch());
    <b>let</b> fungible_staked_oct_data: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctData">FungibleStakedOctData</a> =
        &<b>mut</b> pool.extra_fields[<a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctDataKey">FungibleStakedOctDataKey</a> {}];

    <b>let</b> (
        principal_amount,
        rewards_amount,
    ) = latest_exchange_rate.<a href="staking_pool.md#0x3_staking_pool_calculate_fungible_staked_oct_withdraw_amount">calculate_fungible_staked_oct_withdraw_amount</a>(
        value,
        fungible_staked_oct_data.principal.value(),
        fungible_staked_oct_data.total_supply,
    );

    fungible_staked_oct_data.total_supply = fungible_staked_oct_data.total_supply - value;

    <b>let</b> <b>mut</b> sui_out = fungible_staked_oct_data.principal.<a href="staking_pool.md#0x3_staking_pool_split">split</a>(principal_amount);
    sui_out.join(pool.rewards_pool.<a href="staking_pool.md#0x3_staking_pool_split">split</a>(rewards_amount));

    pool.pending_total_oct_withdraw = pool.pending_total_oct_withdraw + sui_out.value();
    pool.pending_pool_token_withdraw = pool.pending_pool_token_withdraw + value;

    sui_out
}
</code></pre>



</details>

<a name="0x3_staking_pool_calculate_fungible_staked_oct_withdraw_amount"></a>

## Function `calculate_fungible_staked_oct_withdraw_amount`

written in separate function so i can test with random values
returns (principal_withdraw_amount, rewards_withdraw_amount)


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_calculate_fungible_staked_oct_withdraw_amount">calculate_fungible_staked_oct_withdraw_amount</a>(latest_exchange_rate: <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>, fungible_staked_oct_value: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, fungible_staked_oct_data_principal_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, fungible_staked_oct_data_total_supply: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): (<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, <a href="../move-stdlib/u64.md#0x1_u64">u64</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_calculate_fungible_staked_oct_withdraw_amount">calculate_fungible_staked_oct_withdraw_amount</a>(
    latest_exchange_rate: <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a>,
    fungible_staked_oct_value: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    fungible_staked_oct_data_principal_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, // fungible_staked_oct_data.principal.value()
    fungible_staked_oct_data_total_supply: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, // fungible_staked_oct_data.total_supply
): (<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, <a href="../move-stdlib/u64.md#0x1_u64">u64</a>) {
    // 1. <b>if</b> the entire <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctData">FungibleStakedOctData</a> supply is redeemed, how much sui should we receive?
    <b>let</b> total_sui_amount = latest_exchange_rate.<a href="staking_pool.md#0x3_staking_pool_get_sui_amount">get_sui_amount</a>(
        fungible_staked_oct_data_total_supply,
    );

    // <b>min</b> <b>with</b> total_sui_amount <b>to</b> prevent underflow
    <b>let</b> fungible_staked_oct_data_principal_amount = fungible_staked_oct_data_principal_amount.<b>min</b>(
        total_sui_amount,
    );

    // 2. how much do we need <b>to</b> withdraw from the rewards pool?
    <b>let</b> total_rewards = total_sui_amount - fungible_staked_oct_data_principal_amount;

    // 3. proportionally withdraw from both wrt the fungible_staked_oct_value.
    <b>let</b> principal_withdraw_amount = mul_div!(
        fungible_staked_oct_value,
        fungible_staked_oct_data_principal_amount,
        fungible_staked_oct_data_total_supply,
    );

    <b>let</b> rewards_withdraw_amount = mul_div!(
        fungible_staked_oct_value,
        total_rewards,
        fungible_staked_oct_data_total_supply,
    );

    // <b>invariant</b> check, just in case
    <b>let</b> expected_sui_amount = latest_exchange_rate.<a href="staking_pool.md#0x3_staking_pool_get_sui_amount">get_sui_amount</a>(fungible_staked_oct_value);
    <b>assert</b>!(
        principal_withdraw_amount + rewards_withdraw_amount &lt;= expected_sui_amount,
        <a href="staking_pool.md#0x3_staking_pool_EInvariantFailure">EInvariantFailure</a>,
    );

    (principal_withdraw_amount, rewards_withdraw_amount)
}
</code></pre>



</details>

<a name="0x3_staking_pool_convert_to_fungible_staked_oct"></a>

## Function `convert_to_fungible_staked_oct`

Convert the given staked OCT to an FungibleStakedOct object


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_convert_to_fungible_staked_oct">convert_to_fungible_staked_oct</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>, ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_convert_to_fungible_staked_oct">convert_to_fungible_staked_oct</a>(
    pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>,
    ctx: &<b>mut</b> TxContext,
): <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a> {
    <b>let</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> { id, pool_id, stake_activation_epoch, principal,lock:_ } = staked_oct;

    <b>assert</b>!(pool_id == <a href="../one-framework/object.md#0x2_object_id">object::id</a>(pool), <a href="staking_pool.md#0x3_staking_pool_EWrongPool">EWrongPool</a>);
    <b>assert</b>!(ctx.epoch() &gt;= stake_activation_epoch, <a href="staking_pool.md#0x3_staking_pool_ECannotMintFungibleStakedOctYet">ECannotMintFungibleStakedOctYet</a>);
    <b>assert</b>!(!pool.<a href="staking_pool.md#0x3_staking_pool_is_preactive">is_preactive</a>() && !pool.<a href="staking_pool.md#0x3_staking_pool_is_inactive">is_inactive</a>(), <a href="staking_pool.md#0x3_staking_pool_EPoolPreactiveOrInactive">EPoolPreactiveOrInactive</a>);

    id.delete();

    <b>let</b> exchange_rate_at_staking_epoch = pool.<a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(
        stake_activation_epoch,
    );

    <b>let</b> pool_token_amount = exchange_rate_at_staking_epoch.<a href="staking_pool.md#0x3_staking_pool_get_token_amount">get_token_amount</a>(principal.value());
    <b>let</b> key = <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctDataKey">FungibleStakedOctDataKey</a> {};

    <b>if</b> (!pool.extra_fields.contains(key)) {
        pool
            .extra_fields
            .add(
                key,
                <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctData">FungibleStakedOctData</a> {
                    id: <a href="../one-framework/object.md#0x2_object_new">object::new</a>(ctx),
                    total_supply: pool_token_amount,
                    principal,
                },
            );
    } <b>else</b> {
        <b>let</b> fungible_staked_oct_data: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOctData">FungibleStakedOctData</a> = &<b>mut</b> pool.extra_fields[key];
        fungible_staked_oct_data.total_supply =
            fungible_staked_oct_data.total_supply + pool_token_amount;
        fungible_staked_oct_data.principal.join(principal);
    };

    <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a> {
        id: <a href="../one-framework/object.md#0x2_object_new">object::new</a>(ctx),
        pool_id,
        value: pool_token_amount,
    }
}
</code></pre>



</details>

<a name="0x3_staking_pool_withdraw_from_principal"></a>

## Function `withdraw_from_principal`

Withdraw the principal SUI stored in the StakedOct object, and calculate the corresponding amount of pool
tokens using exchange rate at staking epoch.
Returns values are amount of pool tokens withdrawn and withdrawn principal portion of SUI.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_withdraw_from_principal">withdraw_from_principal</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>): (<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_withdraw_from_principal">withdraw_from_principal</a>(
    pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>,
): (<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, Balance&lt;OCT&gt;) {
    // Check that the stake information matches the pool.
    <b>assert</b>!(staked_oct.pool_id == <a href="../one-framework/object.md#0x2_object_id">object::id</a>(pool), <a href="staking_pool.md#0x3_staking_pool_EWrongPool">EWrongPool</a>);

    <b>let</b> exchange_rate_at_staking_epoch = pool.<a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(staked_oct.stake_activation_epoch);
    <b>let</b> principal_withdraw = staked_oct.into_balance();
    <b>let</b> pool_token_withdraw_amount = exchange_rate_at_staking_epoch.<a href="staking_pool.md#0x3_staking_pool_get_token_amount">get_token_amount</a>(principal_withdraw.value());

    (pool_token_withdraw_amount, principal_withdraw)
}
</code></pre>



</details>

<a name="0x3_staking_pool_unwrap_staked_oct"></a>

## Function `unwrap_staked_oct`



<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_unwrap_staked_oct">unwrap_staked_oct</a>(staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>): <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_unwrap_staked_oct">unwrap_staked_oct</a>(staked_oct: <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>): Balance&lt;OCT&gt; {
    <b>let</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> { id, principal, .. } = staked_oct;
    id.delete();
    principal
}
</code></pre>



</details>

<a name="0x3_staking_pool_deposit_rewards"></a>

## Function `deposit_rewards`

Called at epoch advancement times to add rewards (in SUI) to the staking pool.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_deposit_rewards">deposit_rewards</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, rewards: <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_deposit_rewards">deposit_rewards</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>, rewards: Balance&lt;OCT&gt;) {
    pool.sui_balance = pool.sui_balance + rewards.value();
    pool.rewards_pool.join(rewards);
}
</code></pre>



</details>

<a name="0x3_staking_pool_process_pending_stakes_and_withdraws"></a>

## Function `process_pending_stakes_and_withdraws`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_process_pending_stakes_and_withdraws">process_pending_stakes_and_withdraws</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, ctx: &<a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_process_pending_stakes_and_withdraws">process_pending_stakes_and_withdraws</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>, ctx: &TxContext) {
    <b>let</b> new_epoch = ctx.epoch() + 1;
    pool.<a href="staking_pool.md#0x3_staking_pool_process_pending_stake_withdraw">process_pending_stake_withdraw</a>();
    pool.<a href="staking_pool.md#0x3_staking_pool_process_pending_stake">process_pending_stake</a>();
    pool
        .exchange_rates
        .add(
            new_epoch,
            <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a> {
                sui_amount: pool.sui_balance,
                pool_token_amount: pool.pool_token_balance,
            },
        );

    pool.<a href="staking_pool.md#0x3_staking_pool_check_balance_invariants">check_balance_invariants</a>(new_epoch);
}
</code></pre>



</details>

<a name="0x3_staking_pool_process_pending_stake_withdraw"></a>

## Function `process_pending_stake_withdraw`

Called at epoch boundaries to process pending stake withdraws requested during the epoch.
Also called immediately upon withdrawal if the pool is inactive.


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_process_pending_stake_withdraw">process_pending_stake_withdraw</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_process_pending_stake_withdraw">process_pending_stake_withdraw</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>) {
    pool.sui_balance = pool.sui_balance - pool.pending_total_oct_withdraw;
    pool.pool_token_balance = pool.pool_token_balance - pool.pending_pool_token_withdraw;
    pool.pending_total_oct_withdraw = 0;
    pool.pending_pool_token_withdraw = 0;
}
</code></pre>



</details>

<a name="0x3_staking_pool_process_pending_stake"></a>

## Function `process_pending_stake`

Called at epoch boundaries to process the pending stake.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_process_pending_stake">process_pending_stake</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_process_pending_stake">process_pending_stake</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>) {
    // Use the most up <b>to</b> date exchange rate <b>with</b> the rewards deposited and withdraws effectuated.
    <b>let</b> latest_exchange_rate = <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a> {
        sui_amount: pool.sui_balance,
        pool_token_amount: pool.pool_token_balance,
    };
    pool.sui_balance = pool.sui_balance + pool.pending_stake;
    pool.pool_token_balance = latest_exchange_rate.<a href="staking_pool.md#0x3_staking_pool_get_token_amount">get_token_amount</a>(pool.sui_balance);
    pool.pending_stake = 0;
}
</code></pre>



</details>

<a name="0x3_staking_pool_withdraw_rewards"></a>

## Function `withdraw_rewards`

This function does the following:
1. Calculates the total amount of SUI (including principal and rewards) that the provided pool tokens represent
at the current exchange rate.
2. Using the above number and the given <code>principal_withdraw_amount</code>, calculates the rewards portion of the
stake we should withdraw.
3. Withdraws the rewards portion from the rewards pool at the current exchange rate. We only withdraw the rewards
portion because the principal portion was already taken out of the staker's self custodied StakedOct.


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_withdraw_rewards">withdraw_rewards</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, principal_withdraw_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, pool_token_withdraw_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_withdraw_rewards">withdraw_rewards</a>(
    pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    principal_withdraw_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    pool_token_withdraw_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
): Balance&lt;OCT&gt; {
    <b>let</b> exchange_rate = pool.<a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(epoch);
    <b>let</b> total_sui_withdraw_amount = exchange_rate.<a href="staking_pool.md#0x3_staking_pool_get_sui_amount">get_sui_amount</a>(pool_token_withdraw_amount);
    <b>let</b> <b>mut</b> reward_withdraw_amount = <b>if</b> (total_sui_withdraw_amount &gt;= principal_withdraw_amount) {
        total_sui_withdraw_amount - principal_withdraw_amount
    } <b>else</b> 0;

    // This may happen when we are withdrawing everything from the pool and
    // the rewards pool <a href="../one-framework/balance.md#0x2_balance">balance</a> may be less than reward_withdraw_amount.
    // TODO: FIGURE OUT EXACTLY WHY THIS CAN HAPPEN.
    reward_withdraw_amount = reward_withdraw_amount.<b>min</b>(pool.rewards_pool.value());
    pool.rewards_pool.<a href="staking_pool.md#0x3_staking_pool_split">split</a>(reward_withdraw_amount)
}
</code></pre>



</details>

<a name="0x3_staking_pool_activate_staking_pool"></a>

## Function `activate_staking_pool`

Called by <code><a href="validator.md#0x3_validator">validator</a></code> module to activate a staking pool.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_activate_staking_pool">activate_staking_pool</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, activation_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_activate_staking_pool">activate_staking_pool</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>, activation_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>) {
    // Add the initial exchange rate <b>to</b> the <a href="../one-framework/table.md#0x2_table">table</a>.
    pool.exchange_rates.add(activation_epoch, <a href="staking_pool.md#0x3_staking_pool_initial_exchange_rate">initial_exchange_rate</a>());
    // Check that the pool is preactive and not inactive.
    <b>assert</b>!(pool.<a href="staking_pool.md#0x3_staking_pool_is_preactive">is_preactive</a>(), <a href="staking_pool.md#0x3_staking_pool_EPoolAlreadyActive">EPoolAlreadyActive</a>);
    <b>assert</b>!(!pool.<a href="staking_pool.md#0x3_staking_pool_is_inactive">is_inactive</a>(), <a href="staking_pool.md#0x3_staking_pool_EActivationOfInactivePool">EActivationOfInactivePool</a>);
    // Fill in the active epoch.
    pool.activation_epoch.fill(activation_epoch);
}
</code></pre>



</details>

<a name="0x3_staking_pool_deactivate_staking_pool"></a>

## Function `deactivate_staking_pool`

Deactivate a staking pool by setting the <code>deactivation_epoch</code>. After
this pool deactivation, the pool stops earning rewards. Only stake
withdraws can be made to the pool.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_deactivate_staking_pool">deactivate_staking_pool</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, deactivation_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_deactivate_staking_pool">deactivate_staking_pool</a>(pool: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>, deactivation_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>) {
    // We can't deactivate an already deactivated pool.
    <b>assert</b>!(!pool.<a href="staking_pool.md#0x3_staking_pool_is_inactive">is_inactive</a>(), <a href="staking_pool.md#0x3_staking_pool_EDeactivationOfInactivePool">EDeactivationOfInactivePool</a>);
    pool.deactivation_epoch = <a href="../move-stdlib/option.md#0x1_option_some">option::some</a>(deactivation_epoch);
}
</code></pre>



</details>

<a name="0x3_staking_pool_sui_balance"></a>

## Function `sui_balance`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_sui_balance">sui_balance</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_sui_balance">sui_balance</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> { pool.sui_balance }
</code></pre>



</details>

<a name="0x3_staking_pool_pool_id"></a>

## Function `pool_id`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pool_id">pool_id</a>(staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>): <a href="../one-framework/object.md#0x2_object_ID">object::ID</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pool_id">pool_id</a>(staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>): ID { staked_oct.pool_id }
</code></pre>



</details>

<a name="0x3_staking_pool_fungible_staked_oct_pool_id"></a>

## Function `fungible_staked_oct_pool_id`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_fungible_staked_oct_pool_id">fungible_staked_oct_pool_id</a>(fungible_staked_oct: &<a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>): <a href="../one-framework/object.md#0x2_object_ID">object::ID</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_fungible_staked_oct_pool_id">fungible_staked_oct_pool_id</a>(fungible_staked_oct: &<a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a>): ID {
    fungible_staked_oct.pool_id
}
</code></pre>



</details>

<a name="0x3_staking_pool_lock"></a>

## Function `lock`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_lock">lock</a>(staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_lock">lock</a>(staked_oct:&<a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>):bool{staked_oct.lock}
</code></pre>



</details>

<a name="0x3_staking_pool_staked_oct_amount"></a>

## Function `staked_oct_amount`

Returns the principal amount of <code><a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a></code>.


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_staked_oct_amount">staked_oct_amount</a>(staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_staked_oct_amount">staked_oct_amount</a>(staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> { staked_oct.principal.value() }
</code></pre>



</details>

<a name="0x3_staking_pool_stake_activation_epoch"></a>

## Function `stake_activation_epoch`

Returns the activation epoch of <code><a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a></code>.


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_stake_activation_epoch">stake_activation_epoch</a>(staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_stake_activation_epoch">stake_activation_epoch</a>(staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    staked_oct.stake_activation_epoch
}
</code></pre>



</details>

<a name="0x3_staking_pool_is_preactive"></a>

## Function `is_preactive`

Returns true if the input staking pool is preactive.


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_preactive">is_preactive</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_preactive">is_preactive</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>): bool {
    pool.activation_epoch.is_none()
}
</code></pre>



</details>

<a name="0x3_staking_pool_activation_epoch"></a>

## Function `activation_epoch`

Returns the activation epoch of the <code><a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a></code>. For validator candidates,
or pending validators, the value returned is <code>None</code>. For active validators,
the value is the epoch before the validator was activated.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_activation_epoch">activation_epoch</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>): <a href="../move-stdlib/option.md#0x1_option_Option">option::Option</a>&lt;<a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_activation_epoch">activation_epoch</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>): Option&lt;<a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt; {
    pool.activation_epoch
}
</code></pre>



</details>

<a name="0x3_staking_pool_is_inactive"></a>

## Function `is_inactive`

Returns true if the input staking pool is inactive.


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_inactive">is_inactive</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_inactive">is_inactive</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>): bool {
    pool.deactivation_epoch.is_some()
}
</code></pre>



</details>

<a name="0x3_staking_pool_fungible_staked_oct_value"></a>

## Function `fungible_staked_oct_value`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_fungible_staked_oct_value">fungible_staked_oct_value</a>(fungible_staked_oct: &<a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_fungible_staked_oct_value">fungible_staked_oct_value</a>(fungible_staked_oct: &<a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    fungible_staked_oct.value
}
</code></pre>



</details>

<a name="0x3_staking_pool_split_fungible_staked_oct"></a>

## Function `split_fungible_staked_oct`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_split_fungible_staked_oct">split_fungible_staked_oct</a>(fungible_staked_oct: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>, split_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_split_fungible_staked_oct">split_fungible_staked_oct</a>(
    fungible_staked_oct: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a>,
    split_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    ctx: &<b>mut</b> TxContext,
): <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a> {
    <b>assert</b>!(split_amount &lt;= fungible_staked_oct.value, <a href="staking_pool.md#0x3_staking_pool_EInsufficientPoolTokenBalance">EInsufficientPoolTokenBalance</a>);

    fungible_staked_oct.value = fungible_staked_oct.value - split_amount;

    <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a> {
        id: <a href="../one-framework/object.md#0x2_object_new">object::new</a>(ctx),
        pool_id: fungible_staked_oct.pool_id,
        value: split_amount,
    }
}
</code></pre>



</details>

<a name="0x3_staking_pool_join_fungible_staked_oct"></a>

## Function `join_fungible_staked_oct`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_join_fungible_staked_oct">join_fungible_staked_oct</a>(self: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>, other: <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">staking_pool::FungibleStakedOct</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_join_fungible_staked_oct">join_fungible_staked_oct</a>(self: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a>, other: <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a>) {
    <b>let</b> <a href="staking_pool.md#0x3_staking_pool_FungibleStakedOct">FungibleStakedOct</a> { id, pool_id, value } = other;
    <b>assert</b>!(self.pool_id == pool_id, <a href="staking_pool.md#0x3_staking_pool_EWrongPool">EWrongPool</a>);

    id.delete();

    self.value = self.value + value;
}
</code></pre>



</details>

<a name="0x3_staking_pool_split"></a>

## Function `split`

Split StakedOct <code>self</code> to two parts, one with principal <code>split_amount</code>,
and the remaining principal is left in <code>self</code>.
All the other parameters of the StakedOct like <code>stake_activation_epoch</code> or <code>pool_id</code> remain the same.


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_split">split</a>(self: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>, split_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_split">split</a>(self: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>, split_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, ctx: &<b>mut</b> TxContext): <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> {
    <b>let</b> original_amount = self.principal.value();
    <b>assert</b>!(split_amount &lt;= original_amount, <a href="staking_pool.md#0x3_staking_pool_EInsufficientSuiTokenBalance">EInsufficientSuiTokenBalance</a>);
    <b>let</b> remaining_amount = original_amount - split_amount;
    // Both resulting parts should have at least <a href="staking_pool.md#0x3_staking_pool_MIN_STAKING_THRESHOLD">MIN_STAKING_THRESHOLD</a>.
    <b>assert</b>!(remaining_amount &gt;= <a href="staking_pool.md#0x3_staking_pool_MIN_STAKING_THRESHOLD">MIN_STAKING_THRESHOLD</a>, <a href="staking_pool.md#0x3_staking_pool_EStakedOctBelowThreshold">EStakedOctBelowThreshold</a>);
    <b>assert</b>!(split_amount &gt;= <a href="staking_pool.md#0x3_staking_pool_MIN_STAKING_THRESHOLD">MIN_STAKING_THRESHOLD</a>, <a href="staking_pool.md#0x3_staking_pool_EStakedOctBelowThreshold">EStakedOctBelowThreshold</a>);
    <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> {
        id: <a href="../one-framework/object.md#0x2_object_new">object::new</a>(ctx),
        pool_id: self.pool_id,
        stake_activation_epoch: self.stake_activation_epoch,
        principal: self.principal.<a href="staking_pool.md#0x3_staking_pool_split">split</a>(split_amount),
        lock:self.lock,
    }
}
</code></pre>



</details>

<a name="0x3_staking_pool_split_staked_oct"></a>

## Function `split_staked_oct`

Split the given StakedOct to the two parts, one with principal <code>split_amount</code>,
transfer the newly split part to the sender address.


<pre><code><b>public</b> entry <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_split_staked_oct">split_staked_oct</a>(stake: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>, split_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_split_staked_oct">split_staked_oct</a>(stake: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>, split_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, ctx: &<b>mut</b> TxContext) {
    <a href="../one-framework/transfer.md#0x2_transfer_transfer">transfer::transfer</a>(stake.<a href="staking_pool.md#0x3_staking_pool_split">split</a>(split_amount, ctx), ctx.sender());
}
</code></pre>



</details>

<a name="0x3_staking_pool_join_staked_oct"></a>

## Function `join_staked_oct`

Consume the staked sui <code>other</code> and add its value to <code>self</code>.
Aborts if some of the staking parameters are incompatible (pool id, stake activation epoch, etc.)


<pre><code><b>public</b> entry <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_join_staked_oct">join_staked_oct</a>(self: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>, other: <a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_join_staked_oct">join_staked_oct</a>(self: &<b>mut</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>, other: <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>) {
    <b>assert</b>!(<a href="staking_pool.md#0x3_staking_pool_is_equal_staking_metadata">is_equal_staking_metadata</a>(self, &other), <a href="staking_pool.md#0x3_staking_pool_EIncompatibleStakedOct">EIncompatibleStakedOct</a>);
    <b>let</b> <a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a> { id, principal, .. } = other;

    id.delete();
    self.principal.join(principal);
}
</code></pre>



</details>

<a name="0x3_staking_pool_is_equal_staking_metadata"></a>

## Function `is_equal_staking_metadata`

Returns true if all the staking parameters of the staked sui except the principal are identical


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_equal_staking_metadata">is_equal_staking_metadata</a>(self: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>, other: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_equal_staking_metadata">is_equal_staking_metadata</a>(self: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>, other: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>): bool {
    (self.pool_id == other.pool_id) &&
    (self.stake_activation_epoch == other.stake_activation_epoch)
}
</code></pre>



</details>

<a name="0x3_staking_pool_pool_token_exchange_rate_at_epoch"></a>

## Function `pool_token_exchange_rate_at_epoch`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(
    pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
): <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a> {
    // If the pool is preactive then the exchange rate is always 1:1.
    <b>if</b> (pool.<a href="staking_pool.md#0x3_staking_pool_is_preactive_at_epoch">is_preactive_at_epoch</a>(epoch)) {
        <b>return</b> <a href="staking_pool.md#0x3_staking_pool_initial_exchange_rate">initial_exchange_rate</a>()
    };
    <b>let</b> clamped_epoch = pool.deactivation_epoch.get_with_default(epoch);
    <b>let</b> <b>mut</b> epoch = clamped_epoch.<b>min</b>(epoch);
    <b>let</b> activation_epoch = *pool.activation_epoch.borrow();

    // Find the latest epoch that's earlier than the given epoch <b>with</b> an entry in the <a href="../one-framework/table.md#0x2_table">table</a>
    <b>while</b> (epoch &gt;= activation_epoch) {
        <b>if</b> (pool.exchange_rates.contains(epoch)) {
            <b>return</b> pool.exchange_rates[epoch]
        };
        epoch = epoch - 1;
    };
    // This line really should be unreachable. Do we want an <b>assert</b> <b>false</b> here?
    <a href="staking_pool.md#0x3_staking_pool_initial_exchange_rate">initial_exchange_rate</a>()
}
</code></pre>



</details>

<a name="0x3_staking_pool_pending_stake_amount"></a>

## Function `pending_stake_amount`

Returns the total value of the pending staking requests for this staking pool.


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pending_stake_amount">pending_stake_amount</a>(<a href="staking_pool.md#0x3_staking_pool">staking_pool</a>: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pending_stake_amount">pending_stake_amount</a>(<a href="staking_pool.md#0x3_staking_pool">staking_pool</a>: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    <a href="staking_pool.md#0x3_staking_pool">staking_pool</a>.pending_stake
}
</code></pre>



</details>

<a name="0x3_staking_pool_pending_stake_withdraw_amount"></a>

## Function `pending_stake_withdraw_amount`

Returns the total withdrawal from the staking pool this epoch.


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pending_stake_withdraw_amount">pending_stake_withdraw_amount</a>(<a href="staking_pool.md#0x3_staking_pool">staking_pool</a>: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pending_stake_withdraw_amount">pending_stake_withdraw_amount</a>(<a href="staking_pool.md#0x3_staking_pool">staking_pool</a>: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    <a href="staking_pool.md#0x3_staking_pool">staking_pool</a>.pending_total_oct_withdraw
}
</code></pre>



</details>

<a name="0x3_staking_pool_exchange_rates"></a>

## Function `exchange_rates`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_exchange_rates">exchange_rates</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>): &<a href="../one-framework/table.md#0x2_table_Table">table::Table</a>&lt;<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_exchange_rates">exchange_rates</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>): &Table&lt;<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a>&gt; {
    &pool.exchange_rates
}
</code></pre>



</details>

<a name="0x3_staking_pool_sui_amount"></a>

## Function `sui_amount`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_sui_amount">sui_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_sui_amount">sui_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    exchange_rate.sui_amount
}
</code></pre>



</details>

<a name="0x3_staking_pool_pool_token_amount"></a>

## Function `pool_token_amount`



<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pool_token_amount">pool_token_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_pool_token_amount">pool_token_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    exchange_rate.pool_token_amount
}
</code></pre>



</details>

<a name="0x3_staking_pool_is_preactive_at_epoch"></a>

## Function `is_preactive_at_epoch`

Returns true if the provided staking pool is preactive at the provided epoch.


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_preactive_at_epoch">is_preactive_at_epoch</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_is_preactive_at_epoch">is_preactive_at_epoch</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>, epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): bool {
    // Either the pool is currently preactive or the pool's starting epoch is later than the provided epoch.
    pool.<a href="staking_pool.md#0x3_staking_pool_is_preactive">is_preactive</a>() || (*pool.activation_epoch.borrow() &gt; epoch)
}
</code></pre>



</details>

<a name="0x3_staking_pool_get_sui_amount"></a>

## Function `get_sui_amount`



<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_get_sui_amount">get_sui_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>, token_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_get_sui_amount">get_sui_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a>, token_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    // When either amount is 0, that means we have no stakes <b>with</b> this pool.
    // The other amount might be non-zero when there's dust left in the pool.
    <b>if</b> (exchange_rate.sui_amount == 0 || exchange_rate.pool_token_amount == 0) {
        <b>return</b> token_amount
    };

    mul_div!(exchange_rate.sui_amount, token_amount, exchange_rate.pool_token_amount)
}
</code></pre>



</details>

<a name="0x3_staking_pool_get_token_amount"></a>

## Function `get_token_amount`



<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_get_token_amount">get_token_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>, sui_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_get_token_amount">get_token_amount</a>(exchange_rate: &<a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a>, sui_amount: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    // When either amount is 0, that means we have no stakes <b>with</b> this pool.
    // The other amount might be non-zero when there's dust left in the pool.
    <b>if</b> (exchange_rate.sui_amount == 0 || exchange_rate.pool_token_amount == 0) {
        <b>return</b> sui_amount
    };

    mul_div!(exchange_rate.pool_token_amount, sui_amount, exchange_rate.sui_amount)
}
</code></pre>



</details>

<a name="0x3_staking_pool_initial_exchange_rate"></a>

## Function `initial_exchange_rate`



<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_initial_exchange_rate">initial_exchange_rate</a>(): <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">staking_pool::PoolTokenExchangeRate</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_initial_exchange_rate">initial_exchange_rate</a>(): <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a> {
    <a href="staking_pool.md#0x3_staking_pool_PoolTokenExchangeRate">PoolTokenExchangeRate</a> { sui_amount: 0, pool_token_amount: 0 }
}
</code></pre>



</details>

<a name="0x3_staking_pool_check_balance_invariants"></a>

## Function `check_balance_invariants`



<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_check_balance_invariants">check_balance_invariants</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="staking_pool.md#0x3_staking_pool_check_balance_invariants">check_balance_invariants</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>, epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>) {
    <b>let</b> exchange_rate = pool.<a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(epoch);
    // check that the pool token <a href="../one-framework/balance.md#0x2_balance">balance</a> and sui <a href="../one-framework/balance.md#0x2_balance">balance</a> ratio matches the exchange rate stored.
    <b>let</b> expected = exchange_rate.<a href="staking_pool.md#0x3_staking_pool_get_token_amount">get_token_amount</a>(pool.sui_balance);
    <b>let</b> actual = pool.pool_token_balance;
    <b>assert</b>!(expected == actual, <a href="staking_pool.md#0x3_staking_pool_ETokenBalancesDoNotMatchExchangeRate">ETokenBalancesDoNotMatchExchangeRate</a>)
}
</code></pre>



</details>

<a name="0x3_staking_pool_calculate_rewards"></a>

## Function `calculate_rewards`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_calculate_rewards">calculate_rewards</a>(pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">staking_pool::StakingPool</a>, staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">staking_pool::StakedOct</a>, current_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>): <a href="../move-stdlib/u64.md#0x1_u64">u64</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="staking_pool.md#0x3_staking_pool_calculate_rewards">calculate_rewards</a>(
    pool: &<a href="staking_pool.md#0x3_staking_pool_StakingPool">StakingPool</a>,
    staked_oct: &<a href="staking_pool.md#0x3_staking_pool_StakedOct">StakedOct</a>,
    current_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
): <a href="../move-stdlib/u64.md#0x1_u64">u64</a> {
    <b>let</b> staked_amount = staked_oct.amount();
    <b>let</b> pool_token_withdraw_amount = {
        <b>let</b> exchange_rate_at_staking_epoch = pool.<a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(staked_oct.stake_activation_epoch);
        exchange_rate_at_staking_epoch.<a href="staking_pool.md#0x3_staking_pool_get_token_amount">get_token_amount</a>(staked_amount)
    };

    <b>let</b> new_epoch_exchange_rate = pool.<a href="staking_pool.md#0x3_staking_pool_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(current_epoch);
    <b>let</b> total_sui_withdraw_amount = new_epoch_exchange_rate.<a href="staking_pool.md#0x3_staking_pool_get_sui_amount">get_sui_amount</a>(
        pool_token_withdraw_amount,
    );

    <b>let</b> <b>mut</b> reward_withdraw_amount = <b>if</b> (total_sui_withdraw_amount &gt;= staked_amount) {
        total_sui_withdraw_amount - staked_amount
    } <b>else</b> 0;
    reward_withdraw_amount = reward_withdraw_amount.<b>min</b>(pool.rewards_pool.value());

    reward_withdraw_amount
}
</code></pre>



</details>
