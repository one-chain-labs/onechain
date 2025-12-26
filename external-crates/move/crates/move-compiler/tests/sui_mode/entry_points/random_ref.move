// valid Random by immutable reference

module a::m {
    public entry fun yes_random_ref(_: &one::random::Random) {
        abort 0
    }
}

module oct::random {
    struct Random has key {
        id: one::object::UID,
    }
}

module oct::object {
    struct UID has store {
        id: address,
    }
}
