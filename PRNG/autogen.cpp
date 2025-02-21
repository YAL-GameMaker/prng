#include "gml_ext.h"
#include "gml_extm.h"
#include "WELL512.h"
extern gml_ptr<WELL512> well512_create();
dllx double well512_create_raw(void* _inout_ptr, double _inout_ptr_size) {
	gml_istream _in(_inout_ptr);
	gml_ptr<WELL512> _result = well512_create();
	gml_ostream _out(_inout_ptr);
	_out.write<int64_t>((intptr_t)_result);
	return 1;
}

extern void well512_destroy(gml_ptr_destroy<WELL512> rng);
dllx double well512_destroy_raw(WELL512* _arg_rng) {
	// no buffer!
	well512_destroy(_arg_rng);
	return 1;
}

extern void well512_set_seed(gml_ptr<WELL512> rng, uint32_t new_seed);
dllx double well512_set_seed_raw(WELL512* _arg_rng, double _arg_new_seed) {
	// no buffer!
	well512_set_seed(_arg_rng, (uint32_t)_arg_new_seed);
	return 1;
}

extern uint32_t well512_uint32(gml_ptr<WELL512> rng);
dllx double well512_uint32_raw(WELL512* _arg_rng) {
	// no buffer!
	return well512_uint32(_arg_rng);
}

extern uint32_t well512_bits(gml_ptr<WELL512> rng, int count);
dllx double well512_bits_raw(WELL512* _arg_rng, double _arg_count) {
	// no buffer!
	return well512_bits(_arg_rng, (int)_arg_count);
}

extern double well512_float(gml_ptr<WELL512> rng, double max);
dllx double well512_float_raw(WELL512* _arg_rng, double _arg_max) {
	// no buffer!
	return well512_float(_arg_rng, _arg_max);
}

extern double well512_float_range(gml_ptr<WELL512> rng, double min, double max);
dllx double well512_float_range_raw(WELL512* _arg_rng, double _arg_min, double _arg_max) {
	// no buffer!
	return well512_float_range(_arg_rng, _arg_min, _arg_max);
}

extern int well512_int(gml_ptr<WELL512> rng, int max);
dllx double well512_int_raw(WELL512* _arg_rng, double _arg_max) {
	// no buffer!
	return well512_int(_arg_rng, (int)_arg_max);
}

extern int well512_int_range(gml_ptr<WELL512> rng, int min, int max);
dllx double well512_int_range_raw(WELL512* _arg_rng, double _arg_min, double _arg_max) {
	// no buffer!
	return well512_int_range(_arg_rng, (int)_arg_min, (int)_arg_max);
}

extern void* yyri_well512_create_raw();
/// yyri_well512_create_raw()->
dllm void yyri_well512_create_raw_yyr(RValue& result, CInstance* self, CInstance* other, int argc, RValue* arg) {
	#define __YYFUNCNAME__ "yyri_well512_create_raw"
	__YYArgCheck(0);
	void* _result = yyri_well512_create_raw();
	__YYResult_void_ptr(_result);
	#undef __YYFUNCNAME__
}

extern void yyri_well512_set_seed(WELL512* rng, uint32_t seed);
/// yyri_well512_set_seed(rng, seed)
dllm void yyri_well512_set_seed_yyr(RValue& result, CInstance* self, CInstance* other, int argc, RValue* arg) {
	#define __YYFUNCNAME__ "yyri_well512_set_seed"
	__YYArgCheck(2);
	WELL512* _arg_rng; __YYArg_WELL512_ptr("rng", _arg_rng, 0);
	uint32_t _arg_seed; __YYArg_uint32_t("seed", _arg_seed, 1);
	yyri_well512_set_seed(_arg_rng, _arg_seed);
	#undef __YYFUNCNAME__
}

extern double yyri_well512_float(WELL512* rng, double _max);
/// yyri_well512_float(rng, _max)->
dllm void yyri_well512_float_yyr(RValue& result, CInstance* self, CInstance* other, int argc, RValue* arg) {
	#define __YYFUNCNAME__ "yyri_well512_float"
	__YYArgCheck(2);
	WELL512* _arg_rng; __YYArg_WELL512_ptr("rng", _arg_rng, 0);
	double _arg__max; __YYArg_double("_max", _arg__max, 1);
	double _result = yyri_well512_float(_arg_rng, _arg__max);
	__YYResult_double(_result);
	#undef __YYFUNCNAME__
}

