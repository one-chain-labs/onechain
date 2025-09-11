module oct::object {
    public struct ID()
    public struct UID()
}
module oct::transfer {}
module oct::tx_context {
    public struct TxContext()
}

module a::m {
    use sui::object::{Self, ID, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
}
