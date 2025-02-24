// Feather ignore GM1033
#macro Rand0_SEED 1612
#macro Rand0_MAX 1000
// Haxe-GML:
function TC_Rand0_HxStruct(name) : TC(name) constructor {
	rng = new hxRand0();
	init = function() {;rng.setSeed(Rand0_SEED);}
	fn = function(n) {;repeat (n) rng.float(Rand0_MAX);}
}
function TC_Rand0_HxFlat(name) : TC(name) constructor {
	rng = hx_rand0_create();
	init = function() {;hx_rand0_set_seed(rng, Rand0_SEED);}
	fn = function(n) {;repeat (n) hx_rand0_float(rng, Rand0_MAX);}
}
function TC_Rand0_HxGlobal(name) : TC(name) constructor {
	init = function() {;ghx_rand0_set_seed(Rand0_SEED);}
	fn = function(n) {;repeat (n) ghx_rand0_float(Rand0_MAX);}
}
// C++:
function TC_Rand0_Struct(name) : TC(name) constructor {
	rng = new Rand0();
	init = function() {;rng.setSeed(Rand0_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(Rand0_MAX);
		return r;
	};
}
function TC_Rand0_Flat(name) : TC(name) constructor {
	rng = rand0_create() /*#as Rand0*/;
	init = function() {;rand0_set_seed(rng, Rand0_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rand0_float(rng, Rand0_MAX);
		return r;
	};
}
function TC_Rand0_Unsafe(name) : TC(name) constructor {
	rng = rand0_create()[1];
	init = function() {return rand0_set_seed_raw(rng, Rand0_SEED)};
	fn = function(n) {
		var r = 0;
		repeat (n) r += rand0_float_raw(rng, Rand0_MAX);
		return r;
	};
}
//
function bm_rand0(){
	var tests/*:Array<TC>*/ = [
		new TC_Rand0_HxStruct("GML, struct"),
		new TC_Rand0_HxFlat("GML, flat"),
		new TC_Rand0_HxGlobal("GML, global"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_Rand0_Struct("C++ & GM structs"),
		new TC_Rand0_Flat("C++ & GM arrays"),
		new TC_Rand0_Unsafe("C++ & raw pointers"),
	);
	return new Benchmark("Rand0", tests)
}
function scr_verify_rand0() {
	//
	var cpp = new Rand0();
	cpp.setSeed(_seed);
	var gml = new hxRand0();
	gml.setSeed(_seed);
	trace(gml.state);
	//
	repeat (20) {
		var a, b;
		a = cpp.next();
		b = gml.next();
		trace(a, b);
		verify(a, b);
	}
}