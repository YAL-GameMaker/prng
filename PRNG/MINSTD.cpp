#include "stdafx.h"
#include "MINSTD.h"

/**
@dllg:constructor
function MINSTD() constructor {
	var _buf = prng_prepare_buffer(8);
	if (minstd_create_raw(buffer_get_address(_buf), 8)) {
		__ptr__ = ptr(buffer_peek(_buf, 0, buffer_u64));
	} else __ptr__ = pointer_null;
$code
}
*/
dllg gml_ptr<MINSTD> minstd_create() {
	return new MINSTD();
}

// @dllg:method :destroy
dllg void minstd_destroy(gml_ptr_destroy<MINSTD> rng) {
	delete rng;
}

// @dllg:method :setSeed
dllg void minstd_set_seed(gml_ptr<MINSTD> rng, uint32_t new_seed) {
	rng->init(new_seed);
}

// @dllg:method :next
dllg uint32_t minstd_next(gml_ptr<MINSTD> rng) {
	return rng->next();
}

// @dllg:method :float
dllg double minstd_float(gml_ptr<MINSTD> rng, double max) {
	return rng->value() * max;
}

// @dllg:method :floatRange
dllg double minstd_float_range(gml_ptr<MINSTD> rng, double min, double max) {
	return min + rng->value() * (max - min);
}

// @dllg:method :int
dllg double minstd_int(gml_ptr<MINSTD> rng, double max) {
	return (double)(int64_t)(rng->value() * (double)((int64_t)max + 1i64));
}

// @dllg:method :intRange
dllg double minstd_int_range(gml_ptr<MINSTD> rng, double min, double max) {
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
