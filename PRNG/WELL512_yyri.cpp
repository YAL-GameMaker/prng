#include "stdafx.h"
#include "WELL512.h"

dllgm void* yyri_well512_create_raw() {
	return new WELL512();
}
dllgm void yyri_well512_set_seed(WELL512* rng, uint32_t seed) {
	rng->init(seed);
}
dllgm double yyri_well512_float(WELL512* rng, double _max) {
	return rng->value() * _max;
}