draw_self();
var _x = mouse_x div bucketPixelSize;
if (_x >= sprite_get_width(sprite_index)) exit;
var _y = mouse_y div bucketPixelSize;
if (_y >= sprite_get_height(sprite_index)) exit;
//
var _num = _x + _y * sprite_get_width(sprite_index);
var _numLen = string_length(string(count));
var _hits = buffer_peek(countBuf, _num * 4, buffer_u32);
var _msg = ("value: " + string_format(_num, _numLen, 0)
	+ "\n" + "hits: " + string(_hits)
	+ "\n" + string_format(_hits / avgHits * 100, 3, 0) + "% of exp"
);
//
draw_sprite_stretched_ext(spr_select, 0,
	(_x * bucketPixelSize) - 1, (_y * bucketPixelSize) - 1,
	bucketPixelSize + 2, bucketPixelSize + 2, c_red, 1);
//
var _hpad = 4;
var _vpad = 2;
var _mx = mouse_x + 15;
var _my = mouse_y;
draw_set_font(fnt_test);
draw_sprite_stretched(spr_message, 0,
	_mx - 4, _my - 4,
	_hpad * 2 + 8 + string_width(_msg),
	_vpad * 2 + 8 + string_height(_msg),
);
//
draw_set_color(c_black);
draw_text(_mx + _hpad, _my + _vpad, _msg);