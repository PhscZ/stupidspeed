@echo off
setlocal enabledelayedexpansion
rem Build all 15 Odin (dev-2026-09-nightly) tasks.
rem   odin build <task>.odin -o:speed -out:prog     (run: ./prog)
rem This nightly needs two additions to that line, both build-script concerns and not
rem source changes: a single source file must be named as a self-contained package with
rem `-file` (without it: "takes a package/directory as its first argument"), and the output
rem path must carry an extension ("Output path ... must have an appropriate extension"), so
rem `-out:prog` becomes `-out:prog.exe`. The produced executable is prog.exe either way.
rem Odin on Windows does not discover the MSVC SDK on its own and needs WindowsSdkDir,
rem WindowsSDKVersion and VCToolsInstallDir in the environment (plus the MSVC PATH/INCLUDE/
rem LIB from tools\msvc_env.py), or it fails with "Windows SDK not found".
set ODIN=C:\stupidspeed\tools\odin\dist\odin.exe
set SRC=C:\stupidspeed\sources\odin
set EXEC=C:\stupidspeed\exec\odin\odin
set DATA=C:\stupidspeed\data.bin

python C:\stupidspeed\tools\msvc_env.py > "%EXEC%\msvc_env.bat"
call "%EXEC%\msvc_env.bat"
set "WindowsSdkDir=C:\stupidspeed\tools\msvc\Windows Kits\10"
set "WindowsSDKVersion=10.0.26100.0"
set "VCToolsInstallDir=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207"

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.odin" . >nul
  if "%%T"=="14_file_read" copy /y "%DATA%" data.bin >nul
  if "%%T"=="15_file_write" copy /y "%DATA%" data.bin >nul
  if exist prog.exe del prog.exe
  "%ODIN%" build %%T.odin -file -o:speed -out:prog.exe >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo ODIN-FAIL %%T )
)
echo ALLDONE
