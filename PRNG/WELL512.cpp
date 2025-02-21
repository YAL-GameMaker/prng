#include "stdafx.h"
#include "WELL512.h"

/**
@dllg:constructor
function WELL512() constructor {
	var _buf = prng_prepare_buffer(8);
	if (well512_create_raw(buffer_get_address(_buf), 8)) {
		__ptr__ = ptr(buffer_peek(_buf, 0, buffer_u64));
	} else __ptr__ = pointer_null;
$code

	/// @param ...values
	static pick = function() {
		return argument[0 | float(argument_count)];
	}
}
*/
dllg gml_ptr<WELL512> well512_create() {
	return new WELL512();
}

// @dllg:method :destroy
dllg void well512_destroy(gml_ptr_destroy<WELL512> rng) {
	delete rng;
}

// @dllg:method :setSeed
dllg void well512_set_seed(gml_ptr<WELL512> rng, uint32_t new_seed) {
	rng->init(new_seed);
}

// @dllg:method :uint32
dllg uint32_t well512_uint32(gml_ptr<WELL512> rng) {
	return rng->next();
}

// @dllg:method :bits
dllg uint32_t well512_bits(gml_ptr<WELL512> rng, int count) {
	return rng->next() >> (32 - count);
}

// @dllg:method :float
dllg double well512_float(gml_ptr<WELL512> rng, double max) {
	return rng->value() * max;
}

// @dllg:method :floatRange
dllg double well512_float_range(gml_ptr<WELL512> rng, double min, double max) {
	return min + rng->value() * (max - min);
}

// @dllg:method :int
dllg int well512_int(gml_ptr<WELL512> rng, int max) {
	return (int)(rng->value() * (max + 1));
}

// @dllg:method :intRange
dllg int well512_int_range(gml_ptr<WELL512> rng, int min, int max) {
	int start, range;
	if (min < max) {
		start = min;
		range = max - min + 1;
	} else {
		start = max;
		range = min - max + 1;
	}
	return start + (int)(rng->value() * range);
}