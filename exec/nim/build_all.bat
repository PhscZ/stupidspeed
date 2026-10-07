@echo off
setlocal
rem Build all 15 Nim tasks.
rem   nim c -d:release -o:prog.exe <task>.nim
rem Nim rejects a module name that is not a valid identifier, and the sources are named
rem _01_branches.nim ... _15_file_write.nim, so each is copied to t<task>.nim (no leading
rem underscore) before the build. -d:release is the optimisation; without it Nim emits a
rem debug build with the runtime checks on. Nim 2.x enables threads by default, so task 11's
rem std/typedthreads needs no extra flag. The C backend needs gcc on PATH.
rem Output: exec\nim\nim\<task>\prog.exe
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\nim
set OUT=%~dp0nim
set NIM=%ROOT%\tools\nim\bin\nim.exe
set GCCBIN=C:\mingw64\bin
set PATH=%GCCBIN%;%PATH%
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## nim
for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
cd /d "%OUT%\%1"
copy /y "%SRC%\_%1.nim" "t%1.nim" >nul
"%NIM%" c -d:release -o:prog.exe t%1.nim >build.log 2>&1
if exist prog.exe ( echo OK %1 ) else ( echo nim-FAIL %1 )
exit /b 0
