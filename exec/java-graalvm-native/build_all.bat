@echo off
rem Build the java-graalvm-native row: the same fifteen Java sources as the
rem openjdk row, compiled by javac and then ahead-of-time by GraalVM's
rem native-image into a standalone executable.
rem   exec\java-graalvm-native\<task>\_<task>.exe    artifact, run from that directory
rem native-image needs the MSVC linker on PATH plus INCLUDE/LIB (tools\msvc_env.py);
rem without it the launcher stops with "Failed to find 'vswhere.exe' ...".  It also
rem needs the class file on the class path, so javac runs first in the same
rem directory.  Task 03 adds -H:NeverInline for the reason BUILD.md records: with a
rem constant bound and a constant start native-image folds the whole hundred
rem million iteration loop at build time, and the cell would measure nothing.
rem Tasks 14 and 15 need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\java-graalvm-native
set OUT=%ROOT%\exec\java-graalvm-native
set JAVA_HOME=%ROOT%\tools\graalvm
set "PATH=%JAVA_HOME%\bin;%PATH%"
set NI=%JAVA_HOME%\lib\svm\bin\native-image.exe
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
call "%TEMP%\stupidspeed_msvc_env.bat" >nul
set FAIL=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\_%%T.java" "%OUT%\%%T\_%%T.java" >nul || (echo java-graalvm-native-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%JAVA_HOME%\bin\javac.exe" _%%T.java >build.log 2>&1
  if errorlevel 1 (
    echo java-graalvm-native-FAIL %%T & set FAIL=1
  ) else (
    if "%%T"=="03_func_sum" (
      "%NI%" -O2 -H:NeverInline=_03_func_sum.addOne _%%T >>build.log 2>&1
    ) else (
      "%NI%" -O2 _%%T >>build.log 2>&1
    )
    if errorlevel 1 (echo java-graalvm-native-FAIL %%T & set FAIL=1) else (echo OK %%T)
  )
  popd
)
if "%FAIL%"=="1" (echo java-graalvm-native-FAIL some task & exit /b 1)
echo java-graalvm-native OK
endlocal
