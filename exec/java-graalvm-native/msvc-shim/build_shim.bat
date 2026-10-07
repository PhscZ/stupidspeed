@echo off
rem Compile the vswhere.exe stand-in with the hand-extracted MSVC tree.
setlocal
for /f "usebackq delims=" %%L in (`python C:\stupidspeed\tools\msvc_env.py`) do %%L
cd /d "%~dp0"
if not exist "Microsoft Visual Studio\Installer" mkdir "Microsoft Visual Studio\Installer"
cl /nologo /O2 /Fe:"Microsoft Visual Studio\Installer\vswhere.exe" vswhere.c >shim_build.log 2>&1
if exist "Microsoft Visual Studio\Installer\vswhere.exe" (echo SHIM OK) else (echo SHIM FAIL & type shim_build.log)
exit /b 0
