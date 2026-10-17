@echo off
rem Build the kotlin-native row: one Kotlin/Native executable per task.
rem   exec\kotlin-native\<task>\prog.exe   artifact, run as `prog.exe` with cwd that directory
rem Each task is compiled from its own source in sources\kotlin-native\ into its own directory;
rem tasks 14 and 15 also need the data.bin fixture in the directory they run in.
rem JAVA_HOME is pointed at the GraalVM JDK in tools\ because the launcher's own
rem `java -version` parse mis-handles the system JDK 24's version string ("24" has no patch
rem component, so the leading quote is not stripped) and it aborts before compiling.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\kotlin-native
set OUT=%ROOT%\exec\kotlin-native
set "JAVA_HOME=%ROOT%\tools\graalvm"
set KOTLINC=%ROOT%\tools\kotlinnative\bin\kotlinc-native.bat
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.kt" "%OUT%\%%T\%%T.kt" >nul || (echo kotlin-native-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  call "%KOTLINC%" -opt -o prog %%T.kt > build.log 2>&1
  popd
  if not exist "%OUT%\%%T\prog.exe" (echo kotlin-native-FAIL %%T & exit /b 1)
  echo OK %%T
)
endlocal
