// correct, wrong struct field type but not one-time witness candidate

module a::m {
    use one::tx_context;

    struct M has store, drop { value: u64 }

    fun init(_ctx: &mut tx_context::TxContext) {
    }

    fun foo() {
        _ = M { value: 7 };
        _ = M { value: 42 };
    }
}

module 0::beep {
  struct BEEP has store { boop: one::table::Table<u8, bool> }
}

module one::tx_context {
    struct TxContext has drop {}
}
module one::table {
    struct Table<phantom K, phantom V> has store {}
}
