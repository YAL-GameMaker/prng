#pragma once
#include "stdafx.h"

struct Rand0 {
	const uint32_t mask = 0x7fffffff;
	const double div = mask + 1;
	//
	uint32_t state = 0;
	void init(uint32_t seed) {
		state = seed == 0 ? 1 : seed;
	}
	uint32_t next() {
		state = ((state * 1103515245U) + 12345U) & mask;
		return state;
	}
	double value() {
		return (double)next() / div;
	}
};