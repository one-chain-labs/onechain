---
title: Module `0x2::oct`
---

Coin<OCT> is the token used to pay for gas in OCT.
It has 9 decimals, and the smallest unit (10^-9) is called "mist".


-  [Struct `OCT`](#0x2_oct_OCT)
-  [Constants](#@Constants_0)
-  [Function `new`](#0x2_oct_new)
-  [Function `transfer`](#0x2_oct_transfer)


<pre><code><b>use</b> <a href="../move-stdlib/option.md#0x1_option">0x1::option</a>;
<b>use</b> <a href="../one-framework/balance.md#0x2_balance">0x2::balance</a>;
<b>use</b> <a href="../one-framework/coin.md#0x2_coin">0x2::coin</a>;
<b>use</b> <a href="../one-framework/transfer.md#0x2_transfer">0x2::transfer</a>;
<b>use</b> <a href="../one-framework/tx_context.md#0x2_tx_context">0x2::tx_context</a>;
<b>use</b> <a href="../one-framework/url.md#0x2_url">0x2::url</a>;
</code></pre>



<a name="0x2_oct_OCT"></a>

## Struct `OCT`

Name of the coin


<pre><code><b>struct</b> <a href="../one-framework/oct.md#0x2_oct_OCT">OCT</a> <b>has</b> drop
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


<a name="0x2_oct_ENotSystemAddress"></a>

Sender is not @0x0 the system address.


<pre><code><b>const</b> <a href="../one-framework/oct.md#0x2_oct_ENotSystemAddress">ENotSystemAddress</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 1;
</code></pre>



<a name="0x2_oct_EAlreadyMinted"></a>



<pre><code><b>const</b> <a href="../one-framework/oct.md#0x2_oct_EAlreadyMinted">EAlreadyMinted</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 0;
</code></pre>



<a name="0x2_oct_MIST_PER_OCT"></a>

The amount of Mist per Sui token based on the fact that mist is
10^-9 of a Sui token


<pre><code><b>const</b> <a href="../one-framework/oct.md#0x2_oct_MIST_PER_OCT">MIST_PER_OCT</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 1000000000;
</code></pre>



<a name="0x2_oct_TOTAL_SUPPLY_MIST"></a>

The total supply of Sui denominated in Mist (10 Billion * 10^9)


<pre><code><b>const</b> <a href="../one-framework/oct.md#0x2_oct_TOTAL_SUPPLY_MIST">TOTAL_SUPPLY_MIST</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 10000000000000000000;
</code></pre>



<a name="0x2_oct_TOTAL_SUPPLY_OCT"></a>

The total supply of Sui denominated in whole Sui tokens (10 Billion)


<pre><code><b>const</b> <a href="../one-framework/oct.md#0x2_oct_TOTAL_SUPPLY_OCT">TOTAL_SUPPLY_OCT</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 10000000000;
</code></pre>



<a name="0x2_oct_new"></a>

## Function `new`

Register the <code><a href="../one-framework/oct.md#0x2_oct_OCT">OCT</a></code> Coin to acquire its <code>Supply</code>.
This should be called only once during genesis creation.


<pre><code><b>fun</b> <a href="../one-framework/oct.md#0x2_oct_new">new</a>(ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="../one-framework/balance.md#0x2_balance_Balance">balance::Balance</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one-framework/oct.md#0x2_oct_new">new</a>(ctx: &<b>mut</b> TxContext): Balance&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">OCT</a>&gt; {
    <b>assert</b>!(ctx.sender() == @0x0, <a href="../one-framework/oct.md#0x2_oct_ENotSystemAddress">ENotSystemAddress</a>);
    <b>assert</b>!(ctx.epoch() == 0, <a href="../one-framework/oct.md#0x2_oct_EAlreadyMinted">EAlreadyMinted</a>);

    <b>let</b> (treasury, metadata) = <a href="../one-framework/coin.md#0x2_coin_create_currency">coin::create_currency</a>(
        <a href="../one-framework/oct.md#0x2_oct_OCT">OCT</a> {},
        9,
        b"<a href="../one-framework/oct.md#0x2_oct_OCT">OCT</a>",
        b"<a href="../one-framework/oct.md#0x2_oct_OCT">OCT</a>",
        // TODO: add appropriate description and logo <a href="../one-framework/url.md#0x2_url">url</a>
        b"",
        <a href="../move-stdlib/option.md#0x1_option_none">option::none</a>(),
        ctx,
    );
    <a href="../one-framework/transfer.md#0x2_transfer_public_freeze_object">transfer::public_freeze_object</a>(metadata);
    <b>let</b> <b>mut</b> supply = treasury.treasury_into_supply();
    <b>let</b> total_sui = supply.increase_supply(<a href="../one-framework/oct.md#0x2_oct_TOTAL_SUPPLY_MIST">TOTAL_SUPPLY_MIST</a>);
    supply.destroy_supply();
    total_sui
}
</code></pre>



</details>

<a name="0x2_oct_transfer"></a>

## Function `transfer`



<pre><code><b>public</b> entry <b>fun</b> <a href="../one-framework/transfer.md#0x2_transfer">transfer</a>(c: <a href="../one-framework/coin.md#0x2_coin_Coin">coin::Coin</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">oct::OCT</a>&gt;, recipient: <b>address</b>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="../one-framework/transfer.md#0x2_transfer">transfer</a>(c: <a href="../one-framework/coin.md#0x2_coin_Coin">coin::Coin</a>&lt;<a href="../one-framework/oct.md#0x2_oct_OCT">OCT</a>&gt;, recipient: <b>address</b>) {
    <a href="../one-framework/transfer.md#0x2_transfer_public_transfer">transfer::public_transfer</a>(c, recipient)
}
</code></pre>



</details>
