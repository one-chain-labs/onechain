// init is unused but does not error because we are in Sui mode
module a::m {
    fun init(_: &mut one::tx_context::TxContext) {}
}

module one::tx_context {
    struct TxContext has drop {}
}
