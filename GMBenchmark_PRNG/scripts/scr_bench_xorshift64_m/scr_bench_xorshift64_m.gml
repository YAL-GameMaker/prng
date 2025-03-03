function scr_xorshift64_set_seed(_seed) {
	xorshift64_state = (_seed == 0 ? 1 : _seed);
}
function scr_xorshift64_float(_max) {
	m_xorshift64_next;
	return m_xorshift64_float(_max);
}
function scr_xorshift64_float_fi(_max) {
	gml_pragma("forceinline");
	m_xorshift64_next;
	return m_xorshift64_float(_max);
}

function TC_Xorshift64_Mini(name) : TC(name) constructor {
	init = function() {;scr_xorshift64_set_seed(Xorshift64_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += scr_xorshift64_float(Xorshift64_MAX);
		return r;
	}
}
function TC_Xorshift64_Mini_fi(name) : TC(name) constructor {
	init = function() {;scr_xorshift64_set_seed(Xorshift64_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += scr_xorshift64_float_fi(Xorshift64_MAX);
		return r;
	}
}
function TC_Xorshift64_Mini_macro(name) : TC(name) constructor {
	init = function() {;state = Xorshift64_SEED;}
	fn = function(n) {
		m_xorshift64_start(state);
		var r = 0;
		repeat (n) {
			m_xorshift64_next;
			r += m_xorshift64_float(Xorshift64_MAX);
		}
		state = m_xorshift64_var;
		return r;
	}
}
function scr_bench_xorshift64_mini() {
	var tests/*:Array<TC>*/ = [
		//new TC_WELL512_GM("Built-in WELL512"),
		new TC_Xorshift64_Mini("Xorshift64, normal"),
		new TC_Xorshift64_Mini_fi("Xorshift64, forceinline"),
		new TC_Xorshift64_Mini_macro("Xorshift64, macro"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_Xorshift64_Unsafe("Xorshift64, C++ & raw p."),
	);
	return new Benchmark("Xorshift64 tricks", tests);
}