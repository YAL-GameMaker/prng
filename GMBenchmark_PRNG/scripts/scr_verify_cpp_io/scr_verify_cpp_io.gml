function scr_verify_cpp_io(
	_cppStruct,
	_cppFlat,
	_seed,
	_flat_set_seed,
	_flat_next,
	_flat_save,
	_flat_load
){
	_cppStruct.setSeed(_seed);
	_flat_set_seed(_cppFlat, _seed);
	//
	repeat (10) {
		_cppStruct.next();
		_flat_next(_cppFlat);
	}
	//
	var b = buffer_create(4, buffer_grow, 1);
	buffer_write(b, buffer_u32, 0);
	var p = buffer_tell(b);
	//
	_cppStruct.save(b);
	_flat_save(_cppFlat, b);
	//
	var a1 = _cppStruct.next();
	var a2 = _flat_next(_cppFlat);
	//
	buffer_seek(b, buffer_seek_start, p);
	//
	_cppStruct.load(b);
	_flat_load(_cppFlat, b);
	//
	var b1 = _cppStruct.next();
	var b2 = _flat_next(_cppFlat);
	//trace(a1, a2, b1, b2);
	verify(a1, a2, b1, b2);
}