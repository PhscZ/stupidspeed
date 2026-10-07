@echo off
setlocal enabledelayedexpansion
rem Build all 15 Objective-C tasks with MSYS2 UCRT64 clang 22 + the GNUstep runtime.
rem   clang -fobjc-runtime=gnustep-2.2 -O2 -o prog.exe <task>.m -lobjc -lgnustep-base
rem The runtime flag is required: without it the link fails on objc_autoreleasePoolPush
rem and __objc_load.
rem
rem Two toolchain quirks are handled here, both outside the sources:
rem  1. GNU ld (binutils 2.47) cannot link the tasks that define classes/properties or
rem     use typed selectors: it collapses the per-selector COMDAT sections
rem     (all named .objcrt$SEL$m) and leaves the .objc_selector_* definitions
rem     undefined. ld.lld, which ships with the same clang package, links them, so the
rem     linker is pinned with -fuse-ld=lld.
rem  2. gnustep-base-1.31.1-10 was built against GCC 16.1.0-3 (see its .BUILDINFO), but
rem     the tree ships libstdc++ from GCC 16.2.0-4, which changed five std::__format
rem     internal symbols. gnustep-base-1_31.dll then fails to load with
rem     STATUS_ENTRYPOINT_NOT_FOUND (0xC0000139) and prints nothing at all. The matching
rem     libstdc++-6.dll from gcc-libs-16.1.0-3 is vendored at the row root and copied
rem     next to every exe, where the loader looks first.
rem
rem ucrt64\bin is placed on PATH so the produced exe finds the rest of its runtime DLLs
rem (gnustep-base-1_31.dll, libobjc-4.6.dll, libwinpthread, gnutls, icu, ...).
rem Output: exec\objectivec\clang\<task>\prog.exe
set SRC=C:\stupidspeed\sources\objectivec
set EXEC=C:\stupidspeed\exec\objectivec
set UCRT=C:\stupidspeed\tools\msys64\msys64\ucrt64
set PATH=%UCRT%\bin;%PATH%
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do (
  mkdir "%EXEC%\clang\%%T" 2>nul
  cd /d "%EXEC%\clang\%%T"
  copy /y "%SRC%\%%T.m" . >nul
  copy /y "%EXEC%\libstdc++-6.dll" . >nul
  if "%%T"=="14_file_read"  copy /y "C:\stupidspeed\data.bin" . >nul
  if "%%T"=="15_file_write" copy /y "C:\stupidspeed\data.bin" . >nul
  del /q prog.exe 2>nul
  clang -fobjc-runtime=gnustep-2.2 -O2 -fuse-ld=lld -o prog.exe %%T.m -lobjc -lgnustep-base >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo objectivec-FAIL %%T )
)
echo ALLDONE
