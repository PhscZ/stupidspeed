@echo off
setlocal enabledelayedexpansion
rem Build all 15 QB64-PE tasks into exec\qb64\<task>\prog.exe
rem qb64pe translates QB64 to C++ and shells out to the C++ compiler in tools/qb64/internal,
rem so each task takes several seconds. -x compiles without running; -o names the output.
set QB64PE=C:\stupidspeed\tools\qb64\qb64pe.exe
set SRC=C:\stupidspeed\sources\qb64
set EXEC=C:\stupidspeed\exec\qb64

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.bas" . >nul
  "%QB64PE%" -x %%T.bas -o prog.exe >qb64.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo QB64-FAIL %%T )
)
echo ALLDONE
