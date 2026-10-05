@echo off
setlocal enabledelayedexpansion
rem Build all 15 Java tasks with the HotSpot JDK — the `java` (openjdk) row.
rem   javac -d . _<task>.java   -> _<task>.class
rem   run: java -cp . _<task>
rem The sources are sources/java/, which prefix the task name with an underscore because the
rem public class must match the file name; the class is `_<task>`.
rem Output: exec\java\<task>\_<task>.class
set JAVA_HOME=D:\Users\pedro.cardoso\jdk-25.0.2
set JAVAC=%JAVA_HOME%\bin\javac.exe
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\java
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\java
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## openjdk
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\_%%T.java" . >nul
  "%JAVAC%" -d . _%%T.java >build.log 2>&1
  if exist _%%T.class ( echo OK openjdk %%T ) else ( echo JAVA-FAIL openjdk %%T )
)
echo ALLDONE
