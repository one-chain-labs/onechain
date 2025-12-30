// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use sui_types::error::ExecutionError;

use crate::{
    execution_mode::ExecutionMode,
    static_programmable_transactions::{env, loading::ast as L},
};

pub mod ast;
pub mod translate;
pub mod verify;

pub fn translate_and_verify<Mode: ExecutionMode>(
    env: &env::Env,
    lt: L::Transaction,
) -> Result<ast::Transaction, ExecutionError> {
    let mut ast = translate::transaction(env, lt)?;
    verify::transaction::<Mode>(env, &mut ast)?;
    Ok(ast)
}
