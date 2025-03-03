@echo off

if not exist "PRNG-for-GMS1" mkdir "PRNG-for-GMS1"
cmd /C copyre ..\PRNG.gmx\extensions\PRNG.extension.gmx PRNG-for-GMS1\PRNG.extension.gmx
cmd /C copyre ..\PRNG.gmx\extensions\PRNG PRNG-for-GMS1\PRNG
cmd /C copyre ..\PRNG.gmx\datafiles\PRNG.html PRNG-for-GMS1\PRNG\Assets\datafiles\PRNG.html
cd PRNG-for-GMS1
cmd /C 7z a PRNG-for-GMS1.7z *
move /Y PRNG-for-GMS1.7z ../PRNG-for-GMS1.gmez
cd ..

if not exist "PRNG-for-GMS2.3+\extensions" mkdir "PRNG-for-GMS2.3+\extensions"
if not exist "PRNG-for-GMS2.3+\datafiles" mkdir "PRNG-for-GMS2.3+\datafiles"
cmd /C copyre ..\PRNG_23\extensions\PRNG PRNG-for-GMS2.3+\extensions\PRNG
cmd /C copyre ..\PRNG_23\datafiles\PRNG.html PRNG-for-GMS2.3+\datafiles\PRNG.html
cd PRNG-for-GMS2.3+
cmd /C 7z a PRNG-for-GMS2.3+.zip *
move /Y PRNG-for-GMS2.3+.zip ../PRNG-DLL-for-GM2022+.yymps
cd ..

copy /Y ..\GMBenchmark_PRNG\scripts\MINSTD_macros\MINSTD_macros.gml gms2\MINSTD_macros.gml
copy /Y ..\GMBenchmark_PRNG\scripts\Xorshift64_macros\Xorshift64_macros.gml gms2\Xorshift64_macros.gml
del /Q PRNG-Scripts-for-GM2022+.zip
cd gms2
cmd /C 7z a ..\PRNG-Scripts-for-GM2022+.zip *.gml
cd ..

cd ..\GMBenchmark_PRNG
cmd /C 7z a ..\export\PRNG-GMBenchmark.zip
cd ..\export
move /Y PRNG-GMBenchmark.zip PRNG-GMBenchmark.yyz

pause