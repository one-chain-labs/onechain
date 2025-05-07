// invalid Random by mutable reference

module a::m {
    public entry fun no_random_mut(_: &mut one::random::Random) {
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
