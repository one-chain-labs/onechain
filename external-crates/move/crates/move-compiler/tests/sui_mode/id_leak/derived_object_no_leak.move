// valid because we can use `derived_object::claim` without triggering id leak
module a::m {
  use one::derived_object;
  use one::object;

  struct A has key {
    id: object::UID,
  }

  public fun no_leak(ctx: &mut one::tx_context::TxContext): A {
    A {
      id: derived_object::claim(object::new(ctx), 0),
    }
  }
}

module one::object {
  struct UID has store {
    id: address,
  }

  public fun new(_: &mut one::tx_context::TxContext): UID {
    abort 0
  }
}

module one::tx_context {
  struct TxContext has drop {}
}

module one::derived_object {
  use one::object::UID;

  public fun claim<T: copy + store + drop>(_: UID, _: T): UID {
    abort 0
  }
}
