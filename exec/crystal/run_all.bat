@echo off
rem Run all fifteen crystal-row programs the way exec\crystal\verify.py does:
rem prog.exe in its own task directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === crystal %%T
  pushd "%ROOT%\exec\crystal\%%T"
  prog.exe
  popd
)
endlocal
