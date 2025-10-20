// valid Random by immutable reference

module a::m {
    public entry fun yes_random_ref(_: &sui::random::Random) {
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
