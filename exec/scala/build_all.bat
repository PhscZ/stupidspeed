@echo off
rem Build the scala row (jvm toolchain): scalac compiles each task to JVM bytecode.
rem   exec\scala\jvm\<task>\<task>.scala -> exec\scala\jvm\<task>\out\Main.class
rem   scalac -release 17 -d out <task>.scala, run as
rem   java -cp "out;<scala>/maven2/.../scala3-library_3-3.9.0.jar;.../scala-library-3.9.0.jar" Main
rem The compiler needs a JDK 17+. tools\scala\libexec\common.bat deliberately skips any
rem java.exe whose path contains "javapath" and then picks the next one on PATH, which on
rem this box is Oracle's java8path (Java 8) -- scalac then dies with
rem UnsupportedClassVersionError on class file 61.0. Pin JAVACMD to the modern JDK shim
rem (the same java.exe cells.json runs the row with) so common.bat uses it directly.
set "JAVACMD=%ProgramFiles%\Common Files\Oracle\Java\javapath\java.exe"
rem Tasks 14 and 15 get the data.bin fixture in their run directory.
rem Pass task names to build only those (e.g. build_all.bat 03_func_sum).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\scala
set OUT=%ROOT%\exec\scala\jvm
set SCALAC=%ROOT%\tools\scala\bin\scalac.bat
set ALL=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
if "%~1"=="" (set TASKS=%ALL%) else (set TASKS=%*)
set FAILED=0
for %%T in (%TASKS%) do (
  call :build %%T
  if errorlevel 1 (set FAILED=1 & echo scala-FAIL %%T) else (echo OK %%T)
)
if %FAILED%==1 exit /b 1
exit /b 0

:build
set T=%1
set D=%OUT%\%T%
if not exist "%D%" mkdir "%D%"
copy /y "%SRC%\%T%.scala" "%D%\%T%.scala" >nul || exit /b 1
if exist "%D%\out" rd /s /q "%D%\out"
if not exist "%D%\out" mkdir "%D%\out"
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%D%\data.bin" >nul || exit /b 1
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%D%\data.bin" >nul || exit /b 1
pushd "%D%"
call "%SCALAC%" -release 17 -d out "%T%.scala" >build.log 2>&1
set RC=%ERRORLEVEL%
popd
if not %RC%==0 exit /b 1
if not exist "%D%\out\Main.class" exit /b 1
exit /b 0
