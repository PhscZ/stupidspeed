@echo off
setlocal enabledelayedexpansion
rem Build all 15 Fortran tasks with two toolchains.
rem   gfortran  C:\mingw64\bin\gfortran.exe -O3 [-fopenmp] -o prog.exe <task>.f90
rem   flang     tools\msys64\msys64\ucrt64\bin\flang.exe -O3 [-fopenmp] -o prog.exe <task>.f90
rem Task 03 also compiles 03_func_sum_add_one.f90 (cross-file inlining needs LTO, which is
rem off, so the calls are real). Task 11 uses OpenMP and needs -fopenmp.
rem flang needs the MSYS2 ucrt64 bin dir on PATH for its runtime DLLs.
rem Output: exec\fortran\<toolchain>\<task>\prog.exe
set IFX=C:\stupidspeed\tools\ifx\Library\bin\ifx.exe
set IFXBIN=C:\stupidspeed\tools\ifx\Library\bin
set IFXINC=C:\stupidspeed\tools\ifx\opt\compiler\include\intel64
set IFXLIB=C:\stupidspeed\tools\ifx\Library\lib
set GFORTRAN=C:\mingw64\bin\gfortran.exe
set FLANG=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin\flang.exe
set MSYSBIN=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin
set SRC=C:\stupidspeed\sources\fortran
set EXEC=C:\stupidspeed\exec\fortran
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## gfortran
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\gfortran\%%T" 2>nul
  cd /d "%EXEC%\gfortran\%%T"
  copy /y "%SRC%\%%T.f90" . >nul
  set EXTRA=
  if "%%T"=="11_parallel_sum" set EXTRA=-fopenmp
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%\03_func_sum_add_one.f90" . >nul
    "%GFORTRAN%" -O3 !EXTRA! -o prog.exe 03_func_sum.f90 03_func_sum_add_one.f90 >build.log 2>&1
  ) else (
    "%GFORTRAN%" -O3 !EXTRA! -o prog.exe %%T.f90 >build.log 2>&1
  )
  if exist prog.exe ( echo OK gfortran %%T ) else ( echo FTN-FAIL gfortran %%T )
)

echo ########## flang
set PATH=%MSYSBIN%;%PATH%
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\flang\%%T" 2>nul
  cd /d "%EXEC%\flang\%%T"
  copy /y "%SRC%\%%T.f90" . >nul
  set EXTRA=
  if "%%T"=="11_parallel_sum" set EXTRA=-fopenmp
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%\03_func_sum_add_one.f90" . >nul
    "%FLANG%" -O3 !EXTRA! -o prog.exe 03_func_sum.f90 03_func_sum_add_one.f90 >build.log 2>&1
  ) else (
    "%FLANG%" -O3 !EXTRA! -o prog.exe %%T.f90 >build.log 2>&1
  )
  if exist prog.exe ( echo OK flang %%T ) else ( echo FTN-FAIL flang %%T )
)

rem Intel's ifx.  Installed from Intel's conda channel rather than the oneAPI
rem installer (see BUILD.md): tools\ifx holds the compiler, its module tree and
rem its runtime.  ifx is clang-based and links with link.exe, so it needs the
rem MSVC environment on top of its own INCLUDE/LIB.  Two per-task extras:
rem   -Qopenmp       task 11, same reason as the other two compilers
rem   -heap-arrays   task 06, or ifx puts the 100 MB `repeat` result on the stack
rem                  and the program dies with severe (170) stack overflow
echo ########## ifx
python "%ROOT%	ools\msvc_env.py" > "%ROOT%	emp\msvcenv.bat"
call "%ROOT%	emp\msvcenv.bat"
set "PATH=%IFXBIN%;%PATH%"
set "INCLUDE=%IFXINC%;%INCLUDE%"
set "LIB=%IFXLIB%;%LIB%"
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\ifx\%%T" 2>nul
  cd /d "%EXEC%\ifx\%%T"
  copy /y "%SRC%\%%T.f90" . >nul
  set EXTRA=
  if "%%T"=="11_parallel_sum" set EXTRA=-Qopenmp
  if "%%T"=="06_char_count" set EXTRA=-heap-arrays
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%_func_sum_add_one.f90" . >nul
    "%IFX%" -O3 !EXTRA! -o prog.exe 03_func_sum.f90 03_func_sum_add_one.f90 >build.log 2>&1
  ) else (
    "%IFX%" -O3 !EXTRA! -o prog.exe %%T.f90 >build.log 2>&1
  )
  if exist prog.exe ( echo OK ifx %%T ) else ( echo FTN-FAIL ifx %%T )
)
echo ALLDONE
