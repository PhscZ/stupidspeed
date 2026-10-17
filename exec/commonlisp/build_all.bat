@echo off
rem Build the commonlisp row: SBCL compiles each task and dumps a standalone
rem executable, so the timed run pays only the core's start-up.
rem   exec\commonlisp\<task>\prog.exe   artifact, run as `prog.exe` from that dir
rem The header's build line is:
rem   sbcl --non-interactive --no-userinit --no-sysinit --load <task>.lisp
rem        --eval "(sb-ext:save-lisp-and-die \"prog.exe\" :executable t
rem                 :toplevel (function main) :application-type :console)"
rem Task 03 also needs its helper 03_func_sum_add_one.lisp beside it -- the task
rem file `load`s it by bare name, so it is resolved against the working directory.
rem Tasks 14 and 15 need the data.bin fixture there; task 15 leaves out.bin there.
rem TIME_MS goes to *error-output* (stderr) from every dumped executable.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\commonlisp
set OUT=%ROOT%\exec\commonlisp
set SBCL=%ROOT%\tools\sbcl\sbcl.exe
set FAIL=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.lisp" "%OUT%\%%T\%%T.lisp" >nul || (echo commonlisp-FAIL %%T & exit /b 1)
  if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.lisp" "%OUT%\%%T\03_func_sum_add_one.lisp" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%SBCL%" --non-interactive --no-userinit --no-sysinit --load %%T.lisp --eval "(sb-ext:save-lisp-and-die \"prog.exe\" :executable t :toplevel (function main) :application-type :console)" >build.log 2>&1
  if errorlevel 1 (echo commonlisp-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)
if "%FAIL%"=="1" (echo commonlisp-FAIL some task & exit /b 1)
endlocal
