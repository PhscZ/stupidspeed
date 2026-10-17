@echo off
rem Build the tcl row: Tcl is interpreted, so "building" a task is staging its
rem script into the directory the harness runs it from.
rem   exec\tcl\tclsh\<task>\<task>.tcl   artifact, run as `tclsh <task>.tcl`
rem Task 03 also needs its helper, tasks 14 and 15 the data.bin fixture.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\tcl
set OUT=%ROOT%\exec\tcl\tclsh
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.tcl" "%OUT%\%%T\%%T.tcl" >nul || (echo tcl-FAIL %%T & exit /b 1)
  if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.tcl" "%OUT%\%%T\03_func_sum_add_one.tcl" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)
endlocal
