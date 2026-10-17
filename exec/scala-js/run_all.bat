@echo off
rem Run all fifteen scala-js tasks the way exec\scala-js\verify.py does: the one
rem linked prog.js each task produced, under node.  No JVM at run time.
setlocal
set ROOT=%~dp0..\..
set NODE=%ROOT%\tools\nodejs\node.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === %%T
  pushd "%ROOT%\exec\scala-js\%%T"
  "%NODE%" prog.js
  popd
)
endlocal
