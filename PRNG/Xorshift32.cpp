#include "stdafx.h"
#include "XorShift32.h"

/**
@dllg:constructor
function Xorshift32() constructor {
	var _buf = prng_prepare_buffer(8);
	if (xorshift32_create_raw(buffer_get_address(_buf), 8)) {
		__ptr__ = ptr(buffer_peek(_buf, 0, buffer_u64));
	} else __ptr__ = pointer_null;
$code
	static save = function(_buf) {
		if (self.__ptr__ == pointer_null) { show_error("This Xorshift32 is destroyed.", true); exit; }
		var _pos = buffer_tell(_buf);
		buffer_write(_buf, buffer_u32, 0);
		xorshift32_save_raw(self.__ptr__, buffer_get_address(_buf), _pos);
	}
	static load = function(_buf) {
		if (self.__ptr__ == pointer_null) { show_error("This Xorshift32 is destroyed.", true); exit; }
		buffer_seek(_buf, buffer_seek_relative,
			xorshift32_load_raw(self.__ptr__, buffer_get_address(_buf), buffer_tell(_buf))
		);
	}
}
*/
dllg gml_ptr<Xorshift32> xorshift32_create() {
	return new Xorshift32();
}

// @dllg:method :destroy
dllg void xorshift32_destroy(gml_ptr_destroy<Xorshift32> rng) {
	delete rng;
}

// @dllg:method :setSeed
dllg void xorshift32_set_seed(gml_ptr<Xorshift32> rng, uint32_t new_seed) {
	rng->init(new_seed);
}

dllx double xorshift32_save_raw(Xorshift32* rng, uint8_t* buf, double pos) {
	gml_ostream s(buf + (int)pos);
	s.write<uint32_t>(rng->state);
	return 1;
}
dllx double xorshift32_load_raw(Xorshift32* rng, uint8_t* buf, double pos) {
	gml_istream s(buf + (int)pos);
	rng->state = s.read<uint32_t>();
	return 4;
}

// @dllg:method :next
dllg uint32_t xorshift32_next(gml_ptr<Xorshift32> rng) {
	return rng->next();
}

// @dllg:method :float
dllg double xorshift32_float(gml_ptr<Xorshift32> rng, double max) {
	return rng->value() * max;
}

// @dllg:method :floatRange
dllg double xorshift32_float_range(gml_ptr<Xorshift32> rng, double min, double max) {
	return min + rng->value() * (max - min);
}

// @dllg:method :int
dllg double xorshift32_int(gml_ptr<Xorshift32> rng, double max) {
	int64_t r = rng->next();
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
dllg double xorshift32_int_range(gml_ptr<Xorshift32> rng, double min, double max) {
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
		return (double)(start + (r % range));
	}
}
