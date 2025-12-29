---
title: Module `one::accumulator_settlement`
---



-  [Constants](#@Constants_0)
-  [Function `settlement_prologue`](#one_accumulator_settlement_settlement_prologue)
-  [Function `settle_u128`](#one_accumulator_settlement_settle_u128)
-  [Function `record_settlement_sui_conservation`](#one_accumulator_settlement_record_settlement_sui_conservation)


<pre><code><b>use</b> <a href="../one/accumulator.md#one_accumulator">one::accumulator</a>;
<b>use</b> <a href="../one/accumulator_metadata.md#one_accumulator_metadata">one::accumulator_metadata</a>;
<b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/bag.md#one_bag">one::bag</a>;
<b>use</b> <a href="../one/dynamic_field.md#one_dynamic_field">one::dynamic_field</a>;
<b>use</b> <a href="../one/hex.md#one_hex">one::hex</a>;
<b>use</b> <a href="../one/object.md#one_object">one::object</a>;
<b>use</b> <a href="../one/party.md#one_party">one::party</a>;
<b>use</b> <a href="../one/transfer.md#one_transfer">one::transfer</a>;
<b>use</b> <a href="../one/tx_context.md#one_tx_context">one::tx_context</a>;
<b>use</b> <a href="../one/vec_map.md#one_vec_map">one::vec_map</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="@Constants_0"></a>

## Constants


<a name="one_accumulator_settlement_ENotSystemAddress"></a>



<pre><code><b>const</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_ENotSystemAddress">ENotSystemAddress</a>: u64 = 0;
</code></pre>



<a name="one_accumulator_settlement_EInvalidSplitAmount"></a>



<pre><code><b>const</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_EInvalidSplitAmount">EInvalidSplitAmount</a>: u64 = 1;
</code></pre>



<a name="one_accumulator_settlement_settlement_prologue"></a>

## Function `settlement_prologue`

Called by settlement transactions to ensure that the settlement transaction has a unique
digest.


<pre><code><b>fun</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_settlement_prologue">settlement_prologue</a>(_epoch: u64, _checkpoint_height: u64, _idx: u64, input_sui: u64, output_sui: u64, ctx: &<a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_settlement_prologue">settlement_prologue</a>(
    _epoch: u64,
    _checkpoint_height: u64,
    _idx: u64,
    // Total input sui received from user transactions
    input_sui: u64,
    // Total output sui withdrawn by user transactions
    output_sui: u64,
    ctx: &TxContext,
) {
    <b>assert</b>!(ctx.sender() == @0x0, <a href="../one/accumulator_settlement.md#one_accumulator_settlement_ENotSystemAddress">ENotSystemAddress</a>);
    <a href="../one/accumulator_settlement.md#one_accumulator_settlement_record_settlement_sui_conservation">record_settlement_sui_conservation</a>(input_sui, output_sui);
}
</code></pre>



</details>

<a name="one_accumulator_settlement_settle_u128"></a>

## Function `settle_u128`



<pre><code><b>fun</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_settle_u128">settle_u128</a>&lt;T&gt;(accumulator_root: &<b>mut</b> <a href="../one/accumulator.md#one_accumulator_AccumulatorRoot">one::accumulator::AccumulatorRoot</a>, owner: <b>address</b>, merge: u128, split: u128, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_settle_u128">settle_u128</a>&lt;T&gt;(
    accumulator_root: &<b>mut</b> AccumulatorRoot,
    owner: <b>address</b>,
    merge: u128,
    split: u128,
    ctx: &<b>mut</b> TxContext,
) {
    <b>assert</b>!(ctx.sender() == @0x0, <a href="../one/accumulator_settlement.md#one_accumulator_settlement_ENotSystemAddress">ENotSystemAddress</a>);
    // Merge and split should be netted out prior to calling this function.
    <b>assert</b>!((merge == 0 ) != (split == 0), <a href="../one/accumulator_settlement.md#one_accumulator_settlement_EInvalidSplitAmount">EInvalidSplitAmount</a>);
    <b>let</b> name = accumulator_key&lt;T&gt;(owner);
    <b>if</b> (accumulator_root.has_accumulator&lt;T, U128&gt;(name)) {
        <b>let</b> is_zero = {
            <b>let</b> value: &<b>mut</b> U128 = accumulator_root.borrow_accumulator_mut(name);
            value.update(merge, split);
            value.is_zero()
        };
        <b>if</b> (is_zero) {
            <b>let</b> value = accumulator_root.remove_accumulator&lt;T, U128&gt;(name);
            destroy_u128(value);
            accumulator_root.remove_metadata&lt;T&gt;(owner);
        }
    } <b>else</b> {
        // cannot split <b>if</b> the field does not yet exist
        <b>assert</b>!(split == 0, <a href="../one/accumulator_settlement.md#one_accumulator_settlement_EInvalidSplitAmount">EInvalidSplitAmount</a>);
        <b>let</b> value = create_u128(merge);
        accumulator_root.add_accumulator(name, value);
        accumulator_root.create_metadata&lt;T&gt;(owner, ctx);
    };
}
</code></pre>



</details>

<a name="one_accumulator_settlement_record_settlement_sui_conservation"></a>

## Function `record_settlement_sui_conservation`

Called by the settlement transaction to track conservation of SUI.


<pre><code><b>fun</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_record_settlement_sui_conservation">record_settlement_sui_conservation</a>(input_sui: u64, output_sui: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>native</b> <b>fun</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement_record_settlement_sui_conservation">record_settlement_sui_conservation</a>(input_sui: u64, output_sui: u64);
</code></pre>



</details>
