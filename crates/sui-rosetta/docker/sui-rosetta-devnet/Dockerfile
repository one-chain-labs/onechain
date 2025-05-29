FROM ubuntu:latest AS chef
WORKDIR /one
ARG GIT_REVISION
ENV GIT_REVISION=$GIT_REVISION
RUN apt-get update && apt-get install -y build-essential libssl-dev pkg-config curl cmake clang git ca-certificates
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

FROM chef AS builder
RUN git clone https://github.com/one-chain-labs/onechain .
RUN git checkout devnet

RUN curl -sSfL https://raw.githubusercontent.com/coinbase/rosetta-cli/master/scripts/install.sh | sh -s
RUN curl -fLJO https://github.com/one-chain-labs/sui-genesis/raw/main/devnet/genesis.blob
RUN cargo build --release --bin sui --bin sui-rosetta --bin sui-node

# Production Image
FROM ubuntu:latest AS runtime
WORKDIR /one
RUN apt-get update && apt-get install -y ca-certificates
COPY --from=builder /one/target/release/sui /usr/local/bin
COPY --from=builder /one/target/release/sui-node /usr/local/bin
COPY --from=builder /one/target/release/sui-rosetta /usr/local/bin
COPY --from=builder /one/bin/rosetta-cli /usr/local/bin
COPY --from=builder /one/crates/sui-config/data/fullnode-template.yaml /one/devnet/fullnode.yaml
COPY --from=builder /one/genesis.blob /one/devnet/genesis.blob
RUN /usr/local/bin/sui genesis

ARG BUILD_DATE
LABEL build-date=$BUILD_DATE
LABEL git-revision=$GIT_REVISION
