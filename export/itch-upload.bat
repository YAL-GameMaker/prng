@echo off
set /p ver="Version?: "
echo Uploading %ver%...
set user=yellowafterlife
set ext=gamemaker-prng
::cmd /C itchio-butler push PRNG-for-GMS1.gmez %user%/%ext%:gms1 --userversion=%ver%
::cmd /C itchio-butler push PRNG-for-GMS2.yymp %user%/%ext%:gms2 --userversion=%ver%
::cmd /C itchio-butler push PRNG-DLL-for-GM2022+.yymps %user%/%ext%:gm2022-dll --userversion=%ver%
::cmd /C itchio-butler push PRNG-Scripts-for-GM2022+.zip %user%/%ext%:gm2022-scripts --userversion=%ver%
cmd /C itchio-butler push PRNG-GMBenchmark.yyz %user%/%ext%:gm2022-benchmark --userversion=%ver%
cmd /C itchio-butler push PRNG.html %user%/%ext%:gm2022-docs --userversion=%ver%

pause