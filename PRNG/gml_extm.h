#pragma once
//#define GDKEXTENSION_EXPORTS
#define __YYDEFINE_EXTENSION_FUNCTIONS__
#include "YYRunnerInterface.h"

const int VALUE_REAL = 0;		// Real value
const int VALUE_STRING = 1;		// String value
const int VALUE_ARRAY = 2;		// Array value
const int VALUE_OBJECT = 6;		// YYObjectBase* value 
const int VALUE_INT32 = 7;		// Int32 value
const int VALUE_UNDEFINED = 5;	// Undefined value
const int VALUE_PTR = 3;		// Ptr value
const int VALUE_VEC3 = 4;		// Deprecated : unused : Vec3 (x,y,z) value (within the RValue)
const int VALUE_VEC4 = 8;		// Deprecated : unused :Vec4 (x,y,z,w) value (allocated from pool)
const int VALUE_VEC44 = 9;		// Deprecated : unused :Vec44 (matrix) value (allocated from pool)
const int VALUE_INT64 = 10;		// Int64 value
const int VALUE_ACCESSOR = 11;	// Actually an accessor
const int VALUE_NULL = 12;		// JS Null
const int VALUE_BOOL = 13;		// Bool value
const int VALUE_ITERATOR = 14;	// JS For-in Iterator
const int VALUE_REF = 15;		// Reference value (uses the ptr to point at a RefBase structure)
const int MASK_KIND_RVALUE = 0x0ffffff;
const int VALUE_UNSET = MASK_KIND_RVALUE;

struct RValue;
#define dllm_args RValue& result, CInstance* self, CInstance* other, int argc, RValue* arg
typedef void(*YYFunc) (dllm_args);

#pragma region Offsets and class names
template<typename T> struct FieldOffset {
	int64_t offset = 0;
	FieldOffset() {}
	FieldOffset(const int64_t _offset) : offset(_offset) {}
	inline T read(void* obj) {
		return *(T*)((uint8_t*)obj + offset);
	}
};
struct GmlOffsets {
	struct {
		FieldOffset<void*> weakRef{};
	} CWeakRef;
	struct {
		FieldOffset<YYFunc> cppFunc{};
	} CScriptRef;
	struct {
		FieldOffset<RValue*> items{};
		FieldOffset<int> length{};
	} RefDynamicArrayOfRValue;
	struct {
		FieldOffset<const char*> className{};
	} YYObjectBase;
	bool ready = false;
};
extern GmlOffsets gmlOffsets;

struct GmlClassOf {
	const char* WELL512;
};
extern GmlClassOf gmlClassOf;

struct GmlProtoOf {
	YYObjectBase* WELL512;
};
extern GmlProtoOf gmlProtoOf;
#pragma endregion

struct WELL512;

struct RefString {
	const char* text;
	int refCount;
	int size;
};

struct RValue {
	union {
		int v32;
		int64_t v64;
		double val;
		RefString* str;
		void* ptr = 0;
	};
	uint32_t flags = 0;
	uint32_t kind = VALUE_REAL;
	inline int getKind() {
		return kind & MASK_KIND_RVALUE;
	}

	inline bool needsFree() {
		const auto flagSet = (1 << VALUE_STRING) | (1 << VALUE_OBJECT) | (1 << VALUE_ARRAY);
		return ((1 << (kind & 31)) & flagSet) != 0;
	}
	inline void free() {
		if (needsFree()) FREE_RValue(this);
	}

	inline void setReal(double value) {
		free();
		kind = VALUE_REAL;
		val = value;
	}
	inline void setInt64(int64_t value) {
		free();
		kind = VALUE_INT64;
		v64 = value;
	}
	inline void setScriptID(int64_t value) {
		free();
		kind = VALUE_INT64;
		v64 = value;
	}
	inline void setTo(RValue* value) {
		COPY_RValue(this, value);
	}

