@echo off
setlocal
set "ROOT=%~dp0..\.."
set "FPC=%ROOT%\tools\fpc\bin\i386-win32\fpc.exe"
set "SRC=%ROOT%\sources\pascal"

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  cd /d "%~dp0fpc\%%T"
  del /Q program program.exe >nul 2>&1
  copy /Y "%SRC%\%%T.pas" . >nul
  if "%%T"=="14_file_read" copy /Y "%ROOT%\data.bin" . >nul
  if "%%T"=="15_file_write" copy /Y "%ROOT%\data.bin" . >nul
  "%FPC%" -Px86_64 -O3 -oprogram "%%T.pas" > build.log 2>&1
  if errorlevel 1 (echo PASCAL-FAIL %%T) else (echo OK %%T)
)
endlocal
