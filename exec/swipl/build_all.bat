@echo off
rem Build the swipl row: SWI-Prolog is interpreted, so "building" a task is staging its
rem source into the directory the harness runs it from.
rem   exec\swipl\swipl\<task>\<task>.pl   artifact, run as
rem   tools\swipl\bin\swipl.exe -q -O -f none -g main -t halt <task>.pl   from that directory
rem Task 03 also needs its helper module 03_func_sum_add_one.pl (the main file loads it
rem with use_module/1, relative to itself), tasks 14 and 15 the data.bin fixture.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\swipl
set OUT=%ROOT%\exec\swipl\swipl
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.pl" "%OUT%\%%T\%%T.pl" >nul || (echo swipl-FAIL %%T & exit /b 1)
  if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.pl" "%OUT%\%%T\03_func_sum_add_one.pl" >nul || (echo swipl-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul || (echo swipl-FAIL %%T & exit /b 1)
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul || (echo swipl-FAIL %%T & exit /b 1)
  echo OK %%T
)
endlocal
