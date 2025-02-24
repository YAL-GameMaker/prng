@echo off
set dllPath=%~1
set solutionDir=%~2
set projectDir=%~3
set arch=%~4
set config=%~5

echo Running pre-build for %config%

where /q GmlCppExtFuncs
if %ERRORLEVEL% EQU 0 (
	echo Running GmlCppExtFuncs...
	GmlCppExtFuncs ^
	--prefix prng^
	--cpp "%projectDir%autogen.cpp"^
	--gml "%solutionDir%GMBenchmark_PRNG/extensions/PRNG/autogen.gml"^
	--gml-constructors "%solutionDir%GMBenchmark_PRNG/scripts/PRNG_extras/PRNG_extras.gml"^
	--include "WELL512.h"^
	--include "MINSTD.h"^
	--include "XorShift64.h"^
	--include "Rand0.h"^
	%projectDir%*.cpp
)