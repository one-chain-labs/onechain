// valid, Clock by immutable reference

module a::m {
    public entry fun yes_clock_ref(_: &one::clock::Clock) {
        abort 0
    }
}

module one::clock {
    struct Clock has key {
        id: one::object::UID,
    }
}

module one::object {
    struct UID has store {
        id: address,
    }
}
