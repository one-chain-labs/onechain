// init must have & or &mut one::tx_context::TxContext as first argument
module a::m1 {
    fun init(_: u64) {
        abort 0
    }
}

module a::tx_context {
    struct TxContext { value: u64 }
    fun init(_: TxContext) {
        abort 0
    }
}

module a::m2 {
    use one::tx_context;
    fun init(_: tx_context::TxContext) {
        abort 0
    }
}

module one::tx_context {
    struct TxContext has drop {}
}
