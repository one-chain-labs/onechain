// tests the lint for preferring &mut TxContext over &TxContext in public functions
// these cases correctly should not trigger the lint
module 0x42::true_negative {
    use one::tx_context::TxContext;

    public fun correct_mint(_ctx: &mut TxContext) {
    }

    public fun another_correct(_a: u64, _b: &mut TxContext, _c: u64) {
    }

    fun private_function(_ctx: &TxContext) {
    }

    public fun custom_module(_b: &mut one::mock_tx_context::TxContext) {}


}

module one::tx_context {
    struct TxContext has drop {}
}

module one::mock_tx_context {
    struct TxContext has drop {}
}
