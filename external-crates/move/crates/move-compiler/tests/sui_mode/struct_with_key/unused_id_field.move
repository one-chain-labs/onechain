module a::m {
    struct Obj has key { id: one::object::UID }
}

module one::object {
    struct UID has store { value: address }
    public fun borrow_address(id: &UID): &address { &id.value }
}
