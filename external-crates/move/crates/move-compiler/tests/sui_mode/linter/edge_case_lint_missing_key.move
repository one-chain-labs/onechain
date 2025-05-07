module a::edge_cases {
    struct UID {}
    // Test case with a different UID type
    struct DifferentUID {
        id: one::another::UID,
    }

    struct NotAnObject {
        id: UID,
    }

}

module one::object {
    struct UID has store {
        id: address,
    }
}

module one::another {
    struct UID has store {
        id: address,
    }
}
