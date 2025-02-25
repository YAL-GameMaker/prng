/// @template T
/// @param {T} ref
/// @param {T} ...values
function verify() {
	var _ref = argument0;
	for (var _argi = 1; _argi < argument_count; _argi++) {
		var _arg = argument[_argi];
		if (_arg != _ref) {
			show_error($"Argument {_argi} ({_arg}) does not match desired value ({_ref})!", 1);
		}
	}
}
function scr_verify(){
	scr_verify_well512();
	if (!os_is_browser && os_type == os_windows) {
		scr_verify_xorshift64();
		scr_verify_rand0();
		scr_verify_minstd();
	}
}