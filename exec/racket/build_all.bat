@echo off
setlocal
rem Build all 15 Racket tasks.
rem   There is no compile step: Racket.exe compiles the module on every run and the VM
rem   start is part of the measured time, so "building" here is copying the row's sources
rem   into exec\racket\racket\<task>\ so each task runs from its own directory.
rem   Task 03 needs its helper module 03_func_sum_add_one.rkt beside it (a two-file row).
rem   Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in.
rem Output: exec\racket\racket\<task>\
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\racket
set OUT=%~dp0racket
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.rkt" "%OUT%\%1\%1.rkt" >nul
if "%1"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.rkt" "%OUT%\%1\03_func_sum_add_one.rkt" >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
echo no build step: Racket.exe compiles the module on every run > "%OUT%\%1\build.log"
if exist "%OUT%\%1\%1.rkt" ( echo OK %1 ) else ( echo racket-FAIL %1 )
exit /b 0
