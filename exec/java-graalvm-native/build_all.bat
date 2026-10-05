@echo off
setlocal
rem Build all 15 Java tasks into standalone native executables — the `java` (graalvm
rem native-image) row.
rem   javac -d . _<task>.java        -> _<task>.class
rem   native-image -O2 _<task>       -> _<task>.exe
rem The sources are sources/java-graalvm-native/, the openjdk row's own fifteen files unchanged.
rem native-image on Windows insists on an MSVC toolchain and finds it only through vswhere.exe,
rem so this row drives the hand-extracted tree at tools\msvc through two shims: a vswhere.exe
rem that prints the VS root (tools\msvc-vsroot\Microsoft Visual Studio\Installer) and a
rem vcvarsall.bat under it that sets PATH/INCLUDE/LIB. ProgramFiles(x86) is redirected at the
rem shim so native-image's own lookup finds it. See BUILD.md's msvc section.
rem Output: exec\java-graalvm-native\<task>\_<task>.exe
set GRAALVM=D:\Users\pedro.cardoso\stupidspeed\tools\graalvm-jdk-25.0.4+7.1
set JAVAC=%GRAALVM%\bin\javac.exe
set NATIVEIMAGE=%GRAALVM%\bin\native-image.cmd
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\java-graalvm-native
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\java-graalvm-native
set "ProgramFiles(x86)=D:\Users\pedro.cardoso\stupidspeed\tools\msvc-vsroot"
set "SS_VSROOT=D:\Users\pedro.cardoso\stupidspeed\tools\msvc-vsroot\VS"

echo ########## graalvm native-image
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
copy /y "%SRC%\_%1.java" . >nul
"%JAVAC%" -d . _%1.java >javac.log 2>&1
if exist _%1.class call "%NATIVEIMAGE%" -O2 _%1 >build.log 2>&1
if exist _%1.exe ( echo OK native-image %1 ) else ( echo JAVA-FAIL native-image %1 )
exit /b 0
