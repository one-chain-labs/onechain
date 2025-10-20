// invalid Random by mutable reference

module a::m {
    public entry fun no_random_mut(_: &mut sui::random::Random) {
        abort 0
    }
}

module oct::random {
    struct Random has key {
        id: sui::object::UID,
    }
}

module oct::object {
    struct UID has store {
        id: address,
    }
}
