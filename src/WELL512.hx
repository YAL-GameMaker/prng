package;

import gml.io.Buffer;
import haxe.Rest;
import haxe.Int64;
import gml.NativeType;
import gml.NativeArray;
import js.Syntax;
import haxe.ds.Vector;

/*
https://stackoverflow.com/a/1227137/5578773
https://www.lomont.org/papers/2008/Lomont_PRNG_2008.pdf
*/
@:keep class WELL512 implements IRNG {
	var state = NativeArray.create(16, 0);
	var index = 0;
	public function new() {
		
	}
	//
	public function setSeed(seed:Int) {
		var _state = state;
		var s = toUInt32(seed);
		for (i in 0 ... 16) {
			s = ((toUInt32(s * 214013) + 2531011) >> 16);
			_state[i] = s;
		}
		index = 0;
	}
	public function save(buf:Buffer) {
		buf.writeIntUnsigned(index);
		for (i in 0 ... 16) buf.writeIntUnsigned(state[i]);
	}
	public function load(buf:Buffer) {
		index = buf.readIntUnsigned();
		for (i in 0 ... 16) state[i] = buf.readIntUnsigned();
	}
	//
	extern inline function toUInt32(val:Int):Int {
		return Syntax.code("({0} & $ffFFffFF)", val);
	}
	extern inline function toInt(val:Int):Int {
		return cast NativeType.toInt64(val);
		//return Syntax.code("({0} | 0)", val);
	}
	extern inline function toReal(val:Int):Float {
		return NativeType.toReal(val);
	}
	//
	extern static inline var MAX_VALUE = 4294967296.0;
	inline function next() {
		#if !rng.global
		var state = this.state;
		var index = this.index;
		#end
		var a, b, c, d;
		WELL512M.impl();
		#if !rng.global
		this.index = index;
		#end
		return a;
	}
	public inline function value():Float {
		return next() / MAX_VALUE;
	}
	public inline function bits(count) {
		return next() >> (32 - count);
	}
	public inline function float(maxExcl:Float) {
		return value() * maxExcl;
	}
	public inline function floatRange(minIncl:Float, maxExcl:Float) {
		return minIncl + value() * (maxExcl - minIncl);
	}
	//
	public inline function int(maxIncl:Int) {
		var u = next();
		if (maxIncl < 0) {
			return -(u % (1 - Std.int(maxIncl)));
		} else {
			return u % (1 + Std.int(maxIncl));
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
		return start + (u % range);
	}
	//
	public inline function intGM(maxInc:Int):Float {
		#if !rng.global
		var state = this.state;
		var index = this.index;
		#end
		var a, b, c, d;
		WELL512M.impl();
		var low = a;
		WELL512M.impl();
		#if !rng.global
		this.index = index;
		#end
		var r = (low | ((a & 0x7FffFFff) << 32));
		if (maxInc < 0) {
			// this Std.int is very important because otherwise we'll get 0 (!)
			return toReal(-(r % toInt(1 - maxInc)));
		} else {
			return toReal(r % toInt(1 + maxInc));
		}
	}
	public function intRangeGM(minIncl:Int, maxIncl:Int):Float {
		var start, range;
		if (minIncl < maxIncl) {
			start = Std.int(minIncl);
			range = Std.int(maxIncl) - start;
		} else {
			start = Std.int(maxIncl);
			range = Std.int(minIncl) - start;
		}
		return start + intGM(range);
	}
}