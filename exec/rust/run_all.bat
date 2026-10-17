@echo off
rem Run all fifteen rust tasks the way exec\rust\verify.py does -- the LLVM build and
rem the Cranelift build of the same source, side by side.
setlocal
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%C in (rustc cranelift) do (
  for %%T in (%TASKS%) do (
    echo === %%C %%T
    pushd "%ROOT%\exec\rust\%%C\%%T"
    prog.exe
    popd
  )
)
endlocal
