@echo off
rem Build the beef row: BeefBuild compiles projects, not files, so each task is a
rem directory holding <task>.bf plus its two-file wrapper (BeefProj.toml,
rem BeefSpace.toml), and the project is pointed at that directory.
rem   exec\beef\<task>\out\prog.exe     artifact, run from exec\beef\<task>
rem `-config=Release` is mandatory: Beef's Windows Debug toolset is Microsoft's and
rem stops without Visual Studio, while Release links with the bundled lld-link.exe.
rem Two things outside the distribution's own tree are needed and are repaired here
rem only if they are missing (they are present in this repository):
rem   * bin\BeefConfig.toml -- without it BeefBuild stops with
rem     "ERROR: Unable to load project 'corlib'"; its UnversionedLibDirs is resolved
rem     against the config file's own directory, so it is copied from __user\bin\.
rem   * bin\lib\x64\shell32.lib -- bin\lib\x64 ships eleven import libraries and the
rem     Release link line asks for shell32.lib anyway, so the link stops with
rem     "lld-link: error: could not open 'shell32.lib'"; any Windows SDK copy works.
rem corlib is recompiled once per project on every build, so a task takes 1-2 minutes.
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
pushd "%ROOT%"
set "ROOT=%CD%"
popd
set SRC=%ROOT%\sources\beef
set OUT=%ROOT%\exec\beef
set BEEF=%ROOT%\tools\beef
set BEEFBUILD=%BEEF%\bin\BeefBuild.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

if not exist "%BEEFBUILD%" (echo beef-FAIL: no compiler at %BEEFBUILD% & exit /b 1)

if not exist "%BEEF%\bin\BeefConfig.toml" (
  if not exist "%BEEF%\__user\bin\BeefConfig.toml" (echo beef-FAIL: no BeefConfig.toml to copy & exit /b 1)
  copy /y "%BEEF%\__user\bin\BeefConfig.toml" "%BEEF%\bin\BeefConfig.toml" >nul
)
if not exist "%BEEF%\bin\lib\x64\shell32.lib" (
  copy /y "%ROOT%\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64\shell32.lib" "%BEEF%\bin\lib\x64\shell32.lib" >nul
)

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T\%%T.bf" "%OUT%\%%T\%%T.bf" >nul || (echo beef-FAIL %%T & set FAIL=1)
  copy /y "%SRC%\%%T\BeefProj.toml" "%OUT%\%%T\BeefProj.toml" >nul || (echo beef-FAIL %%T & set FAIL=1)
  copy /y "%SRC%\%%T\BeefSpace.toml" "%OUT%\%%T\BeefSpace.toml" >nul || (echo beef-FAIL %%T & set FAIL=1)
  if "%%T"=="03_func_sum" copy /y "%SRC%\03_func_sum\03_func_sum_add_one.bf" "%OUT%\%%T\03_func_sum_add_one.bf" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%OUT%\%%T"
  "%BEEFBUILD%" -proddir=%OUT%\%%T -config=Release -platform=Win64 >build.log 2>&1
  if errorlevel 1 (echo beef-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

endlocal & exit /b %FAIL%
