@echo off
setlocal
rem No build step: PUC Lua compiles the chunk to its own bytecode and runs it on a register VM.
rem This stages the fifteen scripts and the 50 MiB fixture into exec\lua\.
rem   tools\lua\lua54.exe <task>.lua
rem The sources are sources/lua/, run from the directory holding data.bin so tasks 14 and 15
rem resolve it. Task 11 needs the Lanes C extension (a pthreads binding, installed once into
rem tools\lua-rocks with `luarocks --tree tools\lua-rocks install lanes`), which the interpreter
rem finds through LUA_PATH/LUA_CPATH — set here so every cell runs with them, as verify.py does.
rem Output: exec\lua\<task>.lua
rem Paths are derived from this script's own location, so the row works from any checkout.
for %%I in ("%~dp0..\..") do set "ROOT=%%~fI"
set SRC=%ROOT%\sources\lua
set EXEC=%~dp0
set DATA=%ROOT%\data.bin

echo ########## staging
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.lua" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\11_parallel_sum.lua" ( echo OK lua staged ) else ( echo LUA-FAIL staging )
echo ALLDONE
