@echo off
setlocal
rem Build all 15 Chez Scheme tasks.
rem   There is no compile step: `scheme --optimize-level 3 --script <task>.ss` compiles the
rem   script on every run and the boot-file load plus the compile are part of the measured
rem   time, so "building" here is copying the row's sources into exec\scheme\chez\<task>\
rem   so each task runs from its own directory.
rem   Task 03 needs its helper file 03_func_sum_add_one.ss beside it (a two-file row; the
rem   task source `load`s it).
rem   Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in, and
rem   task 15 leaves out.bin there.
rem   The interpreter is the threaded build ta6nt, the only one with fork-thread, so it is
rem   the one RUN.md names; it finds its boot file at ..\..\boot\ta6nt relative to itself.
rem Output: exec\scheme\chez\<task>\
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\scheme
set OUT=%~dp0chez
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.ss" "%OUT%\%1\%1.ss" >nul
if "%1"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.ss" "%OUT%\%1\03_func_sum_add_one.ss" >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
echo no build step: scheme --optimize-level 3 --script %1.ss compiles the script on every run > "%OUT%\%1\build.log"
if exist "%OUT%\%1\%1.ss" ( echo OK %1 ) else ( echo scheme-FAIL %1 )
exit /b 0
