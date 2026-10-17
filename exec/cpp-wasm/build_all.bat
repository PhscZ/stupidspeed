@echo off
rem Build the cpp-wasm row: the fifteen C++ sources compiled to wasm32-wasip1 by the
rem wasi-sdk clang++, once per task.  Six runtime entries in exec/cells.json share the
rem single artifact exec\cpp-wasm\<task>\prog.wasm.
rem   clang++ --target=wasm32-wasip1 -O2 -fno-exceptions -o prog.wasm <task>.cpp
rem   task 11 adds -pthread --target=wasm32-wasip1-threads and the four wasi-threads
rem   linker flags, exactly as the C row does.
rem -fno-exceptions is required: libc++abi is not in the sysroot's default link, so
rem tasks 08 and 10 fail at link with `undefined symbol: __cxa_allocate_exception`.
rem Tasks 14 and 15 need the data.bin fixture in the directory the module runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\cpp-wasm
set WS=%ROOT%\tools\wasi-sdk\bin
set OUT=%ROOT%\exec\cpp-wasm
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.cpp" "%OUT%\%%T\%%T.cpp" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  if "%%T"=="11_parallel_sum" (
    "%WS%\clang++.exe" --target=wasm32-wasip1-threads -O2 -fno-exceptions -pthread -Wl,--import-memory -Wl,--export-memory -Wl,--shared-memory -Wl,--max-memory=2147483648 -o prog.wasm %%T.cpp >build.log 2>&1
  ) else (
    "%WS%\clang++.exe" --target=wasm32-wasip1 -O2 -fno-exceptions -o prog.wasm %%T.cpp >build.log 2>&1
  )
  if errorlevel 1 (echo cpp-wasm-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo cpp-wasm-FAIL some task & exit /b 1)
echo cpp-wasm OK
endlocal
