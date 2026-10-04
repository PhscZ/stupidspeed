{ task 09 fib_recursive — expected output: 102334155 }
{ build: fpc -O3 -oprogram 09_fib_recursive.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

function fib(n: Int64): Int64;
begin
  if n < 2 then
    Result := n
  else
    Result := fib(n - 1) + fib(n - 2);
end;

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(fib(40));
end.
