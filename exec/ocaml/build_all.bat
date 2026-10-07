@echo off
setlocal
rem Build all 15 OCaml tasks with both back ends.
rem   native:   ocamlopt -I +unix unix.cmxa -unsafe -o prog.exe _<task>.ml
rem   bytecode: ocamlc   -I +unix unix.cma  -o prog.exe _<task>.ml
rem The sources use Unix.gettimeofday, so the unix library has to be linked on both
rem back ends; the header's build line omits it but the compile fails with
rem "No implementation provided for the following modules: Unix" without it.
rem -unsafe is the native speed knob; -O3 is a no-op (this switch reports flambda: false).
rem OCAMLLIB must be the *Windows* form of the stdlib directory, because ocamlopt/ocamlc are
rem native Win32 binaries and the MSYS2-style path in their config resolves to nothing.
rem The ucrt64\bin directory has to be on PATH both for the compilers and for the bytecode
rem launcher, which needs ocamlrun.exe and dllunixbyt.dll at run time.
rem Output: exec\ocaml\ocamlopt\<task>\prog.exe and exec\ocaml\ocamlc\<task>\prog.exe
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\ocaml
set UCRT64=%ROOT%\tools\msys64\msys64\ucrt64
set PATH=%UCRT64%\bin;%PATH%
set OCAMLLIB=%UCRT64%\lib\ocaml
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## ocamlopt
set OUT=%~dp0ocamlopt
for %%T in (%TASKS%) do call :native %%T

echo ########## ocamlc
set OUT=%~dp0ocamlc
for %%T in (%TASKS%) do call :bytecode %%T

echo ALLDONE
exit /b 0

:native
mkdir "%OUT%\%1" 2>nul
cd /d "%OUT%\%1"
copy /y "%SRC%\_%1.ml" "_%1.ml" >nul
ocamlopt -I +unix unix.cmxa -unsafe -o prog.exe _%1.ml >build.log 2>&1
if exist prog.exe ( echo OK %1 ) else ( echo ocaml-FAIL %1 )
exit /b 0

:bytecode
mkdir "%OUT%\%1" 2>nul
cd /d "%OUT%\%1"
copy /y "%SRC%\_%1.ml" "_%1.ml" >nul
ocamlc -I +unix unix.cma -o prog.exe _%1.ml >build.log 2>&1
if exist prog.exe ( echo OK %1 ) else ( echo ocaml-FAIL %1 )
exit /b 0
