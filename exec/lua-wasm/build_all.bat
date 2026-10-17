@echo off
rem Build the lua-wasm row: PUC Lua 5.4.8 cross-compiled to wasm32-wasip1, run by
rem wasmtime.  The interpreter is one prebuilt module (tools\lua-wasm\lua.wasm, the
rem cross-compiled build BUILD.md documents); "building" a task is staging it and
rem the module into the directory the harness runs from.
rem   exec\lua-wasm\lua.wasm            the interpreter module
rem   exec\lua-wasm\<task>.lua          artifact, run as `wasmtime -W exceptions=y --dir . lua.wasm <task>.lua`
rem Tasks 14 and 15 need the data.bin fixture in that same directory (cwd is the
rem row root for every task, and `--dir .` preopens it).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\lua-wasm
set OUT=%ROOT%\exec\lua-wasm
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

if not exist "%OUT%" mkdir "%OUT%"
copy /y "%ROOT%\tools\lua-wasm\lua.wasm" "%OUT%\lua.wasm" >nul || (echo lua-wasm-FAIL lua.wasm & exit /b 1)
copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul || (echo lua-wasm-FAIL data.bin & exit /b 1)

for %%T in (%TASKS%) do (
  copy /y "%SRC%\%%T.lua" "%OUT%\%%T.lua" >nul || (echo lua-wasm-FAIL %%T & exit /b 1)
  echo OK %%T
)
echo lua-wasm OK
endlocal
