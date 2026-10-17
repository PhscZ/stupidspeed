@echo off
rem Run all fifteen Erlang tasks the way exec\erlang\verify.py does.
setlocal
set ROOT=%~dp0..\..
set ESCRIPT=%ROOT%\tools\erlang\bin\escript.exe
pushd "%ROOT%\exec\erlang"
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  "%ESCRIPT%" %%T.erl
)
popd
endlocal
