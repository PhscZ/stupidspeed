@echo off
rem Build the scala-native row: the same fifteen Scala sources as the `scala` jvm row,
rem compiled to LLVM IR by Scala Native and linked by the portable llvm-mingw clang.
rem   exec\scala-native\scala-native\<task>\prog.exe   artifact, run as `prog.exe`
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
rem
rem Pass a space-separated task list as the first argument to build only part of the row
rem (used to split the long row across two shells); with no argument the whole row builds.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\scala-native
set OUT=%ROOT%\exec\scala-native\scala-native
set LLVM=%ROOT%\tools\llvm-mingw
set SCALACLI=%ROOT%\tools\scala-cli\scala-cli.exe
rem scala-cli drives a JDK; the shim JDKs on PATH are too old, so point it at a real one.
set "JAVA_HOME=C:\Program Files\Java\jdk-24"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
if not "%~1"=="" set TASKS=%*
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.scala" "%OUT%\%%T\%%T.scala" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%SCALACLI%" --power package %%T.scala --native -S 3.9.0 --native-version 0.5.12 --native-mode release-fast --native-clang "%LLVM%\bin\clang.exe" --native-clangpp "%LLVM%\bin\clang++.exe" --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe --force >build.log 2>&1
  if errorlevel 1 (echo scala-native-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo scala-native-FAIL some task & exit /b 1)
echo scala-native OK
endlocal
