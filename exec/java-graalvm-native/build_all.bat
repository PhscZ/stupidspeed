@echo off
rem Build all 15 Java tasks for the `java` (graalvm native-image) row.
rem   javac -d . _<task>.java          -> _<task>.class
rem   native-image -O2 _<task>         -> _<task>.exe
rem The sources are sources/java-graalvm-native/, the openjdk row's own fifteen
rem files unchanged.
rem
rem native-image needs an MSVC C toolchain on Windows. There is no Visual Studio
rem installed here, so the hand-extracted tree under tools\msvc is put on
rem PATH with INCLUDE/LIB from tools\msvc_env.py. With cl.exe on PATH
rem native-image's WindowsBuildEnvironmentUtil.isCCompilerOnPath() returns true
rem and it skips the vswhere/vcvarsall lookup entirely. The msvc-shim tree is
rem set as a fallback in case that ever changes: msvc-shim\...\vswhere.exe
rem prints the shim VS root and its vcvarsall.bat exports the same environment.
rem Output: exec\java-graalvm-native\<task>\_<task>.exe
setlocal
set "ROOT=C:\stupidspeed"
set "GRAALVM=%ROOT%\tools\graalvm"
set "JAVAC=%GRAALVM%\bin\javac.exe"
set "NATIVEIMAGE=%GRAALVM%\bin\native-image.cmd"
set "SRC=%ROOT%\sources\java-graalvm-native"
set "EXEC=%ROOT%\exec\java-graalvm-native"
set "SHIM=%EXEC%\msvc-shim"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

rem --- MSVC environment -------------------------------------------------------
for /f "usebackq delims=" %%L in (`python "%ROOT%\tools\msvc_env.py"`) do call %%L
set "PATH=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64;%PATH%"
set "VCINSTALLDIR=C:\stupidspeed\tools\msvc\VC\"
set "ProgramFiles(x86)=%SHIM%"
set "SS_VSROOT=%SHIM%\VS"

echo ########## graalvm native-image
for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
copy /y "%SRC%\_%1.java" "%EXEC%\%1\" >nul
pushd "%EXEC%\%1"
del /q _%1.exe _%1.class build.log javac.log out.bin 2>nul
"%JAVAC%" -d . _%1.java >javac.log 2>&1
rem Task 03 is the one task whose loop native-image folds away: addOne is inlined
rem and the hundred-million-iteration loop with a constant bound and a constant
rem start becomes the constant 100000000, so the cell measured nothing (TIME_MS
rem 0.0001 against 31 ms at -O0). -H:NeverInline is native-image's own no-inline
rem lever, the counterpart of the C row's __attribute__((noinline)); the pattern
rem is the one method, so the flag is set for that task alone.
set "NIFLAG="
if "%1"=="03_func_sum" set "NIFLAG=-H:NeverInline=_03_func_sum.addOne"
if exist _%1.class (
  call "%NATIVEIMAGE%" -O2 %NIFLAG% _%1 >build.log 2>&1
)
if exist _%1.exe ( echo OK %1 ) else ( echo JAVA-GRAALVM-NATIVE-FAIL %1 )
popd
exit /b 0
