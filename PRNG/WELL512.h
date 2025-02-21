#pragma once
#include "stdafx.h"
struct WELL512 {
	uint32_t state[16]{};
	uint32_t index = 0;
	void init(uint32_t seed) {
		auto s = seed;
		for (auto i = 0u; i < 16; i++) {
			s = (((s * 214013 + 2531011) >> 16) & 0x7fff'ffff);
			state[i] = s;
		}
		index = 0;
	}
	uint32_t next() {
		unsigned long a, b, c, d;
		a = state[index];
		c = state[(index + 13) & 15];
		b = a ^ c ^ (a << 16) ^ (c << 15);
		c = state[(index + 9) & 15];
		c ^= (c >> 11);
		state[index] = a = b ^ c;
		d = a ^ ((a << 5) & 0xDA442D24UL);
		index = (index + 15) & 15;
		a = state[index];
		state[index] = a = a ^ b ^ d ^ (a << 2) ^ (b << 18) ^ (c << 28);
		return a;
	}
	double value() {
		return ((double)next() / (double)(1i64 << 32));
	}
};