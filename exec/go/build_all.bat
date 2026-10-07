@echo off
setlocal enabledelayedexpansion
rem Build all 15 Go tasks with two toolchains.
rem   gc      "C:\Program Files\Go\bin\go.exe" build -o prog.exe <task>.go
rem   tinygo  tools\tinygo\bin\tinygo.exe build -o prog.exe <task>.go
rem Output: exec\go\<toolchain>\<task>\prog.exe
set GO=C:\Program Files\Go\bin\go.exe
set TINYGO=C:\stupidspeed\tools\tinygo\bin\tinygo.exe
set SRC=C:\stupidspeed\sources\go
set SRCTINY=C:\stupidspeed\sources\tinygo
set EXEC=C:\stupidspeed\exec\go
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## gc
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\gc\%%T" 2>nul
  cd /d "%EXEC%\gc\%%T"
  copy /y "%SRC%\%%T.go" . >nul
  "%GO%" build -o prog.exe %%T.go >build.log 2>&1
  if exist prog.exe ( echo OK gc %%T ) else ( echo GO-FAIL gc %%T )
)

echo ########## tinygo
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\tinygo\%%T" 2>nul
  cd /d "%EXEC%\tinygo\%%T"
  copy /y "%SRCTINY%\%%T.go" . >nul
  "%TINYGO%" build -o prog.exe %%T.go >build.log 2>&1
  if exist prog.exe ( echo OK tinygo %%T ) else ( echo GO-FAIL tinygo %%T )
)
echo ALLDONE
