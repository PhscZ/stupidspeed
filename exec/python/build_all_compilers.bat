@echo off
setlocal
REM Build all 15 tasks for the nuitka toolchain of the sources/python row.
REM (The cpython/pypy/graalpy toolchains of this row are owned elsewhere:
REM  exec\python\build_all.bat and exec\python\verify.py.)
REM   nuitka --standalone <task>.py  ->  <task>.dist\<task>.exe
set ROW=python-nuitka
set HERE=%~dp0
set SRC=%HERE%..\..\sources\python
set PY=C:\Users\pz020\AppData\Local\Programs\Python\Python313
set NUITKA=%PY%\Scripts\nuitka.cmd
set FIXTURE=%HERE%..\..\data.bin

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :build %%T
exit /b 0

:build
set T=%1
set OUT=%HERE%nuitka\%T%
if not exist "%OUT%" mkdir "%OUT%"
if exist "%OUT%\%T%.dist" rmdir /s /q "%OUT%\%T%.dist"
if exist "%OUT%\%T%.build" rmdir /s /q "%OUT%\%T%.build"
copy /y "%SRC%\%T%.py" "%OUT%\%T%.py" >nul
pushd "%OUT%"
call "%NUITKA%" --standalone --assume-yes-for-downloads %T%.py > build.log 2>&1
if errorlevel 1 (
  echo %ROW%-FAIL %T%
  popd
  exit /b 0
)
if not exist "%T%.dist\%T%.exe" (
  echo %ROW%-FAIL %T%
  popd
  exit /b 0
)
if "%T%"=="14_file_read" copy /y "%FIXTURE%" "%T%.dist\data.bin" >nul
if "%T%"=="15_file_write" copy /y "%FIXTURE%" "%T%.dist\data.bin" >nul
REM The intermediate build dir is not needed once the dist exists; the disk here
REM runs close to full and a truncated object file silently corrupts the binary.
rmdir /s /q "%T%.build"
echo OK %T%
popd
exit /b 0
