@echo off
cd /d C:\stupidspeed\exec\erlang
C:\stupidspeed\tools\erlang\bin\escript.exe 01_branches.erl
echo RC=%ERRORLEVEL%
