#pragma once
#include "stdafx.h"

struct Xorshift32 {
	uint32_t state;
	void init(uint32_t seed) {
		state = seed != 0 ? seed : 1;
	}
	uint32_t next() {
		#define dump(n) // trace("%d: %x", n, state)
		dump(0);
		state ^= state << 13;
		dump(1);
		state ^= state >> 17;
		dump(2);
		state ^= state << 5;
		dump(3);
		return state;
	}
	double value() {
		return state / (double)(0xFFFF'FFFF);
	}
};