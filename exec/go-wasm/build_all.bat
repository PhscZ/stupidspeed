@echo off
setlocal enabledelayedexpansion
rem Build all 15 Go tasks for wasip1 (gc toolchain).
rem   set GOOS=wasip1 & set GOARCH=wasm & go build -o prog.wasm <task>.go
rem The installed Go 1.26 has the wasip1 target, so nothing extra is needed.
rem Run with tools\wasmtime46\wasmtime.exe prog.wasm
rem Output: exec\go-wasm\<task>\prog.wasm
set GO=C:\Program Files\Go\bin\go.exe
set SRC=C:\stupidspeed\sources\go-wasm
set EXEC=C:\stupidspeed\exec\go-wasm
set GOOS=wasip1
set GOARCH=wasm

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.go" . >nul
  "%GO%" build -o prog.wasm %%T.go >build.log 2>&1
  if exist prog.wasm ( echo OK %%T ) else ( echo GOWASM-FAIL %%T )
)
echo ALLDONE
