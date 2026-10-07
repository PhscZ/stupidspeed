@echo off
setlocal enabledelayedexpansion
rem Build all 15 Ruby tasks for both toolchains of this row.
rem   cruby-yjit  "C:\stupidspeed\tools\ruby\bin\ruby.exe" --yjit <task>.rb
rem   jruby       "C:\stupidspeed\tools\jruby\bin\jruby.bat" <task>.rb   (needs Java 25:
rem               JAVA_HOME points at tools\graalvm, the only JDK 25 on the box; the
rem               Oracle javapath JRE is 24 and java8path is 8, both too old)
rem No build step for either: the "build" is a syntax check (-c) whose log lands in
rem build.log, exactly as the perl/lua interpreted rows do.
rem NOTE cruby-yjit: the stock Windows CRuby has no YJIT, and none can be had -- upstream
rem   supports YJIT only on macOS/Linux/BSD (doc/jit/yjit.md, configure.ac's JIT_TARGET_OK).
rem   RubyInstaller 4.0.7 and 3.4.11 x64 both answer "Ruby was built without YJIT support"
rem   to --yjit, and building ruby 4.0.7 from source with --enable-yjit dies in the Rust
rem   crate: 34 errors (std::os::unix::io missing, File::from_raw_fd/into_raw_fd, and 24
rem   c_long-as-i32 vs i64 mismatches).  `--yjit` therefore only warns and the interpreter
rem   runs plain; verify.py prints "YJIT enabled? NO_YJIT" to say so out loud.
rem Output: exec\ruby\<toolchain>\<task>\<task>.rb
set "ROOT=%~dp0..\.."
set "SRC=%ROOT%\sources\ruby"
set "CRUBY=%ROOT%\tools\ruby\bin\ruby.exe"
set "JRUBY=%ROOT%\tools\jruby\bin\jruby.bat"
set "JAVA_HOME=%ROOT%\tools\graalvm"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

echo ########## cruby-yjit
for %%T in (%TASKS%) do (
  mkdir "%~dp0cruby-yjit\%%T" 2>nul
  cd /d "%~dp0cruby-yjit\%%T"
  copy /y "%SRC%\%%T.rb" . >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" . >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" . >nul
  "%CRUBY%" --yjit -c "%%T.rb" > build.log 2>&1
  if errorlevel 1 (echo RUBY-FAIL cruby-yjit %%T) else (echo OK cruby-yjit %%T)
)

echo ########## jruby
for %%T in (%TASKS%) do (
  mkdir "%~dp0jruby\%%T" 2>nul
  cd /d "%~dp0jruby\%%T"
  copy /y "%SRC%\%%T.rb" . >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" . >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" . >nul
  call "%JRUBY%" -c "%%T.rb" > build.log 2>&1
  if errorlevel 1 (echo RUBY-FAIL jruby %%T) else (echo OK jruby %%T)
)
echo ALLDONE
