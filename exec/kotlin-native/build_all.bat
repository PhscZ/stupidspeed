@echo off
setlocal
rem Build all 15 Kotlin/Native tasks -- the `kotlin` (native) row.
rem   kotlinc-native -opt -o prog <task>.kt    -> prog.exe
rem Sources: sources\kotlin-native\: tasks 11, 14 and 15 differ from sources\kotlin\ because
rem Native has no java.lang and no java.io, so task 11 uses the stdlib Worker and the two file
rem tasks use platform.posix (fopen/fread/fwrite) through kotlinx.cinterop. The other twelve
rem are byte-identical to the jvm row's.
rem -opt is the optimiser. The launcher needs a JDK via JAVA_HOME. Use JDK 17: the launcher's
rem version parser splits `java -version` on "-." and JDK 24 prints `24` with no dot, leaving a
rem stray quote that breaks the batch (`=ALL-UNNAMED" was unexpected`). JDK 17 prints
rem `17.0.12`, which parses. First build downloads LLVM/libffi into %USERPROFILE%\.konan.
rem Output: exec\kotlin-native\<task>\prog.exe
set "KOTLINNATIVE=C:\stupidspeed\tools\kotlinnative\bin\kotlinc-native.bat"
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "SRC=%~dp0..\..\sources\kotlin-native"
set "EXEC=%~dp0"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo ########## kotlin native
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%%1" 2>nul
cd /d "%EXEC%%1"
copy /y "%SRC%\%1.kt" . >nul
call "%KOTLINNATIVE%" -opt -o prog %1.kt >build.log 2>&1
if exist prog.exe ( echo OK %1 ) else ( echo kotlin-native-FAIL %1 )
exit /b 0
