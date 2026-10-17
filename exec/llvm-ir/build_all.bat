@echo off
rem Build the llvm-ir row: hand-written LLVM IR through llc and clang.
rem   exec\llvm-ir\llc\<task>\prog.exe   artifact, run as `prog.exe`
rem Two steps per task: llc lowers the .ll text to a COFF object, then clang
rem drives lld-link against the MSVC libraries (only LIB from tools\msvc_env.py
rem is needed -- no headers are involved).  Tasks 14 and 15 also need the
rem data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\llvm-ir
set OUT=%ROOT%\exec\llvm-ir\llc
set LLVM=%ROOT%\tools\llvm\bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
call "%TEMP%\stupidspeed_msvc_env.bat" >nul
set "PATH=%LLVM%;%PATH%"

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.ll" "%OUT%\%%T\%%T.ll" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%OUT%\%%T"
  "%LLVM%\llc.exe" -O2 -filetype=obj -o prog.obj %%T.ll >build.log 2>&1
  if errorlevel 1 (
    echo llvm-ir-FAIL %%T & set FAIL=1
  ) else (
    "%LLVM%\clang.exe" -O2 -fuse-ld=lld prog.obj -o prog.exe >>build.log 2>&1
    if errorlevel 1 (echo llvm-ir-FAIL %%T & set FAIL=1) else (echo OK %%T)
  )
  popd
)

if "%FAIL%"=="1" (echo llvm-ir-FAIL some task & exit /b 1)
echo llvm-ir OK
endlocal
