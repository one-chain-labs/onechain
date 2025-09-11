---
title: Module `oct::oct`
---

Coin<OCT> is the token used to pay for gas in Oct.
It has 9 decimals, and the smallest unit (10^-9) is called "mist".


-  [Struct `OCT`](#sui_sui_SUI)
-  [Constants](#@Constants_0)
-  [Function `new`](#sui_sui_new)
-  [Function `transfer`](#sui_sui_transfer)


<pre><code><b>use</b> <a href="../std/address.md#std_address">std::address</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/type_name.md#std_type_name">std::type_name</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
<b>use</b> <a href="../oct/accumulator.md#sui_accumulator">oct::accumulator</a>;
<b>use</b> <a href="../oct/address.md#sui_address">oct::address</a>;
<b>use</b> <a href="../oct/bag.md#sui_bag">oct::bag</a>;
<b>use</b> <a href="../oct/balance.md#sui_balance">oct::balance</a>;
<b>use</b> <a href="../oct/coin.md#sui_coin">oct::coin</a>;
<b>use</b> <a href="../oct/config.md#sui_config">oct::config</a>;
<b>use</b> <a href="../oct/deny_list.md#sui_deny_list">oct::deny_list</a>;
<b>use</b> <a href="../oct/dynamic_field.md#sui_dynamic_field">oct::dynamic_field</a>;
<b>use</b> <a href="../oct/dynamic_object_field.md#sui_dynamic_object_field">oct::dynamic_object_field</a>;
<b>use</b> <a href="../oct/event.md#sui_event">oct::event</a>;
<b>use</b> <a href="../oct/hex.md#sui_hex">oct::hex</a>;
<b>use</b> <a href="../oct/object.md#sui_object">oct::object</a>;
<b>use</b> <a href="../oct/party.md#sui_party">oct::party</a>;
<b>use</b> <a href="../oct/table.md#sui_table">oct::table</a>;
<b>use</b> <a href="../oct/transfer.md#sui_transfer">oct::transfer</a>;
<b>use</b> <a href="../oct/tx_context.md#sui_tx_context">oct::tx_context</a>;
<b>use</b> <a href="../oct/types.md#sui_types">oct::types</a>;
<b>use</b> <a href="../oct/url.md#sui_url">oct::url</a>;
<b>use</b> <a href="../oct/vec_map.md#sui_vec_map">oct::vec_map</a>;
<b>use</b> <a href="../oct/vec_set.md#sui_vec_set">oct::vec_set</a>;
</code></pre>



<a name="sui_sui_SUI"></a>

## Struct `OCT`

Name of the coin


<pre><code><b>public</b> <b>struct</b> <a href="../oct/oct.md#sui_sui_SUI">OCT</a> <b>has</b> drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="sui_sui_EAlreadyMinted"></a>



<pre><code><b>const</b> <a href="../oct/oct.md#sui_sui_EAlreadyMinted">EAlreadyMinted</a>: u64 = 0;
</code></pre>



<a name="sui_sui_ENotSystemAddress"></a>

Sender is not @0x0 the system address.


<pre><code><b>const</b> <a href="../oct/oct.md#sui_sui_ENotSystemAddress">ENotSystemAddress</a>: u64 = 1;
</code></pre>



<a name="sui_sui_MIST_PER_OCT"></a>

The amount of Mist per Oct token based on the fact that mist is
10^-9 of a Oct token


<pre><code><b>const</b> <a href="../oct/oct.md#sui_sui_MIST_PER_OCT">MIST_PER_OCT</a>: u64 = 1000000000;
</code></pre>



<a name="sui_sui_TOTAL_SUPPLY_SUI"></a>

The total supply of Oct denominated in whole Oct tokens (10 Billion)


<pre><code><b>const</b> <a href="../oct/oct.md#sui_sui_TOTAL_SUPPLY_SUI">TOTAL_SUPPLY_SUI</a>: u64 = 10000000000;
</code></pre>



<a name="sui_sui_TOTAL_SUPPLY_MIST"></a>

The total supply of Oct denominated in Mist (10 Billion * 10^9)


<pre><code><b>const</b> <a href="../oct/oct.md#sui_sui_TOTAL_SUPPLY_MIST">TOTAL_SUPPLY_MIST</a>: u64 = 10000000000000000000;
</code></pre>



<a name="sui_sui_new"></a>

## Function `new`

Register the <code><a href="../oct/oct.md#sui_sui_SUI">OCT</a></code> Coin to acquire its <code>Supply</code>.
This should be called only once during genesis creation.


<pre><code><b>fun</b> <a href="../oct/oct.md#sui_sui_new">new</a>(ctx: &<b>mut</b> <a href="../oct/tx_context.md#sui_tx_context_TxContext">oct::tx_context::TxContext</a>): <a href="../oct/balance.md#sui_balance_Balance">oct::balance::Balance</a>&lt;<a href="../oct/oct.md#sui_sui_SUI">oct::oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../oct/oct.md#sui_sui_new">new</a>(ctx: &<b>mut</b> TxContext): Balance&lt;<a href="../oct/oct.md#sui_sui_SUI">OCT</a>&gt; {
    <b>assert</b>!(ctx.sender() == @0x0, <a href="../oct/oct.md#sui_sui_ENotSystemAddress">ENotSystemAddress</a>);
    <b>assert</b>!(ctx.epoch() == 0, <a href="../oct/oct.md#sui_sui_EAlreadyMinted">EAlreadyMinted</a>);
    <b>let</b> (treasury, metadata) = <a href="../oct/coin.md#sui_coin_create_currency">coin::create_currency</a>(
        <a href="../oct/oct.md#sui_sui_SUI">OCT</a> {},
        9,
        b"<a href="../oct/oct.md#sui_sui_SUI">OCT</a>",
        b"Oct",
        // TODO: add appropriate description and logo <a href="../oct/url.md#sui_url">url</a>
        b"",
        option::none(),
        ctx,
    );
    <a href="../oct/transfer.md#sui_transfer_public_freeze_object">transfer::public_freeze_object</a>(metadata);
    <b>let</b> <b>mut</b> supply = treasury.treasury_into_supply();
    <b>let</b> total_oct = supply.increase_supply(<a href="../oct/oct.md#sui_sui_TOTAL_SUPPLY_MIST">TOTAL_SUPPLY_MIST</a>);
    supply.destroy_supply();
    total_oct
}
</code></pre>



</details>

<a name="sui_sui_transfer"></a>

## Function `transfer`



<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../oct/transfer.md#sui_transfer">transfer</a>(c: <a href="../oct/coin.md#sui_coin_Coin">oct::coin::Coin</a>&lt;<a href="../oct/oct.md#sui_sui_SUI">oct::oct::OCT</a>&gt;, recipient: <b>address</b>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>entry</b> <b>fun</b> <a href="../oct/transfer.md#sui_transfer">transfer</a>(c: <a href="../oct/coin.md#sui_coin_Coin">coin::Coin</a>&lt;<a href="../oct/oct.md#sui_sui_SUI">OCT</a>&gt;, recipient: <b>address</b>) {
    <a href="../oct/transfer.md#sui_transfer_public_transfer">transfer::public_transfer</a>(c, recipient)
}
</code></pre>



</details>
