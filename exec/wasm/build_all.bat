@echo off
rem Build the wasm row: hand-written WebAssembly text, no front end at all.
rem
rem   exec\wasm\wat\<task>\<task>.wat   artifact for the four wasmtime cells
rem                                    (wasmtime parses the text form itself)
rem   exec\wasm\wat\<task>\prog.wasm   artifact for the two Wasmer cells, which
rem                                    cannot read .wat, assembled with wabt's
rem                                    wat2wasm
rem
rem Task 11's module is a wasi-threads module, so its assembly needs
rem --enable-threads (and *not* --enable-all, which turns on compact imports and
rem makes both wasmtime and Wasmer reject the module).
rem Tasks 14 and 15 read data.bin / write out.bin in the cell's directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\wasm
set OUT=%ROOT%\exec\wasm\wat
set WAT2WASM=%ROOT%\tools\wabt\wabt-1.0.42\bin\wat2wasm.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.wat" "%OUT%\%%T\%%T.wat" >nul || (echo wasm-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  set FLAGS=
  if "%%T"=="11_parallel_sum" set FLAGS=--enable-threads
  "%WAT2WASM%" !FLAGS! "%OUT%\%%T\%%T.wat" -o "%OUT%\%%T\prog.wasm" > "%OUT%\%%T\build.log" 2>&1 || (echo wasm-FAIL %%T & exit /b 1)
  echo OK %%T
)
endlocal
