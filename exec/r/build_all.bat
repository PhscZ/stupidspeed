@echo off
rem Build the r row: R is interpreted, so "building" a task is staging its
rem script into the directory the harness runs it from.
rem   exec\r\gnu-r\<task>\<task>.R   artifact, run as `tools\r\bin\Rscript.exe <task>.R`
rem R's byte-code compiler runs inside Rscript (JIT level 3), so there is no
rem ahead-of-time step and nothing to link.
rem Tasks 14 and 15 need the data.bin fixture staged beside them.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\r
set OUT=%ROOT%\exec\r\gnu-r
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.R" "%OUT%\%%T\%%T.R" >nul || (echo r-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)
endlocal
