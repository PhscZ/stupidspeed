@echo off
rem Run all fifteen OCaml tasks of both toolchains the way exec\ocaml\verify.py does:
rem from each task's own directory, with the UCRT64 bin directory on PATH (the bytecode
rem launcher needs ocamlrun.exe and dllunixbyt.dll) and OCAMLLIB set.
setlocal
set ROOT=%~dp0..\..
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set "PATH=%UCRT%\bin;%PATH%"
set "OCAMLLIB=%UCRT%\lib\ocaml"
for %%C in (ocamlopt ocamlc) do (
  for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
    echo === %%C %%T
    pushd "%ROOT%\exec\ocaml\%%C\%%T"
    prog.exe
    popd
  )
)
endlocal
