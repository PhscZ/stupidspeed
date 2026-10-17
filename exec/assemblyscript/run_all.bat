@echo off
rem Run all ninety assemblyscript cells the way exec\assemblyscript\verify.py does:
rem the same prog.wasm under six runtimes -- wasmtime's two code generators, WAMR's
rem iwasm, node's V8 through the repository's WASI shim, and Wasmer's two.
rem Task 11 gets the threads flags (wasmtime), tasks 14 and 15 the directory preopen.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set WASMTIME=%ROOT%\tools\wasmtime46\wasmtime.exe
set IWASM=%ROOT%\tools\wamr\iwasm.exe
set NODE=%ROOT%\tools\nodejs\node.exe
set WASMER=%ROOT%\tools\wasmer437\bin\wasmer.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\assemblyscript\%%T"
  if "%%T"=="11_parallel_sum" (
    echo === asc (wasip1) %%T
    "%WASMTIME%" run -C compiler=cranelift -S threads=y -W threads=y -W shared-memory=y prog.wasm
    echo === wasmtime (winch) %%T
    "%WASMTIME%" run -C compiler=winch -S threads=y -W threads=y -W shared-memory=y prog.wasm
  ) else if "%%T"=="14_file_read" (
    echo === asc (wasip1) %%T
    "%WASMTIME%" run -C compiler=cranelift --dir=. prog.wasm
    echo === wasmtime (winch) %%T
    "%WASMTIME%" run -C compiler=winch --dir=. prog.wasm
  ) else if "%%T"=="15_file_write" (
    echo === asc (wasip1) %%T
    "%WASMTIME%" run -C compiler=cranelift --dir=. prog.wasm
    echo === wasmtime (winch) %%T
    "%WASMTIME%" run -C compiler=winch --dir=. prog.wasm
  ) else (
    echo === asc (wasip1) %%T
    "%WASMTIME%" run -C compiler=cranelift prog.wasm
    echo === wasmtime (winch) %%T
    "%WASMTIME%" run -C compiler=winch prog.wasm
  )
  echo === iwasm %%T
  if "%%T"=="14_file_read" (
    "%IWASM%" --dir=. prog.wasm
  ) else if "%%T"=="15_file_write" (
    "%IWASM%" --dir=. prog.wasm
  ) else (
    "%IWASM%" prog.wasm
  )
  echo === node (wasip1) %%T
  "%NODE%" --no-warnings "%ROOT%\exec\wasi-run.js" prog.wasm .
  echo === wasmer (cranelift) %%T
  if "%%T"=="15_file_write" (type nul > out.bin)
  "%WASMER%" run --cranelift --mapdir /:"%CD%" prog.wasm
  echo === wasmer (llvm) %%T
  if "%%T"=="15_file_write" (type nul > out.bin)
  "%WASMER%" run --llvm --mapdir /:"%CD%" prog.wasm
  popd
)
endlocal
