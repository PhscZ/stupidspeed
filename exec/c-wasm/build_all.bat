@echo off
setlocal enabledelayedexpansion
rem Build all 15 C tasks for wasm32-wasip1 with wasi-sdk 34 (LLVM 23.1).
rem   clang --target=wasm32-wasip1 -O2 -o prog.wasm <task>.c
rem Task 11 is threaded and needs a different target plus shared-memory flags:
rem   -pthread --target=wasm32-wasip1-threads -Wl,--import-memory -Wl,--export-memory
rem   -Wl,--shared-memory -Wl,--max-memory=2147483648
rem Run with tools\wasmtime46\wasmtime.exe prog.wasm
set CLANG=C:\stupidspeed\tools\wasi-sdk\bin\clang.exe
set SRC=C:\stupidspeed\sources\c-wasm
set EXEC=C:\stupidspeed\exec\c-wasm

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.c" . >nul
  if "%%T"=="11_parallel_sum" (
    "%CLANG%" -pthread --target=wasm32-wasip1-threads -O2 -Wl,--import-memory -Wl,--export-memory -Wl,--shared-memory -Wl,--max-memory=2147483648 -o prog.wasm 11_parallel_sum.c >build.log 2>&1
  ) else (
    "%CLANG%" --target=wasm32-wasip1 -O2 -o prog.wasm %%T.c >build.log 2>&1
  )
  if exist prog.wasm ( echo OK %%T ) else ( echo CWASM-FAIL %%T )
)
echo ALLDONE
