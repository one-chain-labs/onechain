// valid init function
module a::m {
    use one::tx_context;
    fun init(_: &mut tx_context::TxContext) {
    }
}

module oct::tx_context {
    struct TxContext has drop {}
}
