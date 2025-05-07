---
title: Module `0x3::supper_committee`
---



-  [Struct `ActionKey`](#0x3_supper_committee_ActionKey)
-  [Struct `SupperCommittee`](#0x3_supper_committee_SupperCommittee)
-  [Resource `Proposal`](#0x3_supper_committee_Proposal)
-  [Struct `CreateProposalEvent`](#0x3_supper_committee_CreateProposalEvent)
-  [Struct `VoteProposalEvent`](#0x3_supper_committee_VoteProposalEvent)
-  [Constants](#@Constants_0)
-  [Function `new`](#0x3_supper_committee_new)
-  [Function `vote_proposal`](#0x3_supper_committee_vote_proposal)
-  [Function `proposal_status`](#0x3_supper_committee_proposal_status)
-  [Function `proposal_action_type`](#0x3_supper_committee_proposal_action_type)
-  [Function `proposal_status_pass`](#0x3_supper_committee_proposal_status_pass)
-  [Function `action`](#0x3_supper_committee_action)
-  [Function `create_proposal`](#0x3_supper_committee_create_proposal)
-  [Function `get_vote_power`](#0x3_supper_committee_get_vote_power)


<pre><code><b>use</b> <a href="../move-stdlib/ascii.md#0x1_ascii">0x1::ascii</a>;
<b>use</b> <a href="../move-stdlib/option.md#0x1_option">0x1::option</a>;
<b>use</b> <a href="../move-stdlib/type_name.md#0x1_type_name">0x1::type_name</a>;
<b>use</b> <a href="../one-framework/address.md#0x2_address">0x2::address</a>;
<b>use</b> <a href="../one-framework/bag.md#0x2_bag">0x2::bag</a>;
<b>use</b> <a href="../one-framework/clock.md#0x2_clock">0x2::clock</a>;
<b>use</b> <a href="../one-framework/dynamic_field.md#0x2_dynamic_field">0x2::dynamic_field</a>;
<b>use</b> <a href="../one-framework/event.md#0x2_event">0x2::event</a>;
<b>use</b> <a href="../one-framework/object.md#0x2_object">0x2::object</a>;
<b>use</b> <a href="../one-framework/transfer.md#0x2_transfer">0x2::transfer</a>;
<b>use</b> <a href="../one-framework/tx_context.md#0x2_tx_context">0x2::tx_context</a>;
<b>use</b> <a href="../one-framework/vec_map.md#0x2_vec_map">0x2::vec_map</a>;
<b>use</b> <a href="../one-framework/vec_set.md#0x2_vec_set">0x2::vec_set</a>;
<b>use</b> <a href="voting_power.md#0x3_voting_power">0x3::voting_power</a>;
</code></pre>



<a name="0x3_supper_committee_ActionKey"></a>

## Struct `ActionKey`



<pre><code><b>struct</b> <a href="supper_committee.md#0x3_supper_committee_ActionKey">ActionKey</a> <b>has</b> <b>copy</b>, drop, store
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

<a name="0x3_supper_committee_SupperCommittee"></a>

## Struct `SupperCommittee`



<pre><code><b>struct</b> <a href="supper_committee.md#0x3_supper_committee_SupperCommittee">SupperCommittee</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>proposal_list: <a href="../move-stdlib/vector.md#0x1_vector">vector</a>&lt;<a href="../one-framework/object.md#0x2_object_ID">object::ID</a>&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>extra_fields: <a href="../one-framework/bag.md#0x2_bag_Bag">bag::Bag</a></code>
</dt>
<dd>
 Any extra fields that's not defined statically.
</dd>
</dl>


</details>

<a name="0x3_supper_committee_Proposal"></a>

## Resource `Proposal`



<pre><code><b>struct</b> <a href="supper_committee.md#0x3_supper_committee_Proposal">Proposal</a> <b>has</b> key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>id: <a href="../one-framework/object.md#0x2_object_UID">object::UID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>proposer: <b>address</b></code>
</dt>
<dd>
 creator of the proposal
</dd>
<dt>
<code>for_votes: <a href="../one-framework/vec_set.md#0x2_vec_set_VecSet">vec_set::VecSet</a>&lt;<b>address</b>&gt;</code>
</dt>
<dd>
 count of voters who agree with the proposal
</dd>
<dt>
<code>against_votes: <a href="../one-framework/vec_set.md#0x2_vec_set_VecSet">vec_set::VecSet</a>&lt;<b>address</b>&gt;</code>
</dt>
<dd>
 count of voters who're against the proposal
</dd>
<dt>
<code>start_time_ms: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
<dt>
<code>end_time_ms: <a href="../move-stdlib/u64.md#0x1_u64">u64</a></code>
</dt>
<dd>

</dd>
<dt>
<code>action_type: <a href="../move-stdlib/ascii.md#0x1_ascii_String">ascii::String</a></code>
</dt>
<dd>

</dd>
<dt>
<code>status: u8</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x3_supper_committee_CreateProposalEvent"></a>

## Struct `CreateProposalEvent`



<pre><code><b>struct</b> <a href="supper_committee.md#0x3_supper_committee_CreateProposalEvent">CreateProposalEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>proposal_id: <a href="../one-framework/object.md#0x2_object_ID">object::ID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>proposer: <b>address</b></code>
</dt>
<dd>

</dd>
<dt>
<code>action_type: <a href="../move-stdlib/ascii.md#0x1_ascii_String">ascii::String</a></code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x3_supper_committee_VoteProposalEvent"></a>

## Struct `VoteProposalEvent`



<pre><code><b>struct</b> <a href="supper_committee.md#0x3_supper_committee_VoteProposalEvent">VoteProposalEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>proposal_id: <a href="../one-framework/object.md#0x2_object_ID">object::ID</a></code>
</dt>
<dd>

</dd>
<dt>
<code>voter: <b>address</b></code>
</dt>
<dd>

</dd>
<dt>
<code>agree: bool</code>
</dt>
<dd>

</dd>
<dt>
<code>status: u8</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="0x3_supper_committee_ENotProposalStatusProgress"></a>



<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_ENotProposalStatusProgress">ENotProposalStatusProgress</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 1;
</code></pre>



<a name="0x3_supper_committee_ENotSupportStructType"></a>



<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_ENotSupportStructType">ENotSupportStructType</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 2;
</code></pre>



<a name="0x3_supper_committee_PROPOSAl_STATUS_ACTIVE"></a>



<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a>: u8 = 2;
</code></pre>



<a name="0x3_supper_committee_PROPOSAl_STATUS_FAIL"></a>



<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_FAIL">PROPOSAl_STATUS_FAIL</a>: u8 = 4;
</code></pre>



<a name="0x3_supper_committee_PROPOSAl_STATUS_PASS"></a>



<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_PASS">PROPOSAl_STATUS_PASS</a>: u8 = 3;
</code></pre>



<a name="0x3_supper_committee_PROPOSAl_STATUS_PENDING"></a>

proposal status


<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_PENDING">PROPOSAl_STATUS_PENDING</a>: u8 = 1;
</code></pre>



<a name="0x3_supper_committee_PROPOSAl_STATUS_TIMEOUT"></a>



<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_TIMEOUT">PROPOSAl_STATUS_TIMEOUT</a>: u8 = 5;
</code></pre>



<a name="0x3_supper_committee_Timeout"></a>



<pre><code><b>const</b> <a href="supper_committee.md#0x3_supper_committee_Timeout">Timeout</a>: <a href="../move-stdlib/u64.md#0x1_u64">u64</a> = 604800000;
</code></pre>



<a name="0x3_supper_committee_new"></a>

## Function `new`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_new">new</a>(ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>): <a href="supper_committee.md#0x3_supper_committee_SupperCommittee">supper_committee::SupperCommittee</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_new">new</a>(
    ctx: &<b>mut</b> TxContext,
):<a href="supper_committee.md#0x3_supper_committee_SupperCommittee">SupperCommittee</a>{
    <a href="supper_committee.md#0x3_supper_committee_SupperCommittee">SupperCommittee</a>{
        proposal_list:<a href="../move-stdlib/vector.md#0x1_vector_empty">vector::empty</a>(),
        extra_fields :<a href="../one-framework/bag.md#0x2_bag_new">bag::new</a>(ctx)
    }
}
</code></pre>



</details>

<a name="0x3_supper_committee_vote_proposal"></a>

## Function `vote_proposal`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_vote_proposal">vote_proposal</a>(proposal: &<b>mut</b> <a href="supper_committee.md#0x3_supper_committee_Proposal">supper_committee::Proposal</a>, validator_vote_powers: <a href="../one-framework/vec_map.md#0x2_vec_map_VecMap">vec_map::VecMap</a>&lt;<b>address</b>, <a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;, validator_address: <b>address</b>, agree: bool, <a href="../one-framework/clock.md#0x2_clock">clock</a>: &<a href="../one-framework/clock.md#0x2_clock_Clock">clock::Clock</a>, ctx: &<a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_vote_proposal">vote_proposal</a>(
    proposal: &<b>mut</b> <a href="supper_committee.md#0x3_supper_committee_Proposal">Proposal</a>,
    validator_vote_powers: VecMap&lt;<b>address</b>,<a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;,
    validator_address: <b>address</b>,
    agree: bool,
    <a href="../one-framework/clock.md#0x2_clock">clock</a>: &Clock,
    ctx: &TxContext,
){
    <b>let</b> sender = ctx.sender();

    <b>assert</b>!(proposal.<a href="supper_committee.md#0x3_supper_committee_proposal_status">proposal_status</a>(<a href="../one-framework/clock.md#0x2_clock">clock</a>) == <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a>,<a href="supper_committee.md#0x3_supper_committee_ENotProposalStatusProgress">ENotProposalStatusProgress</a>);

    <b>if</b>(agree){
        proposal.for_votes.insert(validator_address);
    }<b>else</b> {
        proposal.against_votes.insert(validator_address);
    };

    <b>let</b> (for_vote_power,against_vote_power)  = proposal.<a href="supper_committee.md#0x3_supper_committee_get_vote_power">get_vote_power</a>(validator_vote_powers);

    <b>if</b>(for_vote_power &gt;= <a href="voting_power.md#0x3_voting_power_quorum_threshold">voting_power::quorum_threshold</a>()){
        proposal.status = <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_PASS">PROPOSAl_STATUS_PASS</a>;
    }<b>else</b> <b>if</b> (against_vote_power &gt; (<a href="voting_power.md#0x3_voting_power_total_voting_power">voting_power::total_voting_power</a>() - <a href="voting_power.md#0x3_voting_power_quorum_threshold">voting_power::quorum_threshold</a>())){
        proposal.status = <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_FAIL">PROPOSAl_STATUS_FAIL</a>;
    };


    <b>let</b> vote_event = <a href="supper_committee.md#0x3_supper_committee_VoteProposalEvent">VoteProposalEvent</a>{
        proposal_id: <a href="../one-framework/object.md#0x2_object_id">object::id</a>(proposal),
        voter: sender,
        agree,
        status: proposal.status
    };

    <a href="../one-framework/event.md#0x2_event_emit">event::emit</a>(vote_event);
}
</code></pre>



</details>

<a name="0x3_supper_committee_proposal_status"></a>

## Function `proposal_status`



<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_proposal_status">proposal_status</a>(self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">supper_committee::Proposal</a>, <a href="../one-framework/clock.md#0x2_clock">clock</a>: &<a href="../one-framework/clock.md#0x2_clock_Clock">clock::Clock</a>): u8
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_proposal_status">proposal_status</a>(self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">Proposal</a>,<a href="../one-framework/clock.md#0x2_clock">clock</a>: &Clock):u8{
    <b>if</b>(self.start_time_ms &gt; <a href="../one-framework/clock.md#0x2_clock">clock</a>.timestamp_ms()){
        <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_PENDING">PROPOSAl_STATUS_PENDING</a>
    }<b>else</b> <b>if</b>(self.status ==  <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a> && <a href="../one-framework/clock.md#0x2_clock">clock</a>.timestamp_ms() &gt; self.end_time_ms){
        <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_TIMEOUT">PROPOSAl_STATUS_TIMEOUT</a>
    }<b>else</b> {
        self.status
    }
}
</code></pre>



</details>

<a name="0x3_supper_committee_proposal_action_type"></a>

## Function `proposal_action_type`



<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_proposal_action_type">proposal_action_type</a>(self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">supper_committee::Proposal</a>): <a href="../move-stdlib/ascii.md#0x1_ascii_String">ascii::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_proposal_action_type">proposal_action_type</a>(self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">Proposal</a>):String{
    self.action_type
}
</code></pre>



</details>

<a name="0x3_supper_committee_proposal_status_pass"></a>

## Function `proposal_status_pass`



<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_proposal_status_pass">proposal_status_pass</a>(): u8
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_proposal_status_pass">proposal_status_pass</a>():u8{
    <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_PASS">PROPOSAl_STATUS_PASS</a>
}
</code></pre>



</details>

<a name="0x3_supper_committee_action"></a>

## Function `action`



<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_action">action</a>&lt;Action: store&gt;(self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">supper_committee::Proposal</a>): &Action
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_action">action</a>&lt;Action:store&gt;(self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">Proposal</a>):&Action{
    df::borrow&lt;<a href="supper_committee.md#0x3_supper_committee_ActionKey">ActionKey</a>,Action&gt;(&self.id, <a href="supper_committee.md#0x3_supper_committee_ActionKey">ActionKey</a>{})
}
</code></pre>



</details>

<a name="0x3_supper_committee_create_proposal"></a>

## Function `create_proposal`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_create_proposal">create_proposal</a>&lt;Action: store&gt;(self: &<b>mut</b> <a href="supper_committee.md#0x3_supper_committee_SupperCommittee">supper_committee::SupperCommittee</a>, validator_address: <b>address</b>, validator_vote_powers: <a href="../one-framework/vec_map.md#0x2_vec_map_VecMap">vec_map::VecMap</a>&lt;<b>address</b>, <a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;, action: Action, <a href="../one-framework/clock.md#0x2_clock">clock</a>: &<a href="../one-framework/clock.md#0x2_clock_Clock">clock::Clock</a>, ctx: &<b>mut</b> <a href="../one-framework/tx_context.md#0x2_tx_context_TxContext">tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="supper_committee.md#0x3_supper_committee_create_proposal">create_proposal</a>&lt;Action:store&gt;(
    self: &<b>mut</b> <a href="supper_committee.md#0x3_supper_committee_SupperCommittee">SupperCommittee</a>,
    validator_address: <b>address</b>,
    validator_vote_powers: VecMap&lt;<b>address</b>,<a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;,
    action: Action,
    <a href="../one-framework/clock.md#0x2_clock">clock</a>: &Clock,
    ctx: &<b>mut</b> TxContext,
){
    <b>let</b> action_type = <a href="../move-stdlib/type_name.md#0x1_type_name_get">type_name::get</a>&lt;Action&gt;();
    // only sui_system action <b>struct</b> <a href="../one-framework/types.md#0x2_types">types</a>
    <b>assert</b>!(action_type.get_address() == address::to_ascii_string(@0x3),<a href="supper_committee.md#0x3_supper_committee_ENotSupportStructType">ENotSupportStructType</a>);

    <b>let</b> <b>mut</b> proposal = <a href="supper_committee.md#0x3_supper_committee_Proposal">Proposal</a>{
        id: <a href="../one-framework/object.md#0x2_object_new">object::new</a>(ctx),
        proposer: validator_address,
        for_votes: <a href="../one-framework/vec_set.md#0x2_vec_set_empty">vec_set::empty</a>(),
        against_votes: <a href="../one-framework/vec_set.md#0x2_vec_set_empty">vec_set::empty</a>(),
        start_time_ms: <a href="../one-framework/clock.md#0x2_clock">clock</a>.timestamp_ms(),
        end_time_ms:<a href="../one-framework/clock.md#0x2_clock">clock</a>.timestamp_ms() + <a href="supper_committee.md#0x3_supper_committee_Timeout">Timeout</a>,
        status: <a href="supper_committee.md#0x3_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a>,
        action_type: action_type.into_string(),
    };

    <b>let</b> create_proposal_event = <a href="supper_committee.md#0x3_supper_committee_CreateProposalEvent">CreateProposalEvent</a>{
        proposal_id: <a href="../one-framework/object.md#0x2_object_id">object::id</a>(&proposal),
        proposer: proposal.proposer,
        action_type: proposal.action_type
    };


    proposal.<a href="supper_committee.md#0x3_supper_committee_vote_proposal">vote_proposal</a>(
        validator_vote_powers,
        validator_address,
        <b>true</b>,
        <a href="../one-framework/clock.md#0x2_clock">clock</a>,
        ctx,
    );

    df::add(&<b>mut</b> proposal.id, <a href="supper_committee.md#0x3_supper_committee_ActionKey">ActionKey</a>{}, action);

    self.proposal_list.push_back(<a href="../one-framework/object.md#0x2_object_id">object::id</a>(&proposal));

    <a href="../one-framework/transfer.md#0x2_transfer_share_object">transfer::share_object</a>(proposal);

    <a href="../one-framework/event.md#0x2_event_emit">event::emit</a>(create_proposal_event);
}
</code></pre>



</details>

<a name="0x3_supper_committee_get_vote_power"></a>

## Function `get_vote_power`



<pre><code><b>fun</b> <a href="supper_committee.md#0x3_supper_committee_get_vote_power">get_vote_power</a>(self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">supper_committee::Proposal</a>, validator_vote_powers: <a href="../one-framework/vec_map.md#0x2_vec_map_VecMap">vec_map::VecMap</a>&lt;<b>address</b>, <a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;): (<a href="../move-stdlib/u64.md#0x1_u64">u64</a>, <a href="../move-stdlib/u64.md#0x1_u64">u64</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="supper_committee.md#0x3_supper_committee_get_vote_power">get_vote_power</a>(
    self: &<a href="supper_committee.md#0x3_supper_committee_Proposal">Proposal</a>,
    validator_vote_powers: VecMap&lt;<b>address</b>,<a href="../move-stdlib/u64.md#0x1_u64">u64</a>&gt;,
):(<a href="../move-stdlib/u64.md#0x1_u64">u64</a>,<a href="../move-stdlib/u64.md#0x1_u64">u64</a>){
    <b>let</b> <b>mut</b>  for_vote_power = 0;
    <b>let</b> <b>mut</b>  against_votes = 0;

    self.for_votes.keys().do_ref!(|c| {
        <b>let</b> vote_power = validator_vote_powers.try_get(c);
        <b>if</b> (vote_power.is_some()){
            for_vote_power  = for_vote_power + vote_power.destroy_some();
        };
    } );

    self.against_votes.keys().do_ref!(|c|{
        <b>let</b> vote_power = validator_vote_powers.try_get(c);
        <b>if</b> (vote_power.is_some()){
            against_votes  = against_votes + vote_power.destroy_some();
        };
    } );

    (for_vote_power,against_votes)
}
</code></pre>



</details>
