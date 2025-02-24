#include "stdafx.h"
#include "Rand0.h"

/**
@dllg:constructor
function Rand0() constructor {
	var _buf = prng_prepare_buffer(8);
	if (rand0_create_raw(buffer_get_address(_buf), 8)) {
		__ptr__ = ptr(buffer_peek(_buf, 0, buffer_u64));
	} else __ptr__ = pointer_null;
$code
}
*/
dllg gml_ptr<Rand0> rand0_create() {
	return new Rand0();
}

// @dllg:method :destroy
dllg void rand0_destroy(gml_ptr_destroy<Rand0> rng) {
	delete rng;
}

// @dllg:method :setSeed
dllg void rand0_set_seed(gml_ptr<Rand0> rng, uint32_t new_seed) {
	rng->init(new_seed);
}

// @dllg:method :next
dllg uint32_t rand0_next(gml_ptr<Rand0> rng) {
	return rng->next();
}

// @dllg:method :float
dllg double rand0_float(gml_ptr<Rand0> rng, double max) {
	return rng->value() * max;
}

// @dllg:method :floatRange
dllg double rand0_float_range(gml_ptr<Rand0> rng, double min, double max) {
	return min + rng->value() * (max - min);
}

// @dllg:method :int
dllg double rand0_int(gml_ptr<Rand0> rng, double max) {
	return (double)(int64_t)(rng->value() * (double)((int64_t)max + 1i64));
}

// @dllg:method :intRange
dllg double rand0_int_range(gml_ptr<Rand0> rng, double min, double max) {
	int64_t start, range;
	if (min < max) {
		start = (int64_t)min;
		range = (int64_t)max - start + 1;
	} else {
		start = (int64_t)max;
		range = (int64_t)min - start + 1;
	}
	return (double)(start + (int64_t)(rng->value() * range));
}
