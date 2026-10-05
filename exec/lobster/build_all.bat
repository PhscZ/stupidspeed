@echo off
setlocal
rem No build step: lobster.exe compiles the script to bytecode and runs it in one go. This
rem stages the fifteen scripts and the 50 MiB fixture into exec\lobster\.
rem   tools\lobster\bin\lobster.exe <task>.lobster
rem The sources are sources/lobster/, run from the directory holding data.bin so tasks 14 and 15
rem resolve it. Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to
rem time.txt in the working directory, the same exception dyalog, ring and modula2 record.
rem Output: exec\lobster\<task>.lobster
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\lobster
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\lobster
set DATA=D:\Users\pedro.cardoso\stupidspeed\data.bin

echo ########## staging
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.lobster" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\11_parallel_sum.lobster" ( echo OK lobster staged ) else ( echo LOBSTER-FAIL staging )
echo ALLDONE
