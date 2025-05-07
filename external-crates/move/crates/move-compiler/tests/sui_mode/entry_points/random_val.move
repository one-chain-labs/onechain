// invalid Random by value

module a::m {
    public entry fun no_random_val(_: one::random::Random) {
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
