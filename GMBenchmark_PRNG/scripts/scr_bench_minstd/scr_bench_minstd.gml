// Feather ignore GM1033
#macro MINSTD_SEED 1612
#macro MINSTD_MAX 1000
// Haxe-GML:
function TC_MINSTD_HxStruct(name) : TC(name) constructor {
	rng = new hxMINSTD();
	init = function() {;rng.setSeed(MINSTD_SEED);}
	fn = function(n) {;repeat (n) rng.float(MINSTD_MAX);}
}
function TC_MINSTD_HxFlat(name) : TC(name) constructor {
	rng = hx_minstd_create();
	init = function() {;hx_minstd_set_seed(rng, MINSTD_SEED);}
	fn = function(n) {;repeat (n) hx_minstd_float(rng, MINSTD_MAX);}
}
function TC_MINSTD_HxGlobal(name) : TC(name) constructor {
	init = function() {;ghx_minstd_set_seed(MINSTD_SEED);}
	fn = function(n) {;repeat (n) ghx_minstd_float(MINSTD_MAX);}
}
// C++:
function TC_MINSTD_Struct(name) : TC(name) constructor {
	rng = new MINSTD();
	init = function() {;rng.setSeed(MINSTD_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += rng.float(MINSTD_MAX);
		return r;
	};
}
function TC_MINSTD_Flat(name) : TC(name) constructor {
	rng = minstd_create();
	init = function() {;minstd_set_seed(rng, MINSTD_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += minstd_float(rng, MINSTD_MAX);
		return r;
	};
}
function TC_MINSTD_Unsafe(name) : TC(name) constructor {
	rng = minstd_create()[1];
	init = function() {return minstd_set_seed_raw(rng, MINSTD_SEED)};
	fn = function(n) {
		var r = 0;
		repeat (n) r += minstd_float_raw(rng, MINSTD_MAX);
		return r;
	};
}
//
function scr_bench_minstd(){
	var tests/*:Array<TC>*/ = [
		new TC_MINSTD_HxStruct("GML, struct"),
		new TC_MINSTD_HxFlat("GML, flat"),
		new TC_MINSTD_HxGlobal("GML, global"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_MINSTD_Struct("C++ & GM structs"),
		new TC_MINSTD_Flat("C++ & GM arrays"),
		new TC_MINSTD_Unsafe("C++ & raw pointers"),
	);
	return new Benchmark("MINSTD", tests)
}
function scr_verify_minstd() {
	var cpp = new MINSTD();
	var gml = new hxMINSTD();
	cpp.setSeed(MINSTD_SEED);
	gml.setSeed(MINSTD_SEED);
	m_minstd_start(MINSTD_SEED);
	repeat (200) {
		var a = cpp.next();
		var b = gml.next();
		m_minstd_next;
		var c = m_minstd_var;
		verify(a, b, c);
	}
	//
	if (os_has_dlls) scr_verify_cpp_io(
		new MINSTD(),
		minstd_create(),
		MINSTD_SEED,
		function(q, s) {;minstd_set_seed(q, s)},
		function(q) {return minstd_next(q)},
		function(q, b) {;minstd_save(q, b)},
		function(q, b) {;minstd_load(q, b)},
	)
}