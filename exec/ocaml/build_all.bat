@echo off
rem Build the ocaml row: one source set, two back ends.
rem   exec\ocaml\ocamlopt\<task>\prog.exe   ocamlopt -unsafe -I +unix unix.cmxa -o prog.exe _<task>.ml
rem   exec\ocaml\ocamlc\<task>\prog.exe     ocamlc   -I +unix unix.cma  -o prog.exe _<task>.ml
rem Both toolchains need the MSYS2 UCRT64 bin directory on PATH and OCAMLLIB set to the
rem *Windows* form of the stdlib directory (see BUILD.md): ocamlopt is a native Win32
rem binary, so the MSYS2-style /ucrt64/... path in its config resolves to nothing and
rem every compile fails with 'Unbound module Stdlib'.
rem The sources are the ocamlopt row's own fifteen files, unchanged.
rem `unix.cmxa`/`unix.cma` has to be named on the link line: OCaml 5 puts the Unix module
rem in lib\ocaml\unix and only auto-adds that directory to the search path, so the
rem interface is found but the implementation is not, and the link stops with
rem "No implementation provided for the following modules: Unix".
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\ocaml
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

set "PATH=%UCRT%\bin;%PATH%"
set "OCAMLLIB=%UCRT%\lib\ocaml"

for %%C in (ocamlopt ocamlc) do (
  for %%T in (%TASKS%) do (
    if not exist "%ROOT%\exec\ocaml\%%C\%%T" mkdir "%ROOT%\exec\ocaml\%%C\%%T"
    copy /y "%SRC%\_%%T.ml" "%ROOT%\exec\ocaml\%%C\%%T\_%%T.ml" >nul
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\ocaml\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\ocaml\%%C\%%T\data.bin" >nul
  )
)

for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\ocaml\ocamlopt\%%T"
  ocamlopt -unsafe -I +unix unix.cmxa -o prog.exe _%%T.ml >build.log 2>&1
  if errorlevel 1 (echo ocaml-FAIL ocamlopt %%T & set FAIL=1) else (echo OK %%T ocamlopt)
  popd
)

for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\ocaml\ocamlc\%%T"
  ocamlc -I +unix unix.cma -o prog.exe _%%T.ml >build.log 2>&1
  if errorlevel 1 (echo ocaml-FAIL ocamlc %%T & set FAIL=1) else (echo OK %%T ocamlc)
  popd
)

if "%FAIL%"=="1" (echo ocaml-FAIL some task & exit /b 1)
echo ocaml OK
endlocal
