// valid
module a::m {
    use one::object;
    struct S has key {
        id: object::UID
    }
}

module one::object {
    struct UID has store {
        id: address,
    }
}
