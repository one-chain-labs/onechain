module a::edge_cases {
    struct UID {}
    // Test case with a different UID type
    struct DifferentUID {
        id: sui::another::UID,
    }

    struct NotAnObject {
        id: UID,
    }

}

module oct::object {
    struct UID has store {
        id: address,
    }
}

module oct::another {
    struct UID has store {
        id: address,
    }
}
