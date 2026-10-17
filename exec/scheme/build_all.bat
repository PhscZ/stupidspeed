@echo off
rem Build the scheme row: Chez compiles the script on every run (`--script` reads,
rem compiles and runs it), so "building" a task is staging its script into the
rem directory the harness runs it from.
rem   exec\scheme\chez\<task>\<task>.ss   artifact, run as
rem        tools\chez\bin\ta6nt\scheme.exe --optimize-level 3 --script <task>.ss
rem Task 03 also needs its helper 03_func_sum_add_one.ss in the same directory:
rem `load` resolves its argument against the *working directory*, not the script's
rem directory, which is why the cell runs with cwd = the task directory.
rem Tasks 14 and 15 need the data.bin fixture there; task 15 leaves out.bin there,
rem and every task writes its TIME_MS to time.txt (Chez's console-error-port is the
rem console on this host, so the row uses the contract's file fallback).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\scheme
set OUT=%ROOT%\exec\scheme\chez
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.ss" "%OUT%\%%T\%%T.ss" >nul || (echo scheme-FAIL %%T & exit /b 1)
  if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.ss" "%OUT%\%%T\03_func_sum_add_one.ss" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)
endlocal
