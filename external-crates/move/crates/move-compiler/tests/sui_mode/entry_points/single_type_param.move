module a::m {
    use one::tx_context;

    public entry fun foo<T>(_: T, _: &mut tx_context::TxContext) {
        abort 0
    }

}

module one::tx_context {
    struct TxContext has drop {}
}
