---
title: Module `one_system::stake_subsidy`
---



-  [Struct `StakeSubsidy`](#one_system_stake_subsidy_StakeSubsidy)
-  [Constants](#@Constants_0)
-  [Function `create`](#one_system_stake_subsidy_create)
-  [Function `advance_epoch`](#one_system_stake_subsidy_advance_epoch)
-  [Function `current_epoch_subsidy_amount`](#one_system_stake_subsidy_current_epoch_subsidy_amount)
-  [Function `get_distribution_counter`](#one_system_stake_subsidy_get_distribution_counter)


<pre><code><b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/bag.md#one_bag">one::bag</a>;
<b>use</b> <a href="../one/balance.md#one_balance">one::balance</a>;
<b>use</b> <a href="../one/coin.md#one_coin">one::coin</a>;
<b>use</b> <a href="../one/config.md#one_config">one::config</a>;
<b>use</b> <a href="../one/deny_list.md#one_deny_list">one::deny_list</a>;
<b>use</b> <a href="../one/dynamic_field.md#one_dynamic_field">one::dynamic_field</a>;
<b>use</b> <a href="../one/dynamic_object_field.md#one_dynamic_object_field">one::dynamic_object_field</a>;
<b>use</b> <a href="../one/event.md#one_event">one::event</a>;
<b>use</b> <a href="../one/hex.md#one_hex">one::hex</a>;
<b>use</b> <a href="../one/object.md#one_object">one::object</a>;
<b>use</b> <a href="../one/oct.md#one_oct">one::oct</a>;
<b>use</b> <a href="../one/party.md#one_party">one::party</a>;
<b>use</b> <a href="../one/table.md#one_table">one::table</a>;
<b>use</b> <a href="../one/transfer.md#one_transfer">one::transfer</a>;
<b>use</b> <a href="../one/tx_context.md#one_tx_context">one::tx_context</a>;
<b>use</b> <a href="../one/types.md#one_types">one::types</a>;
<b>use</b> <a href="../one/url.md#one_url">one::url</a>;
<b>use</b> <a href="../one/vec_map.md#one_vec_map">one::vec_map</a>;
<b>use</b> <a href="../one/vec_set.md#one_vec_set">one::vec_set</a>;
<b>use</b> <a href="../std/address.md#std_address">std::address</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/type_name.md#std_type_name">std::type_name</a>;
<b>use</b> <a href="../std/u64.md#std_u64">std::u64</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="one_system_stake_subsidy_StakeSubsidy"></a>

## Struct `StakeSubsidy`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">StakeSubsidy</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>balance: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;</code>
</dt>
<dd>
 Balance of SUI set aside for stake subsidies that will be drawn down over time.
</dd>
<dt>
<code>distribution_counter: u64</code>
</dt>
<dd>
 Count of the number of times stake subsidies have been distributed.
</dd>
<dt>
<code>current_distribution_amount: u64</code>
</dt>
<dd>
 The amount of stake subsidy to be drawn down per distribution.
 This amount decays and decreases over time.
</dd>
<dt>
<code>stake_subsidy_period_length: u64</code>
</dt>
<dd>
 Number of distributions to occur before the distribution amount decays.
</dd>
<dt>
<code>stake_subsidy_decrease_rate: u16</code>
</dt>
<dd>
 The rate at which the distribution amount decays at the end of each
 period. Expressed in basis points.
</dd>
<dt>
<code>extra_fields: <a href="../one/bag.md#one_bag_Bag">one::bag::Bag</a></code>
</dt>
<dd>
 Any extra fields that's not defined statically.
</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="one_system_stake_subsidy_ESubsidyDecreaseRateTooLarge"></a>



<pre><code><b>const</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_ESubsidyDecreaseRateTooLarge">ESubsidyDecreaseRateTooLarge</a>: u64 = 0;
</code></pre>



<a name="one_system_stake_subsidy_BASIS_POINT_DENOMINATOR"></a>



<pre><code><b>const</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_BASIS_POINT_DENOMINATOR">BASIS_POINT_DENOMINATOR</a>: u128 = 10000;
</code></pre>



<a name="one_system_stake_subsidy_create"></a>

## Function `create`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_create">create</a>(balance: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, initial_distribution_amount: u64, stake_subsidy_period_length: u64, stake_subsidy_decrease_rate: u16, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">one_system::stake_subsidy::StakeSubsidy</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_create">create</a>(
    balance: Balance&lt;OCT&gt;,
    initial_distribution_amount: u64,
    stake_subsidy_period_length: u64,
    stake_subsidy_decrease_rate: u16,
    ctx: &<b>mut</b> TxContext,
): <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">StakeSubsidy</a> {
    // Rate can't be higher than 100%.
    <b>assert</b>!(
        stake_subsidy_decrease_rate &lt;= <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_BASIS_POINT_DENOMINATOR">BASIS_POINT_DENOMINATOR</a> <b>as</b> u16,
        <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_ESubsidyDecreaseRateTooLarge">ESubsidyDecreaseRateTooLarge</a>,
    );
    <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">StakeSubsidy</a> {
        balance,
        distribution_counter: 0,
        current_distribution_amount: initial_distribution_amount,
        stake_subsidy_period_length,
        stake_subsidy_decrease_rate,
        extra_fields: bag::new(ctx),
    }
}
</code></pre>



</details>

<a name="one_system_stake_subsidy_advance_epoch"></a>

## Function `advance_epoch`

Advance the epoch counter and draw down the subsidy for the epoch.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_advance_epoch">advance_epoch</a>(self: &<b>mut</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">one_system::stake_subsidy::StakeSubsidy</a>): <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_advance_epoch">advance_epoch</a>(self: &<b>mut</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">StakeSubsidy</a>): Balance&lt;OCT&gt; {
    // Take the minimum of the reward amount and the remaining balance in
    // order to ensure we don't overdraft the remaining stake subsidy
    // balance
    <b>let</b> to_withdraw = self.current_distribution_amount.min(self.balance.value());
    // Drawn down the subsidy <b>for</b> this epoch.
    <b>let</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy">stake_subsidy</a> = self.balance.split(to_withdraw);
    self.distribution_counter = self.distribution_counter + 1;
    // Decrease the subsidy amount only when the current period ends.
    <b>if</b> (self.distribution_counter % self.stake_subsidy_period_length == 0) {
        <b>let</b> decrease_amount =
            self.current_distribution_amount <b>as</b> u128
            * (self.stake_subsidy_decrease_rate <b>as</b> u128) / <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_BASIS_POINT_DENOMINATOR">BASIS_POINT_DENOMINATOR</a>;
        self.current_distribution_amount =
            self.current_distribution_amount - (decrease_amount <b>as</b> u64)
    };
    <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy">stake_subsidy</a>
}
</code></pre>



</details>

<a name="one_system_stake_subsidy_current_epoch_subsidy_amount"></a>

## Function `current_epoch_subsidy_amount`

Returns the amount of stake subsidy to be added at the end of the current epoch.


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_current_epoch_subsidy_amount">current_epoch_subsidy_amount</a>(self: &<a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">one_system::stake_subsidy::StakeSubsidy</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_current_epoch_subsidy_amount">current_epoch_subsidy_amount</a>(self: &<a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">StakeSubsidy</a>): u64 {
    self.current_distribution_amount.min(self.balance.value())
}
</code></pre>



</details>

<a name="one_system_stake_subsidy_get_distribution_counter"></a>

## Function `get_distribution_counter`

Returns the number of distributions that have occurred.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_get_distribution_counter">get_distribution_counter</a>(self: &<a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">one_system::stake_subsidy::StakeSubsidy</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_get_distribution_counter">get_distribution_counter</a>(self: &<a href="../one_system/stake_subsidy.md#one_system_stake_subsidy_StakeSubsidy">StakeSubsidy</a>): u64 {
    self.distribution_counter
}
</code></pre>



</details>
