#macro WELL512_SEED 1612
#macro WELL512_MIN 378
#macro WELL512_MAX 1234

function TC_WELL512_GM(name) : TC(name) constructor {
	init = function() {;random_set_seed(WELL512_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += random(WELL512_MAX);
		return r;
	};
}
// Haxe-GML:
function TC_WELL512_HxStruct(name) : TC(name) constructor {
	rng = new hxWELL512();
	init = function() {;rng.setSeed(WELL512_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(WELL512_MAX);
		return r;
	};
}
function TC_WELL512_HxFlat(name) : TC(name) constructor {
	rng = hx_well512_create();
	init = function() {;hx_well512_set_seed(rng, WELL512_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += hx_well512_float(rng, WELL512_MAX);
		return r;
	};
}
function TC_WELL512_HxGlobal(name) : TC(name) constructor {
	init = function() {;ghx_well512_set_seed(WELL512_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += ghx_well512_float(WELL512_MAX);
		return r;
	};
}
// C++:
function TC_WELL512_Struct(name) : TC(name) constructor {
	rng = new WELL512();
	init = function() {;rng.setSeed(WELL512_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(WELL512_MAX);
		return r;
	};
}
function TC_WELL512_Flat(name) : TC(name) constructor {
	rng = well512_create() /*#as WELL512*/;
	init = function() {;well512_set_seed(rng, WELL512_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += well512_float(rng, WELL512_MAX);
		return r;
	};
}
function TC_WELL512_Unsafe(name) : TC(name) constructor {
	rng = well512_create()[1];
	init = function() {return well512_set_seed_raw(rng, WELL512_SEED)};
	fn = function(n) {
		var r = 0;
		repeat (n) r += well512_float_raw(rng, WELL512_MAX);
		return r;
	};
}
//
/*function TC_WELL512_Nik(name) : TC(name) constructor {
	rng = new rerand();
	init = () => ;rng.InitRandom(WELL512_SEED);
	fn = (n) => ;repeat (n) rng.fYYRandom(WELL512_MAX);
}*/

function scr_bench_well512(){
	var tests/*:Array<TC>*/ = [
		new TC_WELL512_GM("Built-in"),
		new TC_WELL512_HxStruct("GML, struct"),
		new TC_WELL512_HxFlat("GML, array"),
		new TC_WELL512_HxGlobal("GML, global"),
		//new TC_WELL512_Nik("GML, Nik's impl"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_WELL512_Struct("C++ & GM structs"),
		new TC_WELL512_Flat("C++ & GM arrays"),
		new TC_WELL512_Unsafe("C++ & raw pointers"),
	);
	return new Benchmark("WELL512", tests);
}
function scr_verify_well512() {
	// this one's easy, can just compare to the built-in generator
	random_set_seed(WELL512_SEED);
	//
	//var _cppStruct = new WELL512();
	//_cppStruct.setSeed(WELL512_SEED);
	//var _cppFlat = well512_create();
	//well512_set_seed(_cppFlat, WELL512_SEED);
	//
	ghx_well512_set_seed(WELL512_SEED);
	var _hxStruct = new hxWELL512();
	_hxStruct.setSeed(WELL512_SEED);
	var _hxFlat = hx_well512_create();
	hx_well512_set_seed(_hxFlat, WELL512_SEED);
	//
	repeat (10) {
		verify(
			random(WELL512_MAX),
			//
			//_cppStruct.float(WELL512_MAX),
			//well512_float(_cppFlat, WELL512_MAX),
			//
			ghx_well512_float(WELL512_MAX),
			_hxStruct.float(WELL512_MAX),
			hx_well512_float(_hxFlat, WELL512_MAX),
		)
	}
	//
	repeat (10) {
		var a = random_range(WELL512_MIN, WELL512_MAX);
		var b = _hxStruct.floatRange(WELL512_MIN, WELL512_MAX);
		verify(a, b);
	}
	//
	repeat (10) {
		var a = irandom(WELL512_MAX);
		var b = _hxStruct.intGM(WELL512_MAX);
		verify(a, b);
	}
	//
	repeat (10) {
		var a = irandom_range(WELL512_MIN, WELL512_MAX);
		var b = _hxStruct.intRangeGM(WELL512_MIN, WELL512_MAX);
		verify(a, b);
	}
	//
}