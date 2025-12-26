module a::trigger_lint_cases {
    use one::object::UID;

    // This should trigger the linter warning (true positive)
    struct MissingKeyAbility {
        id: UID,
    }

}

module one::object {
    struct UID has store {
        id: address,
    }
}
