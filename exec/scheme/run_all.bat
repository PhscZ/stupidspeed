@echo off
rem Run all fifteen Chez Scheme tasks the way exec\scheme\verify.py does.
rem Each task runs from its own directory (task 03 `load`s a file beside it) with
rem the interpreter line exec/cells.json records.
setlocal
set ROOT=%~dp0..\..
set SCHEME=%ROOT%\tools\chez\bin\ta6nt\scheme.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\scheme\chez\%%T"
  if exist time.txt del /q time.txt
  if exist out.bin del /q out.bin
  "%SCHEME%" --optimize-level 3 --script %%T.ss
  popd
)
endlocal
