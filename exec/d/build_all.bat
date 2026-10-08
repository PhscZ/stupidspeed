@echo off
setlocal enabledelayedexpansion
rem Build all 15 D tasks with three toolchains.
rem   dmd   tools/dmd/windows/bin64/dmd.exe -O -release -of=prog.exe _<task>.d
rem   ldc2  tools/ldc2/bin/ldc2.exe -O3 -release -of=prog.exe _<task>.d
rem The sources carry a version(GNU) branch for the clock: GDC here is 4.9.2 (D 2.066.1),
rem which predates core.time.MonoTime, so it uses TickDuration.currSystemTick instead.
rem Task 03 uses pragma(inline, false) in-file, so no separate module is needed.
rem Output: exec\d\<toolchain>\<task>\prog.exe
set SRC=C:\stupidspeed\sources\d
set EXEC=C:\stupidspeed\exec\d
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## dmd
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\dmd\%%T" 2>nul
  cd /d "%EXEC%\dmd\%%T"
  copy /y "%SRC%\_%%T.d" . >nul
  C:\stupidspeed\tools\dmd\windows\bin64\dmd.exe -O -release -of=prog.exe _%%T.d >build.log 2>&1
  if exist prog.exe ( echo OK dmd %%T ) else ( echo D-FAIL dmd %%T )
)

echo ########## ldc2
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\ldc2\%%T" 2>nul
  cd /d "%EXEC%\ldc2\%%T"
  copy /y "%SRC%\_%%T.d" . >nul
  C:\stupidspeed\tools\ldc2\bin\ldc2.exe -O3 -release -of=prog.exe _%%T.d >build.log 2>&1
  if exist prog.exe ( echo OK ldc2 %%T ) else ( echo D-FAIL ldc2 %%T )
)

echo ALLDONE
