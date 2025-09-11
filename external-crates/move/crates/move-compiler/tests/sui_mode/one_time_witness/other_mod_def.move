// invalid, one-time witness type candidate used in a different module

module a::n {
    use oct::oct;
    use sui::tx_context;

    fun init(_otw: oct::OCT, _ctx: &mut tx_context::TxContext) {
    }

}


module oct::tx_context {
    struct TxContext has drop {}
}

module oct::oct {
    struct SUI has drop {}
}
