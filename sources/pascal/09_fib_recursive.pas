{ task 09 fib_recursive — expected output: 102334155 }
{ build: fpc -O3 -oprogram 09_fib_recursive.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

function fib(n: Int64): Int64;
begin
  if n < 2 then
    Result := n
  else
    Result := fib(n - 1) + fib(n - 2);
end;

begin
  WriteLn(fib(40));
end.
