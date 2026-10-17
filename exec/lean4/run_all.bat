@echo off
rem Run all fifteen Lean 4 tasks the way exec\lean4\verify.py does.
rem The compiled program is standalone (nothing from tools\lean4 is needed at run
rem time), so it is run from its own directory, which is the cwd exec/cells.json
rem records for the cell.
setlocal
set ROOT=%~dp0..\..
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\lean4\lean4\%%T"
  if exist out.bin del /q out.bin
  prog.exe
  popd
)
endlocal
