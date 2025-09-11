// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

#[test_only]
module oct_system::staking_pool_tests;

use std::unit_test::assert_eq;
use sui::balance;
use sui::test_scenario::{Self, Scenario};
use sui::test_utils::destroy;
use one_system::staking_pool::{Self, StakingPool};

#[test]
fun join_fungible_staked_oct_happy() {
    let mut scenario = test_scenario::begin(@0x0);
    let staking_pool = staking_pool::new(scenario.ctx());

    let mut fungible_staked_oct_1 = staking_pool.create_fungible_staked_oct_for_testing(
        100_000_000_000,
        scenario.ctx(),
    );
    let fungible_staked_oct_2 = staking_pool.create_fungible_staked_oct_for_testing(
        200_000_000_000,
        scenario.ctx(),
    );

    fungible_staked_oct_1.join(fungible_staked_oct_2);

    assert_eq!(fungible_staked_oct_1.value(), 300_000_000_000);

    destroy(staking_pool);
    destroy(fungible_staked_oct_1);

    scenario.end();
}

#[test, expected_failure(abort_code = staking_pool::EWrongPool)]
fun join_fungible_staked_oct_fail() {
    let mut scenario = test_scenario::begin(@0x0);
    let staking_pool_1 = staking_pool::new(scenario.ctx());
    let staking_pool_2 = staking_pool::new(scenario.ctx());

    let mut fungible_staked_oct_1 = staking_pool_1.create_fungible_staked_oct_for_testing(
        100_000_000_000,
        scenario.ctx(),
    );
    let fungible_staked_oct_2 = staking_pool_2.create_fungible_staked_oct_for_testing(
        200_000_000_000,
        scenario.ctx(),
    );

    fungible_staked_oct_1.join(fungible_staked_oct_2);

    abort
}

#[test]
fun split_fungible_staked_oct_happy() {
    let mut scenario = test_scenario::begin(@0x0);
    let staking_pool = staking_pool::new(scenario.ctx());

    let mut fungible_staked_oct_1 = staking_pool.create_fungible_staked_oct_for_testing(
        100_000_000_000,
        scenario.ctx(),
    );

    let fungible_staked_oct_2 = fungible_staked_oct_1.split(75_000_000_000, scenario.ctx());

    assert_eq!(fungible_staked_oct_1.value(), 25_000_000_000);
    assert_eq!(fungible_staked_oct_2.value(), 75_000_000_000);

    destroy(staking_pool);
    destroy(fungible_staked_oct_1);
    destroy(fungible_staked_oct_2);

    scenario.end();
}

#[test, expected_failure(abort_code = staking_pool::EInsufficientPoolTokenBalance)]
fun split_fungible_staked_oct_fail_too_much() {
    let mut scenario = test_scenario::begin(@0x0);
    let staking_pool = staking_pool::new(scenario.ctx());

    let mut fungible_staked_oct_1 = staking_pool.create_fungible_staked_oct_for_testing(
        100_000_000_000,
        scenario.ctx(),
    );

    let _fungible_staked_oct_2 = fungible_staked_oct_1.split(100_000_000_000 + 1, scenario.ctx());

    abort
}

#[test, expected_failure(abort_code = staking_pool::ECannotMintFungibleStakedOctYet)]
fun convert_to_fungible_staked_oct_fail_too_early() {
    let mut scenario = test_scenario::begin(@0x0);
    let mut staking_pool = staking_pool::new(scenario.ctx());

    let sui = balance::create_for_testing(1_000_000_000);
    let staked_oct = staking_pool.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );
    let _fungible_staked_oct = staking_pool.convert_to_fungible_staked_oct(
        staked_oct,
        scenario.ctx(),
    );

    abort
}

