@echo off
setlocal
rem Build all 15 Modula-3 tasks with Critical Mass Modula-3 (cm3) 5.10.0.
rem   cm3 -build -O      in a directory holding Main.m3 and an m3makefile
rem   run: AMD64_NT\prog.exe
rem Each source directory holds its own Main.m3 and m3makefile, so each task builds in its own
rem output directory. -O is the optimiser; cm3 has no -O level, its knob is the build mode.
rem cm3's C backend needs the MSVC environment (INCLUDE/LIB/PATH) from tools\msvc_env.py.
rem Two runtime DLLs must sit beside the produced exe or it dies with rc 53 before main:
rem m3.dll and m3core.dll from the cm3 tree's bin. Task 10 additionally imports the arithmetic
rem library for BigInteger, so its exe also needs arithmetic.dll.
rem Output: exec\modula3\<task>\AMD64_NT\prog.exe
set CM3=C:\stupidspeed\tools\cm3\cm3-all-AMD64_NT-d5.10.0-VC2019-20210221
set SRC=C:\stupidspeed\sources\modula3
set EXEC=C:\stupidspeed\exec\modula3
rem `call` is required: the `for` body is expanded once, so a literal `%PATH%` coming out of
rem msvc_env.py would never be substituted without the second expansion `call` performs.
for /f "usebackq delims=" %%L in (`python C:\stupidspeed\tools\msvc_env.py`) do call %%L
set PATH=%CM3%\bin;%PATH%
set INSTALL_ROOT=%CM3%

echo ########## cm3
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
xcopy /y /e /i /q "%SRC%\%1" "%EXEC%\%1" >nul
cm3.exe -build -O >build.log 2>&1
if exist AMD64_NT\prog.exe (
  copy /y "%CM3%\bin\m3.dll" AMD64_NT\ >nul
  copy /y "%CM3%\bin\m3core.dll" AMD64_NT\ >nul
  copy /y "%CM3%\bin\arithmetic.dll" AMD64_NT\ >nul
  echo OK cm3 %1
) else ( echo MODULA3-FAIL %1 )
exit /b 0
