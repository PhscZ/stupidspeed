@echo off
setlocal
rem No build step: Luau compiles the chunk to bytecode and runs it on its VM. This stages the
rem fifteen scripts and the 50 MiB fixture into exec\luau\.
rem   tasks 01-13   tools\luau\luau.exe <task>.luau
rem   task 11       tools\lute\lute.exe run 11_parallel_sum.luau
rem   tasks 14, 15  tools\lute\lute.exe run <task>.luau
rem The sources are sources/luau/. The plain Luau CLI has no file I/O and no process API at all
rem — its `os` is {clock, date, difftime, time}, with no io, no os.execute and no package — so
rem data.bin, out.bin and task 11's four child processes are unreachable under luau.exe. Those
rem three tasks need Lute, the Luau team's own runtime, which supplies @lute/fs and
rem @lute/process.run. Luau exposes no stderr, so TIME_MS is the contract's time.txt fallback,
rem written through Lute's @lute/fs: under `lute run` it lands, under luau.exe the guarded
rem require fails and the run is otherwise unchanged.
rem Output: exec\luau\<task>.luau
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\luau
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\luau
set DATA=D:\Users\pedro.cardoso\stupidspeed\data.bin

echo ########## staging
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.luau" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\11_parallel_sum.luau" ( echo OK luau staged ) else ( echo LUAU-FAIL staging )
echo ALLDONE
