@echo off
rem Build the c row: the same fifteen C sources through six compilers.
rem   exec\c\gcc\<task>\prog.exe       gcc  -O2 -pthread
rem   exec\c\clang\<task>\prog.exe     clang -O2 -pthread, MinGW sysroot, -static
rem   exec\c\tcc\<task>\prog.exe       tcc  (C99 only)
rem   exec\c\msvc\<task>\prog.exe      cl   /O2
rem   exec\c\zig-cc\<task>\prog.exe    zig cc -O2 -pthread -mcpu=x86_64_v2
rem   exec\c\compcert\<task>\prog.exe  ccomp -O2 (Cygwin preprocessor/assembler/linker)
rem Every task needs its source staged beside the program; tasks 14 and 15 also
rem need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\c
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set LLVM=%ROOT%\tools\llvm\bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%C in (gcc clang tcc msvc zig-cc compcert) do (
  for %%T in (%TASKS%) do (
    if not exist "%ROOT%\exec\c\%%C\%%T" mkdir "%ROOT%\exec\c\%%C\%%T"
    copy /y "%SRC%\%%T.c" "%ROOT%\exec\c\%%C\%%T\%%T.c" >nul
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\c\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\c\%%C\%%T\data.bin" >nul
  )
)

rem ---- gcc: the MSYS2 UCRT64 tree supplies both the compiler and its runtime DLLs.
set "PATH=%UCRT%\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\c\gcc\%%T"
  gcc -O2 -pthread -o prog.exe %%T.c >build.log 2>&1
  if errorlevel 1 (echo c-FAIL gcc %%T & set FAIL=1) else (echo OK %%T gcc)
  popd
)

rem ---- clang: the LLVM Windows tarball ships no C headers, so it is pointed at the
rem MSYS2 UCRT64 sysroot and linked statically, or prog.exe needs that tree at run time.
set "PATH=%UCRT%\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\c\clang\%%T"
  "%LLVM%\clang.exe" --target=x86_64-w64-windows-gnu -O2 -pthread -static -o prog.exe %%T.c >build.log 2>&1
  if errorlevel 1 (echo c-FAIL clang %%T & set FAIL=1) else (echo OK %%T clang)
  popd
)

rem ---- tcc
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\c\tcc\%%T"
  "%ROOT%\tools\tcc\tcc.exe" -o prog.exe %%T.c >build.log 2>&1
  if errorlevel 1 (echo c-FAIL tcc %%T & set FAIL=1) else (echo OK %%T tcc)
  popd
)

rem ---- msvc: cl needs the PATH/INCLUDE/LIB that tools\msvc_env.py prints.
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\c\msvc\%%T"
  call "%TEMP%\stupidspeed_msvc_env.bat" >nul
  cl /nologo /O2 /Fe:prog.exe %%T.c >build.log 2>&1
  if errorlevel 1 (echo c-FAIL msvc %%T & set FAIL=1) else (echo OK %%T msvc)
  popd
)

rem ---- zig cc: clang's front end on Zig's toolchain and libc. -mcpu is pinned so the
rem binary does not carry the build host's AVX2 instructions (see BUILD.md).
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\c\zig-cc\%%T"
  "%ROOT%\tools\zig\zig.exe" cc -O2 -pthread -mcpu=x86_64_v2 -o prog.exe %%T.c >build.log 2>&1
  if errorlevel 1 (echo c-FAIL zig-cc %%T & set FAIL=1) else (echo OK %%T zig-cc)
  popd
)

rem ---- compcert: Cygwin's preprocessor, assembler and linker do the work, so
rem tools\cygwin\bin has to be on PATH for the build *and* for the run.
set "PATH=%ROOT%\tools\cygwin\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\c\compcert\%%T"
  "%ROOT%\tools\compcert\bin\ccomp.exe" -O2 -o prog.exe %%T.c >build.log 2>&1
  if errorlevel 1 (echo c-FAIL compcert %%T & set FAIL=1) else (echo OK %%T compcert)
  popd
)

if "%FAIL%"=="1" (echo c-FAIL some task & exit /b 1)
echo c OK
endlocal
