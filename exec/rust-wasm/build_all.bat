@echo off
setlocal enabledelayedexpansion
rem Build all 15 Rust tasks for wasm32-wasip1 with rustc 1.97.1.
rem   rustc --target wasm32-wasip1 -O -o prog.wasm <task>.rs
rem Task 11 is threaded (tier 3 target wasm32-wasip1-threads, std present):
rem   rustc --target wasm32-wasip1-threads -O -o prog.wasm 11_parallel_sum.rs
rem Run with tools\wasmtime46\wasmtime.exe prog.wasm
set RUSTC=C:\Users\pz020\.cargo\bin\rustc.exe
set SRC=C:\stupidspeed\sources\rust-wasm
set EXEC=C:\stupidspeed\exec\rust-wasm

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\wasip1\%%T" 2>nul
  cd /d "%EXEC%\wasip1\%%T"
  copy /y "%SRC%\%%T.rs" . >nul
  if "%%T"=="11_parallel_sum" (
    "%RUSTC%" --target wasm32-wasip1-threads -O -o prog.wasm %%T.rs >build.log 2>&1
  ) else (
    "%RUSTC%" --target wasm32-wasip1 -O -o prog.wasm %%T.rs >build.log 2>&1
  )
  if exist prog.wasm ( echo OK %%T ) else ( echo RUSTWASM-FAIL %%T )
)
echo ALLDONE
