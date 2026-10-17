@echo off
rem Build the assemblyscript row: fifteen hand-written AssemblyScript programs
rem compiled by asc into one WASI module each, which six runtimes then execute.
rem   exec\assemblyscript\<task>\prog.wasm     artifact, run from that directory
rem asc is run with the task directory as the working directory, because the
rem `--use abort=<task>/abortImpl` specifier is resolved relative to the source
rem file.  Task 11 adds the threads flags; tasks 14 and 15 also need the data.bin
rem fixture in the directory the module runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\assemblyscript
set OUT=%ROOT%\exec\assemblyscript
set ASC=%ROOT%\tools\assemblyscript\node_modules\.bin\asc.cmd
rem asc.cmd drives node; the repository's own node is put first so the compiler
rem does not depend on whatever node the host happens to have on PATH.
set "PATH=%ROOT%\tools\nodejs;%PATH%"
set FAIL=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.ts" "%OUT%\%%T\%%T.ts" >nul || (echo assemblyscript-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  if "%%T"=="11_parallel_sum" (
    call "%ASC%" %%T.ts -O2 --outFile prog.wasm --runtime incremental --use abort=%%T/abortImpl --enable threads --importMemory --sharedMemory --maximumMemory 1024 >build.log 2>&1
  ) else (
    call "%ASC%" %%T.ts -O2 --outFile prog.wasm --runtime incremental --use abort=%%T/abortImpl >build.log 2>&1
  )
  if errorlevel 1 (echo assemblyscript-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)
if "%FAIL%"=="1" (echo assemblyscript-FAIL some task & exit /b 1)
echo assemblyscript OK
endlocal
