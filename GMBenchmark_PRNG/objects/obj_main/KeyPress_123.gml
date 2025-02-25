var bench_list = self.container.GetChild("BENCHMARK LIST");
var benchmark/*:Benchmark*/ = bench_list.GetSelectedItem();
if (benchmark == undefined) exit;
if (benchmark.runtime == undefined) exit;
var name = benchmark.source_name;
var imageName = name;
imageName = string_replace_all(imageName, ",", "");
imageName = string_replace_all(imageName, "&", "and");
imageName = string_replace_all(imageName, " ", "-");
var buildType = code_is_compiled() ? "YYC" : "VM";
imageName = $"RNG-{buildType}-{imageName}.png";
var imagePath = imageName;
if (1) {
	screen_save_part(imagePath, 0, 297, 900, 310);
} else {
	screen_save(imagePath);
}
var spr = sprite_add(imagePath, 1, false, false, 0, 0);
var width = sprite_get_width(spr);
var height = sprite_get_height(spr);
sprite_delete(spr);
var lines = [
	$"src: /2025/02/{imageName}",
	$"full: *.png",
	$"size: {width}x{height}",
	$"alt: GMBenchmark results for \"{name}\" read:",
];
for (var j = 0, n2 = array_length(benchmark.tests); j < n2; j++) {
	var test = benchmark.tests[j];
	var trt = test.runtime;
	array_push(lines, test.source_name
		+ ": " + string_format(trt.ms, 0, 3)
		+ " (" + string_format(trt.percentage * 100, 0, 1) + "%)"
	);
}
array_insert(lines, 0, "```rth");
array_push(lines, "```");
//
var r = lines[0];
for (var i = 1, n = array_length(lines); i < n; i++) {
	r += "\r\n" + lines[i];
}
clipboard_set_text(r);