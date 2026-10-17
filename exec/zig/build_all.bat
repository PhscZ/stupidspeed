@echo off
rem Build the zig row: the same fifteen Zig sources through two code generators.
rem   exec\zig\zig\<task>\prog.exe         zig build-exe -O ReleaseFast (LLVM)
rem   exec\zig\selfhosted\<task>\prog.exe  zig build-exe -O ReleaseFast -fno-llvm
rem -mcpu=x86_64_v2 is pinned on both: Zig's default target CPU is the build
rem host's, so the binaries would otherwise carry this machine's AVX2 and die
rem with 0xC000001D on an older x86-64.
rem Tasks 14 and 15 need the data.bin fixture in the directory the program runs
rem in; task 15 leaves out.bin there.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\zig
set ZIG=%ROOT%\tools\zig\zig.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%C in (zig selfhosted) do (
  for %%T in (%TASKS%) do (
    if not exist "%ROOT%\exec\zig\%%C\%%T" mkdir "%ROOT%\exec\zig\%%C\%%T"
    copy /y "%SRC%\%%T.zig" "%ROOT%\exec\zig\%%C\%%T\%%T.zig" >nul
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\zig\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\zig\%%C\%%T\data.bin" >nul
  )
)

rem ---- zig: the LLVM back end.  -femit-bin names the file the registry wants.
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\zig\zig\%%T"
  "%ZIG%" build-exe -O ReleaseFast -mcpu=x86_64_v2 -femit-bin=prog.exe %%T.zig >build.log 2>&1
  if errorlevel 1 (echo zig-FAIL zig %%T & set FAIL=1) else (echo OK %%T zig)
  popd
)

rem ---- zig (self-hosted x86-64): -fno-llvm removes LLVM from the pipeline
rem entirely and uses Zig's own x86-64 code generator.  It emits compiler_rt.dll
rem beside the program, which has to stay there for the program to start.
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\zig\selfhosted\%%T"
  "%ZIG%" build-exe -O ReleaseFast -fno-llvm -mcpu=x86_64_v2 -femit-bin=prog.exe %%T.zig >build.log 2>&1
  if errorlevel 1 (echo zig-FAIL selfhosted %%T & set FAIL=1) else (echo OK %%T selfhosted)
  popd
)

if "%FAIL%"=="1" (echo zig-FAIL some task & exit /b 1)
echo zig OK
endlocal
