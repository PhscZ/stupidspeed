@echo off
rem Run all fifteen SWI-Prolog tasks the way exec\swipl\verify.py does.
setlocal
set ROOT=%~dp0..\..
set SWIPL=%ROOT%\tools\swipl\bin\swipl.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\swipl\swipl\%%T"
  "%SWIPL%" -q -O -f none -g main -t halt %%T.pl
  popd
)
endlocal
