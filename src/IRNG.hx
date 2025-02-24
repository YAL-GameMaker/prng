import gml.io.Buffer;

@:autoBuild(Macros.build())
interface IRNG {
	#if !rng.global
	//
	function setSeed(seed:Int):Void;
	function save(buf:Buffer):Void;
	function load(buf:Buffer):Void;
	//
	function value():Float;
	function float(maxExcl:Float):Float;
	function floatRange(minIncl:Float, maxExcl:Float):Float;
	function int(maxIncl:Int):Int;
	function intRange(minIncl:Int, maxIncl:Int):Int;
	#end
}