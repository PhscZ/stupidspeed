@echo off
rem quickjs row: no build step, interpreted by qjs.exe (QuickJS-ng 0.11.0).
rem This script only stages each task's source (and the data.bin fixture for 14/15)
rem into exec\quickjs\quickjs\<task>\ and logs the copy to build.log.
rem Run line per the source header: qjs.exe --std <task>.js
setlocal enabledelayedexpansion
set "ROW=quickjs"
set "HERE=%~dp0"
set "SRC=%~dp0..\..\sources\quickjs"
set "DATA=%~dp0..\..\data.bin"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

for %%F in (%TASKS%) do (
  set "D=%HERE%quickjs\%%F"
  if not exist "!D!" mkdir "!D!"
  copy /Y "%SRC%\%%F.js" "!D!\%%F.js" > "!D!\build.log" 2>&1
  if errorlevel 1 (
    echo %ROW%-FAIL %%F
  ) else (
    if "%%F"=="14_file_read" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
    if "%%F"=="15_file_write" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
    echo OK %%F
  )
)
endlocal
