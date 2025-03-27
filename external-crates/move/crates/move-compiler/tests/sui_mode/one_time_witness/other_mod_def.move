// invalid, one-time witness type candidate used in a different module

module a::n {
    use sui::oct;
    use sui::tx_context;

    fun init(_otw: oct::OCT, _ctx: &mut tx_context::TxContext) {
    }

}


module sui::tx_context {
    struct TxContext has drop {}
}

module sui::oct {
    struct OCT has drop {}
}
