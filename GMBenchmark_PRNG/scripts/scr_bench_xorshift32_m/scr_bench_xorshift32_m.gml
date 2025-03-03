function scr_xorshift32_set_seed(_seed) {
	xorshift32_state = (_seed == 0 ? 1 : _seed);
}
function scr_xorshift32_float(_max) {
	m_xorshift32_next;
	return m_xorshift32_float(_max);
}
function scr_xorshift32_float_fi(_max) {
	gml_pragma("forceinline");
	m_xorshift32_next;
	return m_xorshift32_float(_max);
}

function TC_Xorshift32_Mini(name) : TC(name) constructor {
	init = function() {;scr_xorshift32_set_seed(Xorshift32_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += scr_xorshift32_float(Xorshift32_MAX);
		return r;
	}
}
function TC_Xorshift32_Mini_fi(name) : TC(name) constructor {
	init = function() {;scr_xorshift32_set_seed(Xorshift32_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += scr_xorshift32_float_fi(Xorshift32_MAX);
		return r;
	}
}
function TC_Xorshift32_Mini_macro(name) : TC(name) constructor {
	init = function() {;state = Xorshift32_SEED;}
	fn = function(n) {
		m_xorshift32_start(state);
		var r = 0;
		repeat (n) {
			m_xorshift32_next;
			r += m_xorshift32_float(Xorshift32_MAX);
		}
		state = m_xorshift32_var;
		return r;
	}
}
function scr_bench_xorshift32_mini() {
	var tests/*:Array<TC>*/ = [
		//new TC_WELL512_GM("Built-in WELL512"),
		new TC_Xorshift32_Mini("Xorshift32, normal"),
		new TC_Xorshift32_Mini_fi("Xorshift32, forceinline"),
		new TC_Xorshift32_Mini_macro("Xorshift32, macro"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_Xorshift32_Unsafe("Xorshift32, C++ & raw p."),
	);
	return new Benchmark("Xorshift32 tricks", tests);
}