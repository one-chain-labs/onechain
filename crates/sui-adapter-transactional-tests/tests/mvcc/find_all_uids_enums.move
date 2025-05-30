// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

// tests finding UIDs for dynamic field access

//# init --addresses test=0x0 --accounts A

//# publish

module test::m {
    use one::dynamic_field as field;

    public struct S has key, store {
        id: UID,
        other: EnumWrapper,
        wrapped: Wrapped,
        many: vector<Wrapped>,
    }

    public struct Wrapped has key, store {
        id: UID,
        other: EnumWrapper,
    }

    public enum EnumWrapper has store {
        Wrapped(UID),
    }

    const KEY: u64 = 0;

    //////////////////////////////////////////////////////////////
    // new

    public fun new(ctx: &mut TxContext): S {
        let mut s = S {
            id: object::new(ctx),
            other: EnumWrapper::Wrapped(object::new(ctx)),
            wrapped: wrapped(ctx),
            many: vector[wrapped(ctx), wrapped(ctx)],
        };
        field::add(&mut s.id, KEY, 0);
        field::add(s.other.get_wrapped_uid(), KEY, 0);
        s
    }

    fun wrapped(ctx: &mut TxContext): Wrapped {
        let mut w = Wrapped {
            id: object::new(ctx),
            other: EnumWrapper::Wrapped(object::new(ctx)),
        };
        field::add(&mut w.id, KEY, 0);
        field::add(w.other.get_wrapped_uid(), KEY, 0);
        w
    }


    fun get_wrapped_uid(w: &mut EnumWrapper): &mut UID {
        match (w) {
            EnumWrapper::Wrapped(id) => id,
        }
    }

    fun get_wrapped_uid_ref(w: &EnumWrapper): &UID {
        match (w) {
            EnumWrapper::Wrapped(id) => id,
        }
    }

    //////////////////////////////////////////////////////////////
    // set

    public fun set(s: &mut S, value: u64) {
        set_(&mut s.id, value);
        set_(s.other.get_wrapped_uid(), value);
        set_wrapped(&mut s.wrapped, value);
        set_wrapped(vector::borrow_mut(&mut s.many, 0), value);
        set_wrapped(vector::borrow_mut(&mut s.many, 1), value);
    }

    fun set_wrapped(w: &mut Wrapped, value: u64) {
        set_(&mut w.id, value);
        set_(w.other.get_wrapped_uid(), value);

    }

    fun set_(id: &mut UID, value: u64) {
        *field::borrow_mut(id, KEY) = value;
    }

    //////////////////////////////////////////////////////////////
    // remove

    public fun remove(s: &mut S) {
        remove_(&mut s.id);
        remove_(s.other.get_wrapped_uid());
        remove_wrapped(&mut s.wrapped);
        remove_wrapped(vector::borrow_mut(&mut s.many, 0));
        remove_wrapped(vector::borrow_mut(&mut s.many, 1));
    }

    fun remove_wrapped(w: &mut Wrapped) {
        remove_(&mut w.id);
        remove_(w.other.get_wrapped_uid());
    }

    fun remove_(id: &mut UID) {
        field::remove<u64, u64>(id, KEY);
    }

    //////////////////////////////////////////////////////////////
    // check

    public fun check(s: &S, expected: Option<u64>) {
        check_(&s.id, expected);
        check_(s.other.get_wrapped_uid_ref(), expected);
        check_wrapped(&s.wrapped, expected);
        check_wrapped(vector::borrow(&s.many, 0), expected);
        check_wrapped(vector::borrow(&s.many, 1), expected);
    }

    fun check_wrapped(w: &Wrapped, expected: Option<u64>) {
        check_(&w.id, expected);
        check_(w.other.get_wrapped_uid_ref(), expected);
    }

    fun check_(id: &UID, expected: Option<u64>) {
        if (option::is_some(&expected)) {
            let f = field::borrow(id, KEY);
            assert!(f == option::borrow(&expected), 0);
        } else {
            assert!(!field::exists_with_type<u64, u64>(id, KEY), 0);
        }
    }
}

//# programmable --sender A --inputs @A
//> 0: test::m::new();
//> TransferObjects([Result(0)], Input(0))

//# view-object 2,8

//# programmable --sender A --inputs object(2,8) 112
//> test::m::set(Input(0), Input(1))

//# view-object 2,8

//# programmable --sender A --inputs object(2,8) 112
//> test::m::remove(Input(0))

//# view-object 2,8

// dev-inspect with 'check' and correct values

//# programmable --sender A --inputs object(2,8)@2 vector[0] --dev-inspect
//> test::m::check(Input(0), Input(1))

//# programmable --sender A --inputs object(2,8)@3 vector[112] --dev-inspect
//> test::m::check(Input(0), Input(1))

//# programmable --sender A --inputs object(2,8)@4 vector[] --dev-inspect
//> test::m::check(Input(0), Input(1))

// dev-inspect with 'check' and _incorrect_ values

// Should fail since the field exists but with a different field.
//# programmable --sender A --inputs object(2,8)@3 vector[0] --dev-inspect
//> test::m::check(Input(0), Input(1))

// Should fail since the field has been deleted.
//# programmable --sender A --inputs object(2,8)@4 vector[112] --dev-inspect
//> test::m::check(Input(0), Input(1))

// Should fail since at the version of the object we're passing in the field exists still
//# programmable --sender A --inputs object(2,8)@2 vector[] --dev-inspect
//> test::m::check(Input(0), Input(1))
