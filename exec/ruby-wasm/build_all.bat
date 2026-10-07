@echo off
setlocal enabledelayedexpansion
rem Ruby (ruby.wasm) — wasip1, no build step: the interpreter is the module.
rem   run: tools\wasmtime46\wasmtime.exe --dir . tools\ruby-wasm\ruby.wasm <task>.rb
rem Every cell needs --dir . because the script itself is read through the preopen.
rem We only stage the sources into each task directory here.
set SRC=C:\stupidspeed\sources\ruby-wasm
set EXEC=C:\stupidspeed\exec\ruby-wasm

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\wasip1\%%T" 2>nul
  cd /d "%EXEC%\wasip1\%%T"
  copy /y "%SRC%\%%T.rb" . >nul
  echo no build step ^(interpreted^) >build.log 2>&1
  if exist %%T.rb ( echo OK %%T ) else ( echo RUBYWASM-FAIL %%T )
)
echo ALLDONE
