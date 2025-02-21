#macro prng_use_structs 0

function bm_gml() {
	return new Benchmark("GML, struct", [
		new TC_WELL512_HxStruct("WELL512"),
		new TC_MINSTD_HxStruct("MINSTD"),
	]);
}
function scr_benchmarks() {
	//
	Benchmarks = [
		bm_well512(),
		bm_minstd(),
		bm_gml(),
	];
}