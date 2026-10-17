@echo off
rem Build the fortran row: the same fifteen sources through four Fortran compilers.
rem   exec\fortran\gfortran\<task>\prog.exe    gfortran -O3
rem   exec\fortran\flang\<task>\prog.exe       flang -O3
rem   exec\fortran\ifx\<task>\prog.exe         ifx -O3 (MSVC environment + Intel INCLUDE/LIB)
rem   exec\fortran\lfortran\<task>\prog.exe    lfortran -O3 + gcc link, see build_lfortran.bat
rem Task 03 also compiles 03_func_sum_add_one.f90; task 11 needs OpenMP; ifx task 06
rem needs -heap-arrays. Tasks 14 and 15 need the data.bin fixture beside the program.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\fortran
set OUT=%ROOT%\exec\fortran
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set IFX=%ROOT%\tools\ifx
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%C in (gfortran flang ifx lfortran) do (
  for %%T in (%TASKS%) do (
    if not exist "%OUT%\%%C\%%T" mkdir "%OUT%\%%C\%%T"
    copy /y "%SRC%\%%T.f90" "%OUT%\%%C\%%T\%%T.f90" >nul
    if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.f90" "%OUT%\%%C\%%T\03_func_sum_add_one.f90" >nul
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%C\%%T\data.bin" >nul
  )
)

rem ---- gfortran: the MSYS2 UCRT64 tree supplies the compiler and libgfortran.
set "PATH=%UCRT%\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%OUT%\gfortran\%%T"
  set "SRCS=%%T.f90"
  set "FLAGS=-O3"
  if "%%T"=="03_func_sum" set "SRCS=%%T.f90 03_func_sum_add_one.f90"
  if "%%T"=="11_parallel_sum" set "FLAGS=-O3 -fopenmp"
  gfortran !FLAGS! -o prog.exe !SRCS! >build.log 2>&1
  if errorlevel 1 (echo fortran-FAIL gfortran %%T & set FAIL=1) else (echo OK %%T gfortran)
  popd
)

rem ---- flang: LLVM's Fortran front end from the same UCRT64 tree.
set "PATH=%UCRT%\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%OUT%\flang\%%T"
  set "SRCS=%%T.f90"
  set "FLAGS=-O3"
  if "%%T"=="03_func_sum" set "SRCS=%%T.f90 03_func_sum_add_one.f90"
  if "%%T"=="11_parallel_sum" set "FLAGS=-O3 -fopenmp"
  flang !FLAGS! -o prog.exe !SRCS! >build.log 2>&1
  if errorlevel 1 (echo fortran-FAIL flang %%T & set FAIL=1) else (echo OK %%T flang)
  popd
)

rem ---- ifx: Intel's compiler links with MSVC's link.exe, so it needs the MSVC
rem environment on top of its own PATH/INCLUDE/LIB.
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
call "%TEMP%\stupidspeed_msvc_env.bat" >nul
set "PATH=%IFX%\Library\bin;%PATH%"
set "INCLUDE=%IFX%\opt\compiler\include\intel64;%INCLUDE%"
set "LIB=%IFX%\Library\lib;%LIB%"
for %%T in (%TASKS%) do (
  pushd "%OUT%\ifx\%%T"
  set "SRCS=%%T.f90"
  set "FLAGS=-O3"
  if "%%T"=="03_func_sum" set "SRCS=%%T.f90 03_func_sum_add_one.f90"
  if "%%T"=="06_char_count" set "FLAGS=-O3 -heap-arrays"
  if "%%T"=="11_parallel_sum" set "FLAGS=-O3 -Qopenmp"
  ifx !FLAGS! -o prog.exe !SRCS! >build.log 2>&1
  if errorlevel 1 (echo fortran-FAIL ifx %%T & set FAIL=1) else (echo OK %%T ifx)
  popd
)

rem ---- lfortran: its own two-step build, in build_lfortran.bat.
call "%ROOT%\exec\fortran\build_lfortran.bat"
if errorlevel 1 set FAIL=1

if "%FAIL%"=="1" (echo fortran-FAIL some task & exit /b 1)
echo fortran OK
endlocal
