// valid, Clock by immutable reference

module a::m {
    public entry fun yes_clock_ref(_: &one::clock::Clock) {
        abort 0
    }
}

module oct::clock {
    struct Clock has key {
        id: one::object::UID,
    }
}

module oct::object {
    struct UID has store {
        id: address,
    }
}
