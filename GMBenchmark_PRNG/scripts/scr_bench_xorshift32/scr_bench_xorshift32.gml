// Feather ignore GM1033
#macro Xorshift32_SEED 1612
#macro Xorshift32_MAX 1000
// Haxe-GML:
function TC_Xorshift32_HxStruct(name) : TC(name) constructor {
	rng = new hxXorshift32();
	init = function() {;rng.setSeed(Xorshift32_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(Xorshift32_MAX);
		return r;
	}
}
function TC_Xorshift32_HxFlat(name) : TC(name) constructor {
	rng = hx_xorshift32_create();
	init = function() {;hx_xorshift32_set_seed(rng, Xorshift32_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += hx_xorshift32_float(rng, Xorshift32_MAX);
		return r;
	}
}
function TC_Xorshift32_HxGlobal(name) : TC(name) constructor {
	init = function() {;ghx_xorshift32_set_seed(Xorshift32_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += ghx_xorshift32_float(Xorshift32_MAX);
		return r;
	}
}
// C++:
function TC_Xorshift32_Struct(name) : TC(name) constructor {
	rng = new Xorshift32();
	init = function() {;rng.setSeed(Xorshift32_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(Xorshift32_MAX);
		return r;
	};
}
function TC_Xorshift32_Flat(name) : TC(name) constructor {
	rng = xorshift32_create() /*#as Xorshift32*/;
	init = function() {;xorshift32_set_seed(rng, Xorshift32_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += xorshift32_float(rng, Xorshift32_MAX);
		return r;
	};
}
function TC_Xorshift32_Unsafe(name) : TC(name) constructor {
	rng = xorshift32_create()[1];
	init = function() {return xorshift32_set_seed_raw(rng, Xorshift32_SEED)};
	fn = function(n) {
		var r = 0;
		repeat (n) r += xorshift32_float_raw(rng, Xorshift32_MAX);
		return r;
	};
}
//
function scr_bench_xorshift32(){
	var tests/*:Array<TC>*/ = [
		new TC_Xorshift32_HxStruct("GML, struct"),
		new TC_Xorshift32_HxFlat("GML, flat"),
		new TC_Xorshift32_HxGlobal("GML, global"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_Xorshift32_Struct("C++ & GM structs"),
		new TC_Xorshift32_Flat("C++ & GM arrays"),
		new TC_Xorshift32_Unsafe("C++ & raw pointers"),
	);
	return new Benchmark("Xorshift32", tests)
}
function scr_verify_xorshift32() {
	var _seed = 500_000;
	var xshCpp = new Xorshift32();
	xshCpp.setSeed(_seed);
	var xshHaxe = new hxXorshift32();
	xshHaxe.setSeed(_seed);
	m_xorshift32_start(_seed);
	for (var step = 0; step < 200; step++) {
		var a, b, c;
		a = xshCpp.next();
		b = xshHaxe.next();
		m_xorshift32_next;
		c = m_xorshift32_var;
		verify(a, b, c);
	}
	//
	if (os_has_dlls) scr_verify_cpp_io(
		new Xorshift32(),
		xorshift32_create(),
		Xorshift32_SEED,
		function(q, s) {;xorshift32_set_seed(q, s)},
		function(q) {return xorshift32_next(q)},
		function(q, b) {;xorshift32_save(q, b)},
		function(q, b) {;xorshift32_load(q, b)}
	)
}