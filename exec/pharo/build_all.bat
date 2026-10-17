@echo off
rem Build the pharo row: Pharo 13 is a prebuilt image, so "building" a task is
rem staging its script into the directory the harness runs it from.
rem   exec\pharo\pharo\<task>\<task>.st   artifact, run as
rem     tools\pharo\PharoConsole.exe --headless tools\pharo\...image st --quit --no-source <task>.st
rem Tasks 14 and 15 need the data.bin fixture in that directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\pharo
set OUT=%ROOT%\exec\pharo\pharo
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.st" "%OUT%\%%T\%%T.st" >nul || (echo pharo-FAIL %%T & set FAIL=1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)

if "%FAIL%"=="1" (echo pharo-FAIL some task & exit /b 1)
echo pharo OK
endlocal
