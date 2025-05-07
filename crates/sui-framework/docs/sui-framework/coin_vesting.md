---
title: Module `0x2::coin_vesting`
---



-  [Resource `CoinVesting`](#0x2_coin_vesting_CoinVesting)
-  [Function `new_form_balance`](#0x2_coin_vesting_new_form_balance)
-  [Function `release`](#0x2_coin_vesting_release)
-  [Function `release_non_entry`](#0x2_coin_vesting_release_non_entry)
-  [Function `destroy_zero`](#0x2_coin_vesting_destroy_zero)


<pre><code><b>use</b> <a href="../sui-framework/balance.md#0x2_balance">0x2::balance</a>;
<b>use</b> <a href="../sui-framework/coin.md#0x2_coin">0x2::coin</a>;
<b>use</b> <a href="../sui-framework/object.md#0x2_object">0x2::object</a>;
<b>use</b> <a href="../sui-framework/transfer.md#0x2_transfer">0x2::transfer</a>;
<b>use</b> <a href="../sui-framework/tx_context.md#0x2_tx_context">0x2::tx_context</a>;
</code></pre>



<a name="0x2_coin_vesting_CoinVesting"></a>

## Resource `CoinVesting`



<pre><code><b>struct</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt; <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <a href="../sui-framework/object.md#0x2_object_UID">object::UID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>total: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
<dt>
<code><a href="../sui-framework/balance.md#0x2_balance">balance</a>: <a href="../sui-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;T&gt;</code>
</dt>
<dd>
 Waiting for collection balance
</dd>
<dt>
<code>start_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 Start time
</dd>
<dt>
<code>cliff_interval_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>
 Cooling-off period
</dd>
<dt>
<code>last_release_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
<dt>
<code>vesting_interval_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
<dt>
<code>vesting_internal_release: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x2_coin_vesting_new_form_balance"></a>

## Function `new_form_balance`



<pre><code><b>public</b> <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_new_form_balance">new_form_balance</a>&lt;T&gt;(<a href="../sui-framework/balance.md#0x2_balance">balance</a>: <a href="../sui-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;T&gt;, start_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, cliff_interval_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, vesting_interval_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, period: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>, ctx: &<b>mut</b> <a href="../sui-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">coin_vesting::CoinVesting</a>&lt;T&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_new_form_balance">new_form_balance</a>&lt;T&gt;(
    <a href="../sui-framework/balance.md#0x2_balance">balance</a>: Balance&lt;T&gt;,
    start_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    cliff_interval_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    vesting_interval_epoch: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    period: <a href="../move-stdlib/u64.md#0x1_u64">u64</a>,
    ctx: &<b>mut</b> TxContext,
): <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt; {
    <b>let</b> vesting_internal_release = <a href="../sui-framework/balance.md#0x2_balance">balance</a>.value()/ period;

    <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">CoinVesting</a> {
        id: <a href="../sui-framework/object.md#0x2_object_new">object::new</a>(ctx),
        total: <a href="../sui-framework/balance.md#0x2_balance">balance</a>.value(),
        <a href="../sui-framework/balance.md#0x2_balance">balance</a>,
        start_epoch,
        last_release_epoch: 0,
        cliff_interval_epoch,
        vesting_interval_epoch,
        vesting_internal_release,
    }
}
</code></pre>



</details>

<a name="0x2_coin_vesting_release"></a>

## Function `release`



<pre><code><b>public</b> entry <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_release">release</a>&lt;T&gt;(self: &<b>mut</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">coin_vesting::CoinVesting</a>&lt;T&gt;, ctx: &<b>mut</b> <a href="../sui-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_release">release</a>&lt;T&gt;(self: &<b>mut</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt;, ctx: &<b>mut</b> TxContext){
    <b>let</b> withdraw = self.<a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_release_non_entry">release_non_entry</a>(ctx);
    <b>if</b>(withdraw.value() &gt; 0){
        <a href="../sui-framework/transfer.md#0x2_transfer_public_transfer">transfer::public_transfer</a>(<a href="../sui-framework/coin.md#0x2_coin_from_balance">coin::from_balance</a>(withdraw,ctx),ctx.sender());
    }<b>else</b> {
        withdraw.<a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_destroy_zero">destroy_zero</a>();
    };
}
</code></pre>



</details>

<a name="0x2_coin_vesting_release_non_entry"></a>

## Function `release_non_entry`



<pre><code><b>public</b> <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_release_non_entry">release_non_entry</a>&lt;T&gt;(self: &<b>mut</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">coin_vesting::CoinVesting</a>&lt;T&gt;, ctx: &<a href="../sui-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="../sui-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;T&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_release_non_entry">release_non_entry</a>&lt;T&gt;(self: &<b>mut</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt;, ctx: &TxContext): Balance&lt;T&gt; {
    <b>let</b> current_epoch = ctx.epoch();
    <b>if</b> (self.last_release_epoch == 0) {
        self.last_release_epoch = self.start_epoch + self.cliff_interval_epoch;
    };

    <b>let</b> <b>mut</b> withdraw = <a href="../sui-framework/balance.md#0x2_balance_zero">balance::zero</a>&lt;T&gt;();

    <b>while</b> (self.last_release_epoch + self.vesting_interval_epoch &lt;= current_epoch) {
        self.last_release_epoch = self.last_release_epoch + self.vesting_interval_epoch;

        <b>if</b> (self.<a href="../sui-framework/balance.md#0x2_balance">balance</a>.value() &lt;= self.vesting_internal_release) {
            <b>let</b> value = self.<a href="../sui-framework/balance.md#0x2_balance">balance</a>.value();
            withdraw.join(self.<a href="../sui-framework/balance.md#0x2_balance">balance</a>.split(value));
            <b>return</b> withdraw
        } <b>else</b> {
            <b>let</b> value = self.vesting_internal_release;
            withdraw.join(self.<a href="../sui-framework/balance.md#0x2_balance">balance</a>.split(value));
        };
    };

    withdraw
}
</code></pre>



</details>

<a name="0x2_coin_vesting_destroy_zero"></a>

## Function `destroy_zero`



<pre><code><b>public</b> <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_destroy_zero">destroy_zero</a>&lt;T&gt;(self: <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">coin_vesting::CoinVesting</a>&lt;T&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_destroy_zero">destroy_zero</a>&lt;T&gt;(self: <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">CoinVesting</a>&lt;T&gt;) {
    <b>assert</b>!(self.<a href="../sui-framework/balance.md#0x2_balance">balance</a>.value() == 0, 0);
    <b>let</b> <a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_CoinVesting">CoinVesting</a> {
        id,
        total: _,
        <a href="../sui-framework/balance.md#0x2_balance">balance</a>,
        start_epoch: _,
        cliff_interval_epoch: _,
        last_release_epoch: _,
        vesting_interval_epoch: _,
        vesting_internal_release: _,
    } = self;
    id.delete();
    <a href="../sui-framework/balance.md#0x2_balance">balance</a>.<a href="../sui-framework/coin_vesting.md#0x2_coin_vesting_destroy_zero">destroy_zero</a>();
}
</code></pre>



</details>
