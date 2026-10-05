@echo off
setlocal
rem Build all 15 Kotlin/Native tasks — the `kotlin` (native) row.
rem   kotlinc-native -opt -o prog <task>.kt    -> prog.exe
rem The sources are sources/kotlin-native/: tasks 11, 14 and 15 differ from sources/kotlin/
rem because Native has no java.lang and no java.io, so task 11 uses the stdlib Worker and the
rem two file tasks use platform.posix (fopen/fread/fwrite) through kotlinx.cinterop. The other
rem twelve are byte-identical to the jvm row's.
rem -opt is the optimiser. The launcher wants a JDK via JAVA_HOME; note it mis-parses JDK 24's
rem version string, so a JDK 17-25 with a dotted version is the safe choice (25.0.2 here).
rem The first build downloads the LLVM 21 and libffi dependencies into %USERPROFILE%\.konan.
rem Output: exec\kotlin-native\<task>\prog.exe
set KOTLINNATIVE=D:\Users\pedro.cardoso\stupidspeed\tools\kotlin-native\kotlin-native-prebuilt-windows-x86_64-2.4.20\bin\kotlinc-native.bat
set JAVA_HOME=D:\Users\pedro.cardoso\jdk-25.0.2
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\kotlin-native
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\kotlin-native
set PATH=%JAVA_HOME%\bin;%PATH%

echo ########## kotlin native
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
copy /y "%SRC%\%1.kt" . >nul
call "%KOTLINNATIVE%" -opt -o prog %1.kt >build.log 2>&1
if exist prog.exe ( echo OK kotlin-native %1 ) else ( echo KOTLINNATIVE-FAIL %1 )
exit /b 0
