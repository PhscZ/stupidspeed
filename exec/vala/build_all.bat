@echo off
rem Build the vala row: valac translates each .vala to C and drives gcc.
rem   exec\vala\valac\<task>\prog.exe   artifact, run as `prog.exe` from that directory
rem valac has to run with the MSYS2 UCRT64 bin on PATH so pkg-config resolves GLib's
rem development files, and -X -O2 is what forwards -O2 to the gcc it drives.
rem Task 03 compiles 03_func_sum_add_one.vala on the same command line (its own
rem translation unit, so the hundred million calls stay real calls); tasks 14 and 15
rem read the data.bin fixture from their working directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\vala
set OUT=%ROOT%\exec\vala\valac
set PATH=%ROOT%\tools\msys64\msys64\ucrt64\bin;%PATH%
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.vala" "%OUT%\%%T\%%T.vala" >nul || (echo vala-FAIL %%T & exit /b 1)
  set SRCARGS=%%T.vala
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%\03_func_sum_add_one.vala" "%OUT%\%%T\03_func_sum_add_one.vala" >nul
    set SRCARGS=03_func_sum_add_one.vala 03_func_sum.vala
  )
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  valac -X -O2 -o prog !SRCARGS! >build.log 2>&1
  if errorlevel 1 (popd & echo vala-FAIL %%T & exit /b 1)
  if not exist prog.exe (popd & echo vala-FAIL %%T & exit /b 1)
  popd
  echo OK %%T
)
endlocal
