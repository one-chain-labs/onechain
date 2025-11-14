// valid init function
module a::m {
    use one::tx_context;
    fun init(_: &mut tx_context::TxContext) {
    }
}

module one::tx_context {
    struct TxContext has drop {}
}
