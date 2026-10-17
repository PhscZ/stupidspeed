@echo off
rem Build the objectivec row: clang with the GNUstep Objective-C runtime.
rem   exec\objectivec\clang\<task>\prog.exe
rem   clang -fobjc-runtime=gnustep-2.2 -O2 -o prog.exe <task>.m -lobjc -lgnustep-base
rem Tasks 06, 10, 11, 14 and 15 cannot be linked by GNU ld (binutils collapses the
rem .objcrt$SEL$m COMDAT sections), so those five take -fuse-ld=lld.
rem The produced exe imports the GNUstep runtime DLLs, and the cell's PATH entry is
rem relative, so vendor_dlls.py copies each program's DLL closure beside it.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\objectivec
set OUT=%ROOT%\exec\objectivec\clang
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

set "PATH=%UCRT%\bin;%PATH%"

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.m" "%OUT%\%%T\%%T.m" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  set "LDOPT="
  if "%%T"=="06_char_count" set "LDOPT=-fuse-ld=lld"
  if "%%T"=="10_pi" set "LDOPT=-fuse-ld=lld"
  if "%%T"=="11_parallel_sum" set "LDOPT=-fuse-ld=lld"
  if "%%T"=="14_file_read" set "LDOPT=-fuse-ld=lld"
  if "%%T"=="15_file_write" set "LDOPT=-fuse-ld=lld"
  clang -fobjc-runtime=gnustep-2.2 -O2 !LDOPT! -o prog.exe %%T.m -lobjc -lgnustep-base >build.log 2>&1
  if errorlevel 1 (echo objectivec-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

python "%ROOT%\exec\objectivec\fetch_libstdcxx.py"
if errorlevel 1 set FAIL=1
python "%ROOT%\exec\objectivec\vendor_dlls.py"
if errorlevel 1 set FAIL=1

if "%FAIL%"=="1" (echo objectivec-FAIL some task & exit /b 1)
echo objectivec OK
endlocal
