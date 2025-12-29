---
title: Module `bridge::treasury`
---



-  [Struct `BridgeTreasury`](#bridge_treasury_BridgeTreasury)
-  [Struct `BridgeTokenMetadata`](#bridge_treasury_BridgeTokenMetadata)
-  [Struct `ForeignTokenRegistration`](#bridge_treasury_ForeignTokenRegistration)
-  [Struct `UpdateTokenPriceEvent`](#bridge_treasury_UpdateTokenPriceEvent)
-  [Struct `NewTokenEvent`](#bridge_treasury_NewTokenEvent)
-  [Struct `TokenRegistrationEvent`](#bridge_treasury_TokenRegistrationEvent)
-  [Constants](#@Constants_0)
-  [Function `token_id`](#bridge_treasury_token_id)
-  [Function `decimal_multiplier`](#bridge_treasury_decimal_multiplier)
-  [Function `notional_value`](#bridge_treasury_notional_value)
-  [Function `register_foreign_token`](#bridge_treasury_register_foreign_token)
-  [Function `add_new_token`](#bridge_treasury_add_new_token)
-  [Function `create`](#bridge_treasury_create)
-  [Function `burn`](#bridge_treasury_burn)
-  [Function `mint`](#bridge_treasury_mint)
-  [Function `update_asset_notional_price`](#bridge_treasury_update_asset_notional_price)
-  [Function `get_token_metadata`](#bridge_treasury_get_token_metadata)


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
<b>use</b> <a href="../one/funds_accumulator.md#one_funds_accumulator">one::funds_accumulator</a>;
<b>use</b> <a href="../one/hex.md#one_hex">one::hex</a>;
<b>use</b> <a href="../one/object.md#one_object">one::object</a>;
<b>use</b> <a href="../one/object_bag.md#one_object_bag">one::object_bag</a>;
<b>use</b> <a href="../one/package.md#one_package">one::package</a>;
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



<a name="bridge_treasury_BridgeTreasury"></a>

## Struct `BridgeTreasury`



<pre><code><b>public</b> <b>struct</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>treasuries: <a href="../one/object_bag.md#one_object_bag_ObjectBag">one::object_bag::ObjectBag</a></code>
</dt>
<dd>
</dd>
<dt>
<code>supported_tokens: <a href="../one/vec_map.md#one_vec_map_VecMap">one::vec_map::VecMap</a>&lt;<a href="../std/type_name.md#std_type_name_TypeName">std::type_name::TypeName</a>, <a href="../bridge/treasury.md#bridge_treasury_BridgeTokenMetadata">bridge::treasury::BridgeTokenMetadata</a>&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code>id_token_type_map: <a href="../one/vec_map.md#one_vec_map_VecMap">one::vec_map::VecMap</a>&lt;u8, <a href="../std/type_name.md#std_type_name_TypeName">std::type_name::TypeName</a>&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code>waiting_room: <a href="../one/bag.md#one_bag_Bag">one::bag::Bag</a></code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="bridge_treasury_BridgeTokenMetadata"></a>

## Struct `BridgeTokenMetadata`



<pre><code><b>public</b> <b>struct</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTokenMetadata">BridgeTokenMetadata</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: u8</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a>: u64</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>native_token: bool</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="bridge_treasury_ForeignTokenRegistration"></a>

## Struct `ForeignTokenRegistration`



<pre><code><b>public</b> <b>struct</b> <a href="../bridge/treasury.md#bridge_treasury_ForeignTokenRegistration">ForeignTokenRegistration</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>type_name: <a href="../std/type_name.md#std_type_name_TypeName">std::type_name::TypeName</a></code>
</dt>
<dd>
</dd>
<dt>
<code>uc: <a href="../one/package.md#one_package_UpgradeCap">one::package::UpgradeCap</a></code>
</dt>
<dd>
</dd>
<dt>
<code>decimal: u8</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="bridge_treasury_UpdateTokenPriceEvent"></a>

## Struct `UpdateTokenPriceEvent`



<pre><code><b>public</b> <b>struct</b> <a href="../bridge/treasury.md#bridge_treasury_UpdateTokenPriceEvent">UpdateTokenPriceEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code><a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>: u8</code>
</dt>
<dd>
</dd>
<dt>
<code>new_price: u64</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="bridge_treasury_NewTokenEvent"></a>

## Struct `NewTokenEvent`



<pre><code><b>public</b> <b>struct</b> <a href="../bridge/treasury.md#bridge_treasury_NewTokenEvent">NewTokenEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code><a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>: u8</code>
</dt>
<dd>
</dd>
<dt>
<code>type_name: <a href="../std/type_name.md#std_type_name_TypeName">std::type_name::TypeName</a></code>
</dt>
<dd>
</dd>
<dt>
<code>native_token: bool</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a>: u64</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>: u64</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="bridge_treasury_TokenRegistrationEvent"></a>

## Struct `TokenRegistrationEvent`



<pre><code><b>public</b> <b>struct</b> <a href="../bridge/treasury.md#bridge_treasury_TokenRegistrationEvent">TokenRegistrationEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>type_name: <a href="../std/type_name.md#std_type_name_TypeName">std::type_name::TypeName</a></code>
</dt>
<dd>
</dd>
<dt>
<code>decimal: u8</code>
</dt>
<dd>
</dd>
<dt>
<code>native_token: bool</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="bridge_treasury_EUnsupportedTokenType"></a>



<pre><code><b>const</b> <a href="../bridge/treasury.md#bridge_treasury_EUnsupportedTokenType">EUnsupportedTokenType</a>: u64 = 1;
</code></pre>



<a name="bridge_treasury_EInvalidUpgradeCap"></a>



<pre><code><b>const</b> <a href="../bridge/treasury.md#bridge_treasury_EInvalidUpgradeCap">EInvalidUpgradeCap</a>: u64 = 2;
</code></pre>



<a name="bridge_treasury_ETokenSupplyNonZero"></a>



<pre><code><b>const</b> <a href="../bridge/treasury.md#bridge_treasury_ETokenSupplyNonZero">ETokenSupplyNonZero</a>: u64 = 3;
</code></pre>



<a name="bridge_treasury_EInvalidNotionalValue"></a>



<pre><code><b>const</b> <a href="../bridge/treasury.md#bridge_treasury_EInvalidNotionalValue">EInvalidNotionalValue</a>: u64 = 4;
</code></pre>



<a name="bridge_treasury_token_id"></a>

## Function `token_id`



<pre><code><b>public</b> <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>): u8
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>): u8 {
    <b>let</b> metadata = self.<a href="../bridge/treasury.md#bridge_treasury_get_token_metadata">get_token_metadata</a>&lt;T&gt;();
    metadata.id
}
</code></pre>



</details>

<a name="bridge_treasury_decimal_multiplier"></a>

## Function `decimal_multiplier`



<pre><code><b>public</b> <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>): u64 {
    <b>let</b> metadata = self.<a href="../bridge/treasury.md#bridge_treasury_get_token_metadata">get_token_metadata</a>&lt;T&gt;();
    metadata.<a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a>
}
</code></pre>



</details>

<a name="bridge_treasury_notional_value"></a>

## Function `notional_value`



<pre><code><b>public</b> <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>): u64 {
    <b>let</b> metadata = self.<a href="../bridge/treasury.md#bridge_treasury_get_token_metadata">get_token_metadata</a>&lt;T&gt;();
    metadata.<a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>
}
</code></pre>



</details>

<a name="bridge_treasury_register_foreign_token"></a>

## Function `register_foreign_token`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_register_foreign_token">register_foreign_token</a>&lt;T&gt;(self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>, tc: <a href="../one/coin.md#one_coin_TreasuryCap">one::coin::TreasuryCap</a>&lt;T&gt;, uc: <a href="../one/package.md#one_package_UpgradeCap">one::package::UpgradeCap</a>, metadata: &<a href="../one/coin.md#one_coin_CoinMetadata">one::coin::CoinMetadata</a>&lt;T&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_register_foreign_token">register_foreign_token</a>&lt;T&gt;(
    self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>,
    tc: TreasuryCap&lt;T&gt;,
    uc: UpgradeCap,
    metadata: &CoinMetadata&lt;T&gt;,
) {
    // Make sure TreasuryCap <b>has</b> not been minted before.
    <b>assert</b>!(coin::total_supply(&tc) == 0, <a href="../bridge/treasury.md#bridge_treasury_ETokenSupplyNonZero">ETokenSupplyNonZero</a>);
    <b>let</b> type_name = type_name::with_defining_ids&lt;T&gt;();
    <b>let</b> address_bytes = hex::decode(ascii::into_bytes(type_name::address_string(&type_name)));
    <b>let</b> coin_address = address::from_bytes(address_bytes);
    // Make sure upgrade cap is <b>for</b> the Coin package
    // FIXME: add test
    <b>assert</b>!(
        object::id_to_address(&package::upgrade_package(&uc)) == coin_address,
        <a href="../bridge/treasury.md#bridge_treasury_EInvalidUpgradeCap">EInvalidUpgradeCap</a>,
    );
    <b>let</b> registration = <a href="../bridge/treasury.md#bridge_treasury_ForeignTokenRegistration">ForeignTokenRegistration</a> {
        type_name,
        uc,
        decimal: coin::get_decimals(metadata),
    };
    self.waiting_room.add(type_name::into_string(type_name), registration);
    self.treasuries.add(type_name, tc);
    event::emit(<a href="../bridge/treasury.md#bridge_treasury_TokenRegistrationEvent">TokenRegistrationEvent</a> {
        type_name,
        decimal: coin::get_decimals(metadata),
        native_token: <b>false</b>,
    });
}
</code></pre>



</details>

<a name="bridge_treasury_add_new_token"></a>

## Function `add_new_token`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_add_new_token">add_new_token</a>(self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>, token_name: <a href="../std/ascii.md#std_ascii_String">std::ascii::String</a>, <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>: u8, native_token: bool, <a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_add_new_token">add_new_token</a>(
    self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>,
    token_name: String,
    <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>: u8,
    native_token: bool,
    <a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>: u64,
) {
    <b>if</b> (!native_token) {
        <b>assert</b>!(<a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a> &gt; 0, <a href="../bridge/treasury.md#bridge_treasury_EInvalidNotionalValue">EInvalidNotionalValue</a>);
        <b>let</b> <a href="../bridge/treasury.md#bridge_treasury_ForeignTokenRegistration">ForeignTokenRegistration</a> {
            type_name,
            uc,
            decimal,
        } = self.waiting_room.remove&lt;String, <a href="../bridge/treasury.md#bridge_treasury_ForeignTokenRegistration">ForeignTokenRegistration</a>&gt;(token_name);
        <b>let</b> <a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a> = 10u64.pow(decimal);
        self
            .supported_tokens
            .insert(
                type_name,
                <a href="../bridge/treasury.md#bridge_treasury_BridgeTokenMetadata">BridgeTokenMetadata</a> {
                    id: <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>,
                    <a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a>,
                    <a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>,
                    native_token,
                },
            );
        self.id_token_type_map.insert(<a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>, type_name);
        // Freeze upgrade cap to prevent changes to the coin
        transfer::public_freeze_object(uc);
        event::emit(<a href="../bridge/treasury.md#bridge_treasury_NewTokenEvent">NewTokenEvent</a> {
            <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>,
            type_name,
            native_token,
            <a href="../bridge/treasury.md#bridge_treasury_decimal_multiplier">decimal_multiplier</a>,
            <a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a>,
        })
    } // <b>else</b> not implemented in V1
}
</code></pre>



</details>

<a name="bridge_treasury_create"></a>

## Function `create`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_create">create</a>(ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_create">create</a>(ctx: &<b>mut</b> TxContext): <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a> {
    <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a> {
        treasuries: object_bag::new(ctx),
        supported_tokens: vec_map::empty(),
        id_token_type_map: vec_map::empty(),
        waiting_room: bag::new(ctx),
    }
}
</code></pre>



</details>

<a name="bridge_treasury_burn"></a>

## Function `burn`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_burn">burn</a>&lt;T&gt;(self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>, token: <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_burn">burn</a>&lt;T&gt;(self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>, token: Coin&lt;T&gt;) {
    <b>let</b> <a href="../bridge/treasury.md#bridge_treasury">treasury</a> = &<b>mut</b> self.treasuries[type_name::with_defining_ids&lt;T&gt;()];
    coin::burn(<a href="../bridge/treasury.md#bridge_treasury">treasury</a>, token);
}
</code></pre>



</details>

<a name="bridge_treasury_mint"></a>

## Function `mint`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_mint">mint</a>&lt;T&gt;(self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>, amount: u64, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one/coin.md#one_coin_Coin">one::coin::Coin</a>&lt;T&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_mint">mint</a>&lt;T&gt;(self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>, amount: u64, ctx: &<b>mut</b> TxContext): Coin&lt;T&gt; {
    <b>let</b> <a href="../bridge/treasury.md#bridge_treasury">treasury</a> = &<b>mut</b> self.treasuries[type_name::with_defining_ids&lt;T&gt;()];
    coin::mint(<a href="../bridge/treasury.md#bridge_treasury">treasury</a>, amount, ctx)
}
</code></pre>



</details>

<a name="bridge_treasury_update_asset_notional_price"></a>

## Function `update_asset_notional_price`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_update_asset_notional_price">update_asset_notional_price</a>(self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>, <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>: u8, new_usd_price: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_update_asset_notional_price">update_asset_notional_price</a>(
    self: &<b>mut</b> <a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>,
    <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>: u8,
    new_usd_price: u64,
) {
    <b>let</b> type_name = self.id_token_type_map.try_get(&<a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>);
    <b>assert</b>!(type_name.is_some(), <a href="../bridge/treasury.md#bridge_treasury_EUnsupportedTokenType">EUnsupportedTokenType</a>);
    <b>assert</b>!(new_usd_price &gt; 0, <a href="../bridge/treasury.md#bridge_treasury_EInvalidNotionalValue">EInvalidNotionalValue</a>);
    <b>let</b> type_name = type_name.destroy_some();
    <b>let</b> metadata = self.supported_tokens.get_mut(&type_name);
    metadata.<a href="../bridge/treasury.md#bridge_treasury_notional_value">notional_value</a> = new_usd_price;
    event::emit(<a href="../bridge/treasury.md#bridge_treasury_UpdateTokenPriceEvent">UpdateTokenPriceEvent</a> {
        <a href="../bridge/treasury.md#bridge_treasury_token_id">token_id</a>,
        new_price: new_usd_price,
    })
}
</code></pre>



</details>

<a name="bridge_treasury_get_token_metadata"></a>

## Function `get_token_metadata`



<pre><code><b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_get_token_metadata">get_token_metadata</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">bridge::treasury::BridgeTreasury</a>): <a href="../bridge/treasury.md#bridge_treasury_BridgeTokenMetadata">bridge::treasury::BridgeTokenMetadata</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../bridge/treasury.md#bridge_treasury_get_token_metadata">get_token_metadata</a>&lt;T&gt;(self: &<a href="../bridge/treasury.md#bridge_treasury_BridgeTreasury">BridgeTreasury</a>): <a href="../bridge/treasury.md#bridge_treasury_BridgeTokenMetadata">BridgeTokenMetadata</a> {
    <b>let</b> coin_type = type_name::with_defining_ids&lt;T&gt;();
    <b>let</b> metadata = self.supported_tokens.try_get(&coin_type);
    <b>assert</b>!(metadata.is_some(), <a href="../bridge/treasury.md#bridge_treasury_EUnsupportedTokenType">EUnsupportedTokenType</a>);
    metadata.destroy_some()
}
</code></pre>



</details>
