@echo off
cd /d C:\stupidspeed\exec\gdscript
C:\stupidspeed\tools\godot\Godot_v4.7.2-stable_win64_console.exe --headless --script 01_branches.gd
echo RC=%ERRORLEVEL%
