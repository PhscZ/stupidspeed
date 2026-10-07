@echo off
setlocal
rem Build all 15 SWI-Prolog tasks.
rem   There is no compile step: swipl loads and compiles the source on every run and that
rem   is part of the measured time, so "building" here is copying the row's sources into
rem   exec\swipl\swipl\<task>\ so each task runs from its own directory.
rem   Task 03 needs its helper module 03_func_sum_add_one.pl beside it (a two-file row),
rem   loaded with use_module/1 relative to the working directory.
rem   Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in.
rem   Run line: tools\swipl\bin\swipl.exe -q -O -f none -g main -t halt <task>.pl
rem   -O is load-bearing (it compiles the arithmetic and drops redundant true/0).
rem Output: exec\swipl\swipl\<task>\
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\swipl
set OUT=%~dp0swipl
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.pl" "%OUT%\%1\%1.pl" >nul
if "%1"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.pl" "%OUT%\%1\03_func_sum_add_one.pl" >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
echo no build step: swipl compiles the source on every run > "%OUT%\%1\build.log"
if exist "%OUT%\%1\%1.pl" ( echo OK %1 ) else ( echo SWIPL-FAIL %1 )
exit /b 0
