@echo off
rem Run all fifteen pharo tasks the way exec\pharo\verify.py does.
setlocal
set ROOT=%~dp0..\..
set CONSOLE=%ROOT%\tools\pharo\PharoConsole.exe
set IMAGE=%ROOT%\tools\pharo\Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\pharo\pharo\%%T"
  "%CONSOLE%" --headless "%IMAGE%" st --quit --no-source %%T.st
  popd
)
endlocal
