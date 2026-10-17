@echo off
rem Run all fifteen Objective-C tasks the way exec\objectivec\verify.py does.
setlocal
set ROOT=%~dp0..\..
set "PATH=%ROOT%\tools\msys64\msys64\ucrt64\bin;%PATH%"
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\objectivec\clang\%%T"
  prog.exe
  popd
)
endlocal
