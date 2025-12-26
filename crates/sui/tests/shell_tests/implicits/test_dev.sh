# Copyright (c) Mysten Labs, Inc.
# SPDX-License-Identifier: Apache-2.0

# checks that testing a package with `--dev` that implicitly depends on `Bridge` works
one move test -p example --dev 2> /dev/null
