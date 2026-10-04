{ task 02 switch_case — expected output: 7500000075000000 }
{ build: fpc -O3 -oprogram 02_switch_case.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  i, acc: Int64;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  acc := 0;
  for i := 0 to 99999999 do
  begin
    case i mod 4 of
      0: Inc(acc);
      1: Inc(acc, i);
      2: Inc(acc, 2 * i);
      3: Inc(acc, 3 * i);
    end;
  end;
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(acc);
end.
