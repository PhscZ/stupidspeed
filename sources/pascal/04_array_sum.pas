{ task 04 array_sum — expected output: 599999940000000 }
{ build: fpc -O3 -oprogram 04_array_sum.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  arr: array of Int64;
  i: Integer;
  r: Integer;
  total: Int64;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  SetLength(arr, 10000000);
  for i := 0 to 9999999 do
    arr[i] := i;
  total := 0;
  for r := 1 to 12 do
    for i := 0 to 9999999 do
      total := total + arr[i];
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(total);
end.
