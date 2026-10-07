{ task 03 func_sum — expected output: 100000000 }
{ build: fpc -O3 -oprogram 03_func_sum.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

{ fpc only inlines a routine that carries the "inline" modifier, and only while the
  $INLINE switch is on; both are off here, so the hundred million calls really happen. }
{$INLINE OFF}

function add_one(n: Int64): Int64;
{$INLINE OFF}
begin
  Result := n + 1;
end;

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  i, value: Int64;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  value := 0;
  for i := 1 to 100000000 do
    value := add_one(value);
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(value);
end.
