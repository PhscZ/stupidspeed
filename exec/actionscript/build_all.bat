@echo off
rem Build the actionscript row: AIR 51.4.1, amxmlc + adt.
rem   exec\actionscript\<task>\out\prog.exe      artifact (a directory package)
rem   amxmlc -swf-version=51 -output prog.swf _<task>.as
rem   adt -package -storetype pkcs12 -keystore test.p12 -storepass pass ^
rem       -target cmdline out app.xml prog.swf [worker.swf] [data.bin]
rem Task 11 also compiles _11_parallel_sum_worker.as to worker.swf, and task 14
rem packages data.bin into the bundle: AIR has no working-directory API, so the
rem fixture is read from File.applicationDirectory.
rem app.xml is copied byte for byte -- adt embeds it verbatim as
rem META-INF/AIR/application.xml and the runtime rejects a line-ending-converted
rem copy (see .gitattributes).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\actionscript
set OUT=%ROOT%\exec\actionscript
set AIR=%ROOT%\tools\airsdk\bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

rem One self-signed certificate, generated once and reused by every task: adt
rem refuses to package an unsigned bundle.
if not exist "%OUT%\test.p12" (
  call "%AIR%\adt.bat" -certificate -cn SelfSigned 2048-RSA "%OUT%\test.p12" pass >"%OUT%\cert.log" 2>&1
  if errorlevel 1 (echo actionscript-FAIL certificate & exit /b 1)
)

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\_%%T.as" "%OUT%\%%T\_%%T.as" >nul
  copy /y "%SRC%\app.xml" "%OUT%\%%T\app.xml" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="11_parallel_sum" copy /y "%SRC%\_11_parallel_sum_worker.as" "%OUT%\%%T\_11_parallel_sum_worker.as" >nul
  pushd "%OUT%\%%T"
  if exist out rmdir /s /q out
  call "%AIR%\amxmlc.bat" -swf-version=51 -output prog.swf _%%T.as >amxmlc.log 2>&1
  if errorlevel 1 (
    echo actionscript-FAIL %%T
    set FAIL=1
  ) else (
    set "EXTRA="
    if "%%T"=="11_parallel_sum" (
      call "%AIR%\amxmlc.bat" -swf-version=51 -output worker.swf _11_parallel_sum_worker.as >>amxmlc.log 2>&1
      if errorlevel 1 (echo actionscript-FAIL %%T & set FAIL=1)
      set "EXTRA=worker.swf"
    )
    if "%%T"=="14_file_read" set "EXTRA=data.bin"
    call "%AIR%\adt.bat" -package -storetype pkcs12 -keystore "%OUT%\test.p12" -storepass pass -target cmdline out app.xml prog.swf !EXTRA! >adt.log 2>&1
    if errorlevel 1 (echo actionscript-FAIL %%T & set FAIL=1) else (echo OK %%T)
  )
  popd
)

if "%FAIL%"=="1" (echo actionscript-FAIL some task & exit /b 1)
echo actionscript OK
endlocal
