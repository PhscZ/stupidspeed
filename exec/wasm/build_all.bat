@echo off
setlocal enabledelayedexpansion
rem Build all 15 hand-written WebAssembly (WAT) tasks.
rem   wat   wasmtime parses the .wat text form directly, so there is NO build step
rem         for it: the .wat is both the source and the runnable artifact.
rem         "Building" is just staging the source into exec\wasm\wat\<task>\.
rem   wasm  wasmer cannot read the text form, so the same .wat is also assembled
rem         to exec\wasm\wat\<task>\prog.wasm with wabt's wat2wasm. That .wasm is
rem         the committed build artifact the wasmer cells run.
rem         Task 11 needs --enable-threads for the atomics and the shared memory.
rem         Do NOT use --enable-all there: it also turns on compact imports, and
rem         both wasmtime and wasmer then reject the module with
rem         "invalid leading byte (0x7f) for external kind".
rem Run lines:
rem   wasmtime.exe run <task>.wat
rem   tools\wasmer437\bin\wasmer.exe run --cranelift prog.wasm
rem Task 11 adds -S threads=y -W threads=y -W shared-memory=y for wasmtime;
rem wasmer has threads on by default. Tasks 14/15 add --dir=. (wasmtime) or
rem --mapdir /:<dir> (wasmer). TIME_MS goes to stderr (fd 2), so no time.txt.
set WT=C:\stupidspeed\tools\wasmtime46\wasmtime.exe
set W2W=C:\stupidspeed\tools\wabt\wabt-1.0.42\bin\wat2wasm.exe
set SRC=C:\stupidspeed\sources\wasm
set EXEC=C:\stupidspeed\exec\wasm
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

if not exist "%WT%" (
  echo WASM-FAIL wasmtime.exe not found at %WT%
  echo ALLDONE
  exit /b 1
)

echo ########## wat (hand-written WebAssembly text -- no build step)
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\wat\%%T" 2>nul
  copy /y "%SRC%\%%T.wat" "%EXEC%\wat\%%T\" >nul
  echo no build step: wasmtime run %%T.wat parses the text form on every run > "%EXEC%\wat\%%T\build.log"
  if exist "%EXEC%\wat\%%T\%%T.wat" ( echo OK %%T ) else ( echo WASM-FAIL %%T )
)

rem tasks 14 and 15 need the 50 MiB fixture in the working directory
copy /y "%DATA%" "%EXEC%\wat\14_file_read\data.bin" >nul
copy /y "%DATA%" "%EXEC%\wat\15_file_write\data.bin" >nul

if not exist "%W2W%" (
  echo WASM-WARN wat2wasm not found at %W2W% -- the wasmer cells have no module
  echo ALLDONE
  exit /b 1
)

echo ########## wasm (wat2wasm -- the artifact the wasmer cells run)
for %%T in (%TASKS%) do (
  pushd "%EXEC%\wat\%%T"
  if "%%T"=="11_parallel_sum" (
    "%W2W%" --enable-threads %%T.wat -o prog.wasm >> build.log 2>&1
  ) else (
    "%W2W%" %%T.wat -o prog.wasm >> build.log 2>&1
  )
  if exist prog.wasm ( echo OK wasm %%T ) else ( echo WASM-FAIL wasm %%T )
  popd
)

echo ALLDONE
