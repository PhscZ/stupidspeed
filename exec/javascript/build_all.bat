@echo off
rem Build the javascript row -- sources\javascript\ is one set of CommonJS files
rem shared by every toolchain, so "building" a task is staging it where the
rem registry says the artifact lives:
rem
rem   exec\javascript\bun\<task>\<task>.js       artifact, run as `bun <task>.js`
rem   exec\javascript\deno\<task>\<task>.js      artifact, run as
rem                                              `deno run --unstable-detect-cjs <task>.js`
rem
rem Both run the sources as they are.  Tasks 14 and 15 read and write the 50 MiB
rem fixture, so data.bin is copied into their run directories.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\javascript
set OUT=%ROOT%\exec\javascript
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAILED=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\bun\%%T" mkdir "%OUT%\bun\%%T"
  if not exist "%OUT%\deno\%%T" mkdir "%OUT%\deno\%%T"
  copy /y "%SRC%\%%T.js" "%OUT%\bun\%%T\%%T.js" >nul 2>"%OUT%\bun\%%T\build.log"
  if errorlevel 1 (echo javascript-FAIL bun %%T & set FAILED=1) else (echo OK bun %%T)
  copy /y "%SRC%\%%T.js" "%OUT%\deno\%%T\%%T.js" >nul 2>"%OUT%\deno\%%T\build.log"
  if errorlevel 1 (echo javascript-FAIL deno %%T & set FAILED=1) else (echo OK deno %%T)
  if "%%T"=="14_file_read" (
    copy /y "%ROOT%\data.bin" "%OUT%\bun\%%T\data.bin" >nul
    copy /y "%ROOT%\data.bin" "%OUT%\deno\%%T\data.bin" >nul
  )
  if "%%T"=="15_file_write" (
    copy /y "%ROOT%\data.bin" "%OUT%\bun\%%T\data.bin" >nul
    copy /y "%ROOT%\data.bin" "%OUT%\deno\%%T\data.bin" >nul
  )
)

if not "%FAILED%"=="0" (echo javascript-FAIL build & exit /b 1)
endlocal & exit /b 0
