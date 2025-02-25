// Feather ignore GM1033
#macro Xorshift64_SEED 1612
#macro Xorshift64_MAX 1000
// Haxe-GML:
function TC_Xorshift64_HxStruct(name) : TC(name) constructor {
	rng = new hxXorshift64();
	init = function() {;rng.setSeed(Xorshift64_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(Xorshift64_MAX);
		return r;
	}
}
function TC_Xorshift64_HxFlat(name) : TC(name) constructor {
	rng = hx_xorshift64_create();
	init = function() {;hx_xorshift64_set_seed(rng, Xorshift64_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += hx_xorshift64_float(rng, Xorshift64_MAX);
		return r;
	}
}
function TC_Xorshift64_HxGlobal(name) : TC(name) constructor {
	init = function() {;ghx_xorshift64_set_seed(Xorshift64_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += ghx_xorshift64_float(Xorshift64_MAX);
		return r;
	}
}
// C++:
function TC_Xorshift64_Struct(name) : TC(name) constructor {
	rng = new Xorshift64();
	init = function() {;rng.setSeed(Xorshift64_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(Xorshift64_MAX);
		return r;
	};
}
function TC_Xorshift64_Flat(name) : TC(name) constructor {
	rng = xorshift64_create() /*#as Xorshift64*/;
	init = function() {;xorshift64_set_seed(rng, Xorshift64_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += xorshift64_float(rng, Xorshift64_MAX);
		return r;
	};
}
function TC_Xorshift64_Unsafe(name) : TC(name) constructor {
	rng = xorshift64_create()[1];
	init = function() {return xorshift64_set_seed_raw(rng, Xorshift64_SEED)};
	fn = function(n) {
		var r = 0;
		repeat (n) r += xorshift64_float_raw(rng, Xorshift64_MAX);
		return r;
	};
}
//
function scr_bench_xorshift64(){
	var tests/*:Array<TC>*/ = [
		new TC_Xorshift64_HxStruct("GML, struct"),
		new TC_Xorshift64_HxFlat("GML, flat"),
		new TC_Xorshift64_HxGlobal("GML, global"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_Xorshift64_Struct("C++ & GM structs"),
		new TC_Xorshift64_Flat("C++ & GM arrays"),
		new TC_Xorshift64_Unsafe("C++ & raw pointers"),
	);
	return new Benchmark("Xorshift64", tests)
}
function scr_verify_xorshift64() {
	var xshCpp = new Xorshift64();
	xshCpp.setSeed(500_000);
	var xshHaxe = new hxXorshift64();
	xshHaxe.setSeed(500_000);
	repeat (200) {
		var a, b;
		a = xshCpp.next();
		b = xshHaxe.next();
		verify(a, b);
	}
}