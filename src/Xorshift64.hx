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
@:snakeName("xorshift64")
@:keep class Xorshift64 implements IRNG {
	var state:Int64 = 0;
	public function new() {
		
	}
	//
	public function setSeed(seed:Int) {
		seed = cast NativeType.toInt64(seed);
		state = seed == 0 ? 1 : seed;
	}
	public function save(buf:Buffer) {
		buf.writeInt64(state);
	}
	public function load(buf:Buffer) {
		state = buf.readInt64();
	}
	//
	extern static inline function withoutSignBit(v:Int64):Int64 {
		return Syntax.code("({0} & $7fffffffffffffff)", v);
	}
	//
	public inline function next() {
		#if !rng.global
		var state = this.state;
		#end
		// George's paper says that any of the triples are "likely" to provide good results, 
		// but also I don't feel like setting up PRNG tests just for this.
		inline function dump(step) {
			//trace(step, StringTools.hex(cast state).toLowerCase());
		}
		dump(0);
		state ^= state << 13;
		dump(1);
		// here comes the fun part: if you >> a negative integer, the sign bit stays
		/*
		if (state < 0) {
			state ^= Syntax.code("({0} | $100000000000000)", (withoutSignBit(state) >> 7));
		} else state ^= state >> 7;
		//*/
		state ^= Syntax.code("({0} | (({1}) * $100000000000000))", withoutSignBit(state) >> 7, state < 0);
		dump(2);
		state ^= state << 17;
		dump(3);
		#if !rng.global
		this.state = state;
		#end
		return state;
	}
	public inline function value():Float {
		var result = next();
		// V8's XorShift shifts result to the right, but we shouldn't do that because it's signed
		return Syntax.code("({0} & $1FFFFFFFFFFFFF) / 9007199254740992.0", result);
	}
	public inline function float(maxExcl:Float) {
		return value() * maxExcl;
	}
	public inline function floatRange(minIncl:Float, maxExcl:Float) {
		return minIncl + value() * (maxExcl - minIncl);
	}
	//
	public inline function int(maxIncl:Int):Int {
		var u = withoutSignBit(next());
		if (maxIncl < 0) {
			return cast -(u % (1 - Std.int(maxIncl)));
		} else {
			return cast u % (1 + Std.int(maxIncl));
		}
	}
	public inline function intRange(minIncl:Int, maxIncl:Int) {
		var u = withoutSignBit(next());
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