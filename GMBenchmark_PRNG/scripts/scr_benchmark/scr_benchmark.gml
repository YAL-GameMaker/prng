#macro os_is_browser (os_browser != browser_not_a_browser)

function scr_bench_gml_struct() {
	return new Benchmark("GML, structs", [
		new TC_WELL512_HxStruct("WELL512"),
		new TC_MINSTD_HxStruct("MINSTD"),
		new TC_Xorshift64_HxStruct("XorShift64"),
		new TC_Rand0_HxStruct("Rand0"),
	]);
}
function scr_bench_gml_flat() {
	return new Benchmark("GML, arrays", [
		new TC_WELL512_HxFlat("WELL512"),
		new TC_MINSTD_HxFlat("MINSTD"),
		new TC_Xorshift64_HxFlat("XorShift64"),
		new TC_Rand0_HxFlat("Rand0"),
	]);
}
function scr_bench_gml_global() {
	return new Benchmark("GML, global", [
		new TC_WELL512_HxGlobal("WELL512"),
		new TC_MINSTD_HxGlobal("MINSTD"),
		new TC_Xorshift64_HxGlobal("XorShift64"),
		new TC_Rand0_HxGlobal("Rand0"),
	]);
}
function scr_bench_cpp_struct() {
	return new Benchmark("C++ & GM structs", [
		new TC_WELL512_Struct("WELL512"),
		new TC_MINSTD_Struct("MINSTD"),
		new TC_Xorshift64_Struct("XorShift64"),
		new TC_Rand0_Struct("Rand0"),
	]);
}
function scr_bench_cpp_flat() {
	return new Benchmark("C++ & GM arrays", [
		new TC_WELL512_Flat("WELL512"),
		new TC_MINSTD_Flat("MINSTD"),
		new TC_Xorshift64_Flat("XorShift64"),
		new TC_Rand0_Flat("Rand0"),
	]);
}
function scr_bench_cpp_unsafe() {
	return new Benchmark("C++ & raw pointers", [
		new TC_WELL512_Unsafe("WELL512"),
		new TC_MINSTD_Unsafe("MINSTD"),
		new TC_Xorshift64_Unsafe("XorShift64"),
		new TC_Rand0_Unsafe("Rand0"),
	]);
}
function scr_benchmarks() {
	Benchmarks = [
		scr_bench_gml_struct(),
		scr_bench_gml_flat(),
		scr_bench_gml_global(),
	];
	//
	if (!os_is_browser && os_type == os_windows) array_push(Benchmarks,
		scr_bench_cpp_struct(),
		scr_bench_cpp_flat(),
		scr_bench_cpp_unsafe(),
	);
	// algos:
	array_push(Benchmarks,
		scr_bench_well512(),
		scr_bench_minstd(),
		scr_bench_xorshift64(),
		scr_bench_rand0(),
		scr_bench_minstd_mini(),
	);
	//
}