#[test, expected_failure(abort_code = staking_pool::EPoolPreactiveOrInactive)]
fun convert_to_fungible_staked_oct_fail_too_early_preactive() {
    let mut scenario = test_scenario::begin(@0x0);
    let mut staking_pool = staking_pool::new(scenario.ctx());

    let sui = balance::create_for_testing(1_000_000_000);
    let activation_epoch = scenario.ctx().epoch() + 1;
    let staked_oct = staking_pool.request_add_stake(
        sui,
        activation_epoch,
        scenario.ctx(),
    );

    scenario.skip_to_epoch(activation_epoch);
    let _fungible_staked_oct = staking_pool.convert_to_fungible_staked_oct(
        staked_oct,
        scenario.ctx(),
    );

    abort
}

#[test, expected_failure(abort_code = staking_pool::EPoolPreactiveOrInactive)]
fun convert_to_fungible_staked_oct_fail_too_early_inactive() {
    let mut scenario = test_scenario::begin(@0x0);
    let mut staking_pool = staking_pool::new(scenario.ctx());

    let sui = balance::create_for_testing(1_000_000_000);
    let activation_epoch = scenario.ctx().epoch() + 1;
    let staked_oct = staking_pool.request_add_stake(
        sui,
        activation_epoch,
        scenario.ctx(),
    );

    scenario.skip_to_epoch(activation_epoch);
    staking_pool.deactivate_staking_pool(0);
    let _fungible_staked_oct = staking_pool.convert_to_fungible_staked_oct(
        staked_oct,
        scenario.ctx(),
    );

    abort
}

#[test, expected_failure(abort_code = staking_pool::EWrongPool)]
fun convert_to_fungible_staked_oct_fail_wrong_pool() {
    let mut scenario = test_scenario::begin(@0x0);
    let mut staking_pool_1 = staking_pool::new(scenario.ctx());
    let mut staking_pool_2 = staking_pool::new(scenario.ctx());

    let sui = balance::create_for_testing(1_000_000_000);
    let staked_oct = staking_pool_1.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );

    let _fungible_staked_oct = staking_pool_2.convert_to_fungible_staked_oct(
        staked_oct,
        scenario.ctx(),
    );

    abort
}

#[test]
fun convert_to_fungible_staked_oct_happy() {
    let mut scenario = test_scenario::begin(@0x0);
    let mut staking_pool = staking_pool::new(scenario.ctx());
    staking_pool.activate_staking_pool(0);

    // setup

    let sui = balance::create_for_testing(1_000_000_000);
    let staked_oct_1 = staking_pool.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );

    assert_eq!(distribute_rewards_and_advance_epoch(&mut staking_pool, &mut scenario, 0), 1);

    let latest_exchange_rate = staking_pool.pool_token_exchange_rate_at_epoch(1);
    assert_eq!(latest_exchange_rate.sui_amount(), 1_000_000_000);
    assert_eq!(latest_exchange_rate.pool_token_amount(), 1_000_000_000);

    let sui = balance::create_for_testing(1_000_000_000);
    let staked_oct_2 = staking_pool.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );

    assert_eq!(
        distribute_rewards_and_advance_epoch(
            &mut staking_pool,
            &mut scenario,
            1_000_000_000,
        ),
        2,
    );

    let latest_exchange_rate = staking_pool.pool_token_exchange_rate_at_epoch(2);
    assert_eq!(latest_exchange_rate.sui_amount(), 3_000_000_000);
    assert_eq!(latest_exchange_rate.pool_token_amount(), 1_500_000_000);

    // test basically starts from here.

    let fungible_staked_oct_1 = staking_pool.convert_to_fungible_staked_oct(
        staked_oct_1,
        scenario.ctx(),
    );
    assert_eq!(fungible_staked_oct_1.value(), 1_000_000_000);
    assert_eq!(fungible_staked_oct_1.pool_id(), object::id(&staking_pool));

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 1_000_000_000);
    assert_eq!(fungible_staked_oct_data.principal_value(), 1_000_000_000);

    let fungible_staked_oct_2 = staking_pool.convert_to_fungible_staked_oct(
        staked_oct_2,
        scenario.ctx(),
    );
    assert_eq!(fungible_staked_oct_2.value(), 500_000_000);
    assert_eq!(fungible_staked_oct_2.pool_id(), object::id(&staking_pool));

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 1_500_000_000);
    assert_eq!(fungible_staked_oct_data.principal_value(), 2_000_000_000);

    destroy(staking_pool);
    // destroy(fungible_staked_oct);
    destroy(fungible_staked_oct_1);
    destroy(fungible_staked_oct_2);

    scenario.end();
}

