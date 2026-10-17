@echo off
rem Run all fifteen fasm tasks the way exec\fasm\verify.py does: from exec\fasm, which is
rem the cwd the registry names, so data.bin (task 14) and out.bin (task 15) resolve there.
setlocal
set ROOT=%~dp0..\..
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\fasm"
  "%%T.exe"
  popd
)
endlocal
