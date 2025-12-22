---
title: Module `one::borrow`
---

A simple library that enables hot-potato-locked borrow mechanics.

With Programmable transactions, it is possible to borrow a value within
a transaction, use it and put back in the end. Hot-potato <code><a href="../one/borrow.md#one_borrow_Borrow">Borrow</a></code> makes
sure the object is returned and was not swapped for another one.


-  [Struct `Referent`](#one_borrow_Referent)
-  [Struct `Borrow`](#one_borrow_Borrow)
-  [Constants](#@Constants_0)
-  [Function `new`](#one_borrow_new)
-  [Function `borrow`](#one_borrow_borrow)
-  [Function `put_back`](#one_borrow_put_back)
-  [Function `destroy`](#one_borrow_destroy)


<pre><code><b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/hex.md#one_hex">one::hex</a>;
<b>use</b> <a href="../one/object.md#one_object">one::object</a>;
<b>use</b> <a href="../one/tx_context.md#one_tx_context">one::tx_context</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="one_borrow_Referent"></a>

## Struct `Referent`

An object wrapping a <code>T</code> and providing the borrow API.


<pre><code><b>public</b> <b>struct</b> <a href="../one/borrow.md#one_borrow_Referent">Referent</a>&lt;T: key, store&gt; <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>value: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;T&gt;</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_borrow_Borrow"></a>

## Struct `Borrow`

A hot potato making sure the object is put back once borrowed.


<pre><code><b>public</b> <b>struct</b> <a href="../one/borrow.md#one_borrow_Borrow">Borrow</a>
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>ref: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>obj: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="one_borrow_EWrongBorrow"></a>

The <code><a href="../one/borrow.md#one_borrow_Borrow">Borrow</a></code> does not match the <code><a href="../one/borrow.md#one_borrow_Referent">Referent</a></code>.


<pre><code><b>const</b> <a href="../one/borrow.md#one_borrow_EWrongBorrow">EWrongBorrow</a>: u64 = 0;
</code></pre>



<a name="one_borrow_EWrongValue"></a>

An attempt to swap the <code><a href="../one/borrow.md#one_borrow_Referent">Referent</a>.value</code> with another object of the same type.


<pre><code><b>const</b> <a href="../one/borrow.md#one_borrow_EWrongValue">EWrongValue</a>: u64 = 1;
</code></pre>



<a name="one_borrow_new"></a>

## Function `new`

Create a new <code><a href="../one/borrow.md#one_borrow_Referent">Referent</a></code> struct


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow_new">new</a>&lt;T: key, store&gt;(value: T, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one/borrow.md#one_borrow_Referent">one::borrow::Referent</a>&lt;T&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow_new">new</a>&lt;T: key + store&gt;(value: T, ctx: &<b>mut</b> TxContext): <a href="../one/borrow.md#one_borrow_Referent">Referent</a>&lt;T&gt; {
    <a href="../one/borrow.md#one_borrow_Referent">Referent</a> {
        id: <a href="../one/tx_context.md#one_tx_context_fresh_object_address">tx_context::fresh_object_address</a>(ctx),
        value: option::some(value),
    }
}
</code></pre>



</details>

<a name="one_borrow_borrow"></a>

## Function `borrow`

Borrow the <code>T</code> from the <code><a href="../one/borrow.md#one_borrow_Referent">Referent</a></code> receiving the <code>T</code> and a <code><a href="../one/borrow.md#one_borrow_Borrow">Borrow</a></code>
hot potato.


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow">borrow</a>&lt;T: key, store&gt;(self: &<b>mut</b> <a href="../one/borrow.md#one_borrow_Referent">one::borrow::Referent</a>&lt;T&gt;): (T, <a href="../one/borrow.md#one_borrow_Borrow">one::borrow::Borrow</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow">borrow</a>&lt;T: key + store&gt;(self: &<b>mut</b> <a href="../one/borrow.md#one_borrow_Referent">Referent</a>&lt;T&gt;): (T, <a href="../one/borrow.md#one_borrow_Borrow">Borrow</a>) {
    <b>let</b> value = self.value.extract();
    <b>let</b> id = <a href="../one/object.md#one_object_id">object::id</a>(&value);
    (
        value,
        <a href="../one/borrow.md#one_borrow_Borrow">Borrow</a> {
            ref: self.id,
            obj: id,
        },
    )
}
</code></pre>



</details>

<a name="one_borrow_put_back"></a>

## Function `put_back`

Put an object and the <code><a href="../one/borrow.md#one_borrow_Borrow">Borrow</a></code> hot potato back.


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow_put_back">put_back</a>&lt;T: key, store&gt;(self: &<b>mut</b> <a href="../one/borrow.md#one_borrow_Referent">one::borrow::Referent</a>&lt;T&gt;, value: T, <a href="../one/borrow.md#one_borrow">borrow</a>: <a href="../one/borrow.md#one_borrow_Borrow">one::borrow::Borrow</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow_put_back">put_back</a>&lt;T: key + store&gt;(self: &<b>mut</b> <a href="../one/borrow.md#one_borrow_Referent">Referent</a>&lt;T&gt;, value: T, <a href="../one/borrow.md#one_borrow">borrow</a>: <a href="../one/borrow.md#one_borrow_Borrow">Borrow</a>) {
    <b>let</b> <a href="../one/borrow.md#one_borrow_Borrow">Borrow</a> { ref, obj } = <a href="../one/borrow.md#one_borrow">borrow</a>;
    <b>assert</b>!(<a href="../one/object.md#one_object_id">object::id</a>(&value) == obj, <a href="../one/borrow.md#one_borrow_EWrongValue">EWrongValue</a>);
    <b>assert</b>!(self.id == ref, <a href="../one/borrow.md#one_borrow_EWrongBorrow">EWrongBorrow</a>);
    self.value.fill(value);
}
</code></pre>



</details>

<a name="one_borrow_destroy"></a>

## Function `destroy`

Unpack the <code><a href="../one/borrow.md#one_borrow_Referent">Referent</a></code> struct and return the value.


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow_destroy">destroy</a>&lt;T: key, store&gt;(self: <a href="../one/borrow.md#one_borrow_Referent">one::borrow::Referent</a>&lt;T&gt;): T
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one/borrow.md#one_borrow_destroy">destroy</a>&lt;T: key + store&gt;(self: <a href="../one/borrow.md#one_borrow_Referent">Referent</a>&lt;T&gt;): T {
    <b>let</b> <a href="../one/borrow.md#one_borrow_Referent">Referent</a> { id: _, value } = self;
    value.destroy_some()
}
</code></pre>



</details>
