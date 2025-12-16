---
title: Module `one_system::validator_cap`
---



-  [Struct `UnverifiedValidatorOperationCap`](#one_system_validator_cap_UnverifiedValidatorOperationCap)
-  [Struct `ValidatorOperationCap`](#one_system_validator_cap_ValidatorOperationCap)
-  [Function `unverified_operation_cap_address`](#one_system_validator_cap_unverified_operation_cap_address)
-  [Function `verified_operation_cap_address`](#one_system_validator_cap_verified_operation_cap_address)
-  [Function `new_unverified_validator_operation_cap_and_transfer`](#one_system_validator_cap_new_unverified_validator_operation_cap_and_transfer)
-  [Function `new_from_unverified`](#one_system_validator_cap_new_from_unverified)


<pre><code><b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/hex.md#one_hex">one::hex</a>;
<b>use</b> <a href="../one/object.md#one_object">one::object</a>;
<b>use</b> <a href="../one/transfer.md#one_transfer">one::transfer</a>;
<b>use</b> <a href="../one/tx_context.md#one_tx_context">one::tx_context</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="one_system_validator_cap_UnverifiedValidatorOperationCap"></a>

## Struct `UnverifiedValidatorOperationCap`

The capability object is created when creating a new <code>Validator</code> or when the
validator explicitly creates a new capability object for rotation/revocation.
The holder address of this object can perform some validator operations on behalf of
the authorizer validator. Thus, if a validator wants to separate the keys for operation
(such as reference gas price setting or tallying rule reporting) from fund/staking, it
could transfer this capability object to another address.
To facilitate rotating/revocation, <code>Validator</code> stores the ID of currently valid
<code><a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">UnverifiedValidatorOperationCap</a></code>. Thus, before converting <code><a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">UnverifiedValidatorOperationCap</a></code>
to <code><a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">ValidatorOperationCap</a></code>, verification needs to be done to make sure
the cap object is still valid.


<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">UnverifiedValidatorOperationCap</a> <b>has</b> key, store
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
<code>authorizer_validator_address: <b>address</b></code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_system_validator_cap_ValidatorOperationCap"></a>

## Struct `ValidatorOperationCap`

Privileged operations require <code><a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">ValidatorOperationCap</a></code> for permission check.
This is only constructed after successful verification.


<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">ValidatorOperationCap</a> <b>has</b> drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>authorizer_validator_address: <b>address</b></code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_system_validator_cap_unverified_operation_cap_address"></a>

## Function `unverified_operation_cap_address`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_unverified_operation_cap_address">unverified_operation_cap_address</a>(cap: &<a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">one_system::validator_cap::UnverifiedValidatorOperationCap</a>): &<b>address</b>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_unverified_operation_cap_address">unverified_operation_cap_address</a>(cap: &<a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">UnverifiedValidatorOperationCap</a>): &<b>address</b> {
    &cap.authorizer_validator_address
}
</code></pre>



</details>

<a name="one_system_validator_cap_verified_operation_cap_address"></a>

## Function `verified_operation_cap_address`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_verified_operation_cap_address">verified_operation_cap_address</a>(cap: &<a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">one_system::validator_cap::ValidatorOperationCap</a>): &<b>address</b>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_verified_operation_cap_address">verified_operation_cap_address</a>(cap: &<a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">ValidatorOperationCap</a>): &<b>address</b> {
    &cap.authorizer_validator_address
}
</code></pre>



</details>

<a name="one_system_validator_cap_new_unverified_validator_operation_cap_and_transfer"></a>

## Function `new_unverified_validator_operation_cap_and_transfer`

Should be only called by the friend modules when adding a <code>Validator</code>
or rotating an existing validaotr's <code>operation_cap_id</code>.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_new_unverified_validator_operation_cap_and_transfer">new_unverified_validator_operation_cap_and_transfer</a>(validator_address: <b>address</b>, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one/object.md#one_object_ID">one::object::ID</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_new_unverified_validator_operation_cap_and_transfer">new_unverified_validator_operation_cap_and_transfer</a>(
    validator_address: <b>address</b>,
    ctx: &<b>mut</b> TxContext,
): ID {
    // This function needs to be called only by the <a href="../one_system/validator.md#one_system_validator">validator</a> itself, except
    // 1. in <a href="../one_system/genesis.md#one_system_genesis">genesis</a> where all valdiators are created by @0x0
    // 2. in tests where @0x0 could be used to simplify the setup
    <b>let</b> sender_address = ctx.sender();
    <b>assert</b>!(sender_address == @0x0 || sender_address == validator_address, 0);
    <b>let</b> operation_cap = <a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">UnverifiedValidatorOperationCap</a> {
        id: object::new(ctx),
        authorizer_validator_address: validator_address,
    };
    <b>let</b> operation_cap_id = object::id(&operation_cap);
    transfer::public_transfer(operation_cap, validator_address);
    operation_cap_id
}
</code></pre>



</details>

<a name="one_system_validator_cap_new_from_unverified"></a>

## Function `new_from_unverified`

Convert an <code><a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">UnverifiedValidatorOperationCap</a></code> to <code><a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">ValidatorOperationCap</a></code>.
Should only be called by <code><a href="../one_system/validator_set.md#one_system_validator_set">validator_set</a></code> module AFTER verification.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_new_from_unverified">new_from_unverified</a>(cap: &<a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">one_system::validator_cap::UnverifiedValidatorOperationCap</a>): <a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">one_system::validator_cap::ValidatorOperationCap</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator_cap.md#one_system_validator_cap_new_from_unverified">new_from_unverified</a>(
    cap: &<a href="../one_system/validator_cap.md#one_system_validator_cap_UnverifiedValidatorOperationCap">UnverifiedValidatorOperationCap</a>,
): <a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">ValidatorOperationCap</a> {
    <a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">ValidatorOperationCap</a> {
        authorizer_validator_address: cap.authorizer_validator_address
    }
}
</code></pre>



</details>
