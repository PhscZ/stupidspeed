@echo off
setlocal enabledelayedexpansion
rem Build all 15 AssemblyScript tasks into exec\assemblyscript\<task>\prog.wasm
rem asc translates the .ts straight to WebAssembly. The module is a WASI command that
rem exports _start and writes its answer to fd 1, so wasmtime runs it with no arguments.
rem The `--use abort=<task>/abortImpl` specifier is resolved relative to the source file,
rem which is why each task is built from its own directory with the source under its own
rem name — the abort handler is defined in the task file itself.
set ASC=C:\stupidspeed\tools\assemblyscript\node_modules\.bin\asc.cmd
set SRC=C:\stupidspeed\sources\assemblyscript
set EXEC=C:\stupidspeed\exec\assemblyscript

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.ts" . >nul
  set TFLAGS=
  if "%%T"=="11_parallel_sum" set TFLAGS=--enable threads --importMemory --sharedMemory --maximumMemory 1024
  call "%ASC%" %%T.ts -O2 --outFile prog.wasm --runtime incremental --use abort=%%T/abortImpl !TFLAGS! >asc.log 2>&1
  if exist prog.wasm ( echo OK %%T ) else ( echo ASC-FAIL %%T & type asc.log )
)
echo ALLDONE
