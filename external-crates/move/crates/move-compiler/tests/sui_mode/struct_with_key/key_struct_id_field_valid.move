// valid
module a::m {
    use one::object;
    struct S has key {
        id: object::UID
    }
}

module oct::object {
    struct UID has store {
        id: address,
    }
}
