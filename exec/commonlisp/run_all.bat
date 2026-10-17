@echo off
rem Run all fifteen Common Lisp tasks the way exec\commonlisp\verify.py does.
rem Each dumped executable runs from its own directory, because that is the cwd
rem exec/cells.json records for the cell (tasks 14 and 15 touch data.bin/out.bin
rem there).
setlocal
set ROOT=%~dp0..\..
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\commonlisp\%%T"
  if exist out.bin del /q out.bin
  prog.exe
  popd
)
endlocal
