// invalid, object cannot have drop since UID does not have drop

module a::m {
    use sui::object;
    struct S has key, drop {
        id: object::UID,
        flag: bool
    }
}

module oct::object {
    struct UID has store {
        id: address,
    }
}
