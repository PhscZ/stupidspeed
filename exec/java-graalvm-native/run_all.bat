@echo off
rem Run all fifteen java-graalvm-native programs the way exec\java-graalvm-native\
rem verify.py does: the standalone native executable each task's directory holds.
setlocal
set ROOT=%~dp0..\..
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\java-graalvm-native\%%T"
  _%%T.exe
  popd
)
endlocal
