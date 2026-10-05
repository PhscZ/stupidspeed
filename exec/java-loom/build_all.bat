@echo off
setlocal enabledelayedexpansion
rem Build all 15 Java tasks for the `java` (loom) row.
rem   javac -d . _<task>.java   -> _<task>.class
rem   run: java -cp . _<task>
rem The sources are sources/java-loom/, the openjdk row's own fifteen files with one change:
rem task 11 replaces `new Thread(...)` with `Thread.ofVirtual()`, which is final since 21.
rem Output: exec\java-loom\<task>\_<task>.class
set JAVA_HOME=D:\Users\pedro.cardoso\jdk-25.0.2
set JAVAC=%JAVA_HOME%\bin\javac.exe
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\java-loom
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\java-loom
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## loom
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\_%%T.java" . >nul
  "%JAVAC%" -d . _%%T.java >build.log 2>&1
  if exist _%%T.class ( echo OK loom %%T ) else ( echo JAVA-FAIL loom %%T )
)
echo ALLDONE
