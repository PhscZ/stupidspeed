@echo off
rem Build the gprolog row: GNU Prolog's gplc is a native compiler, so each task
rem is compiled into a stand-alone .exe that links the GNU Prolog runtime in.
rem   exec\gprolog\gplc\<task>\<task>.exe   artifact, run with the task dir as cwd
rem pl2wam/wam2ma/ma2asm ship in tools\gprolog\bin; as/gcc come from MSYS2 UCRT64.
rem tools\gprolog\shim\gpl_ucrt_env.c supplies __imp__environ so the prebuilt
rem runtime archives link against UCRT mingw-w64.
rem Task 03 compiles a second source file; tasks 14 and 15 need data.bin;
rem tasks 05 and 12 reserve a larger global stack (see their source headers).
setlocal
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\gprolog
set OUT=%ROOT%\exec\gprolog\gplc
set SHIM=%ROOT%\tools\gprolog\shim\gpl_ucrt_env.c
set PATH=%ROOT%\tools\gprolog\bin;%ROOT%\tools\msys64\msys64\ucrt64\bin;%PATH%
set FAILED=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :build %%T
if %FAILED% neq 0 exit /b 1
exit /b 0

:build
set T=%1
if not exist "%OUT%\%T%" mkdir "%OUT%\%T%"
pushd "%OUT%\%T%"
del /q %T%.exe *.wam *.o %T%.s >nul 2>&1
copy /y "%SRC%\%T%.pl" . >nul
if "%T%"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.pl" . >nul
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" . >nul
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" . >nul
set GOPT=
if "%T%"=="04_array_sum" set GOPT=--global-size 1048576
if "%T%"=="05_alloc_churn" set GOPT=--global-size 4194304
if "%T%"=="12_matrix_add" set GOPT=--global-size 1572864
if "%T%"=="03_func_sum" (
  gplc --no-top-level -o %T%.exe %T%.pl 03_func_sum_add_one.pl "%SHIM%" >build.log 2>&1
) else (
  gplc --no-top-level %GOPT% -o %T%.exe %T%.pl "%SHIM%" >build.log 2>&1
)
if errorlevel 1 (
  popd
  echo gprolog-FAIL %T%
  set FAILED=1
  exit /b 0
)
popd
echo OK %T%
exit /b 0
