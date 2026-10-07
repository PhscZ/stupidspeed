@echo off
set PATH=C:\stupidspeed\tools\erlang\bin;C:\stupidspeed\tools\gleam;%PATH%
cd /d C:\stupidspeed\exec\gleam
gleam build
echo BUILD=%ERRORLEVEL%
gleam run --module t01_branches
echo RC=%ERRORLEVEL%
