@echo off
rem Build the java-graalvm-jit row: javac produces the class files, GraalVM's java runs
rem them (no ahead-of-time step; the Graal compiler replaces HotSpot's C2 by default).
rem   exec\java-graalvm-jit\<task>\_<task>.class   artifact, run as
rem   tools\graalvm\bin\java.exe -cp . _<task>     with cwd exec\java-graalvm-jit\<task>
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\java-graalvm-jit
set JAVAC=%ROOT%\tools\graalvm\bin\javac.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\java-graalvm-jit\%%T" mkdir "%ROOT%\exec\java-graalvm-jit\%%T"
  copy /y "%SRC%\_%%T.java" "%ROOT%\exec\java-graalvm-jit\%%T\_%%T.java" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\java-graalvm-jit\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\java-graalvm-jit\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\java-graalvm-jit\%%T"
  "%JAVAC%" -encoding UTF-8 _%%T.java >build.log 2>&1
  if errorlevel 1 (echo java-graalvm-jit-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo java-graalvm-jit-FAIL some task & exit /b 1)
echo java-graalvm-jit OK
endlocal
