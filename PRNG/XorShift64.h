#pragma once
#include "stdafx.h"

struct Xorshift64 {
	uint64_t state;
	void init(uint64_t seed) {
		state = seed != 0 ? seed : 1;
	}
	uint64_t next() {
		//trace("C0: %llx", state);
		state ^= state << 13;
		//trace("C1: %llx %llx", state, state >> 7);
		state ^= state >> 7;
		//trace("C2: %llx", state);
		state ^= state << 17;
		//trace("C3: %llx", state);
		return state;
	}
	int64_t next63() {
		return (int64_t)(next() & 0x7FFF'FFFF'FFFF'FFFF);
	}
	double value() {
		constexpr uint64_t max = (1i64 << 53);
		constexpr uint64_t mask = max - 1;
		auto bits = (double)(next() & mask);
		return bits / (double)max;
	}
};