@echo off
setlocal
rem Build all 15 Seed7 tasks with s7c.
rem   Toolchain: Seed7 2026-07-11 (interpreter 5.4.10, s7c 3.5.10) built from the source
rem   release into tools\seed7\seed7 with MSYS2's MSVCRT MinGW gcc (the mingw64 tree), as
rem   BUILD.md says; s7c is tools\seed7\seed7\bin\s7c.exe. The MSVCRT tree is required, not
rem   the UCRT64 one: Seed7's chkccomp probes FILE's _cnt/_ptr fields to build its
rem   read_buffer_empty macro and UCRT's FILE is opaque, so a UCRT64 build stops with
rem   "implicit declaration of function 'read_buffer_empty'" in fil_win.c.
rem   s7c has no code generator of its own: it translates the program to one C file and calls
rem   the C compiler configured when Seed7 was built, so gcc must be on PATH whenever s7c runs.
rem   s7c has no output-name flag: the executable is named after the source file and written
rem   beside it, so each task is compiled as a scratch copy called prog.sd7, which yields
rem   prog.exe in that task directory.
rem   -O2 is not optional: without -O s7c passes no optimisation flag to the C compiler.
rem   Task 03 includes 03_func_sum_add_one.s7i, which is textual, so the helper is copied
rem   beside the scratch copy.
rem   Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in, and
rem   task 15 leaves out.bin there.
rem Output: exec\seed7\s7c\<task>\
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\seed7
set OUT=%~dp0s7c
set S7C=%ROOT%\tools\seed7\seed7\bin\s7c.exe
set PATH=%ROOT%\tools\msys64\msys64\mingw64\bin;%PATH%
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.sd7" "%OUT%\%1\prog.sd7" >nul
if "%1"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.s7i" "%OUT%\%1\03_func_sum_add_one.s7i" >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
pushd "%OUT%\%1"
"%S7C%" -O2 prog.sd7 > build.log 2>&1
popd
if exist "%OUT%\%1\prog.exe" ( echo OK %1 ) else ( echo seed7-FAIL %1 )
exit /b 0