#[test]
fun redeem_fungible_staked_oct_happy() {
    let mut scenario = test_scenario::begin(@0x0);
    let mut staking_pool = staking_pool::new(scenario.ctx());
    staking_pool.activate_staking_pool(0);

    // setup

    let sui = balance::create_for_testing(1_000_000_000);
    let staked_oct_1 = staking_pool.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );

    assert_eq!(distribute_rewards_and_advance_epoch(&mut staking_pool, &mut scenario, 0), 1);

    let latest_exchange_rate = staking_pool.pool_token_exchange_rate_at_epoch(1);
    assert_eq!(latest_exchange_rate.sui_amount(), 1_000_000_000);
    assert_eq!(latest_exchange_rate.pool_token_amount(), 1_000_000_000);

    let sui = balance::create_for_testing(1_000_000_000);
    let staked_oct_2 = staking_pool.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );

    assert_eq!(
        distribute_rewards_and_advance_epoch(
            &mut staking_pool,
            &mut scenario,
            1_000_000_000,
        ),
        2,
    );

    let latest_exchange_rate = staking_pool.pool_token_exchange_rate_at_epoch(2);
    assert_eq!(latest_exchange_rate.sui_amount(), 3_000_000_000);
    assert_eq!(latest_exchange_rate.pool_token_amount(), 1_500_000_000);

    let fungible_staked_oct_1 = staking_pool.convert_to_fungible_staked_oct(
        staked_oct_1,
        scenario.ctx(),
    );
    assert_eq!(fungible_staked_oct_1.value(), 1_000_000_000);
    assert_eq!(fungible_staked_oct_1.pool_id(), object::id(&staking_pool));

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 1_000_000_000);
    assert_eq!(fungible_staked_oct_data.principal_value(), 1_000_000_000);

    let fungible_staked_oct_2 = staking_pool.convert_to_fungible_staked_oct(
        staked_oct_2,
        scenario.ctx(),
    );
    assert_eq!(fungible_staked_oct_2.value(), 500_000_000);
    assert_eq!(fungible_staked_oct_2.pool_id(), object::id(&staking_pool));

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 1_500_000_000);
    assert_eq!(fungible_staked_oct_data.principal_value(), 2_000_000_000);

    // test starts here
    assert_eq!(
        distribute_rewards_and_advance_epoch(
            &mut staking_pool,
            &mut scenario,
            3_000_000_000,
        ),
        3,
    );

    let latest_exchange_rate = staking_pool.pool_token_exchange_rate_at_epoch(3);
    assert_eq!(latest_exchange_rate.sui_amount(), 6_000_000_000);
    assert_eq!(latest_exchange_rate.pool_token_amount(), 1_500_000_000);

    assert_eq!(staking_pool.pending_stake_withdraw_amount(), 0);
    assert_eq!(staking_pool.pending_pool_token_withdraw_amount(), 0);

    let sui_1 = staking_pool.redeem_fungible_staked_oct(fungible_staked_oct_1, scenario.ctx());
    assert!(sui_1.value() <= 4_000_000_000, 0);
    assert_eq!(sui_1.value(), 4_000_000_000 - 1);

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 500_000_000);
    assert_eq!(fungible_staked_oct_data.principal_value(), 2_000_000_000 / 3 + 1); // round against user

    assert_eq!(staking_pool.pending_stake_withdraw_amount(), 4_000_000_000 - 1);
    assert_eq!(staking_pool.pending_pool_token_withdraw_amount(), 1_000_000_000);

    let sui_2 = staking_pool.redeem_fungible_staked_oct(fungible_staked_oct_2, scenario.ctx());
    assert_eq!(sui_2.value(), 2_000_000_000);

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 0);
    assert_eq!(fungible_staked_oct_data.principal_value(), 0);

    assert_eq!(staking_pool.pending_stake_withdraw_amount(), 6_000_000_000 - 1);
    assert_eq!(staking_pool.pending_pool_token_withdraw_amount(), 1_500_000_000);

    destroy(staking_pool);
    destroy(sui_1);
    destroy(sui_2);

    scenario.end();
}

