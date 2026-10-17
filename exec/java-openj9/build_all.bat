@echo off
rem Build the java-openj9 row: javac from IBM Semeru's OpenJ9 JDK, one class file per task.
rem   exec\java-openj9\openj9\<task>\_<task>.class   run as `tools\openj9\bin\java.exe -cp . _<task>`
rem The class file is the artifact exec/cells.json names; the source is staged beside it.
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\java-openj9
set OUT=%ROOT%\exec\java-openj9\openj9
set JAVAC=%ROOT%\tools\openj9\bin\javac.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
if not "%~1"=="" set TASKS=%*
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\_%%T.java" "%OUT%\%%T\_%%T.java" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%JAVAC%" -d . _%%T.java >build.log 2>&1
  if errorlevel 1 (echo java-openj9-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo java-openj9-FAIL some task & exit /b 1)
echo java-openj9 OK
endlocal
