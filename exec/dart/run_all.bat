@echo off
rem Run all fifteen dart tasks the way exec\dart\verify.py does.
rem   aot: prog.exe in each task directory
rem   jit: dart.exe <task>.dart from exec\dart\jit (all fifteen share that directory)
setlocal
set ROOT=%~dp0..\..
set DART=%ROOT%\tools\dart\bin\dart.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do (
  echo === %%T aot
  pushd "%ROOT%\exec\dart\aot\%%T"
  prog.exe
  popd
  echo === %%T jit
  pushd "%ROOT%\exec\dart\jit"
  "%DART%" %%T.dart
  popd
)
endlocal
