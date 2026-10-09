@echo off
setlocal enabledelayedexpansion
rem Build all 15 Rust tasks with two toolchains (see BUILD.md's rust row).
rem   rustc            stable-x86_64-pc-windows-gnu: rustc -O -o prog.exe <task>.rs
rem   rustc(cranelift) nightly-x86_64-pc-windows-msvc with the Cranelift codegen backend:
rem                    rustc +nightly -Zcodegen-backend=cranelift -O -o prog.exe <task>.rs
rem                    The nightly host is msvc, so link.exe and the UCRT headers/libs come
rem                    from tools\msvc_env.py (none of it is on PATH here).
rem Output: exec\rust\rustc\<task>\prog.exe and exec\rust\cranelift\<task>\prog.exe
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\rust
set EXEC=%ROOT%\exec\rust
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## rustc (gnu)
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\rustc\%%T" 2>nul
  cd /d "%EXEC%\rustc\%%T"
  copy /y "%SRC%\%%T.rs" . >nul
  rustc -O -o prog.exe %%T.rs >build.log 2>&1
  if exist prog.exe ( echo OK rustc %%T ) else ( echo RUST-FAIL rustc %%T )
)

rem one MSVC environment for the cranelift builds
for /f "usebackq delims=" %%L in (`python "%ROOT%\tools\msvc_env.py"`) do %%L

echo ########## rustc (cranelift)
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\cranelift\%%T" 2>nul
  cd /d "%EXEC%\cranelift\%%T"
  copy /y "%SRC%\%%T.rs" . >nul
  rustc +nightly -Zcodegen-backend=cranelift -O -o prog.exe %%T.rs >build.log 2>&1
  if exist prog.exe ( echo OK cranelift %%T ) else ( echo RUST-FAIL cranelift %%T )
)
echo ALLDONE
