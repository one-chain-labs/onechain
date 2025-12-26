---
title: Module `one_system::storage_fund`
---



-  [Struct `StorageFund`](#one_system_storage_fund_StorageFund)
-  [Function `new`](#one_system_storage_fund_new)
-  [Function `advance_epoch`](#one_system_storage_fund_advance_epoch)
-  [Function `total_object_storage_rebates`](#one_system_storage_fund_total_object_storage_rebates)
-  [Function `total_balance`](#one_system_storage_fund_total_balance)


<pre><code><b>use</b> <a href="../one/accumulator.md#one_accumulator">one::accumulator</a>;
<b>use</b> <a href="../one/address.md#one_address">one::address</a>;
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
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="one_system_storage_fund_StorageFund"></a>

## Struct `StorageFund`

Struct representing the storage fund, containing two <code>Balance</code>s:
- <code><a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a></code> has the invariant that it's the sum of <code>storage_rebate</code> of
all objects currently stored on-chain. To maintain this invariant, the only inflow of this
balance is storage charges collected from transactions, and the only outflow is storage rebates
of transactions, including both the portion refunded to the transaction senders as well as
the non-refundable portion taken out and put into <code>non_refundable_balance</code>.
- <code>non_refundable_balance</code> contains any remaining inflow of the storage fund that should not
be taken out of the fund.


<pre><code><b>public</b> <b>struct</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">StorageFund</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code><a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code>non_refundable_balance: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_system_storage_fund_new"></a>

## Function `new`

Called by <code>sui_system</code> at genesis time.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_new">new</a>(initial_fund: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;): <a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">one_system::storage_fund::StorageFund</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_new">new</a>(initial_fund: Balance&lt;OCT&gt;): <a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">StorageFund</a> {
    <a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">StorageFund</a> {
        // At the beginning there's no object in the storage yet
        <a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>: balance::zero(),
        non_refundable_balance: initial_fund,
    }
}
</code></pre>



</details>

<a name="one_system_storage_fund_advance_epoch"></a>

## Function `advance_epoch`

Called by <code>sui_system</code> at epoch change times to process the inflows and outflows of storage fund.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_advance_epoch">advance_epoch</a>(self: &<b>mut</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">one_system::storage_fund::StorageFund</a>, storage_charges: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, storage_fund_reinvestment: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, leftover_staking_rewards: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, storage_rebate_amount: u64, non_refundable_storage_fee_amount: u64): <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_advance_epoch">advance_epoch</a>(
    self: &<b>mut</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">StorageFund</a>,
    storage_charges: Balance&lt;OCT&gt;,
    storage_fund_reinvestment: Balance&lt;OCT&gt;,
    leftover_staking_rewards: Balance&lt;OCT&gt;,
    storage_rebate_amount: u64,
    non_refundable_storage_fee_amount: u64,
): Balance&lt;OCT&gt; {
    // Both the reinvestment and leftover rewards are not to be refunded so they go to the non-refundable balance.
    self.non_refundable_balance.join(storage_fund_reinvestment);
    self.non_refundable_balance.join(leftover_staking_rewards);
    // The storage charges <b>for</b> the epoch come from the storage rebate of the <a href="../one_system/storage_fund.md#one_system_storage_fund_new">new</a> objects created
    // and the <a href="../one_system/storage_fund.md#one_system_storage_fund_new">new</a> storage rebates of the objects modified during the epoch so we put the charges
    // into `<a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>`.
    self.<a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>.join(storage_charges);
    // Split out the non-refundable portion of the storage rebate and put it into the non-refundable balance.
    <b>let</b> non_refundable_storage_fee = self
        .<a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>
        .split(non_refundable_storage_fee_amount);
    self.non_refundable_balance.join(non_refundable_storage_fee);
    // `storage_rebates` include the already refunded rebates of deleted objects and old rebates of modified objects and
    // should be taken out of the `<a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>`.
    <b>let</b> storage_rebate = self.<a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>.split(storage_rebate_amount);
    // The storage rebate <b>has</b> already been returned to individual transaction senders' gas coins
    // so we <b>return</b> the balance to be burnt at the very end of epoch change.
    storage_rebate
}
</code></pre>



</details>

<a name="one_system_storage_fund_total_object_storage_rebates"></a>

## Function `total_object_storage_rebates`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>(self: &<a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">one_system::storage_fund::StorageFund</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>(self: &<a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">StorageFund</a>): u64 {
    self.<a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>.value()
}
</code></pre>



</details>

<a name="one_system_storage_fund_total_balance"></a>

## Function `total_balance`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_total_balance">total_balance</a>(self: &<a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">one_system::storage_fund::StorageFund</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/storage_fund.md#one_system_storage_fund_total_balance">total_balance</a>(self: &<a href="../one_system/storage_fund.md#one_system_storage_fund_StorageFund">StorageFund</a>): u64 {
    self.<a href="../one_system/storage_fund.md#one_system_storage_fund_total_object_storage_rebates">total_object_storage_rebates</a>.value() + self.non_refundable_balance.value()
}
</code></pre>



</details>
