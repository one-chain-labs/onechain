// invalid Random by mutable reference

module a::m {
    public entry fun no_random_mut(_: &mut one::random::Random) {
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
