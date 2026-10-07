@echo off
setlocal enabledelayedexpansion
rem Row: sources/python-wasm, toolchain: wasip1 (cpython).
rem
rem There is no per-task compilation: all fifteen tasks run the same
rem python.wasm (CPython 3.12.2 cross-compiled to wasm32-wasip1-threads with
rem wasi-sdk 34), so the "build" for each task is copying its script into
rem exec\python-wasm\wasip1\<task>\.  The module itself is built once by
rem build_wasm.sh (see build_wasm.bat / BUILD.md).
set MSYS=C:\stupidspeed\tools\msys64\msys64\usr\bin\bash.exe
set SRC=C:\stupidspeed\sources\python-wasm
set TOOL=C:\stupidspeed\exec\python-wasm\wasip1

if not exist "%TOOL%\python.wasm" (
  echo === building python.wasm
  call "%~dp0build_wasm.bat"
  if not exist "%TOOL%\python.wasm" (
    echo PYTHON-WASM-FAIL python.wasm
    goto :eof
  )
)

rem data.bin is opened relative to the guest cwd, which is the directory the
rem module is run from (exec\python-wasm\wasip1).
copy /y "C:\stupidspeed\data.bin" "%TOOL%\data.bin" >nul

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%TOOL%\%%T" 2>nul
  copy /y "%SRC%\%%T.py" "%TOOL%\%%T\%%T.py" >nul
  rem No per-task compilation for this row: the task is interpreted by the
  rem shared python.wasm, so build.log just records the copy.
  echo copied %SRC%\%%T.py from the sources directory ^(no per-task compile^) > "%TOOL%\%%T\build.log"
  if exist "%TOOL%\%%T\%%T.py" ( echo OK %%T ) else ( echo PYTHON-WASM-FAIL %%T )
)
echo ALLDONE
