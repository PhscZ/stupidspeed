@echo off
rem Run all ninety c-wasm cells the way exec\c-wasm\verify.py does: the six WASI
rem hosts executing the same per-task prog.wasm, each in that task's directory.
rem Task 11's module is the wasi-threads build, so every run line carries the
rem thread flags exec/cells.json records.  Wasmer's two cells get an empty
rem out.bin staged first, because a file the program creates never reaches the
rem host through its WASIX overlay.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\c-wasm\%%T"
  echo === wasmtime-cranelift %%T
  "%ROOT%\tools\wasmtime46\wasmtime.exe" -C compiler=cranelift -S threads=y -W threads=y -W shared-memory=y --dir . prog.wasm
  echo === wasmtime-winch %%T
  "%ROOT%\tools\wasmtime46\wasmtime.exe" -C compiler=winch -S threads=y -W threads=y -W shared-memory=y --dir . prog.wasm
  echo === iwasm %%T
  "%ROOT%\tools\wamr\iwasm.exe" --dir=. prog.wasm
  echo === node-wasip1 %%T
  "%ROOT%\tools\nodejs\node.exe" --no-warnings "%ROOT%\exec\wasi-run.js" prog.wasm .
  if "%%T"=="15_file_write" del /q out.bin 2>nul
  if "%%T"=="15_file_write" copy /y nul out.bin >nul
  echo === wasmer-cranelift %%T
  "%ROOT%\tools\wasmer437\bin\wasmer.exe" run --cranelift --mapdir /:"%ROOT%\exec\c-wasm\%%T" prog.wasm
  if "%%T"=="15_file_write" del /q out.bin 2>nul
  if "%%T"=="15_file_write" copy /y nul out.bin >nul
  echo === wasmer-llvm %%T
  "%ROOT%\tools\wasmer437\bin\wasmer.exe" run --llvm --mapdir /:"%ROOT%\exec\c-wasm\%%T" prog.wasm
  popd
)
endlocal
