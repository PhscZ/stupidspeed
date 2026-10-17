@echo off
rem Run all fifteen AIR programs the way exec\actionscript\verify.py does.
rem AIR has no stderr: the programs write TIME_MS (and task 15's out.bin) into
rem %APPDATA%\stupidspeed.actionscript\Local Store\, so those are cleared first.
setlocal
set ROOT=%~dp0..\..
set STORE=%APPDATA%\stupidspeed.actionscript\Local Store
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  if exist "%STORE%\time.txt" del /q "%STORE%\time.txt"
  if exist "%STORE%\out.bin" del /q "%STORE%\out.bin"
  pushd "%ROOT%\exec\actionscript\%%T"
  out\prog.exe
  popd
  if exist "%STORE%\time.txt" type "%STORE%\time.txt"
)
endlocal
