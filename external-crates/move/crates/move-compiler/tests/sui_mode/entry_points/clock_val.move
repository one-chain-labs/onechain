// invalid, Clock by value

module a::m {
    public entry fun no_clock_val(_: one::clock::Clock) {
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
