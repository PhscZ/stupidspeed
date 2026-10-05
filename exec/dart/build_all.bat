@echo off
setlocal enabledelayedexpansion
rem Build all 15 Dart tasks two ways.
rem   aot  dart compile exe -o prog.exe <task>.dart   -> a native executable per task
rem   jit  no build step: dart <task>.dart runs the source directly
rem The jit row shares one directory (no per-task artifact); the aot row gets one dir per task.
set DART=C:\stupidspeed\tools\dart\bin\dart.exe
set SRC=C:\stupidspeed\sources\dart
set EXEC=C:\stupidspeed\exec\dart
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## aot
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\aot\%%T" 2>nul
  cd /d "%EXEC%\aot\%%T"
  copy /y "%SRC%\%%T.dart" . >nul
  "%DART%" compile exe -o prog.exe %%T.dart >build.log 2>&1
  if exist prog.exe ( echo OK aot %%T ) else ( echo DART-FAIL aot %%T )
)

echo ########## jit
mkdir "%EXEC%\jit" 2>nul
copy /y "%SRC%\*.dart" "%EXEC%\jit\" >nul
echo OK jit staged
echo ALLDONE
