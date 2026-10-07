@echo off
set PATH=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin;%PATH%
cd /d C:\stupidspeed\exec\fortran\flang\11_parallel_sum
C:\stupidspeed\tools\msys64\msys64\ucrt64\bin\flang.exe -O3 -fopenmp -o prog.exe 11_parallel_sum.f90
echo RC=%ERRORLEVEL%
