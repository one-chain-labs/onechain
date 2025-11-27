// invalid, one-time witness type candidate used in a different module

module a::n {
    use one::sui;
    use one::tx_context;

    fun init(_otw: oct::OCT, _ctx: &mut tx_context::TxContext) {
    }

}


module one::tx_context {
    struct TxContext has drop {}
}

module one::sui {
    struct SUI has drop {}
}
