@echo off
setlocal enabledelayedexpansion
rem Build all 15 Rust tasks natively with rustc 1.97.1 (x86_64-pc-windows-gnu).
rem   rustc -O -o prog.exe <task>.rs
set RUSTC=C:\Users\pz020\.cargo\bin\rustc.exe
set SRC=C:\stupidspeed\sources\rust
set EXEC=C:\stupidspeed\exec\rust

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\rustc\%%T" 2>nul
  cd /d "%EXEC%\rustc\%%T"
  copy /y "%SRC%\%%T.rs" . >nul
  "%RUSTC%" -O -o prog.exe %%T.rs >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo RUST-FAIL %%T )
)
echo ALLDONE
