// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

// DEPRECATED child count no longer tracked
// tests the invalid creation and deletion of a parent object

//# init --addresses test=0x0 --accounts A B

//# publish

module test::m {
    public struct S has key, store {
        id: one::object::UID,
    }

    public entry fun t(ctx: &mut TxContext) {
        let mut parent = one::object::new(ctx);
        let child = S { id: one::object::new(ctx) };
        one::dynamic_object_field::add(&mut parent, 0, child);
        one::object::delete(parent);
    }
}

//# run test::m::t --sender A
