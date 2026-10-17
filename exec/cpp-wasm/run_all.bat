@echo off
rem Run all fifteen cpp-wasm tasks the way exec\cpp-wasm\verify.py does -- the same
rem prog.wasm under each of the six runtimes exec/cells.json records.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set RUN=%ROOT%\exec\cpp-wasm
set WASMTIME=%ROOT%\tools\wasmtime46\wasmtime.exe
set IWASM=%ROOT%\tools\wamr\iwasm.exe
set NODE=%ROOT%\tools\nodejs\node.exe
set WASI=%ROOT%\exec\wasi-run.js
set WASMER=%ROOT%\tools\wasmer437\bin\wasmer.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do (
  pushd "%RUN%\%%T"
  if "%%T"=="15_file_write" del /q out.bin >nul 2>&1
  echo === %%T clang++ ^(wasm32-wasip1^)
  "%WASMTIME%" -C compiler=cranelift -S threads=y -W threads=y -W shared-memory=y --dir . prog.wasm
  echo === %%T wasmtime ^(winch^)
  "%WASMTIME%" -C compiler=winch -S threads=y -W threads=y -W shared-memory=y --dir . prog.wasm
  echo === %%T iwasm
  "%IWASM%" --dir=. prog.wasm
  echo === %%T node ^(wasip1^)
  "%NODE%" --no-warnings "%WASI%" prog.wasm .
  echo === %%T wasmer ^(cranelift^)
  if "%%T"=="15_file_write" type nul > out.bin
  "%WASMER%" run --cranelift --mapdir "/:!CD!" prog.wasm
  echo === %%T wasmer ^(llvm^)
  if "%%T"=="15_file_write" type nul > out.bin
  "%WASMER%" run --llvm --mapdir "/:!CD!" prog.wasm
  popd
)
endlocal
