import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

class Macros {
	public static macro function bindAfterGenerate() {
		if (Context.defined("rng.build")) {
			var name = Context.definedValue("rng.build");
			Sys.print('$name... ');
			Context.onAfterGenerate(() -> {
				Sys.println("OK!");
			});
		}
		return macro {};
	}
	public static macro function build():Array<Field> {
		inline function toSnakeCase(s:String):String {
			return sf.opt.SfGmlSnakeCase.toSnakeCase(s);
		}
		var pos = Context.currentPos();
		var fields = Context.getBuildFields();
		var type = Context.getLocalType();
		var ct = switch (type) {
			case TInst(_.get() => _ct, params): _ct;
			default: Context.error("Should be tagging a class, got " + type, pos);
		}
		inline function getSnakeName() {
			var name = ct.name;
			var m = ct.meta.extract(":snakeName");
			if (m.length > 0) switch (m[0].params[0].expr) {
				case EConst(CString(s)): name = s;
				default:
			};
			return toSnakeCase(name);
		}
		inline function addMeta(tag:String, ?param:String) {
			ct.meta.add(tag, param != null ? [macro $v{param}] : [], pos);
		}
		//
		#if !rng.struct
		ct.meta.add(":snakeCase", [], pos);
		#end
		
		//
		ct.meta.add(":nativeGen", [], pos);
		
		// type-specific:
		#if rng.global
			ct.interfaces = [];
			var remove = [];
			for (fd in fields) {
				fd.access ??= [];
				if (!fd.access.contains(AStatic)) fd.access.push(AStatic);
				if (fd.name == "new") {
					switch (fd.kind) {
						case FFun(_ => { expr: macro {}}):
							remove.push(fd);
						default:
							fd.name = "__init__";
							fd.access.push(AInline);
					}
				}
			}
			for (fd in remove) fields.remove(fd);
		#elseif rng.flat
			ct.meta.add(":gml.linear", [], pos);
		#else // struct
			//
		#end
		
		// name override:
		#if !rng.single
			#if rng.global
				ct.meta.add(":native", [macro $v{"ghx_" + getSnakeName()}], pos);
			#elseif rng.flat
				ct.meta.add(":native", [macro $v{"hx_" + getSnakeName()}], pos);
			#else
				ct.meta.add(":native", [macro $v{"hx" + ct.name}], pos);
			#end
		#end
		
		// add main:
		#if rng.single
		var c = macro class Main {
			public static inline function main() {}
		};
		fields.push(c.fields[0]);
		#end
		
		for (fd in fields) {
			var isPublic = !(fd.access == null || !fd.access.contains(APublic));
			if (isPublic) {
				fd.meta ??= [];
				fd.meta.push({ name: ":doc", pos: pos });
			}
		}
		//ct.meta.add(":doc", [], pos);
		return fields;
	}
}