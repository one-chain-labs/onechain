---
title: Module `one::pay`
---

This module provides handy functionality for wallets and <code>one::Coin</code> management.


-  [Constants](#@Constants_0)
-  [Function `keep`](#one_pay_keep)
-  [Function `split`](#one_pay_split)
-  [Function `split_vec`](#one_pay_split_vec)
-  [Function `split_and_transfer`](#one_pay_split_and_transfer)
-  [Function `divide_and_keep`](#one_pay_divide_and_keep)
-  [Function `join`](#one_pay_join)
-  [Function `join_vec`](#one_pay_join_vec)
-  [Function `join_vec_and_transfer`](#one_pay_join_vec_and_transfer)


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
<b>use</b> <a href="../one/table.md#one_table">one::table</a>;
<b>use</b> <a href="../one/transfer.md#one_transfer">one::transfer</a>;
<b>use</b> <a href="../one/tx_context.md#one_tx_context">one::tx_context</a>;
<b>use</b> <a href="../one/types.md#one_types">one::types</a>;
<b>use</b> <a href="../one/url.md#one_url">one::url</a>;
<b>use</b> <a href="../one/vec_set.md#one_vec_set">one::vec_set</a>;
<b>use</b> <a href="../std/address.md#std_address">std::address</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/type_name.md#std_type_name">std::type_name</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="@Constants_0"></a>

## Constants


<a name="one_pay_ENoCoins"></a>

For when empty vector is supplied into join function.


<pre><code><b>const</b> <a href="../one/pay.md#one_pay_ENoCoins">ENoCoins</a>: u64 = 0;
</code></pre>



<a name="one_pay_keep"></a>

## Function `keep`

Transfer <code>c</code> to the sender of the current transaction


<pre><code><b>public</b> <b>fun</b> <a href="../one/pay.md#one_pay_keep">keep</a>&lt;T&gt;(c: <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;, ctx: &<a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/pay.md#one_pay_keep">keep</a>&lt;T&gt;(c: Coin&lt;T&gt;, ctx: &TxContext) {
    <a href="../one/transfer.md#one_transfer_public_transfer">transfer::public_transfer</a>(c, ctx.sender())
}
</code></pre>



</details>

<a name="one_pay_split"></a>

## Function `split`

Split coin <code>self</code> to two coins, one with balance <code>split_amount</code>,
and the remaining balance is left is <code>self</code>.


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_split">split</a>&lt;T&gt;(<a href="../one/coin.md#one_coin">coin</a>: &<b>mut</b> <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;, split_amount: u64, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_split">split</a>&lt;T&gt;(<a href="../one/coin.md#one_coin">coin</a>: &<b>mut</b> Coin&lt;T&gt;, split_amount: u64, ctx: &<b>mut</b> TxContext) {
    <a href="../one/pay.md#one_pay_keep">keep</a>(<a href="../one/coin.md#one_coin">coin</a>.<a href="../one/pay.md#one_pay_split">split</a>(split_amount, ctx), ctx)
}
</code></pre>



</details>

<a name="one_pay_split_vec"></a>

## Function `split_vec`

Split coin <code>self</code> into multiple coins, each with balance specified
in <code>split_amounts</code>. Remaining balance is left in <code>self</code>.


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_split_vec">split_vec</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;, split_amounts: vector&lt;u64&gt;, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_split_vec">split_vec</a>&lt;T&gt;(self: &<b>mut</b> Coin&lt;T&gt;, split_amounts: vector&lt;u64&gt;, ctx: &<b>mut</b> TxContext) {
    <b>let</b> (<b>mut</b> i, len) = (0, split_amounts.length());
    <b>while</b> (i &lt; len) {
        <a href="../one/pay.md#one_pay_split">split</a>(self, split_amounts[i], ctx);
        i = i + 1;
    };
}
</code></pre>



</details>

<a name="one_pay_split_and_transfer"></a>

## Function `split_and_transfer`

Send <code>amount</code> units of <code>c</code> to <code>recipient</code>
Aborts with <code>EVALUE</code> if <code>amount</code> is greater than or equal to <code>amount</code>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_split_and_transfer">split_and_transfer</a>&lt;T&gt;(c: &<b>mut</b> <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;, amount: u64, recipient: <b>address</b>, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_split_and_transfer">split_and_transfer</a>&lt;T&gt;(
    c: &<b>mut</b> Coin&lt;T&gt;,
    amount: u64,
    recipient: <b>address</b>,
    ctx: &<b>mut</b> TxContext,
) {
    <a href="../one/transfer.md#one_transfer_public_transfer">transfer::public_transfer</a>(c.<a href="../one/pay.md#one_pay_split">split</a>(amount, ctx), recipient)
}
</code></pre>



</details>

<a name="one_pay_divide_and_keep"></a>

## Function `divide_and_keep`

Divide coin <code>self</code> into <code>n - 1</code> coins with equal balances. If the balance is
not evenly divisible by <code>n</code>, the remainder is left in <code>self</code>.


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_divide_and_keep">divide_and_keep</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;, n: u64, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_divide_and_keep">divide_and_keep</a>&lt;T&gt;(self: &<b>mut</b> Coin&lt;T&gt;, n: u64, ctx: &<b>mut</b> TxContext) {
    <b>let</b> <b>mut</b> vec: vector&lt;Coin&lt;T&gt;&gt; = self.divide_into_n(n, ctx);
    <b>let</b> (<b>mut</b> i, len) = (0, vec.length());
    <b>while</b> (i &lt; len) {
        <a href="../one/transfer.md#one_transfer_public_transfer">transfer::public_transfer</a>(vec.pop_back(), ctx.sender());
        i = i + 1;
    };
    vec.destroy_empty();
}
</code></pre>



</details>

<a name="one_pay_join"></a>

## Function `join`

Join <code><a href="../one/coin.md#one_coin">coin</a></code> into <code>self</code>. Re-exports <code><a href="../one/coin.md#one_coin_join">coin::join</a></code> function.
Deprecated: you should call <code><a href="../one/coin.md#one_coin">coin</a>.<a href="../one/pay.md#one_pay_join">join</a>(other)</code> directly.


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_join">join</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;, <a href="../one/coin.md#one_coin">coin</a>: <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_join">join</a>&lt;T&gt;(self: &<b>mut</b> Coin&lt;T&gt;, <a href="../one/coin.md#one_coin">coin</a>: Coin&lt;T&gt;) {
    self.<a href="../one/pay.md#one_pay_join">join</a>(<a href="../one/coin.md#one_coin">coin</a>)
}
</code></pre>



</details>

<a name="one_pay_join_vec"></a>

## Function `join_vec`

Join everything in <code>coins</code> with <code>self</code>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_join_vec">join_vec</a>&lt;T&gt;(self: &<b>mut</b> <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;, coins: vector&lt;<a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_join_vec">join_vec</a>&lt;T&gt;(self: &<b>mut</b> Coin&lt;T&gt;, <b>mut</b> coins: vector&lt;Coin&lt;T&gt;&gt;) {
    <b>let</b> (<b>mut</b> i, len) = (0, coins.length());
    <b>while</b> (i &lt; len) {
        <b>let</b> <a href="../one/coin.md#one_coin">coin</a> = coins.pop_back();
        self.<a href="../one/pay.md#one_pay_join">join</a>(<a href="../one/coin.md#one_coin">coin</a>);
        i = i + 1
    };
    // safe because we've drained the vector
    coins.destroy_empty()
}
</code></pre>



</details>

<a name="one_pay_join_vec_and_transfer"></a>

## Function `join_vec_and_transfer`

Join a vector of <code>Coin</code> into a single object and transfer it to <code>receiver</code>.


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_join_vec_and_transfer">join_vec_and_transfer</a>&lt;T&gt;(coins: vector&lt;<a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;&gt;, receiver: <b>address</b>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/pay.md#one_pay_join_vec_and_transfer">join_vec_and_transfer</a>&lt;T&gt;(<b>mut</b> coins: vector&lt;Coin&lt;T&gt;&gt;, receiver: <b>address</b>) {
    <b>assert</b>!(coins.length() &gt; 0, <a href="../one/pay.md#one_pay_ENoCoins">ENoCoins</a>);
    <b>let</b> <b>mut</b> self = coins.pop_back();
    <a href="../one/pay.md#one_pay_join_vec">join_vec</a>(&<b>mut</b> self, coins);
    <a href="../one/transfer.md#one_transfer_public_transfer">transfer::public_transfer</a>(self, receiver)
}
</code></pre>



</details>
