@echo off
rem Build the perl row: Perl is interpreted, so "building" a task is staging its
rem script into the directory the harness runs it from.
rem   exec\perl\perl\<task>\<task>.pl   artifact, run as `perl <task>.pl`
rem Tasks 14 and 15 also need the data.bin fixture in the run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\perl
set OUT=%ROOT%\exec\perl\perl
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.pl" "%OUT%\%%T\%%T.pl" >nul || (echo perl-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)
endlocal
