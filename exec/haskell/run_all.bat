@echo off
rem Run all fifteen haskell-row programs the way exec\haskell\verify.py does.
rem Task 11 takes `+RTS -N4 -RTS`, the row's second registry entry; the other
rem fourteen run bare.  Every program is ghc-built with -threaded.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === %%T
  pushd "%ROOT%\exec\haskell\ghc\T%%T"
  if "%%T"=="11_parallel_sum" (prog.exe +RTS -N4 -RTS) else (prog.exe)
  popd
)
endlocal
