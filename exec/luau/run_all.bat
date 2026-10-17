@echo off
rem Run all fifteen Luau tasks the way exec\luau\verify.py does.
rem Tasks 01-10, 12 and 13 run under the plain Luau CLI; tasks 11, 14 and 15 under Lute.
setlocal
set ROOT=%~dp0..\..
set LUAU=%ROOT%\tools\luau\luau.exe
set LUTE=%ROOT%\tools\lute\lute.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\luau\luau\%%T"
  if exist time.txt del /q time.txt
  if "%%T"=="11_parallel_sum" ("%LUTE%" run %%T.luau) else if "%%T"=="14_file_read" ("%LUTE%" run %%T.luau) else if "%%T"=="15_file_write" ("%LUTE%" run %%T.luau) else ("%LUAU%" %%T.luau)
  popd
)
endlocal
