@echo off
rem Run all fifteen rust-wasm tasks the way exec\rust-wasm\verify.py does:
rem the same prog.wasm through wasmtime's Cranelift backend, which is the
rem registered `rustc (wasm32-wasip1)` cell.  Task 11 needs the threads flags and
rem tasks 14 and 15 the directory preopen.
setlocal
set ROOT=%~dp0..\..
set WASMTIME=%ROOT%\tools\wasmtime46\wasmtime.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\rust-wasm\wasip1\%%T"
  if exist out.bin del /q out.bin
  if "%%T"=="11_parallel_sum" (
    "%WASMTIME%" -C compiler=cranelift -S threads=y -W threads=y -W shared-memory=y prog.wasm
  ) else if "%%T"=="14_file_read" (
    "%WASMTIME%" -C compiler=cranelift --dir . prog.wasm
  ) else if "%%T"=="15_file_write" (
    "%WASMTIME%" -C compiler=cranelift --dir . prog.wasm
  ) else (
    "%WASMTIME%" -C compiler=cranelift prog.wasm
  )
  popd
)
endlocal
