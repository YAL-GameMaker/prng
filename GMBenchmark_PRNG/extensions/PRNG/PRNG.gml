#define prng_init
//#init prng_init
/// ()~
if (variable_global_exists("__prng_ready")) return;
global.__prng_ready = true;
global.__ptrt_WELL512 = ["PRNG/WELL512"];
global.__ptrt_MINSTD = ["PRNG/MINSTD"];
global.__ptrt_Xorshift64 = ["PRNG/Xorshift64"];
global.__ptrt_Rand0 = ["PRNG/Rand0"];

/*
var _ctx = { _things: [] };
var _fptr = method(_ctx, (_func) => {
   var _method = method(undefined, _func);
   array_push(_things, _method);
   return ptr(_method);
});
var _qptr = method(_ctx, (_struct) => {
	array_push(_things, _struct);
	return ptr(_struct);
});

//
//show_message("!");
var _f1 = () => { return 1; };
var _result = prng_init_1(_fptr(is_bool), _fptr(is_bool), ptr(_f1), ptr(_f1));
if (_result == 0) {
	show_debug_message("[PRNG] Native extension isn't loaded!");
	return false;
}
if (_result < 0) {
	show_debug_message("[PRNG] Failed to resolve method offset (incompatible runtime?)");
	return false;
}

prng_init_array([1, 2], [3, 4, 5], [6, 7, 8, 9]);

prng_init_protos(global.__ptrt_WELL512);

show_debug_message("[PRNG] native bits by YellowAfterlife")
*/

#define prng_prepare_buffer
/// (size:int)->buffer~
var _size = argument0;
gml_pragma("forceinline");
gml_pragma("global", "global.__PRNG_buffer = undefined");
var _buf = global.__PRNG_buffer;
if (_buf == undefined) {
    _buf = buffer_create(_size, buffer_grow, 1);
    global.__PRNG_buffer = _buf;
} else if (buffer_get_size(_buf) < _size) {
    buffer_resize(_buf, _size);
}
buffer_seek(_buf, buffer_seek_start, 0);
return _buf;

#define minstd_save
/// (rng, buffer)
if (argument0[0] != global.__ptrt_MINSTD) { show_error("Expected a MINSTD, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This MINSTD is destroyed.", true); exit; }
var _pos = buffer_tell(argument1);
buffer_write(argument1, buffer_u32, 0);
minstd_save_raw(argument0[1], buffer_get_address(argument1), _pos);

#define minstd_load
/// (rng, buffer)
if (argument0[0] != global.__ptrt_MINSTD) { show_error("Expected a MINSTD, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This MINSTD is destroyed.", true); exit; }
buffer_seek(argument1, buffer_seek_relative,
	minstd_load_raw(argument0[1], buffer_get_address(argument1), buffer_tell(argument1))
);

#define rand0_save
/// (rng, buffer)
if (argument0[0] != global.__ptrt_Rand0) { show_error("Expected a Rand0, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This Rand0 is destroyed.", true); exit; }
var _pos = buffer_tell(argument1);
buffer_write(argument1, buffer_u32, 0);
rand0_save_raw(argument0[1], buffer_get_address(argument1), _pos);

#define rand0_load
/// (rng, buffer)
if (argument0[0] != global.__ptrt_Rand0) { show_error("Expected a Rand0, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This Rand0 is destroyed.", true); exit; }
buffer_seek(argument1, buffer_seek_relative,
	rand0_load_raw(argument0[1], buffer_get_address(argument1), buffer_tell(argument1))
);

#define xorshift64_save
/// (rng, buffer)
if (argument0[0] != global.__ptrt_Xorshift64) { show_error("Expected a Xorshift64, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This Xorshift64 is destroyed.", true); exit; }
var _pos = buffer_tell(argument1);
buffer_write(argument1, buffer_u64, 0);
xorshift64_save_raw(argument0[1], buffer_get_address(argument1), _pos);

#define xorshift64_load
/// (rng, buffer)
if (argument0[0] != global.__ptrt_Xorshift64) { show_error("Expected a Xorshift64, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This Xorshift64 is destroyed.", true); exit; }
buffer_seek(argument1, buffer_seek_relative,
	xorshift64_load_raw(argument0[1], buffer_get_address(argument1), buffer_tell(argument1))
);

#define well512_save
/// (rng, buffer)
if (argument0[0] != global.__ptrt_WELL512) { show_error("Expected a WELL512, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This WELL512 is destroyed.", true); exit; }
var _pos = buffer_tell(argument1);
buffer_write(argument1, buffer_u32, 0);
repeat (8) buffer_write(argument1, buffer_u64, 0);
well512_save_raw(argument0[1], buffer_get_address(argument1), _pos);

#define well512_load
/// (rng, buffer)
if (argument0[0] != global.__ptrt_WELL512) { show_error("Expected a WELL512, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This WELL512 is destroyed.", true); exit; }
buffer_seek(argument1, buffer_seek_relative,
	well512_load_raw(argument0[1], buffer_get_address(argument1), buffer_tell(argument1))
);