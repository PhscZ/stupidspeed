@echo off
setlocal enabledelayedexpansion
rem Build all 15 C++ tasks for wasm32-wasip1 with wasi-sdk 34 (LLVM 23.1).
rem   clang++ --target=wasm32-wasip1 -O2 -fno-exceptions -o prog.wasm <task>.cpp
rem -fno-exceptions is required: libc++abi is not in the sysroot's default link, so tasks
rem 08 and 10 fail at link with undefined __cxa_allocate_exception without it.
rem Task 11 is threaded and adds the same four flags as the C row:
rem   -pthread --target=wasm32-wasip1-threads -Wl,--import-memory -Wl,--export-memory
rem   -Wl,--shared-memory -Wl,--max-memory=2147483648
rem Run with tools\wasmtime46\wasmtime.exe prog.wasm
set CLANGPP=C:\stupidspeed\tools\wasi-sdk\bin\clang++.exe
set SRC=C:\stupidspeed\sources\cpp-wasm
set EXEC=C:\stupidspeed\exec\cpp-wasm

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.cpp" . >nul
  if "%%T"=="11_parallel_sum" (
    "%CLANGPP%" -pthread --target=wasm32-wasip1-threads -O2 -fno-exceptions -Wl,--import-memory -Wl,--export-memory -Wl,--shared-memory -Wl,--max-memory=2147483648 -o prog.wasm 11_parallel_sum.cpp >build.log 2>&1
  ) else (
    "%CLANGPP%" --target=wasm32-wasip1 -O2 -fno-exceptions -o prog.wasm %%T.cpp >build.log 2>&1
  )
  if exist prog.wasm ( echo OK %%T ) else ( echo CPPWASM-FAIL %%T )
)
echo ALLDONE
