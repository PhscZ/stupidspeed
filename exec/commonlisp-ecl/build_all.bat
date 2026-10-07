@echo off
setlocal enabledelayedexpansion
rem Build all 15 ECL tasks into exec\commonlisp-ecl\<task>\<task>.fas
rem   ecl --norc --eval "(progn (require :cmp) (ext:install-c-compiler) ... (compile-file
rem     \"<task>.lisp\" :output-file \"<task>.fas\") (ext:quit))"
rem compile-file routes ECL's generated C through a C compiler and silently falls back to
rem its bytecode compiler without one — and that fallback is 5-10x slower — so c::*cc* is
rem pointed at the MSVC cl.exe under tools/ and INCLUDE/LIB are set for it, none of which
rem is on PATH here. Run: ecl --norc --eval "(load \"<task>.fas\" :verbose nil)".
set ECL=C:\stupidspeed\tools\ecl\ecl.exe
set SRC=C:\stupidspeed\sources\commonlisp-ecl
set EXEC=C:\stupidspeed\exec\commonlisp-ecl
set INCDIR=C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared
set LIBDIR=C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.lisp" . >nul
  "%ECL%" --norc --eval "(progn (require :cmp) (ext:install-c-compiler) (setf c::*cc* \"C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe\" c::*ld* c::*cc*) (si:setenv \"INCLUDE\" \"%INCDIR%\") (si:setenv \"LIB\" \"%LIBDIR%\") (compile-file \"%%T.lisp\" :output-file \"%%T.fas\") (ext:quit))" >build.log 2>&1
  if exist %%T.fas ( echo OK %%T ) else ( echo ECL-FAIL %%T )
)
echo ALLDONE
