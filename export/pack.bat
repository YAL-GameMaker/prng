@echo off

if not exist "PRNG-for-GMS1" mkdir "PRNG-for-GMS1"
cmd /C copyre ..\PRNG.gmx\extensions\PRNG.extension.gmx PRNG-for-GMS1\PRNG.extension.gmx
cmd /C copyre ..\PRNG.gmx\extensions\PRNG PRNG-for-GMS1\PRNG
cmd /C copyre ..\PRNG.gmx\datafiles\PRNG.html PRNG-for-GMS1\PRNG\Assets\datafiles\PRNG.html
cd PRNG-for-GMS1
cmd /C 7z a PRNG-for-GMS1.7z *
move /Y PRNG-for-GMS1.7z ../PRNG-for-GMS1.gmez
cd ..

if not exist "PRNG-for-GMS2\extensions" mkdir "PRNG-for-GMS2\extensions"
if not exist "PRNG-for-GMS2\datafiles" mkdir "PRNG-for-GMS2\datafiles"
if not exist "PRNG-for-GMS2\datafiles_yy" mkdir "PRNG-for-GMS2\datafiles_yy"
cmd /C copyre ..\PRNG_yy\extensions\PRNG PRNG-for-GMS2\extensions\PRNG
cmd /C copyre ..\PRNG_yy\datafiles\PRNG.html PRNG-for-GMS2\datafiles\PRNG.html
cmd /C copyre ..\PRNG_yy\datafiles_yy\PRNG.html.yy PRNG-for-GMS2\datafiles_yy\PRNG.html.yy
cd PRNG-for-GMS2
cmd /C 7z a PRNG-for-GMS2.zip *
move /Y PRNG-for-GMS2.zip ../PRNG-for-GMS2.yymp
cd ..

if not exist "PRNG-for-GMS2.3+\extensions" mkdir "PRNG-for-GMS2.3+\extensions"
if not exist "PRNG-for-GMS2.3+\datafiles" mkdir "PRNG-for-GMS2.3+\datafiles"
cmd /C copyre ..\PRNG_23\extensions\PRNG PRNG-for-GMS2.3+\extensions\PRNG
cmd /C copyre ..\PRNG_23\datafiles\PRNG.html PRNG-for-GMS2.3+\datafiles\PRNG.html
cd PRNG-for-GMS2.3+
cmd /C 7z a PRNG-for-GMS2.3+.zip *
move /Y PRNG-for-GMS2.3+.zip ../PRNG-for-GMS2.3+.yymps
cd ..

pause