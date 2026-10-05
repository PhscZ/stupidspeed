@echo off
setlocal
rem Build all 15 Kotlin/JVM tasks — the `kotlin` (jvm) row.
rem   kotlinc <task>.kt -include-runtime -d prog.jar
rem   run: java -jar prog.jar
rem The sources are sources/kotlin/. -include-runtime bundles kotlin-stdlib into the jar, so
rem the run line needs a JRE and nothing else. Task 11 uses four java.lang.Thread workers.
rem Output: exec\kotlin\<task>\prog.jar
set KOTLIN=D:\Users\pedro.cardoso\stupidspeed\tools\kotlin\kotlinc\bin\kotlinc.bat
set JAVA_HOME=D:\Users\pedro.cardoso\jdk-25.0.2
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\kotlin
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\kotlin
set PATH=%JAVA_HOME%\bin;%PATH%

echo ########## kotlin jvm
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
copy /y "%SRC%\%1.kt" . >nul
call "%KOTLIN%" %1.kt -include-runtime -d prog.jar >build.log 2>&1
if exist prog.jar ( echo OK kotlin %1 ) else ( echo KOTLIN-FAIL %1 )
exit /b 0
