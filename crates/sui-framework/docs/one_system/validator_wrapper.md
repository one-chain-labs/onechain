---
title: Module `one_system::validator_wrapper`
---



-  [Struct `ValidatorWrapper`](#one_system_validator_wrapper_ValidatorWrapper)
-  [Constants](#@Constants_0)
-  [Function `create_v1`](#one_system_validator_wrapper_create_v1)
-  [Function `load_validator_maybe_upgrade`](#one_system_validator_wrapper_load_validator_maybe_upgrade)
-  [Function `destroy`](#one_system_validator_wrapper_destroy)
-  [Function `upgrade_to_latest`](#one_system_validator_wrapper_upgrade_to_latest)
-  [Function `version`](#one_system_validator_wrapper_version)


<pre><code><b>use</b> <a href="../one/accumulator.md#one_accumulator">one::accumulator</a>;
<b>use</b> <a href="../one/accumulator_metadata.md#one_accumulator_metadata">one::accumulator_metadata</a>;
<b>use</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement">one::accumulator_settlement</a>;
<b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/bag.md#one_bag">one::bag</a>;
<b>use</b> <a href="../one/balance.md#one_balance">one::balance</a>;
<b>use</b> <a href="../one/bcs.md#one_bcs">one::bcs</a>;
<b>use</b> <a href="../one/coin.md#one_coin">one::coin</a>;
<b>use</b> <a href="../one/coin_vesting.md#one_coin_vesting">one::coin_vesting</a>;
<b>use</b> <a href="../one/config.md#one_config">one::config</a>;
<b>use</b> <a href="../one/deny_list.md#one_deny_list">one::deny_list</a>;
<b>use</b> <a href="../one/dynamic_field.md#one_dynamic_field">one::dynamic_field</a>;
<b>use</b> <a href="../one/dynamic_object_field.md#one_dynamic_object_field">one::dynamic_object_field</a>;
<b>use</b> <a href="../one/event.md#one_event">one::event</a>;
<b>use</b> <a href="../one/funds_accumulator.md#one_funds_accumulator">one::funds_accumulator</a>;
<b>use</b> <a href="../one/hash.md#one_hash">one::hash</a>;
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
<b>use</b> <a href="../one/versioned.md#one_versioned">one::versioned</a>;
<b>use</b> <a href="../one_system/staking_pool.md#one_system_staking_pool">one_system::staking_pool</a>;
<b>use</b> <a href="../one_system/validator.md#one_system_validator">one_system::validator</a>;
<b>use</b> <a href="../one_system/validator_cap.md#one_system_validator_cap">one_system::validator_cap</a>;
<b>use</b> <a href="../std/address.md#std_address">std::address</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/type_name.md#std_type_name">std::type_name</a>;
<b>use</b> <a href="../std/u64.md#std_u64">std::u64</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="one_system_validator_wrapper_ValidatorWrapper"></a>

## Struct `ValidatorWrapper`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>inner: <a href="../one/versioned.md#one_versioned_Versioned">one::versioned::Versioned</a></code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="one_system_validator_wrapper_EInvalidVersion"></a>



<pre><code><b>const</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_EInvalidVersion">EInvalidVersion</a>: u64 = 0;
</code></pre>



<a name="one_system_validator_wrapper_create_v1"></a>

## Function `create_v1`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_create_v1">create_v1</a>(<a href="../one_system/validator.md#one_system_validator">validator</a>: <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">one_system::validator_wrapper::ValidatorWrapper</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_create_v1">create_v1</a>(<a href="../one_system/validator.md#one_system_validator">validator</a>: Validator, ctx: &<b>mut</b> TxContext): <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a> {
    <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a> {
        inner: versioned::create(1, <a href="../one_system/validator.md#one_system_validator">validator</a>, ctx),
    }
}
</code></pre>



</details>

<a name="one_system_validator_wrapper_load_validator_maybe_upgrade"></a>

## Function `load_validator_maybe_upgrade`

This function should always return the latest supported version.
If the inner version is old, we upgrade it lazily in-place.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_load_validator_maybe_upgrade">load_validator_maybe_upgrade</a>(self: &<b>mut</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">one_system::validator_wrapper::ValidatorWrapper</a>): &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_load_validator_maybe_upgrade">load_validator_maybe_upgrade</a>(self: &<b>mut</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a>): &<b>mut</b> Validator {
    self.<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_upgrade_to_latest">upgrade_to_latest</a>();
    self.inner.load_value_mut()
}
</code></pre>



</details>

<a name="one_system_validator_wrapper_destroy"></a>

## Function `destroy`

Destroy the wrapper and retrieve the inner validator object.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_destroy">destroy</a>(self: <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">one_system::validator_wrapper::ValidatorWrapper</a>): <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_destroy">destroy</a>(self: <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a>): Validator {
    <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_upgrade_to_latest">upgrade_to_latest</a>(&self);
    <b>let</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a> { inner } = self;
    inner.<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_destroy">destroy</a>()
}
</code></pre>



</details>

<a name="one_system_validator_wrapper_upgrade_to_latest"></a>

## Function `upgrade_to_latest`



<pre><code><b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_upgrade_to_latest">upgrade_to_latest</a>(self: &<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">one_system::validator_wrapper::ValidatorWrapper</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_upgrade_to_latest">upgrade_to_latest</a>(self: &<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a>) {
    <b>let</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_version">version</a> = self.<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_version">version</a>();
    // TODO: When new versions are added, we need to explicitly upgrade here.
    <b>assert</b>!(<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_version">version</a> == 1, <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_EInvalidVersion">EInvalidVersion</a>);
}
</code></pre>



</details>

<a name="one_system_validator_wrapper_version"></a>

## Function `version`



<pre><code><b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_version">version</a>(self: &<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">one_system::validator_wrapper::ValidatorWrapper</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_version">version</a>(self: &<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_ValidatorWrapper">ValidatorWrapper</a>): u64 {
    self.inner.<a href="../one_system/validator_wrapper.md#one_system_validator_wrapper_version">version</a>()
}
</code></pre>



</details>
