@echo off
rem Run all fifteen Julia tasks the way exec\julia\verify.py does.
rem Task 11 is the registered `-t4` cell; every other task runs single-threaded.
setlocal
set ROOT=%~dp0..\..
set JULIA=%ROOT%\tools\julia\bin\julia.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\julia\julia\%%T"
  if "%%T"=="11_parallel_sum" (
    "%JULIA%" -t4 %%T.jl
  ) else (
    "%JULIA%" %%T.jl
  )
  popd
)
endlocal
