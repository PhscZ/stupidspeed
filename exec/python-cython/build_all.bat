@echo off
rem Build the python-cython row: each task is turned into C by `cython --embed`
rem and linked by gcc against the CPython 3.13 installation the registry's PATH
rem names.
rem   exec\python-cython\cython\<task>\prog.exe   artifact, run as `prog.exe`
rem prog.exe is *not* standalone: it imports python313.dll, which the registry's
rem env puts on PATH at run time.  -static keeps the MinGW runtime (libgcc,
rem libwinpthread) out of that run-time PATH -- only the build has UCRT64\bin on
rem it.  -DMS_WIN64 is the trap BUILD.md calls out: CPython's pyconfig.h defines
rem it only under _MSC_VER, so MinGW has to be told, and -municode matches the
rem wmain the embedded Cython main expects.
rem Tasks 14 and 15 need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\python-cython
set OUT=%ROOT%\exec\python-cython\cython
set PY=C:\Users\pz020\AppData\Local\Programs\Python\Python313
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set "PATH=%PY%;%PY%\DLLs;%PY%\Scripts;%UCRT%\bin;%PATH%"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  pushd "%OUT%\%%T"
  copy /y "%SRC%\%%T.py" "%%T.py" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" data.bin >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" data.bin >nul
  "%PY%\Scripts\cython.exe" --embed -3 --module-name _%%T -o _%%T.c %%T.py >build.log 2>&1
  if errorlevel 1 (
    echo python-cython-FAIL %%T & set FAIL=1
  ) else (
    gcc -O2 -DMS_WIN64 -municode -I "%PY%\include" -o prog.exe _%%T.c -L "%PY%\libs" -lpython313 -static >>build.log 2>&1
    if errorlevel 1 (echo python-cython-FAIL %%T & set FAIL=1) else (echo OK %%T)
  )
  popd
)

if "%FAIL%"=="1" (echo python-cython-FAIL some task & exit /b 1)
echo python-cython OK
endlocal
