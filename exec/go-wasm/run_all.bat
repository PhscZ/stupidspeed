@echo off
rem Run all ninety go-wasm cells the way exec\go-wasm\verify.py does: the six WASI
rem hosts executing the same per-task prog.wasm, each in that task's directory.
rem Pass one task name to run just that task:  run_all.bat 14_file_read
rem Go's wasip1 port is single-threaded, so no run line carries thread flags.
rem Tasks 14 and 15 get a preopened root (Go opens its preopens by the WASI name
rem and expects "/"):
rem   wasmtime  --dir <dir>::/        iwasm  --map-dir=/::.
rem   wasmer    --mapdir /:<dir>
rem Wasmer cannot create a file on the host through its WASIX overlay, and the
rem registry marks iwasm the same way, so those cells get an empty out.bin staged
rem first and task 15 overwrites it.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set WT=%ROOT%\tools\wasmtime46\wasmtime.exe
set IW=%ROOT%\tools\wamr\iwasm.exe
set ND=%ROOT%\tools\nodejs\node.exe
set WS=%ROOT%\tools\wasmer437\bin\wasmer.exe
set TASKS=%*
if "%TASKS%"=="" set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do call :task %%T
exit /b 0

:task
pushd "%ROOT%\exec\go-wasm\%~1"
if not exist prog.wasm (
  echo MISSING exec\go-wasm\%~1\prog.wasm
  popd
  exit /b 1
)
if "%~1"=="14_file_read" if not exist data.bin copy /y "%ROOT%\data.bin" data.bin >nul
if "%~1"=="15_file_write" if not exist data.bin copy /y "%ROOT%\data.bin" data.bin >nul
if "%~1"=="14_file_read" goto preopen
if "%~1"=="15_file_write" goto preopen

echo === wasmtime-cranelift %~1
"%WT%" -C compiler=cranelift prog.wasm
echo === wasmtime-winch %~1
"%WT%" -C compiler=winch prog.wasm
echo === iwasm %~1
"%IW%" prog.wasm
echo === node-wasip1 %~1
"%ND%" --no-warnings "%ROOT%\exec\wasi-run.js" prog.wasm .
echo === wasmer-cranelift %~1
"%WS%" run --cranelift --mapdir /:"%CD%" prog.wasm
echo === wasmer-llvm %~1
"%WS%" run --llvm --mapdir /:"%CD%" prog.wasm
popd
exit /b 0

:preopen
echo === wasmtime-cranelift %~1
"%WT%" -C compiler=cranelift --dir "%CD%::/" prog.wasm
echo === wasmtime-winch %~1
"%WT%" -C compiler=winch --dir "%CD%::/" prog.wasm
echo === iwasm %~1
del /q out.bin 2>nul
if "%~1"=="15_file_write" copy /y nul out.bin >nul
"%IW%" --map-dir=/::. prog.wasm
echo === node-wasip1 %~1
"%ND%" --no-warnings "%ROOT%\exec\wasi-run.js" prog.wasm .
echo === wasmer-cranelift %~1
del /q out.bin 2>nul
if "%~1"=="15_file_write" copy /y nul out.bin >nul
"%WS%" run --cranelift --mapdir /:"%CD%" prog.wasm
echo === wasmer-llvm %~1
del /q out.bin 2>nul
if "%~1"=="15_file_write" copy /y nul out.bin >nul
"%WS%" run --llvm --mapdir /:"%CD%" prog.wasm
popd
exit /b 0
