@echo off
rem Build the rust-wasm row: one source directory, one rustc target, thirteen cells.
rem   exec\rust-wasm\wasip1\<task>\prog.wasm   artifact
rem   run as `tools\wasmtime46\wasmtime.exe -C compiler=cranelift prog.wasm` (and five
rem   other runtimes -- winch, iwasm, node, wasmer cranelift, wasmer llvm -- all on the
rem   same module).
rem Tasks 01-10 and 12-15 build for wasm32-wasip1; task 11 builds for
rem wasm32-wasip1-threads, which is what gives the module its four real threads.
rem Tasks 14 and 15 need the data.bin fixture in their run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\rust-wasm
set CARGOBIN=%USERPROFILE%\.cargo\bin
set RUSTC=%CARGOBIN%\rustc.exe
set OUT=%ROOT%\exec\rust-wasm\wasip1
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0
set "PATH=%CARGOBIN%;%PATH%"

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.rs" "%OUT%\%%T\%%T.rs" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  if "%%T"=="11_parallel_sum" (
    "%RUSTC%" --target wasm32-wasip1-threads -O -o prog.wasm %%T.rs >build.log 2>&1
  ) else (
    "%RUSTC%" --target wasm32-wasip1 -O -o prog.wasm %%T.rs >build.log 2>&1
  )
  if errorlevel 1 (echo rust-wasm-FAIL %%T & type build.log & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo rust-wasm-FAIL some task & exit /b 1)
echo rust-wasm OK
endlocal
