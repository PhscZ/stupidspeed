@echo off
setlocal
rem Build all 15 Tcl tasks.
rem   There is no compile step: tclsh parses and executes the script on every run and that
rem   is part of the measured time, so "building" here is copying the row's sources into
rem   exec\tcl\tclsh\<task>\ so each task runs from its own directory.
rem   Task 03 is a two-file row: it sources 03_func_sum_add_one.tcl relative to [info script].
rem   Task 11 needs the Thread extension, which the MSYS2 UCRT64 tcl package bundles
rem   (Thread 2.8.13, package require Thread resolves inside tclsh with no extra env).
rem   Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in.
rem   Run line: tools\msys64\msys64\ucrt64\bin\tclsh.exe <task>.tcl
rem Output: exec\tcl\tclsh\<task>\
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\tcl
set OUT=%~dp0tclsh
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.tcl" "%OUT%\%1\%1.tcl" >nul
if "%1"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.tcl" "%OUT%\%1\03_func_sum_add_one.tcl" >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
echo no build step: tclsh parses and executes the script on every run > "%OUT%\%1\build.log"
if exist "%OUT%\%1\%1.tcl" ( echo OK %1 ) else ( echo TCL-FAIL %1 )
exit /b 0
