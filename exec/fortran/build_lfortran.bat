@echo off
rem Build the lfortran toolchain of the fortran row.
rem   exec\fortran\lfortran\<task>\prog.exe
rem Two steps per task: LFortran compiles to an object, then gcc links it with
rem the clock shim (LFortran's SYSTEM_CLOCK is a stub) and the LFortran runtime.
rem Task 03 also compiles 03_func_sum_add_one.f90; tasks 14 and 15 need the
rem runtime's binary-mode patch (see patch_runtime.py).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\fortran
set OUT=%ROOT%\exec\fortran\lfortran
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set SHIM=%ROOT%\tools\lfortran-shim\lfclock_shim.o
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

python "%ROOT%\exec\fortran\patch_runtime.py" || (echo fortran-FAIL lfortran patch & exit /b 1)
set "PATH=%UCRT%\bin;%PATH%"

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.f90" "%OUT%\%%T\%%T.f90" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  lfortran --implicit-interface -O3 -c -o task.o %%T.f90 >build.log 2>&1
  if errorlevel 1 (
    echo fortran-FAIL lfortran %%T
    set FAIL=1
  ) else (
    set "EXTRA="
    if "%%T"=="03_func_sum" (
      copy /y "%SRC%\03_func_sum_add_one.f90" "03_func_sum_add_one.f90" >nul
      lfortran --implicit-interface -O3 -c -o add_one.o 03_func_sum_add_one.f90 >>build.log 2>&1
      if errorlevel 1 (echo fortran-FAIL lfortran %%T & set FAIL=1)
      set "EXTRA=add_one.o"
    )
    gcc -o prog.exe task.o !EXTRA! "%SHIM%" -llfortran_runtime -lm >>build.log 2>&1
    if errorlevel 1 (echo fortran-FAIL lfortran %%T & set FAIL=1) else (echo OK %%T lfortran)
  )
  popd
)

if "%FAIL%"=="1" (echo fortran-FAIL lfortran some task & exit /b 1)
echo lfortran OK
endlocal
