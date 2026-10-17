@echo off
rem Build the ada row: the same fifteen Ada sources through two GNAT front ends.
rem   exec\ada\<task>\t<task>.exe        gnat (gcc), `gnatmake -O3 t<task>.adb`
rem   exec\ada\llvm\<task>\t<task>.exe   gnat llvm, `llvm-gnatmake -O3 t<task>.adb`
rem The gnat toolchain is the Alire-installed native GNAT under
rem tools\alire_home\cache\toolchains\; its bin directory has to be on PATH because
rem gnatmake drives gcc, gnatbind and gnatlink from there. Tasks 14 and 15 run in
rem their own directory and need the data.bin fixture copied in beside them.
rem gnat llvm is registered in exec\cells.json but is a from-source build that is not
rem installed on this machine (BUILD.md), so that half reports SKIP unless
rem tools\gnat-llvm\llvm-interface\bin\llvm-gnatmake.exe exists.
rem Usage: build_all.bat [gnat|llvm]   (default: both)
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\ada
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set WANT=%~1
if "%WANT%"=="" set WANT=all
set FAIL=0

if /i "%WANT%"=="all" goto :gnat
if /i "%WANT%"=="gnat" goto :gnat
if /i "%WANT%"=="llvm" goto :llvm
echo ada-FAIL unknown toolchain %WANT% & exit /b 2

:gnat
set GNATBIN=%ROOT%\tools\alire_home\cache\toolchains\gnat_native_16.1.0_bbd69633\bin
if not exist "%GNATBIN%\gnatmake.exe" (
  echo ada-SKIP gnat ^(gnatmake not found under tools\alire_home\cache\toolchains^)
  goto :after_gnat
)
set PATH=%GNATBIN%;%PATH%
for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\ada\%%T" mkdir "%ROOT%\exec\ada\%%T"
  copy /y "%SRC%\t%%T.adb" "%ROOT%\exec\ada\%%T\t%%T.adb" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\ada\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\ada\%%T\data.bin" >nul
  pushd "%ROOT%\exec\ada\%%T"
  gnatmake -O3 t%%T.adb >build.log 2>&1
  if errorlevel 1 (echo ada-FAIL gnat %%T & set FAIL=1) else (echo OK %%T gnat)
  popd
)
:after_gnat
if /i "%WANT%"=="gnat" goto :done

:llvm
rem llvm-gnatmake drives llvm-gcc/llvm-gnatbind/llvm-gnatlink by bare name, and
rem llvm-gcc links with the clang on PATH, so both directories have to be
rem there: the gnat-llvm bin, and MSYS2 UCRT64 for clang and its runtime.
set LLVMGNAT=%ROOT%\tools\gnat-llvm\llvm-interface\bin\llvm-gnatmake.exe
set "PATH=%ROOT%\tools\gnat-llvm\llvm-interface\bin;%ROOT%\tools\msys64\msys64\ucrt64\bin;%PATH%"
if not exist "%LLVMGNAT%" (
  echo ada-SKIP gnat llvm ^(llvm-gnatmake not installed: tools\gnat-llvm\llvm-interface\bin\llvm-gnatmake.exe is missing^)
  goto :done
)
for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\ada\llvm\%%T" mkdir "%ROOT%\exec\ada\llvm\%%T"
  copy /y "%SRC%\t%%T.adb" "%ROOT%\exec\ada\llvm\%%T\t%%T.adb" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\ada\llvm\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\ada\llvm\%%T\data.bin" >nul
  pushd "%ROOT%\exec\ada\llvm\%%T"
  "%LLVMGNAT%" -O3 t%%T.adb >build.log 2>&1
  if errorlevel 1 (echo ada-FAIL gnat llvm %%T & set FAIL=1) else (echo OK %%T gnat-llvm)
  popd
)

:done
if "%FAIL%"=="1" (echo ada-FAIL some task & exit /b 1)
echo ada OK
endlocal
