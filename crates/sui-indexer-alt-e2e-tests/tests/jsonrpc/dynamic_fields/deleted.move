// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

//# init --protocol-version 70 --accounts A --simulator

// 1. Look for a dynamic field that doesn't exist yet (should return nothing).
// 2. Add the dynamic field and then look for it again (should return the dynamic field).
// 3. Delete the dynamic field and look for it once again (should not return anything).
// 4, 5, 6. The same again, but for dynamic object fields.

//# programmable --sender A --inputs @A
//> 0: one::bag::new();
//> 1: TransferObjects([Result(0)], Input(0))

//# create-checkpoint

//# run-jsonrpc
{
  "method": "suix_getDynamicFieldObject",
  "params": ["@{obj_1_0}", { "type": "u64", "value": "42" }]
}

//# programmable --sender A --inputs object(1,0) 42
//> 0: one::bag::add<u64, u64>(Input(0), Input(1), Input(1))

//# create-checkpoint

//# run-jsonrpc
{
  "method": "suix_getDynamicFieldObject",
  "params": ["@{obj_1_0}", { "type": "u64", "value": "42" }]
}

//# programmable --sender A --inputs object(1,0) 42
//> 0: one::bag::remove<u64, u64>(Input(0), Input(1))

//# create-checkpoint

//# run-jsonrpc
{
  "method": "suix_getDynamicFieldObject",
  "params": ["@{obj_1_0}", { "type": "u64", "value": "42" }]
}

//# programmable --sender A --inputs @A
//> 0: one::object_bag::new();
//> 1: TransferObjects([Result(0)], Input(0))

//# create-checkpoint

//# run-jsonrpc
{
  "method": "suix_getDynamicFieldObject",
  "params": ["@{obj_10_0}", { "type": "u64", "value": "43" }]
}

//# programmable --sender A --inputs object(10,0) 43
//> 0: SplitCoins(Gas, [Input(1)]);
//> 1: one::object_bag::add<u64, one::coin::Coin<one::oct::OCT>>(Input(0), Input(1), Result(0))

//# create-checkpoint

//# run-jsonrpc
{
  "method": "suix_getDynamicFieldObject",
  "params": ["@{obj_10_0}", { "type": "u64", "value": "43" }]
}

//# programmable --sender A --inputs object(10,0) 43
//> 0: one::object_bag::remove<u64, one::coin::Coin<one::oct::OCT>>(Input(0), Input(1));
//> 1: MergeCoins(Gas, [Result(0)])

//# create-checkpoint

//# run-jsonrpc
{
  "method": "suix_getDynamicFieldObject",
  "params": ["@{obj_10_0}", { "type": "u64", "value": "43" }]
}
