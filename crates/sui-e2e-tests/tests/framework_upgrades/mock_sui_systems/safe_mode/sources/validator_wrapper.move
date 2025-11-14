// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module oct_system::validator_wrapper {
    use one::versioned::Versioned;

    public struct ValidatorWrapper has store {
        inner: Versioned
    }
}
