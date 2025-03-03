import sys.io.File;

/**
	Generates those `build-gms1.hxml` / `build-gms2.hxml` files.
	Invoked with `haxe build-builders.hxml`
**/
class Build {
	static function genBuild(old:Bool) {
		var v = old ? 1 : 2;
		var lines = [];
		lines.push("-D rng.single");
		lines.push("-D sf-hint-folds=false");
		lines.push('gml$v.hxml');
		var algos = ["MINSTD", "Rand0", "WELL512", "Xorshift64"];
		var first = true;
		var kinds = ["global", "flat"];
		if (!old) kinds.push("struct");
		for (algo in algos) {
			for (kind in kinds) {
				lines.push("");
				if (first) {
					first = false;
					lines.push("--each");
				} else {
					lines.push("--next");
				}
				//
				var main = algo + "_" + kind;
				lines.push('-D rng.$kind');
				lines.push('-D rng.build=$main');
				lines.push('--main $algo');
				lines.push('--js export/gms$v/$main.gml');
				if (old) {
					lines.push('-D sfgml-main=$main');
				}
			}
		}
		File.saveContent('build-gms$v.hxml', lines.join("\n"));
	}
	public static function main() {
		genBuild(true);
		genBuild(false);
		trace("OK!");
	}
}