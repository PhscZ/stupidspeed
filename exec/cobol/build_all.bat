@echo off
rem Build the cobol row with GnuCOBOL: one native executable per task.
rem   exec\cobol\<task>\prog.exe   artifact, run as `prog.exe` with cwd exec\cobol\<task>
rem `cobc -x -O2 -o prog <task>.cob` generates C and drives the C compiler. Outside an
rem MSYS2 shell cobc needs COB_CONFIG_DIR/COB_COPY_DIR, and the built exe needs
rem libcob-4.dll from the UCRT64 bin on PATH. Tasks 14 and 15 need the data.bin fixture.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set COB=%ROOT%\tools\msys64\msys64\ucrt64
set PATH=%COB%\bin;%PATH%
set COB_CONFIG_DIR=%COB%\share\gnucobol\config
set COB_COPY_DIR=%COB%\share\gnucobol\copy
set SRC=%ROOT%\sources\cobol
set OUT=%ROOT%\exec\cobol
set FAILED=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.cob" "%OUT%\%%T\%%T.cob" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  del /q prog.exe 2>nul
  cobc -x -O2 -o prog %%T.cob > build.log 2>&1
  if errorlevel 1 (
    echo cobol-FAIL %%T
    type build.log
    set FAILED=1
  ) else (
    echo OK %%T
  )
  popd
)
endlocal & if "%FAILED%"=="1" exit /b 1
exit /b 0
