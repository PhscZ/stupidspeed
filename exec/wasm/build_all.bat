@echo off
setlocal enabledelayedexpansion
rem Build all 15 hand-written WebAssembly (WAT) tasks.
rem   wat   wasmtime parses the .wat text form directly, so there is NO build step:
rem         the .wat is both the source and the runnable artifact. "Building" is
rem         just staging the source into exec\wasm\wat\<task>\.
rem Run lines: wasmtime.exe run <task>.wat; task 11 adds -S threads=y -W threads=y
rem -W shared-memory=y (wasi-threads, needs wasmtime 46); tasks 14/15 add --dir=.
rem TIME_MS goes to stderr (fd 2), so no time.txt here.
set WT=C:\stupidspeed\tools\wasmtime46\wasmtime.exe
set SRC=C:\stupidspeed\sources\wasm
set EXEC=C:\stupidspeed\exec\wasm
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

if not exist "%WT%" (
  echo WASM-FAIL wasmtime.exe not found at %WT%
  echo ALLDONE
  exit /b 1
)

echo ########## wat (hand-written WebAssembly text -- no build step)
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\wat\%%T" 2>nul
  copy /y "%SRC%\%%T.wat" "%EXEC%\wat\%%T\" >nul
  echo no build step: wasmtime run %%T.wat parses the text form on every run > "%EXEC%\wat\%%T\build.log"
  if exist "%EXEC%\wat\%%T\%%T.wat" ( echo OK %%T ) else ( echo WASM-FAIL %%T )
)

rem tasks 14 and 15 need the 50 MiB fixture in the working directory
copy /y "%DATA%" "%EXEC%\wat\14_file_read\data.bin" >nul
copy /y "%DATA%" "%EXEC%\wat\15_file_write\data.bin" >nul

echo ALLDONE
