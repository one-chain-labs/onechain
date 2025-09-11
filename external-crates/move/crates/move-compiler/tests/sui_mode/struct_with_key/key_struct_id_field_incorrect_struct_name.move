// invalid, objects need UID not ID
module a::m {
    use sui::object;
    struct S has key {
        id: object::ID
    }
}

module oct::object {
    struct ID has store {
        id: address,
    }
}
