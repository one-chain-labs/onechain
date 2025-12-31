---
title: Module `one::coin_vesting`
---



-  [Struct `CoinVesting`](#one_coin_vesting_CoinVesting)
-  [Function `new_form_balance`](#one_coin_vesting_new_form_balance)
-  [Function `release`](#one_coin_vesting_release)
-  [Function `release_non_entry`](#one_coin_vesting_release_non_entry)
-  [Function `destroy_zero`](#one_coin_vesting_destroy_zero)


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



<a name="one_coin_vesting_CoinVesting"></a>

## Struct `CoinVesting`



<pre><code><b>public</b> <b>struct</b> <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">CoinVesting</a>&lt;<b>phantom</b> T&gt; <b>has</b> key, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <a href="../one/object.md#one_object_UID">one::object::UID</a></code>
</dt>
<dd>
</dd>
<dt>
<code>total: u64</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one/balance.md#one_balance">balance</a>: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;T&gt;</code>
</dt>
<dd>
 Waiting for collection balance
</dd>
<dt>
<code>start_epoch: u64</code>
</dt>
<dd>
 Start time
</dd>
<dt>
<code>cliff_interval_epoch: u64</code>
</dt>
<dd>
 Cooling-off period
</dd>
<dt>
<code>last_release_epoch: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>vesting_interval_epoch: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>vesting_internal_release: u64</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_coin_vesting_new_form_balance"></a>

## Function `new_form_balance`



<pre><code><b>public</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_new_form_balance">new_form_balance</a>&lt;T&gt;(<a href="../one/balance.md#one_balance">balance</a>: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;T&gt;, start_epoch: u64, cliff_interval_epoch: u64, vesting_interval_epoch: u64, period: u64, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">one::coin_vesting::CoinVesting</a>&lt;T&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_new_form_balance">new_form_balance</a>&lt;T&gt;(
    <a href="../one/balance.md#one_balance">balance</a>: Balance&lt;T&gt;,
    start_epoch: u64,
    cliff_interval_epoch: u64,
    vesting_interval_epoch: u64,
    period: u64,
    ctx: &<b>mut</b> TxContext,
): <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt; {
    <b>let</b> vesting_internal_release = <a href="../one/balance.md#one_balance">balance</a>.value()/ period;
    <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">CoinVesting</a> {
        id: <a href="../one/object.md#one_object_new">object::new</a>(ctx),
        total: <a href="../one/balance.md#one_balance">balance</a>.value(),
        <a href="../one/balance.md#one_balance">balance</a>,
        start_epoch,
        last_release_epoch: 0,
        cliff_interval_epoch,
        vesting_interval_epoch,
        vesting_internal_release,
    }
}
</code></pre>



</details>

<a name="one_coin_vesting_release"></a>

## Function `release`



<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_release">release</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">one::coin_vesting::CoinVesting</a>&lt;T&gt;, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_release">release</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt;, ctx: &<b>mut</b> TxContext){
    <b>let</b> withdraw = self.<a href="../one/coin_vesting.md#one_coin_vesting_release_non_entry">release_non_entry</a>(ctx);
    <b>if</b>(withdraw.value() &gt; 0){
        <a href="../one/transfer.md#one_transfer_public_transfer">transfer::public_transfer</a>(<a href="../one/coin.md#one_coin_from_balance">coin::from_balance</a>(withdraw,ctx),ctx.sender());
    }<b>else</b> {
        withdraw.<a href="../one/coin_vesting.md#one_coin_vesting_destroy_zero">destroy_zero</a>();
    };
}
</code></pre>



</details>

<a name="one_coin_vesting_release_non_entry"></a>

## Function `release_non_entry`



<pre><code><b>public</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_release_non_entry">release_non_entry</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">one::coin_vesting::CoinVesting</a>&lt;T&gt;, ctx: &<a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;T&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_release_non_entry">release_non_entry</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt;, ctx: &TxContext): Balance&lt;T&gt; {
    <b>let</b> current_epoch = ctx.epoch();
    <b>if</b> (self.last_release_epoch == 0) {
        self.last_release_epoch = self.start_epoch + self.cliff_interval_epoch;
    };
    <b>let</b> <b>mut</b> withdraw = <a href="../one/balance.md#one_balance_zero">balance::zero</a>&lt;T&gt;();
    <b>while</b> (self.last_release_epoch + self.vesting_interval_epoch &lt;= current_epoch) {
        self.last_release_epoch = self.last_release_epoch + self.vesting_interval_epoch;
        <b>if</b> (self.<a href="../one/balance.md#one_balance">balance</a>.value() &lt;= self.vesting_internal_release) {
            <b>let</b> value = self.<a href="../one/balance.md#one_balance">balance</a>.value();
            withdraw.join(self.<a href="../one/balance.md#one_balance">balance</a>.split(value));
            <b>return</b> withdraw
        } <b>else</b> {
            <b>let</b> value = self.vesting_internal_release;
            withdraw.join(self.<a href="../one/balance.md#one_balance">balance</a>.split(value));
        };
    };
    withdraw
}
</code></pre>



</details>

<a name="one_coin_vesting_destroy_zero"></a>

## Function `destroy_zero`



<pre><code><b>public</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_destroy_zero">destroy_zero</a>&lt;T&gt;(self: <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">one::coin_vesting::CoinVesting</a>&lt;T&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/coin_vesting.md#one_coin_vesting_destroy_zero">destroy_zero</a>&lt;T&gt;(self: <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt;) {
    <b>assert</b>!(self.<a href="../one/balance.md#one_balance">balance</a>.value() == 0, 0);
    <b>let</b> <a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">CoinVesting</a> {
        id,
        total: _,
        <a href="../one/balance.md#one_balance">balance</a>,
        start_epoch: _,
        cliff_interval_epoch: _,
        last_release_epoch: _,
        vesting_interval_epoch: _,
        vesting_internal_release: _,
    } = self;
    id.delete();
    <a href="../one/balance.md#one_balance">balance</a>.<a href="../one/coin_vesting.md#one_coin_vesting_destroy_zero">destroy_zero</a>();
}
</code></pre>



</details>