	inline bool getBool(bool defValue = false) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_REAL: case VALUE_BOOL: return val != 0;
			case VALUE_INT32: return v32 != 0;
			case VALUE_INT64: return v64 != 0;
			case VALUE_PTR: return ptr != 0;
			default: return defValue;
		}
	}
	inline int getInt32(int defValue = 0) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_REAL: case VALUE_BOOL: return (int)val;
			case VALUE_INT32: return v32;
			case VALUE_INT64: return (int)v64;
			default: return defValue;
		}
	}
	inline int64_t getInt64(int64_t defValue = 0) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_REAL: case VALUE_BOOL: return (int64_t)val;
			case VALUE_INT32: return v32;
			case VALUE_INT64: return v64;
			default: return defValue;
		}
	}
	inline const char* getString(const char* defValue = nullptr) {
		if ((kind & MASK_KIND_RVALUE) == VALUE_STRING) {
			return str->text;
		} else return defValue;
	}

	inline bool tryGetReal(double& result) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_REAL: case VALUE_BOOL: result = val; return true;
			case VALUE_INT32: case VALUE_REF: result = (double)v32; return true;
			case VALUE_INT64: result = (double)v64; return true;
			default: return false;
		}
	}
	inline bool tryGetInt(int& result) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_REAL: case VALUE_BOOL: result = (int)val; return true;
			case VALUE_INT32: case VALUE_REF: result = v32; return true;
			case VALUE_INT64: result = (int)v64; return true;
			default: return false;
		}
	}
	inline bool tryGetUInt(uint32_t& result) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_REAL: case VALUE_BOOL: result = (uint32_t)val; return true;
			case VALUE_INT32: case VALUE_REF: result = (uint32_t)v32; return true;
			case VALUE_INT64: result = (uint32_t)v64; return true;
			default: return false;
		}
	}
	inline bool tryGetInt64(int64_t& result) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_REAL: case VALUE_BOOL: result = (int64_t)val; return true;
			case VALUE_INT32: case VALUE_REF: result = v32; return true;
			case VALUE_INT64: result = v64; return true;
			default: return false;
		}
	}
	inline bool tryGetPtr(void*& result) {
		if ((kind & MASK_KIND_RVALUE) == VALUE_PTR) {
			result = ptr;
			return true;
		} else return false;
	}
	template<typename T>
	inline bool tryGetPtrExt(T*& result) {
		if ((kind & MASK_KIND_RVALUE) == VALUE_PTR) {
			result = (T*)ptr;
			return true;
		} else return false;
	}
	inline bool tryGetString(const char*& result) {
		if ((kind & MASK_KIND_RVALUE) == VALUE_STRING) {
			result = str->text;
			return true;
		} else return false;
	}
	inline bool tryGetArrayItems(RValue*& items, int& length) {
		if ((kind & MASK_KIND_RVALUE) == VALUE_ARRAY) {
			length = getArrayLength();
			items = getArrayItems();
			return true;
		} else return false;
	}

	#pragma region offset stuff
	inline bool weakRefIsAlive() {
		return gmlOffsets.CWeakRef.weakRef.read(ptr) != nullptr;
	}
	inline YYFunc getCppFunc() {
		return gmlOffsets.CScriptRef.cppFunc.read(ptr);
	}
	inline int getArrayLength() {
		return gmlOffsets.RefDynamicArrayOfRValue.length.read(ptr);
	}
	inline RValue* getArrayItems() {
		return gmlOffsets.RefDynamicArrayOfRValue.items.read(ptr);
	}
	inline RValue* getArrayItem(int index) {
		return gmlOffsets.RefDynamicArrayOfRValue.items.read(ptr) + index;
	}
	inline const char* getObjectClass() {
		return gmlOffsets.YYObjectBase.className.read(ptr);
	}
	#pragma endregion

	inline RValue* getStructMember(const char* field) {
		return YYStructGetMember(this, field);
	}
	template<typename T> inline bool tryUnwrapStruct(T** out, const char* className) {
		switch (kind & MASK_KIND_RVALUE) {
			case VALUE_OBJECT: {
				if (getObjectClass() != className) return false;
				// it would be faster to find a variable slot but that's a lot of work!
				auto rv = YYStructGetMember(this, "__ptr__");
				if (rv->kind != VALUE_PTR) return false;
				*out = (T*)rv->ptr;
				return true;
			};
			case VALUE_PTR:
				*out = (T*)ptr;
				return true;
			default:
				return false;
		}
	}
	template<typename T> inline bool tryUnwrapArray(T** out, YYObjectBase* proto) {
		if (getKind() == VALUE_ARRAY && getArrayLength() >= 2) {
			auto first = getArrayItem(0);
			if (first->getKind() == VALUE_ARRAY && first->ptr == proto) {
				auto second = getArrayItem(1);
				if (second->getKind() == VALUE_PTR) {
					*out = (T*)second->ptr;
					return true;
				}
			}
		}
		return false;
	}
};

