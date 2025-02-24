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
dllg uint32_t well512_next(gml_ptr<WELL512> rng) {
	return rng->next();
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
dllg double well512_int(gml_ptr<WELL512> rng, double max) {
	auto r = (int64_t)rng->next();
	auto imax = (int64_t)max;
	if (imax == 0) {
		return 0;
	} else if (imax < 0) {
		return (double) -(r % (1i64 - imax));
	} else {
		return (double) (r % (1i64 + imax));
	}
}

// @dllg:method :intRange
dllg double well512_int_range(gml_ptr<WELL512> rng, double min, double max) {
	int64_t start, range;
	if (min < max) {
		start = (int64_t)min;
		range = (int64_t)max - start + 1;
	} else {
		start = (int64_t)max;
		range = (int64_t)min - start + 1;
	}
	int64_t r = rng->next();
	if (range == 0) {
		return 0;
	} else {
		return (double) (start + (r % range));
	}
}

// @dllg:method :intGM
dllg double well512_int_gm(gml_ptr<WELL512> rng, double maxIncl) {
	int64_t low = rng->next();
	int64_t high = rng->next();
	int64_t r = low | ((high & 0x7FffFFff) << 32);
	int64_t max = (int64_t)maxIncl;
	if (max < 0) {
		return (double)(-(r % (1 - max)));
	} else {
		return (double)(r % (1 + max));
	}
}

// @dllg:method :intRangeGM
dllg double well512_int_range_gm(gml_ptr<WELL512> rng, double minIncl, double maxIncl) {
	auto min = (int64_t)minIncl;
	auto max = (int64_t)maxIncl;
	int64_t start, range;
	if (min < max) {
		start = min;
		range = max - min;
	} else {
		start = max;
		range = min - max;
	}
	return (double)start + well512_int_gm(rng, (double)range);
}
