{ task 05 alloc_churn — expected output: 1274991808 }
{ build: fpc -O3 -oprogram 05_alloc_churn.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  slots: array[0..255] of PByte;
  i, slot: Int64;
  total: Int64;
  buf, old: PByte;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  for i := 0 to 255 do
    slots[i] := nil;
  total := 0;
  for i := 0 to 9999999 do
  begin
    GetMem(buf, 64);
    buf^ := Byte(i mod 256);
    total := total + buf^;
    slot := i mod 256;
    old := slots[slot];
    slots[slot] := buf;   { keeps buf reachable, and releases the buffer it replaces }
    if old <> nil then
      FreeMem(old);
  end;
  for i := 0 to 255 do
    if slots[i] <> nil then
      FreeMem(slots[i]);
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(total);
end.
