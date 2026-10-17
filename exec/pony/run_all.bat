@echo off
rem Run all fifteen pony-row programs the way exec\pony\verify.py does.  Task 11 is
rem the parallel one and is run with the four-scheduler pool the registry pins.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === %%T
  pushd "%ROOT%\exec\pony\ponyc\%%T"
  if "%%T"=="11_parallel_sum" (
    %%T.exe --ponymaxthreads=4 --ponynoscale
  ) else (
    %%T.exe
  )
  popd
)
endlocal
