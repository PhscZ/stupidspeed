@echo off
rem Run all fifteen modula2 tasks the way exec\modula2\verify.py does: the
rem compiled prog.exe, from its own directory.  ADW writes its TIME_MS line to
rem time.txt rather than to stderr (it exposes no stderr handle), so the stale
rem file is removed before each run the same way the harness's reset does.
setlocal
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === %%T
  pushd "%ROOT%\exec\modula2\%%T"
  del /q time.txt >nul 2>&1
  prog.exe
  echo -- time.txt: & type time.txt
  popd
)
endlocal
