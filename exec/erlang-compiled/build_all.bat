@echo off
setlocal enabledelayedexpansion
rem Build all 15 Erlang tasks in module form.
rem   erlc <task>.erl                      -> <task>.beam
rem   erl -noshell -s <task> main -s init stop
rem The sources are sources/erlang-compiled/, module-form rewrites of the escript row's
rem scripts (which carry a shebang and no -module declaration, so erlc cannot compile them).
rem Output: exec\erlang-compiled\<task>\<task>.beam
set ERLC=C:\stupidspeed\tools\erlang\bin\erlc.exe
set ERL=C:\stupidspeed\tools\erlang\bin\erl.exe
set SRC=C:\stupidspeed\sources\erlang-compiled
set EXEC=C:\stupidspeed\exec\erlang-compiled

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.erl" . >nul
  "%ERLC%" %%T.erl >build.log 2>&1
  if exist %%T.beam ( echo OK %%T ) else ( echo ERL-FAIL %%T )
)
echo ALLDONE
