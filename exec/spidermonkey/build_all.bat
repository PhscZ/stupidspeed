@echo off
rem Build the spidermonkey row: the JavaScript shell is interpreted, so "building"
rem a task is staging its script into the directory the harness runs it from.
rem   exec\spidermonkey\spidermonkey\<task>\<task>.js   artifact
rem   run as `tools\spidermonkey\js.exe <task>.js`
rem Tasks 14 and 15 need the data.bin fixture in their run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\spidermonkey
set OUT=%ROOT%\exec\spidermonkey\spidermonkey
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.js" "%OUT%\%%T\%%T.js" >nul || (echo spidermonkey-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)
endlocal
