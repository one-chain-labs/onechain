module one::coin_vesting;

use one::balance::{Self, Balance};
use one::coin;

public struct CoinVesting<phantom T> has key, store {
    id: UID,
    total: u64,
    /// Waiting for collection balance
    balance: Balance<T>,
    /// Start time
    start_epoch: u64,
    /// Cooling-off period
    cliff_interval_epoch: u64,
    ///
    last_release_epoch: u64,
    ///
    vesting_interval_epoch: u64,
    ///
    vesting_internal_release: u64,
}

public fun new_form_balance<T>(
    balance: Balance<T>,
    start_epoch: u64,
    cliff_interval_epoch: u64,
    vesting_interval_epoch: u64,
    period: u64,
    ctx: &mut TxContext,
): CoinVesting<T> {
    let vesting_internal_release = balance.value()/ period;

    CoinVesting {
        id: object::new(ctx),
        total: balance.value(),
        balance,
        start_epoch,
        last_release_epoch: 0,
        cliff_interval_epoch,
        vesting_interval_epoch,
        vesting_internal_release,
    }
}

public entry fun release<T>(self: &mut CoinVesting<T>, ctx: &mut TxContext){
    let withdraw = self.release_non_entry(ctx);
    if(withdraw.value() > 0){
        transfer::public_transfer(coin::from_balance(withdraw,ctx),ctx.sender());
    }else {
        withdraw.destroy_zero();
    };
}

public fun release_non_entry<T>(self: &mut CoinVesting<T>, ctx: &TxContext): Balance<T> {
    let current_epoch = ctx.epoch();
    if (self.last_release_epoch == 0) {
        self.last_release_epoch = self.start_epoch + self.cliff_interval_epoch;
    };

    let mut withdraw = balance::zero<T>();

    while (self.last_release_epoch + self.vesting_interval_epoch <= current_epoch) {
        self.last_release_epoch = self.last_release_epoch + self.vesting_interval_epoch;

        if (self.balance.value() <= self.vesting_internal_release) {
            let value = self.balance.value();
            withdraw.join(self.balance.split(value));
            return withdraw
        } else {
            let value = self.vesting_internal_release;
            withdraw.join(self.balance.split(value));
        };
    };

    withdraw
}

public fun destroy_zero<T>(self: CoinVesting<T>) {
    assert!(self.balance.value() == 0, 0);
    let CoinVesting {
        id,
        total: _,
        balance,
        start_epoch: _,
        cliff_interval_epoch: _,
        last_release_epoch: _,
        vesting_interval_epoch: _,
        vesting_internal_release: _,
    } = self;
    id.delete();
    balance.destroy_zero();
}
