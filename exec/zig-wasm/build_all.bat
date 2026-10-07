@echo off
setlocal
set ROOT=C:\stupidspeed
set SRC=%ROOT%\sources\zig-wasm
set OUT=%ROOT%\exec\zig-wasm\wasip1
set ZIG=%ROOT%\tools\zig\zig.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :build %%T
exit /b 0

:build
set T=%1
if not exist "%OUT%\%T%" mkdir "%OUT%\%T%"
copy /y "%SRC%\%T%.zig" "%OUT%\%T%\" >nul
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%T%\" >nul
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%T%\" >nul
del /q "%OUT%\%T%\out.bin" 2>nul
pushd "%OUT%\%T%"
if "%T%"=="11_parallel_sum" (
  "%ZIG%" build-exe 11_parallel_sum.zig -target wasm32-wasi -O ReleaseFast -fno-single-threaded -mcpu=generic+atomics+bulk_memory --shared-memory --import-memory --export-memory --max-memory=2147483648 -rdynamic -femit-bin=prog.wasm > build.log 2>&1
) else (
  "%ZIG%" build-exe %T%.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm > build.log 2>&1
)
if errorlevel 1 (echo zig-wasm-FAIL %T%) else (echo OK %T%)
popd
exit /b 0
