/**
	Best known as type-0 RNG in GLIBC!
	https://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/random_r.c;hb=glibc-2.28
**/

import gml.NativeType;
import gml.io.Buffer;

@:keep class Rand0 implements IRNG {
	static inline var mask = 0x7fffffff;
	static inline var div = 2147483648.0;
	public var state:Int = 0;
	public function new() {
		
	}
	//
	public function setSeed(seed:Int):Void {
		state = cast NativeType.toInt64(seed == 0 ? 1 : seed);
	}
	public function save(buf:Buffer):Void {
		buf.writeIntUnsigned(state);
	}
	public function load(buf:Buffer):Void {
		state = buf.readIntUnsigned();
	}
	//
	public inline function next() {
		state = (state * 1103515245 + 12345) & mask;
		return state;
	}
	public inline function value() {
		return next() / div;
	}
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