#[test]
fun redeem_fungible_staked_oct_regression_rounding() {
    let mut scenario = test_scenario::begin(@0x0);
    let mut staking_pool = staking_pool::new(scenario.ctx());
    staking_pool.activate_staking_pool(0);

    // setup

    let sui = balance::create_for_testing(1_000_000_000);
    let staked_oct_1 = staking_pool.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );

    assert_eq!(distribute_rewards_and_advance_epoch(&mut staking_pool, &mut scenario, 0), 1);

    let latest_exchange_rate = staking_pool.pool_token_exchange_rate_at_epoch(1);
    assert_eq!(latest_exchange_rate.sui_amount(), 1_000_000_000);
    assert_eq!(latest_exchange_rate.pool_token_amount(), 1_000_000_000);

    let sui = balance::create_for_testing(1_000_000_001);
    let staked_oct_2 = staking_pool.request_add_stake(
        sui,
        scenario.ctx().epoch() + 1,
        scenario.ctx(),
    );

    assert_eq!(
        distribute_rewards_and_advance_epoch(
            &mut staking_pool,
            &mut scenario,
            1_000_000_000,
        ),
        2,
    );

    let latest_exchange_rate = staking_pool.pool_token_exchange_rate_at_epoch(2);
    assert_eq!(latest_exchange_rate.sui_amount(), 3_000_000_001);
    assert_eq!(latest_exchange_rate.pool_token_amount(), 1_500_000_000);

    let fungible_staked_oct = staking_pool.convert_to_fungible_staked_oct(
        staked_oct_2,
        scenario.ctx(),
    );
    assert_eq!(fungible_staked_oct.value(), 500_000_000); // rounding!
    assert_eq!(fungible_staked_oct.pool_id(), object::id(&staking_pool));

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 500_000_000);
    assert_eq!(fungible_staked_oct_data.principal_value(), 1_000_000_001);

    // this line used to error
    let sui = staking_pool.redeem_fungible_staked_oct(fungible_staked_oct, scenario.ctx());
    assert_eq!(sui.value(), 1_000_000_000);

    let fungible_staked_oct_data = staking_pool.fungible_staked_oct_data();
    assert_eq!(fungible_staked_oct_data.total_supply(), 0);
    assert_eq!(fungible_staked_oct_data.principal_value(), 1);

    destroy(staking_pool);
    destroy(staked_oct_1);
    destroy(sui);

    scenario.end();
}

#[test_only]
fun distribute_rewards_and_advance_epoch(
    staking_pool: &mut StakingPool,
    scenario: &mut Scenario,
    reward_amount: u64,
): u64 {
    use sui::tx_context::{epoch};
    use sui::coin::{Self};
    use sui::oct::OCT;

    let rewards = coin::mint_for_testing<SUI>(reward_amount, scenario.ctx());
    staking_pool.deposit_rewards(coin::into_balance(rewards));

    staking_pool.process_pending_stakes_and_withdraws(scenario.ctx());
    test_scenario::next_epoch(scenario, @0x0);

    scenario.ctx().epoch()
}
