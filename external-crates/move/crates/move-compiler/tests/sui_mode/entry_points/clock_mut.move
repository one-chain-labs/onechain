// invalid, Clock by mutable reference

module a::m {
    public entry fun no_clock_mut(_: &mut sui::clock::Clock) {
        abort 0
    }
}

module oct::clock {
    struct Clock has key {
        id: sui::object::UID,
    }
}

module oct::object {
    struct UID has store {
        id: address,
    }
}
