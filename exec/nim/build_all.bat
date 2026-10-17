@echo off
rem Build the nim row: one front end, three code generators.
rem   exec\nim\nim\<task>\prog.exe      nim c   -d:release            (C   -> gcc)
rem   exec\nim\cpp\<task>\prog.exe      nim cpp -d:release            (C++ -> g++)
rem   exec\nim\clang\<task>\prog.exe    nim c   -d:release --cc:clang (C   -> LLVM clang)
rem Nim rejects a module name that is not a valid identifier, so the sources
rem `_01_branches.nim` .. `_15_file_write.nim` are copied to `t<task>.nim` first
rem (`Error: invalid module name: '_01_branches'` otherwise).
rem The default C backend needs gcc on PATH (the MSYS2 UCRT64 tree); the clang
rem backend needs the MSVC environment, because tools\llvm\bin\clang.exe ships no
rem headers of its own and would stop at `fatal error: 'windows.h' file not found`.
rem Each toolchain keeps its own nimcache, shared by its fifteen tasks, so the
rem standard library objects are compiled once for the whole row instead of once
rem per task (they are the same set for all fifteen).
rem Tasks 14 and 15 need the data.bin fixture in the directory the program runs in.
setlocal
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\nim
set OUT=%ROOT%\exec\nim
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set NIM=%ROOT%\tools\nim\bin\nim.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

rem ---- stage every task's source, and the fixture for 14 and 15
for %%C in (nim cpp clang) do (
  for %%T in (%TASKS%) do (
    if not exist "%OUT%\%%C\%%T" mkdir "%OUT%\%%C\%%T"
    copy /y "%SRC%\_%%T.nim" "%OUT%\%%C\%%T\t%%T.nim" >nul
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%C\%%T\data.bin" >nul
  )
)

rem ---- nim: C backend, gcc from the MSYS2 UCRT64 tree
set "PATH=%UCRT%\bin;%ROOT%\tools\nim\bin;%PATH%"
for %%T in (%TASKS%) do call :nimc %%T

rem ---- nim (cpp): C++ backend, g++ from the same tree
set "PATH=%UCRT%\bin;%ROOT%\tools\nim\bin;%PATH%"
for %%T in (%TASKS%) do call :nimcpp %%T

rem ---- nim (clang): C backend driven into LLVM; needs the MSVC environment
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
call "%TEMP%\stupidspeed_msvc_env.bat" >nul
set "PATH=%UCRT%\bin;%ROOT%\tools\nim\bin;%ROOT%\tools\llvm\bin;%PATH%"
for %%T in (%TASKS%) do call :nimclang %%T

if "%FAIL%"=="1" (echo nim-FAIL some task & exit /b 1)
echo nim OK
exit /b 0

:nimc
call :one nim c %1
exit /b 0

:nimcpp
call :one cpp cpp %1
exit /b 0

:nimclang
call :one clang c %1 --cc:clang
exit /b 0

:one
rem %1 toolchain dir, %2 subcommand, %3 task, %4 extra flags
if not exist "%OUT%\%1\nimcache" mkdir "%OUT%\%1\nimcache"
pushd "%OUT%\%1\%3"
%NIM% %2 -d:release %4 --nimcache:"%OUT%\%1\nimcache" -o:prog.exe t%3.nim >build.log 2>&1
if errorlevel 1 (echo nim-FAIL %1 %3 & set "FAIL=1" & popd & exit /b 0)
if not exist prog.exe (echo nim-FAIL %1 %3 no prog.exe & set "FAIL=1" & popd & exit /b 0)
echo OK %3 %1
popd
exit /b 0
