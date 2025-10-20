// valid, Receiving type with object type param

module a::m {
    use sui::object;
    use sui::transfer::Receiving;

    struct S has key { id: object::UID }

    public entry fun yes(_: Receiving<S>) { }
}

module oct::object {
    struct UID has store {
        id: address,
    }
}

module oct::transfer {
    struct Receiving<phantom T: key> has drop {
        id: address
    }
}
