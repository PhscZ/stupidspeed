@echo off
rem Run all fifteen zig-wasm tasks the way exec\zig-wasm\verify.py does -- the same
rem prog.wasm under each of the four runtimes exec/cells.json records, with the
rem registry's per-task command split (threads flags on task 11, --dir=. on 14/15).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set RUN=%ROOT%\exec\zig-wasm\wasip1
set WASMTIME=%ROOT%\tools\wasmtime46\wasmtime.exe
set IWASM=%ROOT%\tools\wamr\iwasm.exe
set NODE=%ROOT%\tools\nodejs\node.exe
set WASI=%ROOT%\exec\wasi-run.js
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set THREADS=-S threads=y -W threads=y -W shared-memory=y

for %%T in (%TASKS%) do (
  set DIRFLAG=
  if "%%T"=="14_file_read" set DIRFLAG=--dir=.
  if "%%T"=="15_file_write" set DIRFLAG=--dir=.
  set THREADFLAG=
  if "%%T"=="11_parallel_sum" set THREADFLAG=%THREADS%
  pushd "%RUN%\%%T"
  echo === %%T wasm32-wasip1 ^(zig^)
  "%WASMTIME%" run -C compiler=cranelift !THREADFLAG! !DIRFLAG! prog.wasm
  echo === %%T wasmtime ^(winch^)
  "%WASMTIME%" run -C compiler=winch !THREADFLAG! !DIRFLAG! prog.wasm
  echo === %%T iwasm
  "%IWASM%" !DIRFLAG! prog.wasm
  echo === %%T node ^(wasip1^)
  "%NODE%" --no-warnings "%WASI%" prog.wasm .
  popd
)
endlocal
