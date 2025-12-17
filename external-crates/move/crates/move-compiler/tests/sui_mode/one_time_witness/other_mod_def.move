// invalid, one-time witness type candidate used in a different module

module a::n {
    use oct::OCT;
    use one::tx_context;

    fun init(_otw: one::OCT, _ctx: &mut tx_context::TxContext) {
    }

}


module one::tx_context {
    struct TxContext has drop {}
}

module oct::OCT {
    struct SUI has drop {}
}
