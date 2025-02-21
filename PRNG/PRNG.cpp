/// @author YellowAfterlife

#include "stdafx.h"

static bool canAccessMemory(const void* base, size_t size) {
	#ifdef _APOLLO_MEMCHECK
	const auto pmask = PAGE_READONLY | PAGE_READWRITE | PAGE_WRITECOPY
		| PAGE_EXECUTE | PAGE_EXECUTE_READ | PAGE_EXECUTE_READWRITE | PAGE_EXECUTE_WRITECOPY;
	::MEMORY_BASIC_INFORMATION mbi{};
	size_t steps = size > 0 ? 2 : 1;
	for (auto step = 0u; step < steps; step++) {
		const void* addr = ((uint8_t*)base) + step * (size - 1);
		if (!VirtualQuery(addr, &mbi, sizeof mbi)) return false;
		if (mbi.State != MEM_COMMIT) return false;
		if ((mbi.Protect & PAGE_GUARD) != 0) return false;
		if ((mbi.Protect & pmask) == 0) return false;
	}
	#endif
	return true;
}

static int findCScriptRefOffset(void* _fptr_1, void* _fptr_2, void* _mptr_1, void* _mptr_2) {
	auto f1 = (void**)_fptr_1;
	auto f2 = (void**)_fptr_2;
	auto f3 = (void**)_mptr_1;
	auto f4 = (void**)_mptr_2;
	void** fx[] = { f1, f2, f3, f4 };
	for (auto i = 10u; i < 24; i++) {
		auto step = 0u;
		for (; step < 2; step++) {
			auto fi = fx[step];

			// should be NULL, <addr>, NULL:
			if (fi[i - 1] != nullptr) break;
			if (fi[i] == nullptr) break;
			if (fi[i + 1] != nullptr) break;
			// and the method pointers shouldn't have a function in them:
			auto mi = fx[step + 2];
			if (mi[i] != nullptr) break;
		}
		if (step < 2u) continue;

		// destination address must match:
		auto dest = f1[i];
		if (dest != f2[i]) continue;

		return (int)(sizeof(void*) * i);
	}
	return -1;
}

dllx double prng_init_1(void* _fptr_1, void* _fptr_2, void* _mptr_1, void* _mptr_2) {
	auto ofs = findCScriptRefOffset(_fptr_1, _fptr_2, _mptr_1, _mptr_2);
	if (ofs < 0) return -1;
	gmlOffsets.CScriptRef.cppFunc = ofs;

	// both CWeakRef and CScriptRef inherit from YYObjectBase;
	// in CScriptRef, the three pointers are the first non-inherited members.
	// in CWeakRef, the destination pointer is the first non-inherited member.
	gmlOffsets.CWeakRef.weakRef = ofs - sizeof(void*);

	// we'll check if it's a 2023.8+ array layout in the function below:
	gmlOffsets.RefDynamicArrayOfRValue.items = gmlOffsets.CWeakRef.weakRef.offset + sizeof(int) * 2;
	gmlOffsets.RefDynamicArrayOfRValue.length = gmlOffsets.RefDynamicArrayOfRValue.items.offset + sizeof(void*) + sizeof(int64_t) + sizeof(int);
	return 1;
}

dllm void prng_init_array(dllm_args) {
	// at first arrays were a little struct
	// with introduction of GC, arrays were made into a collectable object, inherting from YYObjectBase
	// now arrays are a little struct again, and they've got a pointer to YYObjectBase (probably used *only* for GC)
	// the new layout is like this:
	/*
	struct RefDynamicArrayOfRValue {
		YYObjectBase* gcThing;
		RValue* items;
		int64 copyOnWriteStuff;
		int refCount;
		int mystery1;
		int mystery2;
		int length;
	}
	*/
	auto a2 = arg + 0;
	auto a3 = arg + 1;
	auto a4 = arg + 2;
	FieldOffset<int> magicLength = sizeof(void*) * 2 + sizeof(int64) + sizeof(int) * 3;
	if (magicLength.read(a2->ptr) == 2 && magicLength.read(a3->ptr) == 3 && magicLength.read(a4->ptr) == 4) {
		// so if what we've passed seems to be using that layout, 
		gmlOffsets.RefDynamicArrayOfRValue.items.offset = sizeof(void*);
		gmlOffsets.RefDynamicArrayOfRValue.length = magicLength;
	}
	gmlOffsets.ready = a2->getArrayLength() == 2 && a3->getArrayLength() == 3;
	result.setReal(gmlOffsets.ready ? 1 : 0);
}

dllm void prng_init_protos(dllm_args) {
	gmlProtoOf.WELL512 = (YYObjectBase*)arg[0].ptr;
}

GmlOffsets gmlOffsets{};
GmlClassOf gmlClassOf{};
GmlProtoOf gmlProtoOf{};
static YYRunnerInterface g_YYRunnerInterface{};
YYRunnerInterface* g_pYYRunnerInterface;
__declspec(dllexport) void YYExtensionInitialise(const struct YYRunnerInterface* _struct, size_t _size) {
	if (_size < sizeof(YYRunnerInterface)) {
		memcpy(&g_YYRunnerInterface, _struct, _size);
	} else {
		memcpy(&g_YYRunnerInterface, _struct, sizeof(YYRunnerInterface));
	}
	g_pYYRunnerInterface = &g_YYRunnerInterface;
}
