@echo off
rem Build the java row.  One build step: javac compiles each task's class file into
rem the directory the harness runs it from.
rem   exec\java\openjdk\<task>\_<task>.class   artifact, run as `java -cp . _<task>`
rem The row's other three toolchains -- (interp), (c1) and (c2) -- are the *same*
rem class files with a different JVM run line (-Xint, -XX:TieredStopAtLevel=1,
rem -XX:-TieredCompilation), so they need no build of their own.
rem Tasks 14 and 15 get the data.bin fixture in their run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\java
set OUT=%ROOT%\exec\java\openjdk
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\_%%T.java" "%OUT%\%%T\_%%T.java" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  javac _%%T.java >build.log 2>&1
  if errorlevel 1 (echo java-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo java-FAIL some task & exit /b 1)
echo java OK
endlocal
