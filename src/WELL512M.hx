import haxe.macro.Expr;

class WELL512M {
	public static macro function impl():Expr {
		return macro {
			a = state[index];
			c = state[(index + 13) & 15];
			b = (a ^ c
				^ (a << 16)
				^ (c << 15)
			);
			c = state[(index + 9) & 15];
			c ^= (c >> 11);
			a = b ^ c;
			state[index] = toUInt32(a);
			d = a ^ ((a << 5) & Syntax.code("0xDA442D24"));
			index = (index + 15) & 15;
			a = state[index];
			a = toUInt32(a ^ b ^ d ^ (a << 2) ^ (b << 18) ^ (c << 28));
			state[index] = a;
		};
	}
}