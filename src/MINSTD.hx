import gml.Mathf;
import gml.io.Buffer;

/**
	https://en.wikipedia.org/wiki/Lehmer_random_number_generator#Parameters_in_common_use
**/
@:keep class MINSTD implements IRNG {
	extern static inline var M = 2147483647;
	var state:Int = 0;
	public function new() {
		
	}
	//
	public function setSeed(seed:Int):Void {
		state = seed == 0 ? 1 : seed;
	}
	public function save(buf:Buffer):Void {
		buf.writeIntUnsigned(state);
	}
	public function load(buf:Buffer):Void {
		state = buf.readIntUnsigned();
	}
	//
	public inline function next() {
		state = (state * 48271) % M;
		return state;
	}
	public inline function value() {
		return next() / M;
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
		if (maxIncl < 0) {
			return -Math.floor(value() * (1 - maxIncl));
		} else {
			return Math.floor(value() * (1 + maxIncl));
		}
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
}