module oct::object {
    public struct ID()
    public struct UID()
}
module oct::transfer {}
module oct::tx_context {
    public struct TxContext()
}

module a::m {
    use one::object::{Self, ID, UID};
    use one::transfer;
    use one::tx_context::{Self, TxContext};
}
