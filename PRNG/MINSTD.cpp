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
	static save = function(_buf) {
		if (self.__ptr__ == pointer_null) { show_error("This MINSTD is destroyed.", true); exit; }
		var _pos = buffer_tell(_buf);
		buffer_write(_buf, buffer_u32, 0);
		minstd_save_raw(self.__ptr__, buffer_get_address(_buf), _pos);
	}
	static load = function(_buf) {
		if (self.__ptr__ == pointer_null) { show_error("This MINSTD is destroyed.", true); exit; }
		buffer_seek(_buf, buffer_seek_relative,
			minstd_load_raw(self.__ptr__, buffer_get_address(_buf), buffer_tell(_buf))
		);
	}
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

dllx double minstd_save_raw(MINSTD* rng, uint8_t* buf, double pos) {
	gml_ostream s(buf + (int)pos);
	s.write<uint32_t>(rng->state);
	return 1;
}
dllx double minstd_load_raw(MINSTD* rng, uint8_t* buf, double pos) {
	gml_istream s(buf + (int)pos);
	rng->state = s.read<uint32_t>();
	return 4;
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
