#include "stdafx.h"
#include "XorShift64.h"

/**
@dllg:constructor
function Xorshift64() constructor {
	var _buf = prng_prepare_buffer(8);
	if (xorshift64_create_raw(buffer_get_address(_buf), 8)) {
		__ptr__ = ptr(buffer_peek(_buf, 0, buffer_u64));
	} else __ptr__ = pointer_null;
$code
}
*/
dllg gml_ptr<Xorshift64> xorshift64_create() {
	return new Xorshift64();
}

// @dllg:method :destroy
dllg void xorshift64_destroy(gml_ptr_destroy<Xorshift64> rng) {
	delete rng;
}

// @dllg:method :setSeed
dllg void xorshift64_set_seed(gml_ptr<Xorshift64> rng, uint32_t new_seed) {
	rng->init(new_seed);
}

// @dllg:method :next
dllg uint64_t xorshift64_next(gml_ptr<Xorshift64> rng) {
	return rng->next();
}

// @dllg:method :float
dllg double xorshift64_float(gml_ptr<Xorshift64> rng, double max) {
	return rng->value() * max;
}

// @dllg:method :floatRange
dllg double xorshift64_float_range(gml_ptr<Xorshift64> rng, double min, double max) {
	return min + rng->value() * (max - min);
}

// @dllg:method :int
dllg double xorshift64_int(gml_ptr<Xorshift64> rng, double max) {
	auto r = rng->next63();
	auto imax = (int64_t)max;
	if (imax == 0) {
		return 0;
	} else if (imax < 0) {
		return (double)-(r % (1i64 - imax));
	} else {
		return (double)(r % (1i64 + imax));
	}
}

// @dllg:method :intRange
dllg double xorshift64_int_range(gml_ptr<Xorshift64> rng, double min, double max) {
	int64_t start, range;
	if (min < max) {
		start = (int64_t)min;
		range = (int64_t)max - start + 1;
	} else {
		start = (int64_t)max;
		range = (int64_t)min - start + 1;
	}
	auto r = rng->next63();
	if (range == 0) {
		return 0;
	} else {
		return (double)(start + (r % range));
	}
}
