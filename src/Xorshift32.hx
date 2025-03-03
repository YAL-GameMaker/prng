import js.Syntax;
import gml.NativeType;
import haxe.Int64;
import gml.io.Buffer;

/**
	https://excamera.com/sphinx/article-xorshift.html
	https://www.jstatsoft.org/article/download/v008i14/916
	https://en.wikipedia.org/wiki/Xorshift
	http://www.cse.yorku.ca/~oz/marsaglia-rng.html
**/
@:keep class Xorshift32 implements IRNG {
	var state:Int = 0;
	public function new() {
		
	}
	//
	public function setSeed(seed:Int) {
		seed = NativeType.toInt(seed) & Syntax.code("$FFFFFFFF");
		state = seed == 0 ? 1 : seed;
	}
	public function save(buf:Buffer) {
		buf.writeIntUnsigned(state);
	}
	public function load(buf:Buffer) {
		state = buf.readIntUnsigned();
	}
	//
	public inline function next() {
		#if !rng.global
		var state = this.state;
		#end
		inline function dump(step) {
			//trace(step, NativeType.toPtr(state));
		}
		dump(0);
		Syntax.code("{0} ^= ({0} << 13) & $FFFFFFFF", state);
		dump(1);
		state ^= state >> 17;
		dump(2);
		Syntax.code("{0} ^= ({0} << 5) & $FFFFFFFF", state);
		dump(3);
		#if !rng.global
		this.state = state;
		#end
		return state;
	}
	public inline function value():Float {
		return next() / 4294967296.0;
	}
	public inline function float(maxExcl:Float) {
		return value() * maxExcl;
	}
	public inline function floatRange(minIncl:Float, maxExcl:Float) {
		return minIncl + value() * (maxExcl - minIncl);
	}
	//
	public inline function int(maxIncl:Int):Int {
		var u = next();
		if (maxIncl < 0) {
			return cast -(u % (1 - Std.int(maxIncl)));
		} else {
			return cast u % (1 + Std.int(maxIncl));
		}
	}
	public inline function intRange(minIncl:Int, maxIncl:Int) {
		var u = next();
		var start, range;
		if (minIncl < maxIncl) {
			start = Std.int(minIncl);
			range = Std.int(maxIncl) - start + 1;
		} else {
			start = Std.int(maxIncl);
			range = Std.int(minIncl) - start + 1;
		}
		return start + cast (u % range);
	}
}