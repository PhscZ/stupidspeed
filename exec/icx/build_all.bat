@echo off
rem Build the icx row: the fifteen C-row sources through Intel's oneAPI DPC++
rem `icx` -- tools\icx\bin\clang.exe, Intel's downstream LLVM clang, which targets
rem x86_64-pc-windows-msvc.  It therefore needs the MSVC environment (PATH/INCLUDE/
rem LIB, from tools\msvc_env.py) both for the C headers and so that it can link with
rem link.exe.  Artifact contract: exec\icx\<task>\prog.exe.
rem Every task needs its source staged beside the program; tasks 14 and 15 also
rem need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\c
set ICX=%ROOT%\tools\icx\bin\clang.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\icx\%%T" mkdir "%ROOT%\exec\icx\%%T"
  copy /y "%SRC%\%%T.c" "%ROOT%\exec\icx\%%T\%%T.c" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\icx\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\icx\%%T\data.bin" >nul
)

rem ---- icx: the MSVC environment has to be active for every invocation, so the
rem tools\msvc_env.py output is written to a .bat and re-called per task.
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_icx_env.bat"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\icx\%%T"
  call "%TEMP%\stupidspeed_icx_env.bat" >nul
  "%ICX%" -O2 -o prog.exe %%T.c >build.log 2>&1
  if errorlevel 1 (echo icx-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if %FAIL% neq 0 exit /b 1
endlocal
