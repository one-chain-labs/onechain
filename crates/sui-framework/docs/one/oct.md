---
title: Module `one::oct`
---

Coin<OCT> is the token used to pay for gas in OCT.
It has 9 decimals, and the smallest unit (10^-9) is called "mist".


-  [Struct `OCT`](#one_oct_OCT)
-  [Constants](#@Constants_0)
-  [Function `new`](#one_oct_new)
-  [Function `transfer`](#one_oct_transfer)


<pre><code><b>use</b> <a href="../one/accumulator.md#one_accumulator">one::accumulator</a>;
<b>use</b> <a href="../one/accumulator_metadata.md#one_accumulator_metadata">one::accumulator_metadata</a>;
<b>use</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement">one::accumulator_settlement</a>;
<b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/bag.md#one_bag">one::bag</a>;
<b>use</b> <a href="../one/balance.md#one_balance">one::balance</a>;
<b>use</b> <a href="../one/bcs.md#one_bcs">one::bcs</a>;
<b>use</b> <a href="../one/coin.md#one_coin">one::coin</a>;
<b>use</b> <a href="../one/config.md#one_config">one::config</a>;
<b>use</b> <a href="../one/deny_list.md#one_deny_list">one::deny_list</a>;
<b>use</b> <a href="../one/dynamic_field.md#one_dynamic_field">one::dynamic_field</a>;
<b>use</b> <a href="../one/dynamic_object_field.md#one_dynamic_object_field">one::dynamic_object_field</a>;
<b>use</b> <a href="../one/event.md#one_event">one::event</a>;
<b>use</b> <a href="../one/funds_accumulator.md#one_funds_accumulator">one::funds_accumulator</a>;
<b>use</b> <a href="../one/hash.md#one_hash">one::hash</a>;
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



<a name="one_oct_OCT"></a>

## Struct `OCT`

Name of the coin


<pre><code><b>public</b> <b>struct</b> <a href="../one/oct.md#one_oct_OCT">OCT</a> <b>has</b> drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="one_oct_EAlreadyMinted"></a>



<pre><code><b>const</b> <a href="../one/oct.md#one_oct_EAlreadyMinted">EAlreadyMinted</a>: u64 = 0;
</code></pre>



<a name="one_oct_ENotSystemAddress"></a>

Sender is not @0x0 the system address.


<pre><code><b>const</b> <a href="../one/oct.md#one_oct_ENotSystemAddress">ENotSystemAddress</a>: u64 = 1;
</code></pre>



<a name="one_oct_MIST_PER_OCT"></a>

The amount of Mist per Sui token based on the fact that mist is
10^-9 of a Sui token


<pre><code><b>const</b> <a href="../one/oct.md#one_oct_MIST_PER_OCT">MIST_PER_OCT</a>: u64 = 1000000000;
</code></pre>



<a name="one_oct_TOTAL_SUPPLY_OCT"></a>

The total supply of Sui denominated in whole Sui tokens (10 Billion)


<pre><code><b>const</b> <a href="../one/oct.md#one_oct_TOTAL_SUPPLY_OCT">TOTAL_SUPPLY_OCT</a>: u64 = 10000000000;
</code></pre>



<a name="one_oct_TOTAL_SUPPLY_MIST"></a>

The total supply of Sui denominated in Mist (10 Billion * 10^9)


<pre><code><b>const</b> <a href="../one/oct.md#one_oct_TOTAL_SUPPLY_MIST">TOTAL_SUPPLY_MIST</a>: u64 = 10000000000000000000;
</code></pre>



<a name="one_oct_new"></a>

## Function `new`

Register the <code><a href="../one/oct.md#one_oct_OCT">OCT</a></code> Coin to acquire its <code>Supply</code>.
This should be called only once during genesis creation.


<pre><code><b>fun</b> <a href="../one/oct.md#one_oct_new">new</a>(ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one/oct.md#one_oct_new">new</a>(ctx: &<b>mut</b> TxContext): Balance&lt;<a href="../one/oct.md#one_oct_OCT">OCT</a>&gt; {
    <b>assert</b>!(ctx.sender() == @0x0, <a href="../one/oct.md#one_oct_ENotSystemAddress">ENotSystemAddress</a>);
    <b>assert</b>!(ctx.epoch() == 0, <a href="../one/oct.md#one_oct_EAlreadyMinted">EAlreadyMinted</a>);
    <b>let</b> (treasury, metadata) = <a href="../one/coin.md#one_coin_create_currency">coin::create_currency</a>(
        <a href="../one/oct.md#one_oct_OCT">OCT</a> {},
        9,
        b"<a href="../one/oct.md#one_oct_OCT">OCT</a>",
        b"<a href="../one/oct.md#one_oct_OCT">OCT</a>",
        // TODO: add appropriate description and logo <a href="../one/url.md#one_url">url</a>
        b"",
        option::none(),
        ctx,
    );
    <a href="../one/transfer.md#one_transfer_public_freeze_object">transfer::public_freeze_object</a>(metadata);
    <b>let</b> <b>mut</b> supply = treasury.treasury_into_supply();
    <b>let</b> total_sui = supply.increase_supply(<a href="../one/oct.md#one_oct_TOTAL_SUPPLY_MIST">TOTAL_SUPPLY_MIST</a>);
    supply.destroy_supply();
    total_sui
}
</code></pre>



</details>

<a name="one_oct_transfer"></a>

## Function `transfer`



<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/transfer.md#one_transfer">transfer</a>(c: <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, recipient: <b>address</b>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../one/transfer.md#one_transfer">transfer</a>(c: <a href="../one/coin.md#one_coin_Coin">coin::Coin</a>&lt;<a href="../one/oct.md#one_oct_OCT">OCT</a>&gt;, recipient: <b>address</b>) {
    <a href="../one/transfer.md#one_transfer_public_transfer">transfer::public_transfer</a>(c, recipient)
}
</code></pre>



</details>
