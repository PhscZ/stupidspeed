@echo off
rem Build the vbnet row: one .vbproj per task, compiled with the .NET 8 SDK.
rem
rem   exec\vbnet\dotnet\<task>\<task>.vb        source copy
rem   exec\vbnet\dotnet\<task>\bin\Release\net8.0\<task>.dll   artifact
rem
rem The .NET SDK does not support several projects in one directory, so each task
rem keeps its own directory (BUILD.md), which is also the directory the registry
rem runs the built dll from.  Tasks 14 and 15 read data.bin / write out.bin
rem there.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\vbnet
set OUT=%ROOT%\exec\vbnet\dotnet
set DOTNET=%ROOT%\tools\dotnet8\dotnet.exe
set DOTNET_CLI_TELEMETRY_OPTOUT=1
set DOTNET_NOLOGO=1
set DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T\%%T.vb" "%OUT%\%%T\%%T.vb" >nul || (echo vbnet-FAIL %%T & exit /b 1)
  copy /y "%SRC%\%%T\%%T.vbproj" "%OUT%\%%T\%%T.vbproj" >nul || (echo vbnet-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%DOTNET%" build -c Release "%%T.vbproj" > build.log 2>&1
  set RC=!errorlevel!
  popd
  if not "!RC!"=="0" (echo vbnet-FAIL %%T & exit /b 1)
  if not exist "%OUT%\%%T\bin\Release\net8.0\%%T.dll" (echo vbnet-FAIL %%T & exit /b 1)
  echo OK %%T
)
endlocal
