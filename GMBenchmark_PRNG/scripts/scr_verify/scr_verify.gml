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
}