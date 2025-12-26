# Copyright (c) Mysten Labs, Inc.
# SPDX-License-Identifier: Apache-2.0

# tests that one move new followed by one move disassemble succeeds


one move new example
cat > example/sources/example.move <<EOF
module example::example;

public fun foo(_ctx: &mut TxContext) {}
EOF
cd example

echo "=== Build ===" | tee /dev/stderr
one move build

echo "=== Disassemble ===" | tee /dev/stderr
one move disassemble build/example/bytecode_modules/example.mv
