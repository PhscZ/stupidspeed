@echo off
rem Build the c-wasm row: the same fifteen C sources through the wasi-sdk clang,
rem one prog.wasm per task directory.  Six runtimes (wasmtime cranelift/winch,
rem iwasm, node's WASI shim, Wasmer cranelift/llvm) then execute that one module.
rem   exec\c-wasm\<task>\prog.wasm   clang --target=wasm32-wasip1 -O2
rem Task 11 adds the four thread flags and the wasm32-wasip1-threads target.
rem Every task needs its source staged beside the module; tasks 14 and 15 also
rem need the data.bin fixture in the directory the module runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\c-wasm
set CLANG=%ROOT%\tools\wasi-sdk\bin\clang.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\c-wasm\%%T" mkdir "%ROOT%\exec\c-wasm\%%T"
  copy /y "%SRC%\%%T.c" "%ROOT%\exec\c-wasm\%%T\%%T.c" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\c-wasm\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\c-wasm\%%T\data.bin" >nul
)

rem ---- the ordinary tasks: one wasip1 module per task.
for %%T in (%TASKS%) do (
  if not "%%T"=="11_parallel_sum" (
    pushd "%ROOT%\exec\c-wasm\%%T"
    "%CLANG%" --target=wasm32-wasip1 -O2 -o prog.wasm %%T.c >build.log 2>&1
    if errorlevel 1 (echo c-wasm-FAIL %%T & set FAIL=1) else (echo OK %%T)
    popd
  )
)

rem ---- task 11: the wasi-threads build.  -pthread selects wasm32-wasip1-threads
rem and the four link flags hand the linear memory to the host, which the ABI
rem requires; --max-memory is the 2 GiB ceiling the registry's run lines assume.
pushd "%ROOT%\exec\c-wasm\11_parallel_sum"
"%CLANG%" -pthread --target=wasm32-wasip1-threads -O2 -Wl,--import-memory -Wl,--export-memory -Wl,--shared-memory -Wl,--max-memory=2147483648 -o prog.wasm 11_parallel_sum.c >build.log 2>&1
if errorlevel 1 (echo c-wasm-FAIL 11_parallel_sum & set FAIL=1) else (echo OK 11_parallel_sum)
popd

if "%FAIL%"=="1" (echo c-wasm-FAIL some task & exit /b 1)
echo c-wasm OK
endlocal
