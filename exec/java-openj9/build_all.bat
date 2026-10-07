@echo off
setlocal
rem Build all 15 tasks for the `java-openj9` row, toolchain `openj9` (IBM Semeru / Eclipse OpenJ9 21).
rem   build: tools\openj9\bin\javac.exe -d . _<task>.java
rem   run:   tools\openj9\bin\java.exe -cp . _<task>
rem Sources are sources/java-openj9/ (identical to sources/java/); task 11 uses four
rem platform threads, so no special JVM flag is needed.
rem Output: exec\java-openj9\openj9\<task>\_<task>.class
set JAVAC=C:\stupidspeed\tools\openj9\bin\javac.exe
set SRC=C:\stupidspeed\sources\java-openj9
set EXEC=C:\stupidspeed\exec\java-openj9
set TOOL=openj9
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## %TOOL%
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\%TOOL%\%%T" 2>nul
  cd /d "%EXEC%\%TOOL%\%%T"
  copy /y "%SRC%\_%%T.java" . >nul
  if "%%T"=="14_file_read" copy /y "%DATA%" . >nul
  if "%%T"=="15_file_write" copy /y "%DATA%" . >nul
  del /q *.class 2>nul
  "%JAVAC%" -d . _%%T.java >build.log 2>&1
  if exist _%%T.class ( echo OK %TOOL% %%T ) else ( echo JAVA-OPENJ9-FAIL %TOOL% %%T )
)
echo ALLDONE
