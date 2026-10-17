@echo off
rem Run all fifteen built Swift programs the way exec\swift\verify.py does:
rem from each task's own directory, with the Swift runtime directories on PATH
rem (the cell's env in exec\cells.json does the same for the harness).
setlocal
set ROOT=%~dp0..\..
set SWIFT=%ROOT%\tools\swift
set "PATH=%SWIFT%\Toolchains\6.4.0+NoAsserts\usr\bin;%SWIFT%\Runtimes\6.4.0\usr\bin;%PATH%"
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\swift\swiftc\%%T"
  prog.exe
  popd
)
endlocal
