@echo off
rem Build the odin row: one Odin compiler, fifteen single-file programs.
rem   exec\odin\odin\<task>\prog.exe    artifact, run from that directory
rem Two things the compiler needs beyond the bare command:
rem   * `-file`, or it stops with "takes a package/directory as its first argument",
rem     and an explicit `.exe` on `-out`, or "Output path ... must have an appropriate
rem     extension";
rem   * the MSVC environment (it links through MSVC's linker) plus WindowsSdkDir,
rem     WindowsSDKVersion and VCToolsInstallDir -- Odin does not discover the SDK on
rem     its own and stops with "Windows SDK not found" without them. The three values
rem     mirror tools\msvc_env.py's VCVER/SDKVER/KITS.
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
pushd "%ROOT%"
set "ROOT=%CD%"
popd
set SRC=%ROOT%\sources\odin
set OUT=%ROOT%\exec\odin\odin
set ODIN=%ROOT%\tools\odin\dist\odin.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

if not exist "%ODIN%" (echo odin-FAIL: no compiler at %ODIN% & exit /b 1)

rem cl.exe / link.exe on PATH and INCLUDE/LIB, written to a file and `call`ed: a
rem `for /f` loop over the same output mangles %PATH%.
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_odin_msvc_env.bat" || (echo odin-FAIL: msvc_env.py & exit /b 1)
call "%TEMP%\stupidspeed_odin_msvc_env.bat"
set "WindowsSdkDir=%ROOT%\tools\msvc\Windows Kits\10\"
set "WindowsSDKVersion=10.0.26100.0\"
set "VCToolsInstallDir=%ROOT%\tools\msvc\VC\Tools\MSVC\14.44.35207\"
if not exist "%WindowsSdkDir%Lib\%WindowsSDKVersion%um\x64" (echo odin-FAIL: Windows SDK libraries not found under "%WindowsSdkDir%" & exit /b 1)

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.odin" "%OUT%\%%T\%%T.odin" >nul || (echo odin-FAIL %%T & set FAIL=1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%OUT%\%%T"
  "%ODIN%" build %%T.odin -file -o:speed -out:prog.exe >build.log 2>&1
  if errorlevel 1 (echo odin-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

endlocal & exit /b %FAIL%
