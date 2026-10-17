@echo off
rem Build the lean4 row: Lean compiles the module to C and then links it with the
rem toolchain's own clang/lld.
rem   exec\lean4\lean4\<task>\prog.exe   artifact, run as `prog.exe` from that dir
rem The header's build line is:
rem   lean -c <task>.c <task>.lean && leanc -O2 -o prog <task>.c
rem `leanc` drives the clang/lld/Lean-runtime tree that lives in tools\lean4\bin\,
rem so that directory has to be first on PATH or leanc cannot find its own linker
rem (BUILD.md).  On Windows `-o prog` writes `prog.exe`, which is the artifact path
rem exec/cells.json names.
rem The .c the first step emits is kept beside the program -- it is the build's
rem intermediate, in the same directory the harness runs from.
rem Tasks 14 and 15 need the data.bin fixture in the directory the program runs in;
rem task 15 leaves out.bin there.  TIME_MS goes to stderr (IO.eprintln).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\lean4
set OUT=%ROOT%\exec\lean4\lean4
set "PATH=%ROOT%\tools\lean4\bin;%PATH%"
set FAIL=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.lean" "%OUT%\%%T\%%T.lean" >nul || (echo lean4-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  del /q prog.exe >nul 2>&1
  lean -c %%T.c %%T.lean >build.log 2>&1
  if errorlevel 1 (echo lean4-FAIL %%T & set FAIL=1) else (
    leanc -O2 -o prog %%T.c >>build.log 2>&1
    if errorlevel 1 (echo lean4-FAIL %%T & set FAIL=1) else (echo OK %%T)
  )
  popd
)
if "%FAIL%"=="1" (echo lean4-FAIL some task & exit /b 1)
endlocal
