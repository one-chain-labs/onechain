// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module type_params::m3 {
    use one::transfer;

    public entry fun transfer_object<T: key + store>(o: T, recipient: address) {
        transfer::public_transfer(o, recipient);
    }


}
