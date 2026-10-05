@echo off
setlocal enabledelayedexpansion
rem Build all 15 FreeBASIC tasks into exec\freebasic\<task>\prog.exe
rem fbc -O 2 -x prog.exe <task>.bas.  -x names the output, so the source must come after it;
rem "-x <task>.bas" alone would overwrite the source. Task 03 also compiles
rem 03_func_sum_add_one.bas on the same command line so add_one is a real cross-module call.
set PATH=C:\stupidspeed\tools\freebasic;%PATH%
set SRC=C:\stupidspeed\sources\basic
set EXEC=C:\stupidspeed\exec\freebasic

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.bas" . >nul
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%\03_func_sum_add_one.bas" . >nul
    fbc -O 2 -x prog.exe 03_func_sum.bas 03_func_sum_add_one.bas >fbc.log 2>&1
  ) else (
    fbc -O 2 -x prog.exe %%T.bas >fbc.log 2>&1
  )
  if exist prog.exe ( echo OK %%T ) else ( echo FB-FAIL %%T )
)
echo ALLDONE
