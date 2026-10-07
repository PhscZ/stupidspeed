@echo off
set "PATH=C:\stupidspeed\tools\llvm-mingw\bin;%PATH%"
C:\stupidspeed\tools\scala-cli\scala-cli.exe --power package 01_branches.scala --native -S 3.9.0 --native-version 0.5.12 --native-mode release-fast --native-clang C:\stupidspeed\tools\llvm-mingw\bin\clang.exe --native-clangpp C:\stupidspeed\tools\llvm-mingw\bin\clang++.exe --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe
