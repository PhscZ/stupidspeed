@echo off
setlocal enabledelayedexpansion
rem Build all 15 SBCL tasks into exec\commonlisp\<task>\prog.exe
rem sbcl --non-interactive --no-userinit --no-sysinit --load <task>.lisp --eval
rem   "(sb-ext:save-lisp-and-die \"prog.exe\" :executable t :toplevel (function main)
rem    :application-type :console)"
rem The dump makes a standalone console exe, so the timed run pays the core's start-up
rem rather than the reader/compiler. Task 03 does (load "03_func_sum_add_one.lisp") from
rem its own directory, so that helper is copied in too.
set SBCL=C:\stupidspeed\tools\sbcl\sbcl.exe
set SRC=C:\stupidspeed\sources\commonlisp
set EXEC=C:\stupidspeed\exec\commonlisp

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.lisp" . >nul
  if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.lisp" . >nul
  "%SBCL%" --non-interactive --no-userinit --no-sysinit --load %%T.lisp --eval "(sb-ext:save-lisp-and-die \"prog.exe\" :executable t :toplevel (function main) :application-type :console)" >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo SBCL-FAIL %%T )
)
echo ALLDONE
