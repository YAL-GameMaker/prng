#macro bucketPixelSize 10
var w = room_width div bucketPixelSize;
var h = room_height div bucketPixelSize;
width = w;
height = h;
count = w * h;
bufSize = count * 4;
avgHits = 1000;

//
show_debug_message("Generating...");
countBuf = buffer_create(bufSize, buffer_fixed, 1);
maxHits = 0;
var _steps = count * avgHits;
var _mod = _steps div 10;
for (var _step = 0; _step < _steps; _step += 1) {
	if (_step mod _mod == 0) {
		show_debug_message(string((_step div _mod) * 10) + "%...");
	}
	//
	var _pos = scr_iter(_step, _steps, count) * 4;
	var _hits = buffer_peek(countBuf, _pos, buffer_u32) + 1;
	buffer_poke(countBuf, _pos, buffer_u32, _hits);
	maxHits = max(maxHits, _hits);
}
maxHits = real(maxHits);

//
show_debug_message("Drawing...");
minHits = maxHits;
colorBuf = buffer_create(bufSize, buffer_fixed, 1);
_mod = ((bufSize div 4) div 10) * 4;
for (var _pos = 0; _pos < bufSize; _pos += 4) {
	if (_pos mod _mod == 0) {
		show_debug_message(string((_pos div _mod) * 10) + "%...");
	}
	//
	var _hits = buffer_peek(countBuf, _pos, buffer_u32);
	minHits = min(minHits, _hits);
	//
	var _brightness = min(1, real(_hits) / (avgHits * 2));
	var _rgba = c_white | (round(_brightness * 255) << 24);
	buffer_poke(colorBuf, _pos, buffer_u32, _rgba);
}

// make a sprite out of that:
var _surf = surface_create(w, h);
buffer_set_surface(colorBuf, _surf, 0);
sprite_index = sprite_create_from_surface(_surf, 0, 0, w, h, false, false, 0, 0);
surface_free(_surf);
image_xscale = bucketPixelSize;
image_yscale = bucketPixelSize;

//
var _title = ("Buckets: " + string(count)
	+ ", expected avg: " + string(avgHits)
	+ ", min: " + string(minHits) + " (" + string_format(minHits / avgHits * 100, 0, 0) + "%)"
	+ ", max: " + string(maxHits) + " (" + string_format(maxHits / avgHits * 100, 0, 0) + "%)"
);
show_debug_message(_title);
window_set_caption(_title);
