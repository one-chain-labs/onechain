---
title: Module `one::event`
---

Events module. Defines the <code><a href="../one/event.md#one_event_emit">one::event::emit</a></code> function which
creates and sends a custom MoveEvent as a part of the effects
certificate of the transaction.

Every MoveEvent has the following properties:
- sender
- type signature (<code>T</code>)
- event data (the value of <code>T</code>)
- timestamp (local to a node)
- transaction digest

Example:
```
module my::marketplace {
use one::event;
/* ... */
struct ItemPurchased has copy, drop {
item_id: ID, buyer: address
}
entry fun buy(/* .... */) {
/* ... */
event::emit(ItemPurchased { item_id: ..., buyer: .... })
}
}
```


-  [Function `emit`](#one_event_emit)
-  [Function `emit_authenticated`](#one_event_emit_authenticated)
-  [Function `emit_authenticated_impl`](#one_event_emit_authenticated_impl)


<pre><code><b>use</b> <a href="../one/accumulator.md#one_accumulator">one::accumulator</a>;
<b>use</b> <a href="../one/accumulator_metadata.md#one_accumulator_metadata">one::accumulator_metadata</a>;
<b>use</b> <a href="../one/accumulator_settlement.md#one_accumulator_settlement">one::accumulator_settlement</a>;
<b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/bag.md#one_bag">one::bag</a>;
<b>use</b> <a href="../one/bcs.md#one_bcs">one::bcs</a>;
<b>use</b> <a href="../one/dynamic_field.md#one_dynamic_field">one::dynamic_field</a>;
<b>use</b> <a href="../one/hash.md#one_hash">one::hash</a>;
<b>use</b> <a href="../one/hex.md#one_hex">one::hex</a>;
<b>use</b> <a href="../one/object.md#one_object">one::object</a>;
<b>use</b> <a href="../one/party.md#one_party">one::party</a>;
<b>use</b> <a href="../one/transfer.md#one_transfer">one::transfer</a>;
<b>use</b> <a href="../one/tx_context.md#one_tx_context">one::tx_context</a>;
<b>use</b> <a href="../one/vec_map.md#one_vec_map">one::vec_map</a>;
<b>use</b> <a href="../std/address.md#std_address">std::address</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/type_name.md#std_type_name">std::type_name</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="one_event_emit"></a>

## Function `emit`

Emit a custom Move event, sending the data offchain.

Used for creating custom indexes and tracking onchain
activity in a way that suits a specific application the most.

The type <code>T</code> is the main way to index the event, and can contain
phantom parameters, eg <code><a href="../one/event.md#one_event_emit">emit</a>(MyEvent&lt;<b>phantom</b> T&gt;)</code>.


<pre><code><b>public</b> <b>fun</b> <a href="../one/event.md#one_event_emit">emit</a>&lt;T: <b>copy</b>, drop&gt;(<a href="../one/event.md#one_event">event</a>: T)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>native</b> <b>fun</b> <a href="../one/event.md#one_event_emit">emit</a>&lt;T: <b>copy</b> + drop&gt;(<a href="../one/event.md#one_event">event</a>: T);
</code></pre>



</details>

<a name="one_event_emit_authenticated"></a>

## Function `emit_authenticated`

Emits a custom Move event which can be authenticated by a light client.

This method emits the authenticated event to the event stream for the Move package that
defines the event type <code>T</code>.
Only the package that defines the type <code>T</code> can emit authenticated events to this stream.


<pre><code><b>public</b> <b>fun</b> <a href="../one/event.md#one_event_emit_authenticated">emit_authenticated</a>&lt;T: <b>copy</b>, drop&gt;(<a href="../one/event.md#one_event">event</a>: T)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/event.md#one_event_emit_authenticated">emit_authenticated</a>&lt;T: <b>copy</b> + drop&gt;(<a href="../one/event.md#one_event">event</a>: T) {
    <b>let</b> stream_id = type_name::original_id&lt;T&gt;();
    <b>let</b> accumulator_addr = <a href="../one/accumulator.md#one_accumulator_accumulator_address">accumulator::accumulator_address</a>&lt;EventStreamHead&gt;(stream_id);
    <a href="../one/event.md#one_event_emit_authenticated_impl">emit_authenticated_impl</a>&lt;EventStreamHead, T&gt;(accumulator_addr, stream_id, <a href="../one/event.md#one_event">event</a>);
}
</code></pre>



</details>

<a name="one_event_emit_authenticated_impl"></a>

## Function `emit_authenticated_impl`



<pre><code><b>fun</b> <a href="../one/event.md#one_event_emit_authenticated_impl">emit_authenticated_impl</a>&lt;StreamHeadT, T: <b>copy</b>, drop&gt;(accumulator_id: <b>address</b>, stream: <b>address</b>, <a href="../one/event.md#one_event">event</a>: T)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>native</b> <b>fun</b> <a href="../one/event.md#one_event_emit_authenticated_impl">emit_authenticated_impl</a>&lt;StreamHeadT, T: <b>copy</b> + drop&gt;(
    accumulator_id: <b>address</b>,
    stream: <b>address</b>,
    <a href="../one/event.md#one_event">event</a>: T,
);
</code></pre>



</details>
