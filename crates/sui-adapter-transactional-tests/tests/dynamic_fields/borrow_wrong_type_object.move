// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

// similar to dynamic_object_field_tests but over multiple transactions,
// as this uses a different code path
// test borrow with the wrong value type

//# init --addresses a=0x0 --accounts A

//# publish
module a::m {

use one::dynamic_object_field::{add, borrow, borrow_mut};

public struct Obj has key, store {
    id: object::UID,
}

public struct Fake has key, store {
    id: object::UID,
}

entry fun t1(ctx: &mut TxContext) {
    let mut id = object::new(ctx);
    add(&mut id, 0, Obj { id: object::new(ctx) });
    one::transfer::public_transfer(Obj { id }, ctx.sender())
}

entry fun t2(obj: &mut Obj) {
    borrow<u64, Fake>(&mut obj.id, 0);
}

entry fun t3(obj: &mut Obj) {
    borrow_mut<u64, Fake>(&mut obj.id, 0);
}

}

//# run a::m::t1 --sender A

//# run a::m::t2 --sender A --args object(2,1)

//# run a::m::t3 --sender A --args object(2,1)
