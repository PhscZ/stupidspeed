@echo off
rem Build the commonlisp-ecl row: ECL's compile-file lowers each .lisp to C and drives
rem the MSVC cl.exe to produce the .fas.
rem   exec\commonlisp-ecl\<task>\<task>.fas   artifact, run by
rem                                           `ecl.exe --norc --eval "(load "<task>.fas" :verbose nil)"`
rem The build line is the one in each source's header: require :cmp, install the C
rem compiler, point c::*cc*/c::*ld* at the MSVC tree under tools\ and hand cl.exe the
rem INCLUDE and LIB it needs (none of that is on PATH on this host). Without a C
rem compiler ECL silently falls back to its bytecode compiler and the loops run 5-10x
rem slower, so the build checks the .fas exists and that the log carries no internal
rem error rather than trusting ECL's always-zero exit code.
rem Tasks 14 and 15 run in their own directory and need the data.bin fixture there.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\commonlisp-ecl
set OUT=%ROOT%\exec\commonlisp-ecl
set ECL=%ROOT%\tools\ecl\ecl.exe
set CC=C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe
set INCS=C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared
set LIBS=C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.lisp" "%OUT%\%%T\%%T.lisp" >nul || (echo commonlisp-ecl-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%ECL%" --norc --eval "(progn (require :cmp) (ext:install-c-compiler) (setf c::*cc* ""%CC%"" c::*ld* c::*cc*) (si:setenv ""INCLUDE"" ""%INCS%"") (si:setenv ""LIB"" ""%LIBS%"") (compile-file ""%%T.lisp"" :output-file ""%%T.fas"") (ext:quit))" >build.log 2>&1
  if not exist "%%T.fas" (popd & echo commonlisp-ecl-FAIL %%T & exit /b 1)
  findstr /c:"Internal error" /c:"Could not spawn" build.log >nul
  if not errorlevel 1 (popd & echo commonlisp-ecl-FAIL %%T & exit /b 1)
  popd
  echo OK %%T
)
endlocal
