@echo off
rem Build the masm row: the same fifteen tasks in MASM syntax, assembled by
rem ml64.exe and linked by link.exe against kernel32.lib only.
rem   exec\masm\masm\<task>\<task>.exe   ml64 /c + link /subsystem:console
rem The tool paths are NOT called ML/LINK: ml64 reads %ML% and link reads %LINK%
rem as extra default command-line options.
rem Tasks 14 and 15 also need the data.bin fixture in the directory they run in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\masm
set OUT=%ROOT%\exec\masm\masm
set MSVC=%ROOT%\tools\msvc\VC\Tools\MSVC\14.44.35207
set ML64EXE=%MSVC%\bin\Hostx64\x64\ml64.exe
set LINKEXE=%MSVC%\bin\Hostx64\x64\link.exe
set "LIB=%MSVC%\lib\x64;%ROOT%\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;%ROOT%\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.asm" "%OUT%\%%T\%%T.asm" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%ML64EXE%" /nologo /c /Fo prog.obj %%T.asm >build.log 2>&1
  if errorlevel 1 (
    echo masm-FAIL %%T
    set FAIL=1
  ) else (
    "%LINKEXE%" /nologo /subsystem:console /entry:main /out:%%T.exe prog.obj kernel32.lib >>build.log 2>&1
    if errorlevel 1 (echo masm-FAIL %%T & set FAIL=1) else (echo OK %%T)
  )
  popd
)

if "%FAIL%"=="1" (echo masm-FAIL some task & exit /b 1)
echo masm OK
endlocal
