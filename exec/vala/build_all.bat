@echo off
setlocal enabledelayedexpansion
rem Build all 15 Vala tasks.
rem   valac -X -O2 -o prog <task>.vala      (run: prog.exe)
rem valac translates the Vala to C and drives gcc; -X -O2 is what hands -O2 to that gcc,
rem and without it the generated C is compiled unoptimised.
rem valac comes from the MSYS2 UCRT64 tree, so its bin dir goes on PATH for valac itself,
rem for the gcc it drives and for pkg-config (GLib development files). The produced
rem executables import libglib-2.0-0.dll (and libgobject-2.0-0.dll for task 10), which the
rem same directory provides, so verify.py keeps that bin dir on PATH at run time too.
rem Task 03 is a two-file row: add_one lives in 03_func_sum_add_one.vala and is compiled on
rem the same valac command line, so gcc -O2 cannot inline it away.
rem Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in.
rem Output: exec\vala\valac\<task>\prog.exe
set MSYSBIN=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin
set PATH=%MSYSBIN%;%PATH%
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\vala
set OUT=%~dp0valac
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
cd /d "%OUT%\%1"
copy /y "%SRC%\%1.vala" . >nul
if "%1"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.vala" . >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" . >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" . >nul
if exist prog.exe del /q prog.exe
if "%1"=="03_func_sum" (
  valac -X -O2 -o prog 03_func_sum_add_one.vala 03_func_sum.vala > build.log 2>&1
) else (
  valac -X -O2 -o prog %1.vala > build.log 2>&1
)
if exist prog.exe ( echo OK %1 ) else ( echo VALA-FAIL %1 )
exit /b 0
