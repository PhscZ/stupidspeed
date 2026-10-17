@echo off
rem Run all sixty java-row cells the way exec\java\verify.py does: the same class
rem files, once per HotSpot configuration.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === openjdk %%T
  pushd "%ROOT%\exec\java\openjdk\%%T"
  java -cp . _%%T
  popd
  echo === openjdk (interp) %%T
  pushd "%ROOT%\exec\java\openjdk\%%T"
  java -Xint -cp . _%%T
  popd
  echo === openjdk (c1) %%T
  pushd "%ROOT%\exec\java\openjdk\%%T"
  java -XX:TieredStopAtLevel=1 -cp . _%%T
  popd
  echo === openjdk (c2) %%T
  pushd "%ROOT%\exec\java\openjdk\%%T"
  java -XX:-TieredCompilation -cp . _%%T
  popd
)
endlocal
