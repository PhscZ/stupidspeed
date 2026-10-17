@echo off
rem Build the gforth row: gforth interprets the file, so "building" a task is
rem staging its script into the directory the harness runs it from.
rem   exec\gforth\<task>.fs   artifact, run as `tools/gforth/gforth.exe <task>.fs`
rem cwd is exec\gforth, so the sources are staged flat. gforth.exe finds its image
rem gforth.fi beside the executable, so no GFORTHPATH is needed. Task 03 also needs
rem its helper, tasks 14 and 15 the data.bin fixture (read from the cwd).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\gforth
set OUT=%ROOT%\exec\gforth
if not exist "%OUT%" mkdir "%OUT%"
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  copy /y "%SRC%\%%T.fs" "%OUT%\%%T.fs" >nul || (echo gforth-FAIL %%T & exit /b 1)
  if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.fs" "%OUT%\03_func_sum_add_one.fs" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul
  echo OK %%T
)
endlocal
