module a::trigger_lint_cases {
    use one::object::UID;

    // 4. Suppress warning
    #[allow(lint(missing_key))]
    struct SuppressWarning {
       id: UID,
    }
}

module one::object {
    struct UID has store {
        id: address,
    }
}
