@echo off
setlocal
rem Build all 15 tasks for the `java` row, toolchain `openjdk` (the system HotSpot JDK).
rem   build: javac -d . _<task>.java     run: java -cp . _<task>
rem The sources are sources/java/, where the public class name matches the file name,
rem so the class is `_<task>` (the leading underscore is part of the name).
rem Task 11 in this row uses four platform threads (java.lang.Thread); the virtual-thread
rem variant lives in sources/java-loom/.
rem Output: exec\java\openjdk\<task>\_<task>.class
set JAVAC=javac
set SRC=C:\stupidspeed\sources\java
set EXEC=C:\stupidspeed\exec\java
set TOOL=openjdk
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
  if exist _%%T.class ( echo OK %TOOL% %%T ) else ( echo JAVA-FAIL %TOOL% %%T )
)
echo ALLDONE
