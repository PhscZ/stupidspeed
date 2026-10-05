@echo off
setlocal enabledelayedexpansion
rem Build all 15 Crystal tasks into exec\crystal\<task>\prog.exe
rem   crystal build --release -o prog.exe <task>.cr
rem Crystal shells out to cl.exe (which drives link.exe), so the MSVC environment from
rem tools/msvc_env.py must be set first — none of it is on PATH here.
set CRYSTAL=C:\stupidspeed\tools\crystal\crystal.exe
set SRC=C:\stupidspeed\sources\crystal
set EXEC=C:\stupidspeed\exec\crystal

for /f "usebackq delims=" %%L in (`python C:\stupidspeed\tools\msvc_env.py`) do %%L

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.cr" . >nul
  "%CRYSTAL%" build --release -o prog.exe %%T.cr >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo CRYSTAL-FAIL %%T )
)
echo ALLDONE
