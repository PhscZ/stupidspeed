@echo off
rem Build the swift row: fifteen Swift sources through swiftc into
rem   exec\swift\swiftc\<task>\prog.exe   (artifact, run as `prog.exe` in that dir)
rem The link step needs the MSVC environment on PATH/INCLUDE/LIB, and the clang
rem importer needs -sdk (the toolchain's own Windows.sdk) plus
rem -windows-sdk-root/-windows-sdk-version: without those two flags the importer
rem never injects ucrt.modulemap/winsdk_*.modulemap and every `import Foundation`
rem dies with "missing required modules: '_complex', 'ucrt'".
rem The reassembled MSVC tree's `um` set is missing CommCtrl.h, ShlObj.h, DbgHelp.h
rem and 23 more headers the winsdk_um.modulemap names, so the SDK root is the
rem complete header tree from Microsoft.Windows.SDK.CPP 10.0.26100.1742 (nuget.org),
rem extracted under exec\swift\winsdk; the libraries come from the MSVC tree through
rem the LIB environment variable, so no Lib junction is needed.
rem Tasks 14 and 15 need the data.bin fixture in the directory they run in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\swift
set OUT=%ROOT%\exec\swift\swiftc
set SWIFT=%ROOT%\tools\swift
set WINDSK=%ROOT%\exec\swift\winsdk
set SDK=%SWIFT%\Platforms\6.4.0\Windows.platform\Developer\SDKs\Windows.sdk
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

if not exist "%WINDSK%\Include\10.0.26100.0\um\CommCtrl.h" (
  echo swift-FAIL missing Windows SDK headers under "%WINDSK%"
  exit /b 1
)

rem tools\msvc_env.py prints the set "VAR=..." lines; a for /f loop would mangle
rem %PATH%, so it is written to a .bat and called.
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
call "%TEMP%\stupidspeed_msvc_env.bat" >nul
set "PATH=%SWIFT%\Toolchains\6.4.0+NoAsserts\usr\bin;%SWIFT%\Runtimes\6.4.0\usr\bin;%PATH%"

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.swift" "%OUT%\%%T\%%T.swift" >nul || (echo swift-FAIL %%T & set FAIL=1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%OUT%\%%T"
  del /q prog.exe >nul 2>&1
  swiftc -O -sdk "%SDK%" -windows-sdk-root "%WINDSK%" -windows-sdk-version 10.0.26100.0 -o prog.exe %%T.swift >build.log 2>&1
  if errorlevel 1 (echo swift-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo swift-FAIL some task & exit /b 1)
echo swift OK
endlocal
