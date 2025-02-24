#pragma once
#include "stdafx.h"
struct MINSTD {
	const uint64_t M = 2147483647;
	const uint64_t A = 48271;
	//
	uint32_t state = 0;
	void init(uint32_t seed) {
		state = seed == 0 ? 1 : seed;
	}
	uint32_t next() {
		state = (uint32_t)(((uint64_t)state * A) % M);
		return state;
	}
	double value() {
		return (double)next() / M;
	}
};