@echo off
rem Build the quickjs row: QuickJS-ng is a bytecode interpreter with no compile step,
rem so "building" a task is staging its script into the directory the harness runs it
rem from.
rem   exec\quickjs\quickjs\<task>\<task>.js   artifact, run as `qjs.exe --std <task>.js`
rem Tasks 14 and 15 need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\quickjs
set OUT=%ROOT%\exec\quickjs\quickjs
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.js" "%OUT%\%%T\%%T.js" >nul || (echo quickjs-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)
endlocal
