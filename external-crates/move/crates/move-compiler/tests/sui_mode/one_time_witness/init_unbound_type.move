module a::m {
    fun init(_ctx: who::TxContext) {}
}

module a::beep {
    struct BEEP has drop {}
    fun init(_: Who, _ctx: &mut sui::tx_context::TxContext) {}
}

module oct::tx_context {
    struct TxContext {}
}
