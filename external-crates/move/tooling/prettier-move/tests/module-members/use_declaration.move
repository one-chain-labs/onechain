// options:
// printWidth: 50
// useModuleLabel: true
// autoGroupImports: module

module prettier::use_declaration;

use one::coin::Coin;
use one::coin::Coin as C;
use one::coin::{Self as c, Coin as C};
use one::coin::very_long_function_name_very_long_function_name as short_name;
use beep::staked_one::StakedOct;

use one::transfer_policy::{Self as policy, TransferPolicy, TransferPolicyCap, TransferRequest};
use one::transfer_policy::TransferPolicyCap as cap;
use one::{
    transfer_policy::{TransferPolicy, TransferPolicyCap, TransferRequest, Kek as KEK},
    transfer_policy::TransferPolicyCap as cap,
};

public use fun my_custom_function_with_a_long_name as TransferPolicyCap.very_long_function_name;

friend has_been::here;

// will break before `as`
public use fun my_custom_function_with_a_long_name
    as TransferPolicyCap.very_long_function_name;
