@echo off
setlocal
REM Build all 15 tasks for the python-cython row.
REM   cython --embed -> C, then gcc -> prog.exe (links python313.lib, imports python313.dll).
set ROW=python-cython
set HERE=%~dp0
set SRC=%HERE%..\..\sources\python-cython
set PY=C:\Users\pz020\AppData\Local\Programs\Python\Python313
set GCCBIN=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin
set PATH=%GCCBIN%;%PY%;%PY%\DLLs;%PATH%
set CYTHON=%PY%\Scripts\cython.exe
set GCC=%GCCBIN%\gcc.exe
set FIXTURE=%HERE%..\..\data.bin

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :build %%T
exit /b 0

:build
set T=%1
set OUT=%HERE%cython\%T%
if not exist "%OUT%" mkdir "%OUT%"
copy /y "%SRC%\%T%.py" "%OUT%\%T%.py" >nul
if "%T%"=="14_file_read" copy /y "%FIXTURE%" "%OUT%\data.bin" >nul
if "%T%"=="15_file_write" copy /y "%FIXTURE%" "%OUT%\data.bin" >nul
pushd "%OUT%"
"%CYTHON%" --embed -3 --module-name _%T% -o _%T%.c %T%.py > build.log 2>&1
if errorlevel 1 (
  echo %ROW%-FAIL %T%
  popd
  exit /b 0
)
"%GCC%" -O2 -DMS_WIN64 -municode -I "%PY%\Include" -o prog.exe _%T%.c -L "%PY%\libs" -lpython313 >> build.log 2>&1
if errorlevel 1 (
  echo %ROW%-FAIL %T%
) else (
  echo OK %T%
)
popd
exit /b 0
