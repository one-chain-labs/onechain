// object is re shared, but it is never transferred and doesn't have public transfer
module a::is_not_transferred {
    use one::transfer;
    use one::tx_context::TxContext;
    use one::object::UID;

    struct Obj has key {
        id: UID
    }

    public fun make_obj(ctx: &mut TxContext): Obj {
        Obj { id: one::object::new(ctx) }
    }

    public fun crate(ctx: &mut TxContext) {
        transfer::share_object(make_obj(ctx));
    }

    public fun share(o: Obj) {
        transfer::share_object(o);
    }
}

// object is created locally, even though it is transferred somewhere else and has public share
module a::can_determine_to_be_new {
    use one::transfer;
    use one::object::UID;

    struct Obj has key, store {
        id: UID
    }

    fun make_obj(_: u64, _: vector<vector<u8>>, ctx: &mut one::tx_context::TxContext): Obj {
        Obj { id: one::object::new(ctx) }
    }

    public fun transfer(ctx: &mut one::tx_context::TxContext) {
        let o = make_obj(0, vector[], ctx);
        transfer::transfer(o, @0);
    }

    public fun share(ctx: &mut one::tx_context::TxContext) {
        let o = make_obj(0, vector[], ctx);
        transfer::share_object(o);
    }
}


// object is created locally, but the analysis cannot determine that currently
module b::can_determine_to_be_new_with_struct {
    use one::transfer;
    use one::object::UID;

    struct Obj has key {
        id: UID
    }

    struct X<phantom T> has drop {}

    fun make_obj<T>(_: X<T>, ctx: &mut one::tx_context::TxContext): Obj {
        Obj { id: one::object::new(ctx) }
    }

    public fun transfer(ctx: &mut one::tx_context::TxContext) {
        let o = make_obj(X<Obj> {}, ctx);
        transfer::transfer(o, one::tx_context::sender(ctx));
    }

    public fun share(ctx: &mut one::tx_context::TxContext) {
        let o = make_obj(X<Obj> {}, ctx);
        transfer::share_object(o);
    }
}



module one::tx_context {
    struct TxContext has drop {}
    public fun sender(_: &TxContext): address {
        @0
    }
}

module one::object {
    const ZERO: u64 = 0;
    struct UID has store {
        id: address,
    }
    public fun delete(_: UID) {
        abort ZERO
    }
    public fun new(_: &mut one::tx_context::TxContext): UID {
        abort ZERO
    }
}

module one::transfer {
    const ZERO: u64 = 0;
    public fun transfer<T: key>(_: T, _: address) {
        abort ZERO
    }
    public fun share_object<T: key>(_: T) {
        abort ZERO
    }
    public fun public_share_object<T: key>(_: T) {
        abort ZERO
    }
}
