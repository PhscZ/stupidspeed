@echo off
setlocal enabledelayedexpansion
rem Build all 15 Java tasks for the `java` (openj9) row.
rem   tools\openj9\bin\javac.exe -d . _<task>.java   -> _<task>.class
rem   run: tools\openj9\bin\java.exe -cp . _<task>
rem The sources are sources/java-openj9/, the openjdk row's own fifteen files unchanged. The
rem whole difference is which VM executes the bytecode: Eclipse OpenJ9's JIT (openj9-0.61.0)
rem against HotSpot's C2. OpenJ9 maps java.lang.Thread onto OS threads, so task 11 is a real
rem four-thread pass. No OpenJ9-specific flag and no -X option is used.
rem Output: exec\java-openj9\<task>\_<task>.class
set J9=D:\Users\pedro.cardoso\stupidspeed\tools\openj9
set JAVAC=%J9%\bin\javac.exe
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\java-openj9
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\java-openj9
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## openj9
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\_%%T.java" . >nul
  "%JAVAC%" -d . _%%T.java >build.log 2>&1
  if exist _%%T.class ( echo OK openj9 %%T ) else ( echo JAVA-FAIL openj9 %%T )
)
echo ALLDONE
