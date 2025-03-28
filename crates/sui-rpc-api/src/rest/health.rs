// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use crate::{
    rest::openapi::{ApiEndpoint, OperationBuilder, ResponseBuilder, RouteHandler},
    Result,
    RpcService,
};
use axum::extract::{Query, State};
use documented::Documented;

/// Perform a service health check
///
/// By default the health check only verifies that the latest checkpoint can be fetched from the
/// node's store before returning a 200. Optionally the `threshold_seconds` parameter can be
/// provided to test for how up to date the node needs to be to be considered healthy.
#[derive(Documented)]
pub struct HealthCheck;

impl ApiEndpoint<RpcService> for HealthCheck {
    fn method(&self) -> axum::http::Method {
        axum::http::Method::GET
    }

    fn path(&self) -> &'static str {
        "/-/health"
    }

    fn stable(&self) -> bool {
        true
    }

    fn operation(&self, generator: &mut schemars::gen::SchemaGenerator) -> openapiv3::v3_1::Operation {
        OperationBuilder::new()
            .tag("General")
            .operation_id("Health Check")
            .description(Self::DOCS)
            .query_parameters::<Threshold>(generator)
            .response(200, ResponseBuilder::new().text_content().build())
            .response(500, ResponseBuilder::new().build())
            .build()
    }

    fn handler(&self) -> crate::rest::openapi::RouteHandler<RpcService> {
        RouteHandler::new(self.method(), health)
    }
}

#[derive(Debug, serde::Serialize, serde::Deserialize, schemars::JsonSchema)]
pub struct Threshold {
    /// The threshold, or delta, between the server's system time and the timestamp in the most
    /// recently executed checkpoint for which the server is considered to be healthy.
    ///
    /// If not provided, the server will be considered healthy if it can simply fetch the latest
    /// checkpoint from its store.
    pub threshold_seconds: Option<u32>,
}

async fn health(
    Query(Threshold { threshold_seconds }): Query<Threshold>,
    State(state): State<RpcService>,
) -> Result<()> {
    state.health_check(threshold_seconds)
}
