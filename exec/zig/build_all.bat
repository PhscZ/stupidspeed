@echo off
setlocal
rem Build all 15 Zig tasks twice on the same sources: once through Zig's own
rem front end and LLVM, once with `-fno-llvm`, which uses Zig's self-hosted x86-64
rem code generator instead.  The pair is what makes a code-generator comparison
rem possible on identical input; see BUILD.md.
rem
rem   zig            exec\zig\zig\<task>\prog.exe         (LLVM backend)
rem   zig self-hosta exec\zig\selfhosted\<task>\prog.exe  (-fno-llvm)
rem
rem -mcpu is pinned deliberately.  Without it Zig targets the *build* machine's
rem CPU model, so a binary built on an AVX2 host carries AVX2 instructions and
rem dies with exit code 0xC000001D (illegal instruction) on any x86-64 CPU
rem without them -- which is exactly what the committed binaries did before
rem 2026-10-09.  x86_64_v2 (SSE4.2 + POPCNT) is the floor.
set ROOT=C:\stupidspeed
set SRC=%ROOT%\sources\zig
set ZIG=%ROOT%\tools\zig\zig.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  call :build %%T zig "%ROOT%\exec\zig\zig" ""
  call :build %%T selfhosted "%ROOT%\exec\zig\selfhosted" "-fno-llvm"
)
exit /b 0

:build
set T=%1
set TC=%2
set OUT=%3
set EXTRA=%4
if not exist "%OUT%\%T%" mkdir "%OUT%\%T%"
copy /y "%SRC%\%T%.zig" "%OUT%\%T%\" >nul
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%T%\" >nul
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%T%\" >nul
del /q "%OUT%\%T%\out.bin" 2>nul
pushd "%OUT%\%T%"
"%ZIG%" build-exe -O ReleaseFast -mcpu=x86_64_v2 %EXTRA% %T%.zig -femit-bin=prog.exe > build.log 2>&1
if errorlevel 1 (echo zig-FAIL %TC% %T%) else (echo OK %TC% %T%)
popd
exit /b 0
