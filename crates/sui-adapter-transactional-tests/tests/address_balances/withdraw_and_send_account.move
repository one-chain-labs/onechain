// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

// Test send_funds and redeem_funds from one::balance

//# init --addresses test=0x0 --accounts A B --enable-accumulators --simulator

// Send 1000 from A to B
//# programmable --sender A --inputs 1000 @B
//> 0: SplitCoins(Gas, [Input(0)]);
//> 1: one::coin::into_balance<one::oct::OCT>(Result(0));
//> 2: one::balance::send_funds<one::oct::OCT>(Result(1), Input(1));

//# create-checkpoint

// B withdraws 500 and send to A
//# programmable --sender B --inputs withdraw<one::balance::Balance<one::oct::OCT>>(500) @A
//> 0: one::balance::redeem_funds<one::oct::OCT>(Input(0));
//> 1: one::balance::send_funds<one::oct::OCT>(Result(0), Input(1));

//# create-checkpoint

// B withdraws 500 and send to self
//# programmable --sender B --inputs withdraw<one::balance::Balance<one::oct::OCT>>(500) @B
//> 0: one::balance::redeem_funds<one::oct::OCT>(Input(0));
//> 1: one::balance::send_funds<one::oct::OCT>(Result(0), Input(1));
