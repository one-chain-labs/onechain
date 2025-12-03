// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

#[test_only]
module one_system::voting_power_tests {
    use one_system::governance_test_utils as gtu;
    use one_system::voting_power;
    use one::test_scenario;
    use one::test_utils;
    use one_system::validator::{Self, Validator};

    const TOTAL_VOTING_POWER: u64 = 10_000;

    fun check(stakes: vector<u64>, voting_power: vector<u64>, ctx: &mut TxContext) {
        let mut validators = gtu::create_validators_with_stakes(stakes, ctx);
        voting_power::set_voting_power(&mut validators);
        test_utils::assert_eq(get_voting_power(&validators), voting_power);
        test_utils::destroy(validators);
    }

    #[test]
    fun test_small_validator_sets() {
        let mut scenario = test_scenario::begin(@0x0);
        let ctx = scenario.ctx();
        check(vector[1], vector[TOTAL_VOTING_POWER], ctx);
        check(vector[77], vector[TOTAL_VOTING_POWER], ctx);
        check(vector[TOTAL_VOTING_POWER * 93], vector[TOTAL_VOTING_POWER], ctx);
        check(vector[1, 1], vector[5_000, 5_000], ctx);
        check(vector[1, 2], vector[5_000, 5_000], ctx);
        check(vector[1, 1, 1], vector[3_333, 3_333, 3_334], ctx);
        check(vector[1, 1, 2], vector[3_333, 3_333, 3_334], ctx);
        check(vector[1, 1, 1, 1], vector[2_500, 2_500, 2_500, 2_500], ctx);
        check(vector[1, 1, 1, 1, 1, 1], vector[1666, 1666, 1667, 1667, 1667, 1667], ctx);
        check(vector[1, 1, 1, 1, 1, 1, 1], vector[1428, 1428, 1428, 1429, 1429, 1429, 1429], ctx);
        check(vector[1, 1, 1, 1, 1, 1, 1, 1, 1], vector[1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1112], ctx);
        // different stake distributions that all lead to 10 validators, all with max voting power
        check(vector[1, 1, 1, 1, 1, 1, 1, 1, 1, 1], vector[1_000, 1_000, 1_000, 1_000, 1_000, 1_000, 1_000, 1_000, 1_000, 1_000], ctx);
        check(vector[2, 1, 1, 1, 1, 1, 1, 1, 1, 1], vector[1_819, 909, 909, 909, 909, 909, 909, 909, 909, 909], ctx);
        check(vector[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], vector[181, 363, 545, 727, 909, 1_091, 1_273, 1_455, 1_637, 1_819 ], ctx);
        // This tests the scenario where we have validators whose stakes are only slightly different.
        // Make sure that the order is preserved correctly and the leftover voting power goes to the right validators.
        check(vector[10000, 10001, 10000], vector[3333, 3334, 3333], ctx);
        scenario.end();
    }

    #[test]
    fun test_medium_validator_sets() {
        let mut scenario = test_scenario::begin(@0x0);
        let ctx = scenario.ctx();
        // >10 validators. now things get a bit more interesting because we can redistribute stake away from the max validators
        check(vector[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], vector[909, 909, 909, 909, 909, 909, 909, 909, 909, 909, 910], ctx);
        check(vector[2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], vector[1667, 833, 833, 833, 833, 833, 833, 833, 834, 834, 834], ctx);
        check(vector[2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1], vector[1539, 1539, 769, 769, 769, 769, 769, 769, 769, 769, 770], ctx);
        check(vector[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], vector[151, 303, 454, 606, 757, 909, 1060, 1213, 1364, 1516, 1667], ctx);

        scenario.end();
    }

    #[test]
    fun test_medium_validator_sets_2() {
        let mut scenario = test_scenario::begin(@0x0);
        let ctx = scenario.ctx();

        // more validators, harder to reach max
        check(vector[2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], vector[953, 953, 476, 476, 476, 476, 476, 476, 476, 476, 476, 476, 476, 476, 476, 476, 476, 477, 477], ctx);
        check(vector[4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], vector[1251, 938, 938, 938, 626, 626, 626, 312, 312, 312, 312, 312, 312, 312, 312, 312, 312, 312, 312, 313], ctx);
        scenario.end();
    }

    fun get_voting_power(validators: &vector<Validator>): vector<u64> {
        let mut result = vector[];
        let mut i = 0;
        let len = validators.length();
        while (i < len) {
            let voting_power = validator::voting_power(&validators[i]);
            result.push_back(voting_power);
            i = i + 1;
        };
        result
    }
}
