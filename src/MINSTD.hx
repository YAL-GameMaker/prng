import gml.Mathf;
import gml.io.Buffer;

/**
	https://en.wikipedia.org/wiki/Lehmer_random_number_generator#Parameters_in_common_use
**/
@:keep class MINSTD implements IRNG {
	extern static inline var M = 2147483647;
	extern static inline var A = 48271;
	var state:Int = 0;
	public function new() {
		
	}
	//
	public function setSeed(seed:Int):Void {
		// ensure that seed is in (0 ... M) range
		seed = (seed - 1) % (M - 1);
		if (seed < 0) seed += M - 1;
		state = seed + 1;
	}
	public function save(buf:Buffer):Void {
		buf.writeIntUnsigned(state);
	}
	public function load(buf:Buffer):Void {
		state = buf.readIntUnsigned();
	}
	//
	extern inline function next() {
		state = (state & A) % M;
	}
	public inline function value() {
		next();
		return state / M;
	}
	/** NB! This has a maximum of 31 bits! **/
	public inline function bits(count:Int) {
		next();
		return state >> (31 - count);
	}
	//
	public function float(maxExcl:Float):Float {
		return value() * maxExcl;
	}
	public function floatRange(minIncl:Float, maxExcl:Float):Float {
		var v = value();
		return minIncl * (1 - v) + maxExcl * v;
	}
	public function int(maxIncl:Int):Int {
		return Math.floor(value() * (maxIncl + 1));
	}
	public function intRange(minIncl:Int, maxIncl:Int):Int {
		var start, range;
		if (minIncl < maxIncl) {
			start = Std.int(minIncl);
			range = Std.int(maxIncl) - start + 1;
		} else {
			start = Std.int(maxIncl);
			range = Std.int(minIncl) - start + 1;
		}
		return Math.floor(start + range * value());
	}
	//
	public function pick<T>(args:SfRest<T>):T {
		return args[Std.int(float(args.length))];
	}
}