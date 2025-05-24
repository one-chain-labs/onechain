// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

import type { DelegatedStake } from '@mysten/sui/client';

// Helper function to get the delegation by stakedOctId
export const getDelegationDataByStakeId = (
	delegationsStake: DelegatedStake[],
	stakeSuiId: string,
) => {
	let stake = null;
	for (const { stakes } of delegationsStake) {
		stake = stakes.find(({ stakedOctId }) => stakedOctId === stakeSuiId) || null;
		if (stake) return stake;
	}

	return stake;
};
