function scr_minstd_set_seed(_seed) {
	minstd_state = (_seed == 0 ? 1 : _seed);
}
function scr_minstd_float(_max) {
	m_minstd_next;
	return m_minstd_float(_max);
}
function scr_minstd_float_fi(_max) {
	gml_pragma("forceinline");
	m_minstd_next;
	return m_minstd_float(_max);
}

function TC_MINSTD_Mini(name) : TC(name) constructor {
	init = function() {;scr_minstd_set_seed(MINSTD_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += scr_minstd_float(MINSTD_MAX);
		return r;
	}
}
function TC_MINSTD_Mini_fi(name) : TC(name) constructor {
	init = function() {;scr_minstd_set_seed(MINSTD_SEED);}
	fn = function(n) {
		var r = 0;
		repeat (n) r += scr_minstd_float_fi(MINSTD_MAX);
		return r;
	}
}
function TC_MINSTD_Mini_macro(name) : TC(name) constructor {
	init = function() {;state = MINSTD_SEED;}
	fn = function(n) {
		m_minstd_start(state);
		var r = 0;
		repeat (n) {
			m_minstd_next;
			r += m_minstd_float(MINSTD_MAX);
		}
		state = m_minstd_var;
		return r;
	}
}
function scr_bench_minstd_mini() {
	var tests/*:Array<TC>*/ = [
		//new TC_WELL512_GM("Built-in WELL512"),
		new TC_MINSTD_Mini("MINSTD, normal"),
		new TC_MINSTD_Mini_fi("MINSTD, forceinline"),
		new TC_MINSTD_Mini_macro("MINSTD, macro"),
	];
	if (!os_is_browser && os_type == os_windows) array_push(tests,
		new TC_MINSTD_Unsafe("MINSTD, C++ & raw p."),
	);
	return new Benchmark("MINSTD tricks", tests);
}