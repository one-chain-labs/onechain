# Copyright (c) Mysten Labs, Inc.
# SPDX-License-Identifier: Apache-2.0

one client --client.config config.yaml switch --env base

one client --client.config config.yaml envs
one client --client.config config.yaml --client.env one envs
one client --client.config config.yaml --client.env two envs

one client --client.config config.yaml active-env
one client --client.config config.yaml --client.env one active-env
one client --client.config config.yaml --client.env two active-env

# Unknown name -- Should give you None and nothing active
one client --client.config config.yaml --client.env not_an_env envs
one client --client.config config.yaml --client.env not_an_env active-env
