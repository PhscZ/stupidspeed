@echo off
rem Run all sixty wasm-row programs the way exec\wasm\verify.py does: the four
rem toolchain cells (wasmtime Cranelift, wasmtime Winch, Wasmer Cranelift, Wasmer
rem LLVM) over the fifteen tasks, each in its own task directory.
rem
rem The two wasmtime cells run the .wat text form, which wasmtime parses itself;
rem task 11 needs the wasi-threads flags and tasks 14/15 need --dir=. The two
rem Wasmer cells run the assembled prog.wasm (Wasmer cannot read .wat) with the
rem task directory mapped to / so the file tasks can reach data.bin/out.bin.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set WASMTIME=%ROOT%\tools\wasmtime46\wasmtime.exe
set WASMER=%ROOT%\tools\wasmer437\bin\wasmer.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%G in (cranelift winch) do (
  for %%T in (%TASKS%) do (
    echo === wasmtime (%%G) %%T
    pushd "%ROOT%\exec\wasm\wat\%%T"
    set FLAGS=-C compiler=%%G
    if "%%T"=="11_parallel_sum" set FLAGS=-C compiler=%%G -S threads=y -W threads=y -W shared-memory=y
    if "%%T"=="14_file_read" set FLAGS=-C compiler=%%G --dir=.
    if "%%T"=="15_file_write" set FLAGS=-C compiler=%%G --dir=.
    "%WASMTIME%" run !FLAGS! %%T.wat
    popd
  )
)

for %%G in (--cranelift --llvm) do (
  for %%T in (%TASKS%) do (
    echo === wasmer (%%G) %%T
    pushd "%ROOT%\exec\wasm\wat\%%T"
    rem Wasmer cannot create a file inside a mapped directory (WASIX overlays it
    rem and discards the overlay at exit), so task 15's out.bin is pre-created,
    rem exactly as the registry's create_out tells the harness to.
    if "%%T"=="15_file_write" type nul > out.bin
    "%WASMER%" run %%G --mapdir /:%ROOT%\exec\wasm\wat\%%T prog.wasm
    popd
  )
)
endlocal
