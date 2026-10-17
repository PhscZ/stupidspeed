@echo off
rem Run all fifteen built D programs of both toolchains, the way exec\d\verify.py does.
setlocal
set ROOT=%~dp0..\..
for %%C in (dmd ldc2) do (
  for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
    echo === %%C %%T
    pushd "%ROOT%\exec\d\%%C\%%T"
    prog.exe
    popd
  )
)
endlocal
