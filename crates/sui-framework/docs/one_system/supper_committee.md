---
title: Module `one_system::supper_committee`
---



-  [Struct `ActionKey`](#one_system_supper_committee_ActionKey)
-  [Struct `SupperCommittee`](#one_system_supper_committee_SupperCommittee)
-  [Struct `Proposal`](#one_system_supper_committee_Proposal)
-  [Struct `CreateProposalEvent`](#one_system_supper_committee_CreateProposalEvent)
-  [Struct `VoteProposalEvent`](#one_system_supper_committee_VoteProposalEvent)
-  [Constants](#@Constants_0)
-  [Function `new`](#one_system_supper_committee_new)
-  [Function `vote_proposal`](#one_system_supper_committee_vote_proposal)
-  [Function `proposal_status`](#one_system_supper_committee_proposal_status)
-  [Function `proposal_action_type`](#one_system_supper_committee_proposal_action_type)
-  [Function `proposal_status_pass`](#one_system_supper_committee_proposal_status_pass)
-  [Function `action`](#one_system_supper_committee_action)
-  [Function `create_proposal`](#one_system_supper_committee_create_proposal)
-  [Function `get_vote_power`](#one_system_supper_committee_get_vote_power)


<pre><code><b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/bag.md#one_bag">one::bag</a>;
<b>use</b> <a href="../one/balance.md#one_balance">one::balance</a>;
<b>use</b> <a href="../one/clock.md#one_clock">one::clock</a>;
<b>use</b> <a href="../one/coin.md#one_coin">one::coin</a>;
<b>use</b> <a href="../one/coin_vesting.md#one_coin_vesting">one::coin_vesting</a>;
<b>use</b> <a href="../one/config.md#one_config">one::config</a>;
<b>use</b> <a href="../one/deny_list.md#one_deny_list">one::deny_list</a>;
<b>use</b> <a href="../one/dynamic_field.md#one_dynamic_field">one::dynamic_field</a>;
<b>use</b> <a href="../one/dynamic_object_field.md#one_dynamic_object_field">one::dynamic_object_field</a>;
<b>use</b> <a href="../one/event.md#one_event">one::event</a>;
<b>use</b> <a href="../one/hex.md#one_hex">one::hex</a>;
<b>use</b> <a href="../one/object.md#one_object">one::object</a>;
<b>use</b> <a href="../one/oct.md#one_oct">one::oct</a>;
<b>use</b> <a href="../one/table.md#one_table">one::table</a>;
<b>use</b> <a href="../one/transfer.md#one_transfer">one::transfer</a>;
<b>use</b> <a href="../one/tx_context.md#one_tx_context">one::tx_context</a>;
<b>use</b> <a href="../one/types.md#one_types">one::types</a>;
<b>use</b> <a href="../one/url.md#one_url">one::url</a>;
<b>use</b> <a href="../one/vec_map.md#one_vec_map">one::vec_map</a>;
<b>use</b> <a href="../one/vec_set.md#one_vec_set">one::vec_set</a>;
<b>use</b> <a href="../one_system/staking_pool.md#one_system_staking_pool">one_system::staking_pool</a>;
<b>use</b> <a href="../one_system/validator.md#one_system_validator">one_system::validator</a>;
<b>use</b> <a href="../one_system/validator_cap.md#one_system_validator_cap">one_system::validator_cap</a>;
<b>use</b> <a href="../one_system/voting_power.md#one_system_voting_power">one_system::voting_power</a>;
<b>use</b> <a href="../std/address.md#std_address">std::address</a>;
<b>use</b> <a href="../std/ascii.md#std_ascii">std::ascii</a>;
<b>use</b> <a href="../std/bcs.md#std_bcs">std::bcs</a>;
<b>use</b> <a href="../std/option.md#std_option">std::option</a>;
<b>use</b> <a href="../std/string.md#std_string">std::string</a>;
<b>use</b> <a href="../std/type_name.md#std_type_name">std::type_name</a>;
<b>use</b> <a href="../std/u64.md#std_u64">std::u64</a>;
<b>use</b> <a href="../std/vector.md#std_vector">std::vector</a>;
</code></pre>



<a name="one_system_supper_committee_ActionKey"></a>

## Struct `ActionKey`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_ActionKey">ActionKey</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
</dl>


</details>

<a name="one_system_supper_committee_SupperCommittee"></a>

## Struct `SupperCommittee`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_SupperCommittee">SupperCommittee</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>proposal_list: vector&lt;<a href="../one/object.md#one_object_ID">one::object::ID</a>&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code>extra_fields: <a href="../one/bag.md#one_bag_Bag">one::bag::Bag</a></code>
</dt>
<dd>
 Any extra fields that's not defined statically.
</dd>
</dl>


</details>

<a name="one_system_supper_committee_Proposal"></a>

## Struct `Proposal`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">Proposal</a> <b>has</b> key
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
<code>proposer: <b>address</b></code>
</dt>
<dd>
 creator of the proposal
</dd>
<dt>
<code>for_votes: <a href="../one/vec_set.md#one_vec_set_VecSet">one::vec_set::VecSet</a>&lt;<b>address</b>&gt;</code>
</dt>
<dd>
 count of voters who agree with the proposal
</dd>
<dt>
<code>against_votes: <a href="../one/vec_set.md#one_vec_set_VecSet">one::vec_set::VecSet</a>&lt;<b>address</b>&gt;</code>
</dt>
<dd>
 count of voters who're against the proposal
</dd>
<dt>
<code>start_time_ms: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>end_time_ms: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>action_type: <a href="../std/ascii.md#std_ascii_String">std::ascii::String</a></code>
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

<a name="one_system_supper_committee_CreateProposalEvent"></a>

## Struct `CreateProposalEvent`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_CreateProposalEvent">CreateProposalEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>proposal_id: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
</dt>
<dd>
</dd>
<dt>
<code>proposer: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>action_type: <a href="../std/ascii.md#std_ascii_String">std::ascii::String</a></code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_system_supper_committee_VoteProposalEvent"></a>

## Struct `VoteProposalEvent`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_VoteProposalEvent">VoteProposalEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>proposal_id: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
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


<a name="one_system_supper_committee_ENotProposalStatusProgress"></a>



<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_ENotProposalStatusProgress">ENotProposalStatusProgress</a>: u64 = 1;
</code></pre>



<a name="one_system_supper_committee_ENotSupportStructType"></a>



<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_ENotSupportStructType">ENotSupportStructType</a>: u64 = 2;
</code></pre>



<a name="one_system_supper_committee_PROPOSAl_STATUS_ACTIVE"></a>



<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a>: u8 = 2;
</code></pre>



<a name="one_system_supper_committee_PROPOSAl_STATUS_FAIL"></a>



<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_FAIL">PROPOSAl_STATUS_FAIL</a>: u8 = 4;
</code></pre>



<a name="one_system_supper_committee_PROPOSAl_STATUS_PASS"></a>



<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_PASS">PROPOSAl_STATUS_PASS</a>: u8 = 3;
</code></pre>



<a name="one_system_supper_committee_PROPOSAl_STATUS_PENDING"></a>

proposal status


<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_PENDING">PROPOSAl_STATUS_PENDING</a>: u8 = 1;
</code></pre>



<a name="one_system_supper_committee_PROPOSAl_STATUS_TIMEOUT"></a>



<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_TIMEOUT">PROPOSAl_STATUS_TIMEOUT</a>: u8 = 5;
</code></pre>



<a name="one_system_supper_committee_Timeout"></a>



<pre><code><b>const</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_Timeout">Timeout</a>: u64 = 604800000;
</code></pre>



<a name="one_system_supper_committee_new"></a>

## Function `new`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_new">new</a>(ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/supper_committee.md#one_system_supper_committee_SupperCommittee">one_system::supper_committee::SupperCommittee</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_new">new</a>(
    ctx: &<b>mut</b> TxContext,
):<a href="../one_system/supper_committee.md#one_system_supper_committee_SupperCommittee">SupperCommittee</a>{
    <a href="../one_system/supper_committee.md#one_system_supper_committee_SupperCommittee">SupperCommittee</a>{
        proposal_list:vector::empty(),
        extra_fields :bag::new(ctx)
    }
}
</code></pre>



</details>

<a name="one_system_supper_committee_vote_proposal"></a>

## Function `vote_proposal`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_vote_proposal">vote_proposal</a>(proposal: &<b>mut</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">one_system::supper_committee::Proposal</a>, validator_vote_powers: <a href="../one/vec_map.md#one_vec_map_VecMap">one::vec_map::VecMap</a>&lt;<b>address</b>, u64&gt;, validator_address: <b>address</b>, agree: bool, clock: &<a href="../one/clock.md#one_clock_Clock">one::clock::Clock</a>, ctx: &<a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_vote_proposal">vote_proposal</a>(
    proposal: &<b>mut</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">Proposal</a>,
    validator_vote_powers: VecMap&lt;<b>address</b>,u64&gt;,
    validator_address: <b>address</b>,
    agree: bool,
    clock: &Clock,
    ctx: &TxContext,
){
    <b>let</b> sender = ctx.sender();
    <b>assert</b>!(proposal.<a href="../one_system/supper_committee.md#one_system_supper_committee_proposal_status">proposal_status</a>(clock) == <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a>,<a href="../one_system/supper_committee.md#one_system_supper_committee_ENotProposalStatusProgress">ENotProposalStatusProgress</a>);
    <b>if</b>(agree){
        proposal.for_votes.insert(validator_address);
    }<b>else</b> {
        proposal.against_votes.insert(validator_address);
    };
    <b>let</b> (for_vote_power,against_vote_power)  = proposal.<a href="../one_system/supper_committee.md#one_system_supper_committee_get_vote_power">get_vote_power</a>(validator_vote_powers);
    <b>if</b>(for_vote_power &gt;= <a href="../one_system/voting_power.md#one_system_voting_power_quorum_threshold">voting_power::quorum_threshold</a>()){
        proposal.status = <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_PASS">PROPOSAl_STATUS_PASS</a>;
    }<b>else</b> <b>if</b> (against_vote_power &gt; (<a href="../one_system/voting_power.md#one_system_voting_power_total_voting_power">voting_power::total_voting_power</a>() - <a href="../one_system/voting_power.md#one_system_voting_power_quorum_threshold">voting_power::quorum_threshold</a>())){
        proposal.status = <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_FAIL">PROPOSAl_STATUS_FAIL</a>;
    };
    <b>let</b> vote_event = <a href="../one_system/supper_committee.md#one_system_supper_committee_VoteProposalEvent">VoteProposalEvent</a>{
        proposal_id: object::id(proposal),
        voter: sender,
        agree,
        status: proposal.status
    };
    event::emit(vote_event);
}
</code></pre>



</details>

<a name="one_system_supper_committee_proposal_status"></a>

## Function `proposal_status`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_proposal_status">proposal_status</a>(self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">one_system::supper_committee::Proposal</a>, clock: &<a href="../one/clock.md#one_clock_Clock">one::clock::Clock</a>): u8
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_proposal_status">proposal_status</a>(self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">Proposal</a>,clock: &Clock):u8{
    <b>if</b>(self.start_time_ms &gt; clock.timestamp_ms()){
        <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_PENDING">PROPOSAl_STATUS_PENDING</a>
    }<b>else</b> <b>if</b>(self.status ==  <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a> && clock.timestamp_ms() &gt; self.end_time_ms){
        <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_TIMEOUT">PROPOSAl_STATUS_TIMEOUT</a>
    }<b>else</b> {
        self.status
    }
}
</code></pre>



</details>

<a name="one_system_supper_committee_proposal_action_type"></a>

## Function `proposal_action_type`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_proposal_action_type">proposal_action_type</a>(self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">one_system::supper_committee::Proposal</a>): <a href="../std/ascii.md#std_ascii_String">std::ascii::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_proposal_action_type">proposal_action_type</a>(self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">Proposal</a>):String{
    self.action_type
}
</code></pre>



</details>

<a name="one_system_supper_committee_proposal_status_pass"></a>

## Function `proposal_status_pass`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_proposal_status_pass">proposal_status_pass</a>(): u8
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_proposal_status_pass">proposal_status_pass</a>():u8{
    <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_PASS">PROPOSAl_STATUS_PASS</a>
}
</code></pre>



</details>

<a name="one_system_supper_committee_action"></a>

## Function `action`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_action">action</a>&lt;Action: store&gt;(self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">one_system::supper_committee::Proposal</a>): &Action
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_action">action</a>&lt;Action:store&gt;(self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">Proposal</a>):&Action{
    df::borrow&lt;<a href="../one_system/supper_committee.md#one_system_supper_committee_ActionKey">ActionKey</a>,Action&gt;(&self.id, <a href="../one_system/supper_committee.md#one_system_supper_committee_ActionKey">ActionKey</a>{})
}
</code></pre>



</details>

<a name="one_system_supper_committee_create_proposal"></a>

## Function `create_proposal`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_create_proposal">create_proposal</a>&lt;Action: store&gt;(self: &<b>mut</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_SupperCommittee">one_system::supper_committee::SupperCommittee</a>, validator_address: <b>address</b>, validator_vote_powers: <a href="../one/vec_map.md#one_vec_map_VecMap">one::vec_map::VecMap</a>&lt;<b>address</b>, u64&gt;, <a href="../one_system/supper_committee.md#one_system_supper_committee_action">action</a>: Action, clock: &<a href="../one/clock.md#one_clock_Clock">one::clock::Clock</a>, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_create_proposal">create_proposal</a>&lt;Action:store&gt;(
    self: &<b>mut</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_SupperCommittee">SupperCommittee</a>,
    validator_address: <b>address</b>,
    validator_vote_powers: VecMap&lt;<b>address</b>,u64&gt;,
    <a href="../one_system/supper_committee.md#one_system_supper_committee_action">action</a>: Action,
    clock: &Clock,
    ctx: &<b>mut</b> TxContext,
){
    <b>let</b> action_type = type_name::get&lt;Action&gt;();
    // only sui_system <a href="../one_system/supper_committee.md#one_system_supper_committee_action">action</a> <b>struct</b> types
    <b>assert</b>!(action_type.get_address() == address::to_ascii_string(@0x3),<a href="../one_system/supper_committee.md#one_system_supper_committee_ENotSupportStructType">ENotSupportStructType</a>);
    <b>let</b> <b>mut</b> proposal = <a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">Proposal</a>{
        id: object::new(ctx),
        proposer: validator_address,
        for_votes: vec_set::empty(),
        against_votes: vec_set::empty(),
        start_time_ms: clock.timestamp_ms(),
        end_time_ms:clock.timestamp_ms() + <a href="../one_system/supper_committee.md#one_system_supper_committee_Timeout">Timeout</a>,
        status: <a href="../one_system/supper_committee.md#one_system_supper_committee_PROPOSAl_STATUS_ACTIVE">PROPOSAl_STATUS_ACTIVE</a>,
        action_type: action_type.into_string(),
    };
    <b>let</b> create_proposal_event = <a href="../one_system/supper_committee.md#one_system_supper_committee_CreateProposalEvent">CreateProposalEvent</a>{
        proposal_id: object::id(&proposal),
        proposer: proposal.proposer,
        action_type: proposal.action_type
    };
    proposal.<a href="../one_system/supper_committee.md#one_system_supper_committee_vote_proposal">vote_proposal</a>(
        validator_vote_powers,
        validator_address,
        <b>true</b>,
        clock,
        ctx,
    );
    df::add(&<b>mut</b> proposal.id, <a href="../one_system/supper_committee.md#one_system_supper_committee_ActionKey">ActionKey</a>{}, <a href="../one_system/supper_committee.md#one_system_supper_committee_action">action</a>);
    self.proposal_list.push_back(object::id(&proposal));
    transfer::share_object(proposal);
    event::emit(create_proposal_event);
}
</code></pre>



</details>

<a name="one_system_supper_committee_get_vote_power"></a>

## Function `get_vote_power`



<pre><code><b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_get_vote_power">get_vote_power</a>(self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">one_system::supper_committee::Proposal</a>, validator_vote_powers: <a href="../one/vec_map.md#one_vec_map_VecMap">one::vec_map::VecMap</a>&lt;<b>address</b>, u64&gt;): (u64, u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one_system/supper_committee.md#one_system_supper_committee_get_vote_power">get_vote_power</a>(
    self: &<a href="../one_system/supper_committee.md#one_system_supper_committee_Proposal">Proposal</a>,
    validator_vote_powers: VecMap&lt;<b>address</b>,u64&gt;,
):(u64,u64){
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
