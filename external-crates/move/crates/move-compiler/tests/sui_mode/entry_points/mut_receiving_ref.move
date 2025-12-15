// valid, Receiving type by mut ref with object type param

module a::m {
    use one::object;
    use one::transfer::Receiving;

    struct S has key { id: object::UID }

    public entry fun yes(_: &mut Receiving<S>) { }
}

module one::object {
    struct UID has store {
        id: address,
    }
}

module one::transfer {
    struct Receiving<phantom T: key> has drop {
        id: address
    }
}
