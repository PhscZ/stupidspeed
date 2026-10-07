@echo off
setlocal
set "ROOT=%~dp0..\.."
set "PERL=%ROOT%\tools\perl\bin\perl.exe"
set "SRC=%ROOT%\sources\perl"

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  cd /d "%~dp0perl\%%T"
  copy /Y "%SRC%\%%T.pl" . >nul
  if "%%T"=="14_file_read" copy /Y "%ROOT%\data.bin" . >nul
  if "%%T"=="15_file_write" copy /Y "%ROOT%\data.bin" . >nul
  "%PERL%" -c "%%T.pl" > build.log 2>&1
  if errorlevel 1 (echo PERL-FAIL %%T) else (echo OK %%T)
)
endlocal
