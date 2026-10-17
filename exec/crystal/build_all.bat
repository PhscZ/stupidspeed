@echo off
rem Build the crystal row: the fifteen Crystal sources through the one toolchain,
rem   exec\crystal\<task>\prog.exe    crystal build --release -o prog <task>.cr
rem Crystal compiles to LLVM IR and shells out to cl.exe, which drives link.exe,
rem so the MSVC environment from tools\msvc_env.py has to be active for the link.
rem Every task keeps its source staged beside the program; tasks 14 and 15 also
rem need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\crystal
set CRYSTAL=%ROOT%\tools\crystal\crystal.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
call "%TEMP%\stupidspeed_msvc_env.bat" >nul

for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\crystal\%%T" mkdir "%ROOT%\exec\crystal\%%T"
  copy /y "%SRC%\%%T.cr" "%ROOT%\exec\crystal\%%T\%%T.cr" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\crystal\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\crystal\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\crystal\%%T"
  "%CRYSTAL%" build --release -o prog %%T.cr >build.log 2>&1
  if errorlevel 1 (echo crystal-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo crystal-FAIL some task & exit /b 1)
echo crystal OK
endlocal
