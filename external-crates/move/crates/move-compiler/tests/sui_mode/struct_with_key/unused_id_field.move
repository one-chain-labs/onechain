module a::m {
    struct Obj has key { id: sui::object::UID }
}

module oct::object {
    struct UID has store { value: address }
    public fun borrow_address(id: &UID): &address { &id.value }
}
