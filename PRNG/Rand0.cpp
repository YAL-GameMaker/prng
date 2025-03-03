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
	static save = function(_buf) {
		if (self.__ptr__ == pointer_null) { show_error("This Rand0 is destroyed.", true); exit; }
		var _pos = buffer_tell(_buf);
		buffer_write(_buf, buffer_u32, 0);
		rand0_save_raw(self.__ptr__, buffer_get_address(_buf), _pos);
	}
	static load = function(_buf) {
		if (self.__ptr__ == pointer_null) { show_error("This Rand0 is destroyed.", true); exit; }
		buffer_seek(_buf, buffer_seek_relative,
			rand0_load_raw(self.__ptr__, buffer_get_address(_buf), buffer_tell(_buf))
		);
	}
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

dllx double rand0_save_raw(Rand0* rng, uint8_t* buf, double pos) {
	gml_ostream s(buf + (int)pos);
	s.write<uint32_t>(rng->state);
	return 1;
}
dllx double rand0_load_raw(Rand0* rng, uint8_t* buf, double pos) {
	gml_istream s(buf + (int)pos);
	rng->state = s.read<uint32_t>();
	return 4;
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
