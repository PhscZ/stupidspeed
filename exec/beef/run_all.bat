@echo off
rem Run all fifteen Beef tasks the way exec\beef\verify.py does: the executable is
rem <task>\out\prog.exe and the working directory is <task>, which is where the
rem harness runs it (cells.json cwd) and where data.bin is staged for tasks 14/15.
setlocal
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === %%T
  pushd "%ROOT%\exec\beef\%%T"
  out\prog.exe
  popd
)
endlocal
