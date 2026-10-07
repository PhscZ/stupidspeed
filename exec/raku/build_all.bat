@echo off
setlocal
rem Build all 15 Raku tasks.
rem   There is no compile step: raku.exe interprets <task>.raku directly and the interpreter
rem   start-up is inside the measured time, so "building" here is copying the row's sources
rem   into exec\raku\rakudo\<task>\ so each task runs from its own directory.
rem   Task 03 needs its helper module AddOne.rakumod beside it (a two-file row).
rem   Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in.
rem Output: exec\raku\rakudo\<task>\
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\raku
set OUT=%~dp0rakudo
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.raku" "%OUT%\%1\%1.raku" >nul
if "%1"=="03_func_sum" copy /y "%SRC%\AddOne.rakumod" "%OUT%\%1\AddOne.rakumod" >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
echo no build step: raku.exe interprets the script on every run > "%OUT%\%1\build.log"
if exist "%OUT%\%1\%1.raku" ( echo OK %1 ) else ( echo raku-FAIL %1 )
exit /b 0
