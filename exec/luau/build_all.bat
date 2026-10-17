@echo off
rem Build the luau row: Luau is interpreted, so "building" a task is staging its
rem script into the directory the harness runs it from.
rem   exec\luau\luau\<task>\<task>.luau   artifact
rem   tasks 01-10, 12, 13 run as `tools\luau\luau.exe <task>.luau`
rem   tasks 11, 14, 15 need Lute: `tools\lute\lute.exe run <task>.luau`, because the
rem   plain Luau CLI exposes no file I/O and no process API at all.
rem Tasks 14 and 15 need the data.bin fixture in their run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\luau
set OUT=%ROOT%\exec\luau\luau
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.luau" "%OUT%\%%T\%%T.luau" >nul || (echo luau-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  echo OK %%T
)
endlocal
