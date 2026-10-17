@echo off
rem Build the zig-wasm row: fifteen Zig sources compiled to wasm32-wasip1 by
rem tools\zig\zig.exe, one artifact per task under exec\zig-wasm\wasip1\<task>\.
rem   zig build-exe <task>.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm
rem Task 11 is the threads+atomics build, and needs the extra flags the source
rem header lists: -fno-single-threaded -mcpu=generic+atomics+bulk_memory
rem --shared-memory --import-memory --export-memory --max-memory=2147483648
rem -rdynamic.  -rdynamic is load-bearing: wasm-ld only exports a symbol in the
rem dynamic table, and wasmtime's wasi-threads looks for an exported
rem `wasi_thread_start` entry point.
rem Tasks 14 and 15 need the data.bin fixture in the directory the module runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\zig-wasm
set ZIG=%ROOT%\tools\zig\zig.exe
set OUT=%ROOT%\exec\zig-wasm\wasip1
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.zig" "%OUT%\%%T\%%T.zig" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  if "%%T"=="11_parallel_sum" (
    "%ZIG%" build-exe %%T.zig -target wasm32-wasi -O ReleaseFast -fno-single-threaded -mcpu=generic+atomics+bulk_memory --shared-memory --import-memory --export-memory --max-memory=2147483648 -rdynamic -femit-bin=prog.wasm >build.log 2>&1
  ) else (
    "%ZIG%" build-exe %%T.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm >build.log 2>&1
  )
  if errorlevel 1 (echo zig-wasm-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo zig-wasm-FAIL some task & exit /b 1)
echo zig-wasm OK
endlocal
