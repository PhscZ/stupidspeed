@echo off
rem Build the dart row: two toolchains over the same fifteen sources.
rem   exec\dart\aot\<task>\prog.exe   artifact, run as `prog.exe` in that directory
rem   exec\dart\jit\<task>.dart       artifact, run as `dart <task>.dart` in exec\dart\jit
rem The jit half has no build step: the Dart VM compiles the kernel on every run, so
rem "building" it is staging the script into the directory the harness runs it from.
rem Tasks 14 and 15 read/write data.bin in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\dart
set DART=%ROOT%\tools\dart\bin\dart.exe
set AOT=%ROOT%\exec\dart\aot
set JIT=%ROOT%\exec\dart\jit
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

if not exist "%JIT%" mkdir "%JIT%"

for %%T in (%TASKS%) do (
  if not exist "%AOT%\%%T" mkdir "%AOT%\%%T"
  copy /y "%SRC%\%%T.dart" "%AOT%\%%T\%%T.dart" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%AOT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%AOT%\%%T\data.bin" >nul
  pushd "%AOT%\%%T"
  "%DART%" compile exe -o prog.exe %%T.dart >build.log 2>&1
  if errorlevel 1 (echo dart-FAIL aot %%T & set FAIL=1) else (echo OK %%T aot)
  popd

  copy /y "%SRC%\%%T.dart" "%JIT%\%%T.dart" >nul || (echo dart-FAIL jit %%T & set FAIL=1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%JIT%\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%JIT%\data.bin" >nul
  echo OK %%T jit
)

if "%FAIL%"=="1" (echo dart-FAIL some task & exit /b 1)
echo dart OK
endlocal