using YYResult = RValue;
struct YYRest {
	int length;
	RValue* items;
	inline RValue operator[] (int ind) const { return items[ind]; }
	inline RValue& operator[] (int ind) { return items[ind]; }
	// Ensures that the number does not exceed available items and that passing -1 uses all available items
	void procCount(int* count) {
		if (*count < 0 || *count > length) *count = length;
	}
	void procCountOffset(int* pCount, int* pOffset) {
		int offset = *pOffset;
		if (offset < 0) {
			*pOffset = offset = 0;
		} else if (offset > length) {
			*pOffset = offset = length;
		}
		int count = *pCount;
		if (count < 0) {
			*pCount = length - offset;
		} else {
			int maxCount = length - offset;
			if (count > maxCount) *pCount = maxCount;
		}
	}
};
using YYArrayItems = YYRest;


#define __YYArgCheck_trouble1 if (!gmlOffsets.ready) {\
	if (g_pYYRunnerInterface) {\
		YYError(__YYFUNCNAME__ " :: YYRunnerInterface structure doesn't match up");\
	} else trace(__YYFUNCNAME__ " :: YYRunnerInterface is not available");\
	return;\
}
#define __YYArgCheck_trouble
#define __YYArgCheck_any __YYArgCheck_trouble
#define __YYArgCheck(argCount)\
	__YYArgCheck_trouble\
	if (argc != argCount) {\
		YYError(__YYFUNCNAME__ " :: argument count mismatch - want " #argCount ", have %d", argc);\
		return;\
	}
#define __YYArgCheck_range(minArgs, maxArgs)\
	__YYArgCheck_trouble\
	if (argc < minArgs || argc > maxArgs) {\
		YYError(__YYFUNCNAME__ " :: argument count mismatch - want " #minArgs ".." #maxArgs ", have %d", argc);\
		return;\
	}
#define __YYArgCheck_rest(minArgs)\
	__YYArgCheck_trouble\
	if (argc < minArgs) {\
		YYError(__YYFUNCNAME__ " :: argument count mismatch - want " #minArgs " or more, have %d", argc);\
		return;\
	}
#define __YYArgError(name, want, i) {\
	YYError(__YYFUNCNAME__ " :: argument type mismatch for \"" name "\" - want " want ", have %s", KIND_NAME_RValue(&arg[i]));\
	return;\
}


#define __YYArg_YYRest(name, v, i) v = { argc - i, arg + i };
#define __YYArg_RValue_ptr(name, v, i) v = &arg[i];
#define __YYArg_int(name, v, i) if (!arg[i].tryGetInt(v)) __YYArgError(name, "an int", i);
#define __YYArg_uint32_t(name, v, i) if (!arg[i].tryGetUInt(v)) __YYArgError(name, "a uint", i);
#define __YYArg_int64(name, v, i) if (!arg[i].tryGetInt64(v)) __YYArgError(name, "an int64", i);
#define __YYArg_double(name, v, i) if (!arg[i].tryGetReal(v)) __YYArgError(name, "a real", i);
#define __YYArg_void_ptr(name, v, i) if (!arg[i].tryGetPtr(v)) __YYArgError(name, "a pointer", i);
#define __YYArg_const_char_ptr(name, v, i) if (!arg[i].tryGetString(v)) __YYArgError(name, "a string", i);

// Semi-standard:
#define __YYArg_YYArrayItems(name, v, i) if (!arg[i].tryGetArrayItems(v.items, v.length)) __YYArgError(name, "an array", i);

// Custom:
#define __YYArg_gml_ptr_of_WELL512(name, v, i) if (!arg[i].tryUnwrapArray<WELL512>(&v, gmlProtoOf.WELL512)) __YYArgError(name, "a WELL512 struct", i);
#define __YYArg_WELL512_ptr(name, v, i) if (!arg[i].tryUnwrapArray<WELL512>(&v, gmlProtoOf.WELL512)) __YYArgError(name, "a WELL512 struct", i);
//#define __YYArg_WELL512_ptr(name, v, i) if (!arg[i].tryUnwrapStruct<WELL512>(&v, gmlClassOf.WELL512)) __YYArgError(name, "a WELL512 struct", i);
//if (!arg[i].tryGetPtrExt<WELL512>(v)) __YYArgError(name, "a pointer", i);

// Results:
#define __YYResult_bool(v) result.kind = VALUE_BOOL; result.val = v;
#define __YYResult_int(v) result.kind = VALUE_REAL; result.val = v;
#define __YYResult_int64_t(v) result.kind = VALUE_INT64; result.v64 = v;
#define __YYResult_double(v) result.kind = VALUE_REAL; result.val = v;
#define __YYResult_void_ptr(v) result.kind = VALUE_PTR; result.ptr = v;
#define __YYResult_const_char_ptr(v) YYCreateString(&result, v);

// TODO: add macros for project-specific types here
