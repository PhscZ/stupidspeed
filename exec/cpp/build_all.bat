@echo off
rem Build the cpp row: the same fifteen C++ sources through four compilers.
rem   exec\cpp\gpp\<task>\prog.exe       g++  -O2 -pthread -static
rem   exec\cpp\clangpp\<task>\prog.exe   clang++ -O2 -pthread, MinGW sysroot, -static
rem   exec\cpp\msvc\<task>\prog.exe      cl   /O2 /EHsc
rem   exec\cpp\zigcpp\<task>\prog.exe    zig c++ -O2
rem Every task needs its source staged beside the program; tasks 14 and 15 also
rem need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\cpp
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set LLVM=%ROOT%\tools\llvm\bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%C in (gpp clangpp msvc zigcpp) do (
  for %%T in (%TASKS%) do (
    if not exist "%ROOT%\exec\cpp\%%C\%%T" mkdir "%ROOT%\exec\cpp\%%C\%%T"
    copy /y "%SRC%\%%T.cpp" "%ROOT%\exec\cpp\%%C\%%T\%%T.cpp" >nul
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\cpp\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\cpp\%%C\%%T\data.bin" >nul
  )
)

rem ---- g++: the MSYS2 UCRT64 tree supplies the compiler and its C++ runtime; -static
rem keeps prog.exe free of the tree's libstdc++/libgcc DLLs at run time.
set "PATH=%UCRT%\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\cpp\gpp\%%T"
  g++ -O2 -pthread -static -o prog.exe %%T.cpp >build.log 2>&1
  if errorlevel 1 (echo cpp-FAIL gpp %%T & set FAIL=1) else (echo OK %%T gpp)
  popd
)

rem ---- clang++: the LLVM Windows tarball ships no C++ headers, so it is pointed at
rem the MSYS2 UCRT64 sysroot and linked statically, or prog.exe needs that tree at run time.
set "PATH=%UCRT%\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\cpp\clangpp\%%T"
  "%LLVM%\clang++.exe" --target=x86_64-w64-windows-gnu -O2 -pthread -static -o prog.exe %%T.cpp >build.log 2>&1
  if errorlevel 1 (echo cpp-FAIL clangpp %%T & set FAIL=1) else (echo OK %%T clangpp)
  popd
)

rem ---- msvc: cl needs the PATH/INCLUDE/LIB that tools\msvc_env.py prints.
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\cpp\msvc\%%T"
  call "%TEMP%\stupidspeed_msvc_env.bat" >nul
  cl /nologo /O2 /EHsc /Fe:prog.exe %%T.cpp >build.log 2>&1
  if errorlevel 1 (echo cpp-FAIL msvc %%T & set FAIL=1) else (echo OK %%T msvc)
  popd
)

rem ---- zig c++: clang++'s front end on Zig's toolchain and libc++.
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\cpp\zigcpp\%%T"
  "%ROOT%\tools\zig\zig.exe" c++ -O2 -o prog.exe %%T.cpp >build.log 2>&1
  if errorlevel 1 (echo cpp-FAIL zigcpp %%T & set FAIL=1) else (echo OK %%T zigcpp)
  popd
)

if "%FAIL%"=="1" (echo cpp-FAIL some task & exit /b 1)
echo cpp OK
endlocal
