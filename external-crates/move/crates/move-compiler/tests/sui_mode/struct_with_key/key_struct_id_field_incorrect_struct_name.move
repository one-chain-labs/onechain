// invalid, objects need UID not ID
module a::m {
    use one::object;
    struct S has key {
        id: object::ID
    }
}

module one::object {
    struct ID has store {
        id: address,
    }
}
