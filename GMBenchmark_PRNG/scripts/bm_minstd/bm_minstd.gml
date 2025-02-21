// Feather ignore GM1033
#macro MINSTD_SEED 1612
#macro MINSTD_MAX 1000
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
//

//
function bm_minstd(){
	return new Benchmark("MINSTD", [
		new TC_MINSTD_HxStruct("GML, struct"),
		new TC_MINSTD_HxFlat("GML, flat"),
		new TC_MINSTD_HxGlobal("GML, global"),
	])
}