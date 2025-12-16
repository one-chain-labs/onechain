---
title: Module `one_system::validator`
---



-  [Struct `ValidatorMetadata`](#one_system_validator_ValidatorMetadata)
-  [Struct `Validator`](#one_system_validator_Validator)
-  [Struct `StakingRequestEvent`](#one_system_validator_StakingRequestEvent)
-  [Struct `UnstakingRequestEvent`](#one_system_validator_UnstakingRequestEvent)
-  [Struct `ConvertingToFungibleStakedOctEvent`](#one_system_validator_ConvertingToFungibleStakedOctEvent)
-  [Struct `RedeemingFungibleStakedOctEvent`](#one_system_validator_RedeemingFungibleStakedOctEvent)
-  [Constants](#@Constants_0)
-  [Function `new_metadata`](#one_system_validator_new_metadata)
-  [Function `new`](#one_system_validator_new)
-  [Function `deactivate`](#one_system_validator_deactivate)
-  [Function `activate`](#one_system_validator_activate)
-  [Function `adjust_stake_and_gas_price`](#one_system_validator_adjust_stake_and_gas_price)
-  [Function `request_set_revenue_receiving_address`](#one_system_validator_request_set_revenue_receiving_address)
-  [Function `request_add_stake`](#one_system_validator_request_add_stake)
-  [Function `request_add_stake_no_check`](#one_system_validator_request_add_stake_no_check)
-  [Function `convert_to_fungible_staked_oct`](#one_system_validator_convert_to_fungible_staked_oct)
-  [Function `redeem_fungible_staked_oct`](#one_system_validator_redeem_fungible_staked_oct)
-  [Function `request_add_stake_at_genesis`](#one_system_validator_request_add_stake_at_genesis)
-  [Function `request_withdraw_stake`](#one_system_validator_request_withdraw_stake)
-  [Function `set_only_validator_staking`](#one_system_validator_set_only_validator_staking)
-  [Function `request_set_gas_price`](#one_system_validator_request_set_gas_price)
-  [Function `set_candidate_gas_price`](#one_system_validator_set_candidate_gas_price)
-  [Function `request_set_commission_rate`](#one_system_validator_request_set_commission_rate)
-  [Function `set_candidate_commission_rate`](#one_system_validator_set_candidate_commission_rate)
-  [Function `deposit_stake_rewards`](#one_system_validator_deposit_stake_rewards)
-  [Function `process_pending_stakes_and_withdraws`](#one_system_validator_process_pending_stakes_and_withdraws)
-  [Function `is_preactive`](#one_system_validator_is_preactive)
-  [Function `metadata`](#one_system_validator_metadata)
-  [Function `sui_address`](#one_system_validator_sui_address)
-  [Function `name`](#one_system_validator_name)
-  [Function `description`](#one_system_validator_description)
-  [Function `image_url`](#one_system_validator_image_url)
-  [Function `project_url`](#one_system_validator_project_url)
-  [Function `network_address`](#one_system_validator_network_address)
-  [Function `p2p_address`](#one_system_validator_p2p_address)
-  [Function `primary_address`](#one_system_validator_primary_address)
-  [Function `worker_address`](#one_system_validator_worker_address)
-  [Function `protocol_pubkey_bytes`](#one_system_validator_protocol_pubkey_bytes)
-  [Function `proof_of_possession`](#one_system_validator_proof_of_possession)
-  [Function `network_pubkey_bytes`](#one_system_validator_network_pubkey_bytes)
-  [Function `worker_pubkey_bytes`](#one_system_validator_worker_pubkey_bytes)
-  [Function `next_epoch_network_address`](#one_system_validator_next_epoch_network_address)
-  [Function `next_epoch_p2p_address`](#one_system_validator_next_epoch_p2p_address)
-  [Function `next_epoch_primary_address`](#one_system_validator_next_epoch_primary_address)
-  [Function `next_epoch_worker_address`](#one_system_validator_next_epoch_worker_address)
-  [Function `next_epoch_protocol_pubkey_bytes`](#one_system_validator_next_epoch_protocol_pubkey_bytes)
-  [Function `next_epoch_proof_of_possession`](#one_system_validator_next_epoch_proof_of_possession)
-  [Function `next_epoch_network_pubkey_bytes`](#one_system_validator_next_epoch_network_pubkey_bytes)
-  [Function `next_epoch_worker_pubkey_bytes`](#one_system_validator_next_epoch_worker_pubkey_bytes)
-  [Function `operation_cap_id`](#one_system_validator_operation_cap_id)
-  [Function `next_epoch_gas_price`](#one_system_validator_next_epoch_gas_price)
-  [Function `total_stake_amount`](#one_system_validator_total_stake_amount)
-  [Function `stake_amount`](#one_system_validator_stake_amount)
-  [Function `total_stake`](#one_system_validator_total_stake)
-  [Function `voting_power`](#one_system_validator_voting_power)
-  [Function `set_voting_power`](#one_system_validator_set_voting_power)
-  [Function `pending_stake_amount`](#one_system_validator_pending_stake_amount)
-  [Function `pending_stake_withdraw_amount`](#one_system_validator_pending_stake_withdraw_amount)
-  [Function `revenue_receiving_address`](#one_system_validator_revenue_receiving_address)
-  [Function `gas_price`](#one_system_validator_gas_price)
-  [Function `commission_rate`](#one_system_validator_commission_rate)
-  [Function `pool_token_exchange_rate_at_epoch`](#one_system_validator_pool_token_exchange_rate_at_epoch)
-  [Function `staking_pool_id`](#one_system_validator_staking_pool_id)
-  [Function `is_duplicate`](#one_system_validator_is_duplicate)
-  [Function `is_equal_some_and_value`](#one_system_validator_is_equal_some_and_value)
-  [Function `is_equal_some`](#one_system_validator_is_equal_some)
-  [Function `new_unverified_validator_operation_cap_and_transfer`](#one_system_validator_new_unverified_validator_operation_cap_and_transfer)
-  [Function `update_name`](#one_system_validator_update_name)
-  [Function `update_description`](#one_system_validator_update_description)
-  [Function `update_image_url`](#one_system_validator_update_image_url)
-  [Function `update_project_url`](#one_system_validator_update_project_url)
-  [Function `update_next_epoch_network_address`](#one_system_validator_update_next_epoch_network_address)
-  [Function `update_candidate_network_address`](#one_system_validator_update_candidate_network_address)
-  [Function `update_next_epoch_p2p_address`](#one_system_validator_update_next_epoch_p2p_address)
-  [Function `update_candidate_p2p_address`](#one_system_validator_update_candidate_p2p_address)
-  [Function `update_next_epoch_primary_address`](#one_system_validator_update_next_epoch_primary_address)
-  [Function `update_candidate_primary_address`](#one_system_validator_update_candidate_primary_address)
-  [Function `update_next_epoch_worker_address`](#one_system_validator_update_next_epoch_worker_address)
-  [Function `update_candidate_worker_address`](#one_system_validator_update_candidate_worker_address)
-  [Function `update_next_epoch_protocol_pubkey`](#one_system_validator_update_next_epoch_protocol_pubkey)
-  [Function `update_candidate_protocol_pubkey`](#one_system_validator_update_candidate_protocol_pubkey)
-  [Function `update_next_epoch_network_pubkey`](#one_system_validator_update_next_epoch_network_pubkey)
-  [Function `update_candidate_network_pubkey`](#one_system_validator_update_candidate_network_pubkey)
-  [Function `update_next_epoch_worker_pubkey`](#one_system_validator_update_next_epoch_worker_pubkey)
-  [Function `update_candidate_worker_pubkey`](#one_system_validator_update_candidate_worker_pubkey)
-  [Function `effectuate_staged_metadata`](#one_system_validator_effectuate_staged_metadata)
-  [Function `validate_metadata`](#one_system_validator_validate_metadata)
-  [Function `validate_metadata_bcs`](#one_system_validator_validate_metadata_bcs)
-  [Function `get_staking_pool_ref`](#one_system_validator_get_staking_pool_ref)
-  [Function `new_from_metadata`](#one_system_validator_new_from_metadata)


<pre><code><b>use</b> <a href="../one/address.md#one_address">one::address</a>;
<b>use</b> <a href="../one/bag.md#one_bag">one::bag</a>;
<b>use</b> <a href="../one/balance.md#one_balance">one::balance</a>;
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
<b>use</b> <a href="../one/vec_set.md#one_vec_set">one::vec_set</a>;
<b>use</b> <a href="../one_system/staking_pool.md#one_system_staking_pool">one_system::staking_pool</a>;
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



<a name="one_system_validator_ValidatorMetadata"></a>

## Struct `ValidatorMetadata`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">ValidatorMetadata</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>: <b>address</b></code>
</dt>
<dd>
 The Sui Address of the validator. This is the sender that created the Validator object,
 and also the address to send validator/coins to during withdraws.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>: vector&lt;u8&gt;</code>
</dt>
<dd>
 The public key bytes corresponding to the private key that the validator
 holds to sign transactions. For now, this is the same as AuthorityName.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>: vector&lt;u8&gt;</code>
</dt>
<dd>
 The public key bytes corresponding to the private key that the validator
 uses to establish TLS connections
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>: vector&lt;u8&gt;</code>
</dt>
<dd>
 The public key bytes correstponding to the Narwhal Worker
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;</code>
</dt>
<dd>
 This is a proof that the validator has ownership of the private key
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_name">name</a>: <a href="../std/string.md#std_string_String">std::string::String</a></code>
</dt>
<dd>
 A unique human-readable name of this validator.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_description">description</a>: <a href="../std/string.md#std_string_String">std::string::String</a></code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>: <a href="../one/url.md#one_url_Url">one::url::Url</a></code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>: <a href="../one/url.md#one_url_Url">one::url::Url</a></code>
</dt>
<dd>
</dd>
<dt>
<code>net_address: <a href="../std/string.md#std_string_String">std::string::String</a></code>
</dt>
<dd>
 The network address of the validator (could also contain extra info such as port, DNS and etc.).
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: <a href="../std/string.md#std_string_String">std::string::String</a></code>
</dt>
<dd>
 The address of the validator used for p2p activities such as state sync (could also contain extra info such as port, DNS and etc.).
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: <a href="../std/string.md#std_string_String">std::string::String</a></code>
</dt>
<dd>
 The address of the narwhal primary
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: <a href="../std/string.md#std_string_String">std::string::String</a></code>
</dt>
<dd>
 The address of the narwhal worker
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;</code>
</dt>
<dd>
 "next_epoch" metadata only takes effects in the next epoch.
 If none, current value will stay unchanged.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a>: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code>next_epoch_net_address: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a>: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a>: <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;</code>
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

<a name="one_system_validator_Validator"></a>

## Struct `Validator`



<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a> <b>has</b> store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>: <a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">one_system::validator::ValidatorMetadata</a></code>
</dt>
<dd>
 Summary of the validator.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>only_validator_staking: bool</code>
</dt>
<dd>
</dd>
<dt>
<code><a href="../one_system/voting_power.md#one_system_voting_power">voting_power</a>: u64</code>
</dt>
<dd>
 The voting power of this validator, which might be different from its
 stake amount.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_operation_cap_id">operation_cap_id</a>: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
</dt>
<dd>
 The ID of this validator's current valid <code>UnverifiedValidatorOperationCap</code>
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>: u64</code>
</dt>
<dd>
 Gas price quote, updated only at end of epoch.
</dd>
<dt>
<code><a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>: <a href="../one_system/staking_pool.md#one_system_staking_pool_StakingPool">one_system::staking_pool::StakingPool</a></code>
</dt>
<dd>
 Staking pool for this validator.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>: u64</code>
</dt>
<dd>
 Commission rate of the validator, in basis point.
</dd>
<dt>
<code>next_epoch_stake: u64</code>
</dt>
<dd>
 Total amount of stake that would be active in the next epoch.
</dd>
<dt>
<code><a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a>: u64</code>
</dt>
<dd>
 This validator's gas price quote for the next epoch.
</dd>
<dt>
<code>next_epoch_commission_rate: u64</code>
</dt>
<dd>
 The commission rate of the validator starting the next epoch, in basis point.
</dd>
<dt>
<code>extra_fields: <a href="../one/bag.md#one_bag_Bag">one::bag::Bag</a></code>
</dt>
<dd>
 Any extra fields that's not defined statically.
</dd>
</dl>


</details>

<a name="one_system_validator_StakingRequestEvent"></a>

## Struct `StakingRequestEvent`

Event emitted when a new stake request is received.


<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator.md#one_system_validator_StakingRequestEvent">StakingRequestEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>pool_id: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
</dt>
<dd>
</dd>
<dt>
<code>validator_address: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>staker_address: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>epoch: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>lock: bool</code>
</dt>
<dd>
</dd>
<dt>
<code>amount: u64</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_system_validator_UnstakingRequestEvent"></a>

## Struct `UnstakingRequestEvent`

Event emitted when a new unstake request is received.


<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator.md#one_system_validator_UnstakingRequestEvent">UnstakingRequestEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>pool_id: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
</dt>
<dd>
</dd>
<dt>
<code>validator_address: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>staker_address: <b>address</b></code>
</dt>
<dd>
</dd>
<dt>
<code>stake_activation_epoch: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>unstaking_epoch: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>principal_amount: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>reward_amount: u64</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_system_validator_ConvertingToFungibleStakedOctEvent"></a>

## Struct `ConvertingToFungibleStakedOctEvent`

Event emitted when a staked SUI is converted to a fungible staked SUI.


<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator.md#one_system_validator_ConvertingToFungibleStakedOctEvent">ConvertingToFungibleStakedOctEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>pool_id: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
</dt>
<dd>
</dd>
<dt>
<code>stake_activation_epoch: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>staked_oct_principal_amount: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>fungible_staked_oct_amount: u64</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="one_system_validator_RedeemingFungibleStakedOctEvent"></a>

## Struct `RedeemingFungibleStakedOctEvent`

Event emitted when a fungible staked SUI is redeemed.


<pre><code><b>public</b> <b>struct</b> <a href="../one_system/validator.md#one_system_validator_RedeemingFungibleStakedOctEvent">RedeemingFungibleStakedOctEvent</a> <b>has</b> <b>copy</b>, drop
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>pool_id: <a href="../one/object.md#one_object_ID">one::object::ID</a></code>
</dt>
<dd>
</dd>
<dt>
<code>fungible_staked_oct_amount: u64</code>
</dt>
<dd>
</dd>
<dt>
<code>sui_amount: u64</code>
</dt>
<dd>
</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="one_system_validator_ECalledDuringNonGenesis"></a>

Function called during non-genesis times.


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_ECalledDuringNonGenesis">ECalledDuringNonGenesis</a>: u64 = 12;
</code></pre>



<a name="one_system_validator_ECommissionRateTooHigh"></a>

Commission rate set by the validator is higher than the threshold


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_ECommissionRateTooHigh">ECommissionRateTooHigh</a>: u64 = 8;
</code></pre>



<a name="one_system_validator_EGasPriceHigherThanThreshold"></a>

Validator trying to set gas price higher than threshold.


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EGasPriceHigherThanThreshold">EGasPriceHigherThanThreshold</a>: u64 = 102;
</code></pre>



<a name="one_system_validator_EInvalidCap"></a>

Capability code is not valid


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EInvalidCap">EInvalidCap</a>: u64 = 101;
</code></pre>



<a name="one_system_validator_EInvalidProofOfPossession"></a>

Invalid proof_of_possession field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EInvalidProofOfPossession">EInvalidProofOfPossession</a>: u64 = 0;
</code></pre>



<a name="one_system_validator_EInvalidStakeAmount"></a>

Stake amount is invalid or wrong.


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EInvalidStakeAmount">EInvalidStakeAmount</a>: u64 = 11;
</code></pre>



<a name="one_system_validator_EMetadataInvalidNetAddr"></a>

Invalid net_address field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EMetadataInvalidNetAddr">EMetadataInvalidNetAddr</a>: u64 = 4;
</code></pre>



<a name="one_system_validator_EMetadataInvalidNetPubkey"></a>

Invalid network_pubkey_bytes field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EMetadataInvalidNetPubkey">EMetadataInvalidNetPubkey</a>: u64 = 2;
</code></pre>



<a name="one_system_validator_EMetadataInvalidP2pAddr"></a>

Invalid p2p_address field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EMetadataInvalidP2pAddr">EMetadataInvalidP2pAddr</a>: u64 = 5;
</code></pre>



<a name="one_system_validator_EMetadataInvalidPrimaryAddr"></a>

Invalid primary_address field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EMetadataInvalidPrimaryAddr">EMetadataInvalidPrimaryAddr</a>: u64 = 6;
</code></pre>



<a name="one_system_validator_EMetadataInvalidPubkey"></a>

Invalid pubkey_bytes field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EMetadataInvalidPubkey">EMetadataInvalidPubkey</a>: u64 = 1;
</code></pre>



<a name="one_system_validator_EMetadataInvalidWorkerAddr"></a>

Invalidworker_address field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EMetadataInvalidWorkerAddr">EMetadataInvalidWorkerAddr</a>: u64 = 7;
</code></pre>



<a name="one_system_validator_EMetadataInvalidWorkerPubkey"></a>

Invalid worker_pubkey_bytes field in ValidatorMetadata


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EMetadataInvalidWorkerPubkey">EMetadataInvalidWorkerPubkey</a>: u64 = 3;
</code></pre>



<a name="one_system_validator_ENewCapNotCreatedByValidatorItself"></a>

New Capability is not created by the validator itself


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_ENewCapNotCreatedByValidatorItself">ENewCapNotCreatedByValidatorItself</a>: u64 = 100;
</code></pre>



<a name="one_system_validator_ENotValidatorCandidate"></a>

Intended validator is not a candidate one.


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>: u64 = 10;
</code></pre>



<a name="one_system_validator_EOnlyValidatorStake"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EOnlyValidatorStake">EOnlyValidatorStake</a>: u64 = 201;
</code></pre>



<a name="one_system_validator_EStakedOctIsLock"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EStakedOctIsLock">EStakedOctIsLock</a>: u64 = 203;
</code></pre>



<a name="one_system_validator_EStakedOctNotLock"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EStakedOctNotLock">EStakedOctNotLock</a>: u64 = 204;
</code></pre>



<a name="one_system_validator_EValidatorMetadataExceedingLengthLimit"></a>

Validator Metadata is too long


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>: u64 = 9;
</code></pre>



<a name="one_system_validator_EValidatorStakeClosed"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_EValidatorStakeClosed">EValidatorStakeClosed</a>: u64 = 202;
</code></pre>



<a name="one_system_validator_LOCK_CLIFF_EPOCH"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_LOCK_CLIFF_EPOCH">LOCK_CLIFF_EPOCH</a>: u64 = 180;
</code></pre>



<a name="one_system_validator_LOCK_INTERVAL_EPOCH"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_LOCK_INTERVAL_EPOCH">LOCK_INTERVAL_EPOCH</a>: u64 = 30;
</code></pre>



<a name="one_system_validator_LOCK_PERIOD"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_LOCK_PERIOD">LOCK_PERIOD</a>: u64 = 24;
</code></pre>



<a name="one_system_validator_MAX_COMMISSION_RATE"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_MAX_COMMISSION_RATE">MAX_COMMISSION_RATE</a>: u64 = 10000;
</code></pre>



<a name="one_system_validator_MAX_VALIDATOR_GAS_PRICE"></a>

Max gas price a validator can set is 100K MIST.


<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_GAS_PRICE">MAX_VALIDATOR_GAS_PRICE</a>: u64 = 100000;
</code></pre>



<a name="one_system_validator_MAX_VALIDATOR_METADATA_LENGTH"></a>



<pre><code><b>const</b> <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>: u64 = 256;
</code></pre>



<a name="one_system_validator_new_metadata"></a>

## Function `new_metadata`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_new_metadata">new_metadata</a>(<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>: <b>address</b>, <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_name">name</a>: <a href="../std/string.md#std_string_String">std::string::String</a>, <a href="../one_system/validator.md#one_system_validator_description">description</a>: <a href="../std/string.md#std_string_String">std::string::String</a>, <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>: <a href="../one/url.md#one_url_Url">one::url::Url</a>, <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>: <a href="../one/url.md#one_url_Url">one::url::Url</a>, net_address: <a href="../std/string.md#std_string_String">std::string::String</a>, <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: <a href="../std/string.md#std_string_String">std::string::String</a>, <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: <a href="../std/string.md#std_string_String">std::string::String</a>, <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: <a href="../std/string.md#std_string_String">std::string::String</a>, extra_fields: <a href="../one/bag.md#one_bag_Bag">one::bag::Bag</a>): <a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">one_system::validator::ValidatorMetadata</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_new_metadata">new_metadata</a>(
    <a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>: <b>address</b>,
    <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_name">name</a>: String,
    <a href="../one_system/validator.md#one_system_validator_description">description</a>: String,
    <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>: Url,
    <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>: Url,
    net_address: String,
    <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: String,
    <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: String,
    <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: String,
    extra_fields: Bag,
): <a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">ValidatorMetadata</a> {
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a> = <a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">ValidatorMetadata</a> {
        <a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>,
        <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>,
        <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>,
        <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>,
        <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>,
        <a href="../one_system/validator.md#one_system_validator_name">name</a>,
        <a href="../one_system/validator.md#one_system_validator_description">description</a>,
        <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>,
        <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>,
        net_address,
        <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>,
        <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>,
        <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>,
        <a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>: option::none(),
        <a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>: option::none(),
        <a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>: option::none(),
        <a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a>: option::none(),
        next_epoch_net_address: option::none(),
        <a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>: option::none(),
        <a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a>: option::none(),
        <a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a>: option::none(),
        extra_fields,
    };
    <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>
}
</code></pre>



</details>

<a name="one_system_validator_new"></a>

## Function `new`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_new">new</a>(<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>: <b>address</b>, <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>: <b>address</b>, <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_name">name</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_description">description</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>: vector&lt;u8&gt;, net_address: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>: u64, <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>: u64, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_new">new</a>(
    <a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>: <b>address</b>,
    <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>: <b>address</b>,
    <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_name">name</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_description">description</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>: vector&lt;u8&gt;,
    net_address: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: vector&lt;u8&gt;,
    <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>: u64,
    <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>: u64,
    ctx: &<b>mut</b> TxContext
): <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a> {
    <b>assert</b>!(
        net_address.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>
            && <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>
            && <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>
            && <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>
            && <a href="../one_system/validator.md#one_system_validator_name">name</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>
            && <a href="../one_system/validator.md#one_system_validator_description">description</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>
            && <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>
            && <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a> &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_COMMISSION_RATE">MAX_COMMISSION_RATE</a>, <a href="../one_system/validator.md#one_system_validator_ECommissionRateTooHigh">ECommissionRateTooHigh</a>);
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a> &lt; <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_GAS_PRICE">MAX_VALIDATOR_GAS_PRICE</a>, <a href="../one_system/validator.md#one_system_validator_EGasPriceHigherThanThreshold">EGasPriceHigherThanThreshold</a>);
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a> = <a href="../one_system/validator.md#one_system_validator_new_metadata">new_metadata</a>(
        <a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>,
        <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>,
        <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>,
        <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>,
        <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>,
        <a href="../one_system/validator.md#one_system_validator_name">name</a>.to_ascii_string().to_string(),
        <a href="../one_system/validator.md#one_system_validator_description">description</a>.to_ascii_string().to_string(),
        url::new_unsafe_from_bytes(<a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>),
        url::new_unsafe_from_bytes(<a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>),
        net_address.to_ascii_string().to_string(),
        <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>.to_ascii_string().to_string(),
        <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>.to_ascii_string().to_string(),
        <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>.to_ascii_string().to_string(),
        bag::new(ctx),
    );
    // Checks that the keys & addresses & PoP are valid.
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
    <a href="../one_system/validator.md#one_system_validator_new_from_metadata">new_from_metadata</a>(
        <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>,
        <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>,
        <b>true</b>,
        <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>,
        <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>,
        ctx
    )
}
</code></pre>



</details>

<a name="one_system_validator_deactivate"></a>

## Function `deactivate`

Deactivate this validator's staking pool


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_deactivate">deactivate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, deactivation_epoch: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_deactivate">deactivate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, deactivation_epoch: u64) {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.deactivate_staking_pool(deactivation_epoch)
}
</code></pre>



</details>

<a name="one_system_validator_activate"></a>

## Function `activate`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_activate">activate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, activation_epoch: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_activate">activate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, activation_epoch: u64) {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.activate_staking_pool(activation_epoch);
}
</code></pre>



</details>

<a name="one_system_validator_adjust_stake_and_gas_price"></a>

## Function `adjust_stake_and_gas_price`

Process pending stake and pending withdraws, and update the gas price.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_adjust_stake_and_gas_price">adjust_stake_and_gas_price</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_adjust_stake_and_gas_price">adjust_stake_and_gas_price</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>) {
    self.<a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a> = self.<a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a>;
    self.<a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a> = self.next_epoch_commission_rate;
}
</code></pre>



</details>

<a name="one_system_validator_request_set_revenue_receiving_address"></a>

## Function `request_set_revenue_receiving_address`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_set_revenue_receiving_address">request_set_revenue_receiving_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, verified_cap: <a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">one_system::validator_cap::ValidatorOperationCap</a>, <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>: <b>address</b>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_set_revenue_receiving_address">request_set_revenue_receiving_address</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    verified_cap: ValidatorOperationCap,
    <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>: <b>address</b>,
) {
    <b>let</b> validator_address = *verified_cap.verified_operation_cap_address();
    <b>assert</b>!(validator_address == self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>, <a href="../one_system/validator.md#one_system_validator_EInvalidCap">EInvalidCap</a>);
    self.<a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a> = <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>;
}
</code></pre>



</details>

<a name="one_system_validator_request_add_stake"></a>

## Function `request_add_stake`

Request to add stake to the validator's staking pool, processed at the end of the epoch.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_add_stake">request_add_stake</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, stake: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, staker_address: <b>address</b>, is_validator: bool, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/staking_pool.md#one_system_staking_pool_StakedOct">one_system::staking_pool::StakedOct</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_add_stake">request_add_stake</a>(
        self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
        stake: Balance&lt;OCT&gt;,
        staker_address: <b>address</b>,
        is_validator: bool,
        ctx: &<b>mut</b> TxContext,
    ): StakedOct {
        <b>if</b> (self.only_validator_staking) {
            <b>assert</b>!(is_validator, <a href="../one_system/validator.md#one_system_validator_EOnlyValidatorStake">EOnlyValidatorStake</a>);
        }<b>else</b> {
            <b>assert</b>!(!is_validator, <a href="../one_system/validator.md#one_system_validator_EValidatorStakeClosed">EValidatorStakeClosed</a>);
        };
        self.<a href="../one_system/validator.md#one_system_validator_request_add_stake_no_check">request_add_stake_no_check</a>(
            stake,
            staker_address,
            is_validator,
            ctx
        )
    }
</code></pre>



</details>

<a name="one_system_validator_request_add_stake_no_check"></a>

## Function `request_add_stake_no_check`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_add_stake_no_check">request_add_stake_no_check</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, stake: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, staker_address: <b>address</b>, is_validator: bool, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/staking_pool.md#one_system_staking_pool_StakedOct">one_system::staking_pool::StakedOct</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_add_stake_no_check">request_add_stake_no_check</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    stake: Balance&lt;OCT&gt;,
    staker_address: <b>address</b>,
    is_validator: bool,
    ctx: &<b>mut</b> TxContext,
) : StakedOct {
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a> = stake.value();
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a> &gt; 0, <a href="../one_system/validator.md#one_system_validator_EInvalidStakeAmount">EInvalidStakeAmount</a>);
    <b>let</b> stake_epoch = ctx.epoch() + 1;
    <b>let</b> staked_oct = self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_request_add_stake">request_add_stake</a>(stake, stake_epoch, is_validator, ctx);
    // Process stake right away <b>if</b> staking pool is preactive.
    <b>if</b> (self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>()) {
        self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.process_pending_stake();
    };
    self.next_epoch_stake = self.next_epoch_stake + <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a>;
    event::emit(
        <a href="../one_system/validator.md#one_system_validator_StakingRequestEvent">StakingRequestEvent</a> {
            pool_id: <a href="../one_system/validator.md#one_system_validator_staking_pool_id">staking_pool_id</a>(self),
            validator_address: self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>,
            staker_address,
            epoch: ctx.epoch(),
            lock: is_validator,
            amount: <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a>,
        }
    );
    staked_oct
}
</code></pre>



</details>

<a name="one_system_validator_convert_to_fungible_staked_oct"></a>

## Function `convert_to_fungible_staked_oct`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_convert_to_fungible_staked_oct">convert_to_fungible_staked_oct</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, staked_oct: <a href="../one_system/staking_pool.md#one_system_staking_pool_StakedOct">one_system::staking_pool::StakedOct</a>, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/staking_pool.md#one_system_staking_pool_FungibleStakedOct">one_system::staking_pool::FungibleStakedOct</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_convert_to_fungible_staked_oct">convert_to_fungible_staked_oct</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    staked_oct: StakedOct,
    ctx: &<b>mut</b> TxContext,
): FungibleStakedOct {
    <b>assert</b>!(!staked_oct.lock(), <a href="../one_system/validator.md#one_system_validator_EStakedOctIsLock">EStakedOctIsLock</a>);
    <b>let</b> stake_activation_epoch = staked_oct.stake_activation_epoch();
    <b>let</b> staked_oct_principal_amount = staked_oct.staked_oct_amount();
    <b>let</b> fungible_staked_oct = self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_convert_to_fungible_staked_oct">convert_to_fungible_staked_oct</a>(staked_oct, ctx);
    event::emit(
        <a href="../one_system/validator.md#one_system_validator_ConvertingToFungibleStakedOctEvent">ConvertingToFungibleStakedOctEvent</a> {
            pool_id: self.<a href="../one_system/validator.md#one_system_validator_staking_pool_id">staking_pool_id</a>(),
            stake_activation_epoch,
            staked_oct_principal_amount,
            fungible_staked_oct_amount: fungible_staked_oct.value(),
        }
    );
    fungible_staked_oct
}
</code></pre>



</details>

<a name="one_system_validator_redeem_fungible_staked_oct"></a>

## Function `redeem_fungible_staked_oct`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_redeem_fungible_staked_oct">redeem_fungible_staked_oct</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, fungible_staked_oct: <a href="../one_system/staking_pool.md#one_system_staking_pool_FungibleStakedOct">one_system::staking_pool::FungibleStakedOct</a>, ctx: &<a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_redeem_fungible_staked_oct">redeem_fungible_staked_oct</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    fungible_staked_oct: FungibleStakedOct,
    ctx: &TxContext,
): Balance&lt;OCT&gt; {
    <b>let</b> fungible_staked_oct_amount = fungible_staked_oct.value();
    <b>let</b> sui = self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_redeem_fungible_staked_oct">redeem_fungible_staked_oct</a>(fungible_staked_oct, ctx);
    self.next_epoch_stake = self.next_epoch_stake - sui.value();
    event::emit(
        <a href="../one_system/validator.md#one_system_validator_RedeemingFungibleStakedOctEvent">RedeemingFungibleStakedOctEvent</a> {
            pool_id: self.<a href="../one_system/validator.md#one_system_validator_staking_pool_id">staking_pool_id</a>(),
            fungible_staked_oct_amount,
            sui_amount: sui.value(),
        }
    );
    sui
}
</code></pre>



</details>

<a name="one_system_validator_request_add_stake_at_genesis"></a>

## Function `request_add_stake_at_genesis`

Request to add stake to the validator's staking pool at genesis


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_add_stake_at_genesis">request_add_stake_at_genesis</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, stake: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, staker_address: <b>address</b>, lock: bool, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_add_stake_at_genesis">request_add_stake_at_genesis</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    stake: Balance&lt;OCT&gt;,
    staker_address: <b>address</b>,
    lock: bool,
    ctx: &<b>mut</b> TxContext,
) {
    <b>assert</b>!(ctx.epoch() == 0, <a href="../one_system/validator.md#one_system_validator_ECalledDuringNonGenesis">ECalledDuringNonGenesis</a>);
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a> = stake.value();
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a> &gt; 0, <a href="../one_system/validator.md#one_system_validator_EInvalidStakeAmount">EInvalidStakeAmount</a>);
    <b>let</b> staked_oct = self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_request_add_stake">request_add_stake</a>(
        stake,
        0, // epoch 0 -- <a href="../one_system/genesis.md#one_system_genesis">genesis</a>
        lock,
        ctx
    );
    transfer::public_transfer(staked_oct, staker_address);
    // Process stake right away
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.process_pending_stake();
    self.next_epoch_stake = self.next_epoch_stake + <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a>;
}
</code></pre>



</details>

<a name="one_system_validator_request_withdraw_stake"></a>

## Function `request_withdraw_stake`

Request to withdraw stake from the validator's staking pool, processed at the end of the epoch.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_withdraw_stake">request_withdraw_stake</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, staked_oct: <a href="../one_system/staking_pool.md#one_system_staking_pool_StakedOct">one_system::staking_pool::StakedOct</a>, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): (<a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;, <a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../one/coin_vesting.md#one_coin_vesting_CoinVesting">one::coin_vesting::CoinVesting</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_withdraw_stake">request_withdraw_stake</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    staked_oct: StakedOct,
    ctx: &<b>mut</b> TxContext,
): (Balance&lt;OCT&gt;, Option&lt;CoinVesting&lt;OCT&gt;&gt;) {
    <b>let</b> lock = staked_oct.lock();
    <b>let</b> principal_amount = staked_oct.staked_oct_amount();
    <b>let</b> stake_activation_epoch = staked_oct.stake_activation_epoch();
    <b>let</b> <b>mut</b> withdrawn_stake = self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_request_withdraw_stake">request_withdraw_stake</a>(staked_oct, ctx);
    <b>let</b> withdraw_amount = withdrawn_stake.value();
    <b>let</b> reward_amount = withdraw_amount - principal_amount;
    self.next_epoch_stake = self.next_epoch_stake - withdraw_amount;
    event::emit(
        <a href="../one_system/validator.md#one_system_validator_UnstakingRequestEvent">UnstakingRequestEvent</a> {
            pool_id: <a href="../one_system/validator.md#one_system_validator_staking_pool_id">staking_pool_id</a>(self),
            validator_address: self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>,
            staker_address: ctx.sender(),
            stake_activation_epoch,
            unstaking_epoch: ctx.epoch(),
            principal_amount,
            reward_amount,
        }
    );
    <b>if</b>(lock){
        <b>let</b> withdrawn_reward = withdrawn_stake.split(reward_amount);
        <b>let</b> coin_vesting = coin_vesting::new_form_balance(
            withdrawn_stake,
            stake_activation_epoch,
            <a href="../one_system/validator.md#one_system_validator_LOCK_CLIFF_EPOCH">LOCK_CLIFF_EPOCH</a>,
            <a href="../one_system/validator.md#one_system_validator_LOCK_INTERVAL_EPOCH">LOCK_INTERVAL_EPOCH</a>,
            <a href="../one_system/validator.md#one_system_validator_LOCK_PERIOD">LOCK_PERIOD</a>,
            ctx,
        );
        (withdrawn_reward, option::some(coin_vesting))
    }<b>else</b> {
        (withdrawn_stake,option::none())
    }
}
</code></pre>



</details>

<a name="one_system_validator_set_only_validator_staking"></a>

## Function `set_only_validator_staking`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_only_validator_staking">set_only_validator_staking</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, only_validator_staking: bool)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_only_validator_staking">set_only_validator_staking</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    only_validator_staking: bool
) {
    self.only_validator_staking = only_validator_staking
}
</code></pre>



</details>

<a name="one_system_validator_request_set_gas_price"></a>

## Function `request_set_gas_price`

Request to set new gas price for the next epoch.
Need to present a <code>ValidatorOperationCap</code>.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_set_gas_price">request_set_gas_price</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, verified_cap: <a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">one_system::validator_cap::ValidatorOperationCap</a>, new_price: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_set_gas_price">request_set_gas_price</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    verified_cap: ValidatorOperationCap,
    new_price: u64,
) {
    <b>assert</b>!(new_price &lt; <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_GAS_PRICE">MAX_VALIDATOR_GAS_PRICE</a>, <a href="../one_system/validator.md#one_system_validator_EGasPriceHigherThanThreshold">EGasPriceHigherThanThreshold</a>);
    <b>let</b> validator_address = *verified_cap.verified_operation_cap_address();
    <b>assert</b>!(validator_address == self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>, <a href="../one_system/validator.md#one_system_validator_EInvalidCap">EInvalidCap</a>);
    self.<a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a> = new_price;
}
</code></pre>



</details>

<a name="one_system_validator_set_candidate_gas_price"></a>

## Function `set_candidate_gas_price`

Set new gas price for the candidate validator.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_candidate_gas_price">set_candidate_gas_price</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, verified_cap: <a href="../one_system/validator_cap.md#one_system_validator_cap_ValidatorOperationCap">one_system::validator_cap::ValidatorOperationCap</a>, new_price: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_candidate_gas_price">set_candidate_gas_price</a>(
    self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>,
    verified_cap: ValidatorOperationCap,
    new_price: u64
) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    <b>assert</b>!(new_price &lt; <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_GAS_PRICE">MAX_VALIDATOR_GAS_PRICE</a>, <a href="../one_system/validator.md#one_system_validator_EGasPriceHigherThanThreshold">EGasPriceHigherThanThreshold</a>);
    <b>let</b> validator_address = *verified_cap.verified_operation_cap_address();
    <b>assert</b>!(validator_address == self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>, <a href="../one_system/validator.md#one_system_validator_EInvalidCap">EInvalidCap</a>);
    self.<a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a> = new_price;
    self.<a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a> = new_price;
}
</code></pre>



</details>

<a name="one_system_validator_request_set_commission_rate"></a>

## Function `request_set_commission_rate`

Request to set new commission rate for the next epoch.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_set_commission_rate">request_set_commission_rate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, new_commission_rate: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_request_set_commission_rate">request_set_commission_rate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, new_commission_rate: u64) {
    <b>assert</b>!(new_commission_rate &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_COMMISSION_RATE">MAX_COMMISSION_RATE</a>, <a href="../one_system/validator.md#one_system_validator_ECommissionRateTooHigh">ECommissionRateTooHigh</a>);
    self.next_epoch_commission_rate = new_commission_rate;
}
</code></pre>



</details>

<a name="one_system_validator_set_candidate_commission_rate"></a>

## Function `set_candidate_commission_rate`

Set new commission rate for the candidate validator.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_candidate_commission_rate">set_candidate_commission_rate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, new_commission_rate: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_candidate_commission_rate">set_candidate_commission_rate</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, new_commission_rate: u64) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    <b>assert</b>!(new_commission_rate &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_COMMISSION_RATE">MAX_COMMISSION_RATE</a>, <a href="../one_system/validator.md#one_system_validator_ECommissionRateTooHigh">ECommissionRateTooHigh</a>);
    self.<a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a> = new_commission_rate;
}
</code></pre>



</details>

<a name="one_system_validator_deposit_stake_rewards"></a>

## Function `deposit_stake_rewards`

Deposit stakes rewards into the validator's staking pool, called at the end of the epoch.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_deposit_stake_rewards">deposit_stake_rewards</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, reward: <a href="../one/balance.md#one_balance_Balance">one::balance::Balance</a>&lt;<a href="../one/oct.md#one_oct_OCT">one::oct::OCT</a>&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_deposit_stake_rewards">deposit_stake_rewards</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, reward: Balance&lt;OCT&gt;) {
    self.next_epoch_stake = self.next_epoch_stake + reward.value();
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.deposit_rewards(reward);
}
</code></pre>



</details>

<a name="one_system_validator_process_pending_stakes_and_withdraws"></a>

## Function `process_pending_stakes_and_withdraws`

Process pending stakes and withdraws, called at the end of the epoch.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_process_pending_stakes_and_withdraws">process_pending_stakes_and_withdraws</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, ctx: &<a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_process_pending_stakes_and_withdraws">process_pending_stakes_and_withdraws</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, ctx: &TxContext) {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_process_pending_stakes_and_withdraws">process_pending_stakes_and_withdraws</a>(ctx);
    // TODO: bring this assertion back when we are ready.
    // <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a>(self) == self.next_epoch_stake, <a href="../one_system/validator.md#one_system_validator_EInvalidStakeAmount">EInvalidStakeAmount</a>);
}
</code></pre>



</details>

<a name="one_system_validator_is_preactive"></a>

## Function `is_preactive`

Returns true if the validator is preactive.


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): bool {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>()
}
</code></pre>



</details>

<a name="one_system_validator_metadata"></a>

## Function `metadata`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">one_system::validator::ValidatorMetadata</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &<a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">ValidatorMetadata</a> {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>
}
</code></pre>



</details>

<a name="one_system_validator_sui_address"></a>

## Function `sui_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): <b>address</b>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): <b>address</b> {
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_name"></a>

## Function `name`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_name">name</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/string.md#std_string_String">std::string::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_name">name</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &String {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_name">name</a>
}
</code></pre>



</details>

<a name="one_system_validator_description"></a>

## Function `description`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_description">description</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/string.md#std_string_String">std::string::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_description">description</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &String {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_description">description</a>
}
</code></pre>



</details>

<a name="one_system_validator_image_url"></a>

## Function `image_url`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../one/url.md#one_url_Url">one::url::Url</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Url {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>
}
</code></pre>



</details>

<a name="one_system_validator_project_url"></a>

## Function `project_url`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../one/url.md#one_url_Url">one::url::Url</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Url {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>
}
</code></pre>



</details>

<a name="one_system_validator_network_address"></a>

## Function `network_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_network_address">network_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/string.md#std_string_String">std::string::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_network_address">network_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &String {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.net_address
}
</code></pre>



</details>

<a name="one_system_validator_p2p_address"></a>

## Function `p2p_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/string.md#std_string_String">std::string::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &String {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_primary_address"></a>

## Function `primary_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/string.md#std_string_String">std::string::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &String {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_worker_address"></a>

## Function `worker_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/string.md#std_string_String">std::string::String</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &String {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_protocol_pubkey_bytes"></a>

## Function `protocol_pubkey_bytes`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &vector&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &vector&lt;u8&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>
}
</code></pre>



</details>

<a name="one_system_validator_proof_of_possession"></a>

## Function `proof_of_possession`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &vector&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &vector&lt;u8&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>
}
</code></pre>



</details>

<a name="one_system_validator_network_pubkey_bytes"></a>

## Function `network_pubkey_bytes`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &vector&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &vector&lt;u8&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>
}
</code></pre>



</details>

<a name="one_system_validator_worker_pubkey_bytes"></a>

## Function `worker_pubkey_bytes`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &vector&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &vector&lt;u8&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_network_address"></a>

## Function `next_epoch_network_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_network_address">next_epoch_network_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_network_address">next_epoch_network_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;String&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_p2p_address"></a>

## Function `next_epoch_p2p_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;String&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_primary_address"></a>

## Function `next_epoch_primary_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;String&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_worker_address"></a>

## Function `next_epoch_worker_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;<a href="../std/string.md#std_string_String">std::string::String</a>&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;String&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_protocol_pubkey_bytes"></a>

## Function `next_epoch_protocol_pubkey_bytes`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;vector&lt;u8&gt;&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_proof_of_possession"></a>

## Function `next_epoch_proof_of_possession`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;vector&lt;u8&gt;&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_network_pubkey_bytes"></a>

## Function `next_epoch_network_pubkey_bytes`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;vector&lt;u8&gt;&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_worker_pubkey_bytes"></a>

## Function `next_epoch_worker_pubkey_bytes`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;vector&lt;u8&gt;&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &Option&lt;vector&lt;u8&gt;&gt; {
    &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>
}
</code></pre>



</details>

<a name="one_system_validator_operation_cap_id"></a>

## Function `operation_cap_id`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_operation_cap_id">operation_cap_id</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../one/object.md#one_object_ID">one::object::ID</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_operation_cap_id">operation_cap_id</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &ID {
    &self.<a href="../one_system/validator.md#one_system_validator_operation_cap_id">operation_cap_id</a>
}
</code></pre>



</details>

<a name="one_system_validator_next_epoch_gas_price"></a>

## Function `next_epoch_gas_price`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a>
}
</code></pre>



</details>

<a name="one_system_validator_total_stake_amount"></a>

## Function `total_stake_amount`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_total_stake_amount">total_stake_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_total_stake_amount">total_stake_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.sui_balance()
}
</code></pre>



</details>

<a name="one_system_validator_stake_amount"></a>

## Function `stake_amount`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.sui_balance()
}
</code></pre>



</details>

<a name="one_system_validator_total_stake"></a>

## Function `total_stake`

Return the total amount staked with this validator


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_total_stake">total_stake</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_total_stake">total_stake</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    <a href="../one_system/validator.md#one_system_validator_stake_amount">stake_amount</a>(self)
}
</code></pre>



</details>

<a name="one_system_validator_voting_power"></a>

## Function `voting_power`

Return the voting power of this validator.


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/voting_power.md#one_system_voting_power">voting_power</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/voting_power.md#one_system_voting_power">voting_power</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/voting_power.md#one_system_voting_power">voting_power</a>
}
</code></pre>



</details>

<a name="one_system_validator_set_voting_power"></a>

## Function `set_voting_power`

Set the voting power of this validator, called only from validator_set.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_voting_power">set_voting_power</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, new_voting_power: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_set_voting_power">set_voting_power</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, new_voting_power: u64) {
    self.<a href="../one_system/voting_power.md#one_system_voting_power">voting_power</a> = new_voting_power;
}
</code></pre>



</details>

<a name="one_system_validator_pending_stake_amount"></a>

## Function `pending_stake_amount`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_pending_stake_amount">pending_stake_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_pending_stake_amount">pending_stake_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_pending_stake_amount">pending_stake_amount</a>()
}
</code></pre>



</details>

<a name="one_system_validator_pending_stake_withdraw_amount"></a>

## Function `pending_stake_withdraw_amount`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_pending_stake_withdraw_amount">pending_stake_withdraw_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_pending_stake_withdraw_amount">pending_stake_withdraw_amount</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_pending_stake_withdraw_amount">pending_stake_withdraw_amount</a>()
}
</code></pre>



</details>

<a name="one_system_validator_revenue_receiving_address"></a>

## Function `revenue_receiving_address`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): <b>address</b>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): <b>address</b> {
    self.<a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>
}
</code></pre>



</details>

<a name="one_system_validator_gas_price"></a>

## Function `gas_price`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>
}
</code></pre>



</details>

<a name="one_system_validator_commission_rate"></a>

## Function `commission_rate`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): u64
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): u64 {
    self.<a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>
}
</code></pre>



</details>

<a name="one_system_validator_pool_token_exchange_rate_at_epoch"></a>

## Function `pool_token_exchange_rate_at_epoch`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, epoch: u64): <a href="../one_system/staking_pool.md#one_system_staking_pool_PoolTokenExchangeRate">one_system::staking_pool::PoolTokenExchangeRate</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, epoch: u64): PoolTokenExchangeRate {
    self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>.<a href="../one_system/validator.md#one_system_validator_pool_token_exchange_rate_at_epoch">pool_token_exchange_rate_at_epoch</a>(epoch)
}
</code></pre>



</details>

<a name="one_system_validator_staking_pool_id"></a>

## Function `staking_pool_id`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_staking_pool_id">staking_pool_id</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): <a href="../one/object.md#one_object_ID">one::object::ID</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_staking_pool_id">staking_pool_id</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): ID {
    object::id(&self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>)
}
</code></pre>



</details>

<a name="one_system_validator_is_duplicate"></a>

## Function `is_duplicate`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_duplicate">is_duplicate</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, other: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_duplicate">is_duplicate</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, other: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): bool {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_name">name</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_name">name</a>
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.net_address == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.net_address
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>
        || self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a> == other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>
        // All next epoch parameters.
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>)
        // My next epoch parameters with other current epoch parameters.
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.net_address)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>, &other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>)
        // Other next epoch parameters with my current epoch parameters.
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address, &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.net_address)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>, &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>, &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>, &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>, &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>, &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a>)
        || <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>(&other.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>, &self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a>)
}
</code></pre>



</details>

<a name="one_system_validator_is_equal_some_and_value"></a>

## Function `is_equal_some_and_value`



<pre><code><b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>&lt;T&gt;(a: &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;T&gt;, b: &T): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_equal_some_and_value">is_equal_some_and_value</a>&lt;T&gt;(a: &Option&lt;T&gt;, b: &T): bool {
    <b>if</b> (a.is_none()) {
        <b>false</b>
    } <b>else</b> {
        a.borrow() == b
    }
}
</code></pre>



</details>

<a name="one_system_validator_is_equal_some"></a>

## Function `is_equal_some`



<pre><code><b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>&lt;T&gt;(a: &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;T&gt;, b: &<a href="../std/option.md#std_option_Option">std::option::Option</a>&lt;T&gt;): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one_system/validator.md#one_system_validator_is_equal_some">is_equal_some</a>&lt;T&gt;(a: &Option&lt;T&gt;, b: &Option&lt;T&gt;): bool {
    <b>if</b> (a.is_none() || b.is_none()) {
        <b>false</b>
    } <b>else</b> {
        a.borrow() == b.borrow()
    }
}
</code></pre>



</details>

<a name="one_system_validator_new_unverified_validator_operation_cap_and_transfer"></a>

## Function `new_unverified_validator_operation_cap_and_transfer`

Create a new <code>UnverifiedValidatorOperationCap</code>, transfer to the validator,
and registers it, thus revoking the previous cap's permission.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_new_unverified_validator_operation_cap_and_transfer">new_unverified_validator_operation_cap_and_transfer</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_new_unverified_validator_operation_cap_and_transfer">new_unverified_validator_operation_cap_and_transfer</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, ctx: &<b>mut</b> TxContext) {
    <b>let</b> <b>address</b> = ctx.sender();
    <b>assert</b>!(<b>address</b> == self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>, <a href="../one_system/validator.md#one_system_validator_ENewCapNotCreatedByValidatorItself">ENewCapNotCreatedByValidatorItself</a>);
    <b>let</b> new_id = <a href="../one_system/validator_cap.md#one_system_validator_cap_new_unverified_validator_operation_cap_and_transfer">validator_cap::new_unverified_validator_operation_cap_and_transfer</a>(<b>address</b>, ctx);
    self.<a href="../one_system/validator.md#one_system_validator_operation_cap_id">operation_cap_id</a> = new_id;
}
</code></pre>



</details>

<a name="one_system_validator_update_name"></a>

## Function `update_name`

Update name of the validator.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_name">update_name</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_name">name</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_name">update_name</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_name">name</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_name">name</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_name">name</a> = <a href="../one_system/validator.md#one_system_validator_name">name</a>.to_ascii_string().to_string();
}
</code></pre>



</details>

<a name="one_system_validator_update_description"></a>

## Function `update_description`

Update description of the validator.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_description">update_description</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_description">description</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_description">update_description</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_description">description</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_description">description</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_description">description</a> = <a href="../one_system/validator.md#one_system_validator_description">description</a>.to_ascii_string().to_string();
}
</code></pre>



</details>

<a name="one_system_validator_update_image_url"></a>

## Function `update_image_url`

Update image url of the validator.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_image_url">update_image_url</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_image_url">update_image_url</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_image_url">image_url</a> = url::new_unsafe_from_bytes(<a href="../one_system/validator.md#one_system_validator_image_url">image_url</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_project_url"></a>

## Function `update_project_url`

Update project url of the validator.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_project_url">update_project_url</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_project_url">update_project_url</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_project_url">project_url</a> = url::new_unsafe_from_bytes(<a href="../one_system/validator.md#one_system_validator_project_url">project_url</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_next_epoch_network_address"></a>

## Function `update_next_epoch_network_address`

Update network address of this validator, taking effects from next epoch


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_network_address">update_next_epoch_network_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, net_address: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_network_address">update_next_epoch_network_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, net_address: vector&lt;u8&gt;) {
    <b>assert</b>!(
        net_address.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> net_address = net_address.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address = option::some(net_address);
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_candidate_network_address"></a>

## Function `update_candidate_network_address`

Update network address of this candidate validator


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_network_address">update_candidate_network_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, net_address: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_network_address">update_candidate_network_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, net_address: vector&lt;u8&gt;) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    <b>assert</b>!(
        net_address.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> net_address = net_address.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.net_address = net_address;
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_next_epoch_p2p_address"></a>

## Function `update_next_epoch_p2p_address`

Update p2p address of this validator, taking effects from next epoch


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_p2p_address">update_next_epoch_p2p_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_p2p_address">update_next_epoch_p2p_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a> = <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a> = option::some(<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>);
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_candidate_p2p_address"></a>

## Function `update_candidate_p2p_address`

Update p2p address of this candidate validator


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_p2p_address">update_candidate_p2p_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_p2p_address">update_candidate_p2p_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a> = <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a> = <a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a>;
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_next_epoch_primary_address"></a>

## Function `update_next_epoch_primary_address`

Update primary address of this validator, taking effects from next epoch


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_primary_address">update_next_epoch_primary_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_primary_address">update_next_epoch_primary_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a> = <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a> = option::some(<a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>);
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_candidate_primary_address"></a>

## Function `update_candidate_primary_address`

Update primary address of this candidate validator


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_primary_address">update_candidate_primary_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_primary_address">update_candidate_primary_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a> = <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a> = <a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a>;
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_next_epoch_worker_address"></a>

## Function `update_next_epoch_worker_address`

Update worker address of this validator, taking effects from next epoch


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_worker_address">update_next_epoch_worker_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_worker_address">update_next_epoch_worker_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a> = <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a> = option::some(<a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>);
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_candidate_worker_address"></a>

## Function `update_candidate_worker_address`

Update worker address of this candidate validator


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_worker_address">update_candidate_worker_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_worker_address">update_candidate_worker_address</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    <b>assert</b>!(
        <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>.length() &lt;= <a href="../one_system/validator.md#one_system_validator_MAX_VALIDATOR_METADATA_LENGTH">MAX_VALIDATOR_METADATA_LENGTH</a>,
        <a href="../one_system/validator.md#one_system_validator_EValidatorMetadataExceedingLengthLimit">EValidatorMetadataExceedingLengthLimit</a>
    );
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a> = <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>.to_ascii_string().to_string();
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a> = <a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a>;
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_next_epoch_protocol_pubkey"></a>

## Function `update_next_epoch_protocol_pubkey`

Update protocol public key of this validator, taking effects from next epoch


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_protocol_pubkey">update_next_epoch_protocol_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, protocol_pubkey: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_protocol_pubkey">update_next_epoch_protocol_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, protocol_pubkey: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;) {
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a> = option::some(protocol_pubkey);
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a> = option::some(<a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>);
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_candidate_protocol_pubkey"></a>

## Function `update_candidate_protocol_pubkey`

Update protocol public key of this candidate validator


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_protocol_pubkey">update_candidate_protocol_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, protocol_pubkey: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_protocol_pubkey">update_candidate_protocol_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, protocol_pubkey: vector&lt;u8&gt;, <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>: vector&lt;u8&gt;) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a> = protocol_pubkey;
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a> = <a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a>;
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_next_epoch_network_pubkey"></a>

## Function `update_next_epoch_network_pubkey`

Update network public key of this validator, taking effects from next epoch


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_network_pubkey">update_next_epoch_network_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, network_pubkey: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_network_pubkey">update_next_epoch_network_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, network_pubkey: vector&lt;u8&gt;) {
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a> = option::some(network_pubkey);
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_candidate_network_pubkey"></a>

## Function `update_candidate_network_pubkey`

Update network public key of this candidate validator


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_network_pubkey">update_candidate_network_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, network_pubkey: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_network_pubkey">update_candidate_network_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, network_pubkey: vector&lt;u8&gt;) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a> = network_pubkey;
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_next_epoch_worker_pubkey"></a>

## Function `update_next_epoch_worker_pubkey`

Update Narwhal worker public key of this validator, taking effects from next epoch


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_worker_pubkey">update_next_epoch_worker_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, worker_pubkey: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_next_epoch_worker_pubkey">update_next_epoch_worker_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, worker_pubkey: vector&lt;u8&gt;) {
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a> = option::some(worker_pubkey);
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_update_candidate_worker_pubkey"></a>

## Function `update_candidate_worker_pubkey`

Update Narwhal worker public key of this candidate validator


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_worker_pubkey">update_candidate_worker_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>, worker_pubkey: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_update_candidate_worker_pubkey">update_candidate_worker_pubkey</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>, worker_pubkey: vector&lt;u8&gt;) {
    <b>assert</b>!(<a href="../one_system/validator.md#one_system_validator_is_preactive">is_preactive</a>(self), <a href="../one_system/validator.md#one_system_validator_ENotValidatorCandidate">ENotValidatorCandidate</a>);
    self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a> = worker_pubkey;
    <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(&self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>);
}
</code></pre>



</details>

<a name="one_system_validator_effectuate_staged_metadata"></a>

## Function `effectuate_staged_metadata`

Effectutate all staged next epoch metadata for this validator.
NOTE: this function SHOULD ONLY be called by validator_set when
advancing an epoch.


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_effectuate_staged_metadata">effectuate_staged_metadata</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_effectuate_staged_metadata">effectuate_staged_metadata</a>(self: &<b>mut</b> <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>) {
    <b>if</b> (<a href="../one_system/validator.md#one_system_validator_next_epoch_network_address">next_epoch_network_address</a>(self).is_some()) {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.net_address = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.next_epoch_net_address = option::none();
    };
    <b>if</b> (<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>(self).is_some()) {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_p2p_address">p2p_address</a> = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a>.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_p2p_address">next_epoch_p2p_address</a> = option::none();
    };
    <b>if</b> (<a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a>(self).is_some()) {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_primary_address">primary_address</a> = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a>.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_primary_address">next_epoch_primary_address</a> = option::none();
    };
    <b>if</b> (<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a>(self).is_some()) {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_address">worker_address</a> = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a>.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_address">next_epoch_worker_address</a> = option::none();
    };
    <b>if</b> (<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>(self).is_some()) {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_protocol_pubkey_bytes">protocol_pubkey_bytes</a> = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a>.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_protocol_pubkey_bytes">next_epoch_protocol_pubkey_bytes</a> = option::none();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_proof_of_possession">proof_of_possession</a> = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a>.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_proof_of_possession">next_epoch_proof_of_possession</a> = option::none();
    };
    <b>if</b> (<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>(self).is_some()) {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_network_pubkey_bytes">network_pubkey_bytes</a> = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a>.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_network_pubkey_bytes">next_epoch_network_pubkey_bytes</a> = option::none();
    };
    <b>if</b> (<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>(self).is_some()) {
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_worker_pubkey_bytes">worker_pubkey_bytes</a> = self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a>.extract();
        self.<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_next_epoch_worker_pubkey_bytes">next_epoch_worker_pubkey_bytes</a> = option::none();
    };
}
</code></pre>



</details>

<a name="one_system_validator_validate_metadata"></a>

## Function `validate_metadata`

Aborts if validator metadata is valid


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>: &<a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">one_system::validator::ValidatorMetadata</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_validate_metadata">validate_metadata</a>(<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>: &<a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">ValidatorMetadata</a>) {
    <a href="../one_system/validator.md#one_system_validator_validate_metadata_bcs">validate_metadata_bcs</a>(bcs::to_bytes(<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>));
}
</code></pre>



</details>

<a name="one_system_validator_validate_metadata_bcs"></a>

## Function `validate_metadata_bcs`



<pre><code><b>public</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_validate_metadata_bcs">validate_metadata_bcs</a>(<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>native</b> <b>fun</b> <a href="../one_system/validator.md#one_system_validator_validate_metadata_bcs">validate_metadata_bcs</a>(<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>: vector&lt;u8&gt;);
</code></pre>



</details>

<a name="one_system_validator_get_staking_pool_ref"></a>

## Function `get_staking_pool_ref`



<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_get_staking_pool_ref">get_staking_pool_ref</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>): &<a href="../one_system/staking_pool.md#one_system_staking_pool_StakingPool">one_system::staking_pool::StakingPool</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(package) <b>fun</b> <a href="../one_system/validator.md#one_system_validator_get_staking_pool_ref">get_staking_pool_ref</a>(self: &<a href="../one_system/validator.md#one_system_validator_Validator">Validator</a>): &StakingPool {
    &self.<a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>
}
</code></pre>



</details>

<a name="one_system_validator_new_from_metadata"></a>

## Function `new_from_metadata`

Create a new validator from the given <code><a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">ValidatorMetadata</a></code>, called by both <code><a href="../one_system/validator.md#one_system_validator_new">new</a></code> and <code>new_for_testing</code>.


<pre><code><b>fun</b> <a href="../one_system/validator.md#one_system_validator_new_from_metadata">new_from_metadata</a>(<a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>: <a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">one_system::validator::ValidatorMetadata</a>, <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>: <b>address</b>, only_validator_staking: bool, <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>: u64, <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>: u64, ctx: &<b>mut</b> <a href="../one/tx_context.md#one_tx_context_TxContext">one::tx_context::TxContext</a>): <a href="../one_system/validator.md#one_system_validator_Validator">one_system::validator::Validator</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="../one_system/validator.md#one_system_validator_new_from_metadata">new_from_metadata</a>(
    <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>: <a href="../one_system/validator.md#one_system_validator_ValidatorMetadata">ValidatorMetadata</a>,
    <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>: <b>address</b>,
    only_validator_staking:bool,
    <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>: u64,
    <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>: u64,
    ctx: &<b>mut</b> TxContext
): <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a> {
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a> = <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>.<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>;
    <b>let</b> <a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a> = <a href="../one_system/staking_pool.md#one_system_staking_pool_new">staking_pool::new</a>(ctx);
    <b>let</b> <a href="../one_system/validator.md#one_system_validator_operation_cap_id">operation_cap_id</a> = <a href="../one_system/validator_cap.md#one_system_validator_cap_new_unverified_validator_operation_cap_and_transfer">validator_cap::new_unverified_validator_operation_cap_and_transfer</a>(<a href="../one_system/validator.md#one_system_validator_sui_address">sui_address</a>, ctx);
    <a href="../one_system/validator.md#one_system_validator_Validator">Validator</a> {
        <a href="../one_system/validator.md#one_system_validator_metadata">metadata</a>,
        // Initialize the voting power to be 0.
        // At the epoch change where this <a href="../one_system/validator.md#one_system_validator">validator</a> is actually added to the
        // active <a href="../one_system/validator.md#one_system_validator">validator</a> set, the voting power will be updated accordingly.
        <a href="../one_system/voting_power.md#one_system_voting_power">voting_power</a>: 0,
        <a href="../one_system/validator.md#one_system_validator_revenue_receiving_address">revenue_receiving_address</a>,
        only_validator_staking,
        <a href="../one_system/validator.md#one_system_validator_operation_cap_id">operation_cap_id</a>,
        <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>,
        <a href="../one_system/staking_pool.md#one_system_staking_pool">staking_pool</a>,
        <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>,
        next_epoch_stake: 0,
        <a href="../one_system/validator.md#one_system_validator_next_epoch_gas_price">next_epoch_gas_price</a>: <a href="../one_system/validator.md#one_system_validator_gas_price">gas_price</a>,
        next_epoch_commission_rate: <a href="../one_system/validator.md#one_system_validator_commission_rate">commission_rate</a>,
        extra_fields: bag::new(ctx),
    }
}
</code></pre>



</details>
