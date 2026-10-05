@echo off
setlocal enabledelayedexpansion
rem Build all 15 ActionScript tasks into exec\actionscript\<task>\out\prog.exe
rem Each task gets its own directory holding the source, the shared app.xml, the SWF and
rem the packaged -target cmdline bundle. Task 11 compiles its worker SWF as a second
rem translation unit; task 14 bundles data.bin, because AIR has no working-directory API.
set AIR_HOME=C:\stupidspeed\tools\airsdk
set PATH=C:\stupidspeed\tools\openj9\bin;%AIR_HOME%\bin;%PATH%
set JAVA_HOME=C:\stupidspeed\tools\openj9
set SRC=C:\stupidspeed\sources\actionscript
set EXEC=C:\stupidspeed\exec\actionscript
set ADT=%AIR_HOME%\bin\adt.bat
set AMXMLC=%AIR_HOME%\bin\amxmlc.bat

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\_%%T.as" . >nul
  copy /y "%SRC%\app.xml" . >nul
  if not exist test.p12 call "%ADT%" -certificate -cn SelfSigned 2048-RSA test.p12 pass >nul 2>&1
  call "%AMXMLC%" -swf-version=51 -output prog.swf _%%T.as >amxmlc.log 2>&1
  if not exist prog.swf (
    echo AMXMLC-FAIL %%T
  ) else (
    set EXTRA=
    if "%%T"=="11_parallel_sum" (
      copy /y "%SRC%\_11_parallel_sum_worker.as" . >nul
      call "%AMXMLC%" -swf-version=51 -output worker.swf _11_parallel_sum_worker.as >worker.log 2>&1
      set EXTRA=worker.swf
    )
    if "%%T"=="14_file_read" (
      copy /y "C:\stupidspeed\data.bin" . >nul
      set EXTRA=data.bin
    )
    call "%ADT%" -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf !EXTRA! >adt.log 2>&1
    if exist "out\prog.exe" ( echo OK %%T ) else ( echo ADT-FAIL %%T & type adt.log )
  )
)
echo ALLDONE
