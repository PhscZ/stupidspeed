@echo off
rem Build all 15 Java tasks for the `java` (graalvm jit) row.
rem   javac -d . _<task>.java    -> _<task>.class
rem   run: java -cp . _<task>    (tools\graalvm\bin\java.exe, GraalVM's JIT)
rem The sources are sources/java-graalvm-jit/, the openjdk row's own fifteen files
rem unchanged; the whole difference from the openjdk row is which JIT compiles the
rem bytecode -- GraalVM enables JVMCI and the Graal compiler by default.
rem Output: exec\java-graalvm-jit\<task>\_<task>.class
setlocal
set "ROOT=C:\stupidspeed"
set "GRAALVM=%ROOT%\tools\graalvm"
set "JAVAC=%GRAALVM%\bin\javac.exe"
set "SRC=%ROOT%\sources\java-graalvm-jit"
set "EXEC=%ROOT%\exec\java-graalvm-jit"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## graalvm jit
for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
copy /y "%SRC%\_%1.java" "%EXEC%\%1\" >nul
pushd "%EXEC%\%1"
"%JAVAC%" -d . _%1.java >build.log 2>&1
if exist _%1.class ( echo OK %1 ) else ( echo JAVA-GRAALVM-JIT-FAIL %1 )
popd
exit /b 0
