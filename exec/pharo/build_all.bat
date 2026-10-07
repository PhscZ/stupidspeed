@echo off
setlocal
set "ROOT=%~dp0..\.."
set "SRC=%ROOT%\sources\pharo"

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  cd /d "%~dp0pharo\%%T"
  copy /Y "%SRC%\%%T.st" . >nul
  if "%%T"=="14_file_read" copy /Y "%ROOT%\data.bin" . >nul
  if "%%T"=="15_file_write" copy /Y "%ROOT%\data.bin" . >nul
  > build.log echo no build step: Pharo 13 image is prebuilt, script is compiled at run time
  echo OK %%T
)
endlocal
