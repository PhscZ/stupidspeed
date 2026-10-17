@echo off
rem Build the pony row: ponyc 0.65.0, type check -> LLVM IR -> object -> link.
rem   exec\pony\ponyc\<task>\<task>.exe   artifact, run as `<task>.exe`
rem ponyc compiles a *directory* as one package and names the executable after that
rem directory, and all fifteen sources declare `Main`, so each task is built in a
rem directory of its own: the task's own directory, which is where the harness runs
rem it from.  Tasks 14 and 15 get the data.bin fixture in that directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\pony
set OUT=%ROOT%\exec\pony\ponyc
set PONYC=%ROOT%\tools\ponyc\bin\ponyc.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.pony" "%OUT%\%%T\%%T.pony" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%PONYC%" -o . . >build.log 2>&1
  if errorlevel 1 (echo pony-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo pony-FAIL some task & exit /b 1)
echo pony OK
endlocal
