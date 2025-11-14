// valid Random by immutable reference

module a::m {
    public entry fun yes_random_ref(_: &one::random::Random) {
        abort 0
    }
}

module one::random {
    struct Random has key {
        id: one::object::UID,
    }
}

module one::object {
    struct UID has store {
        id: address,
    }
}
