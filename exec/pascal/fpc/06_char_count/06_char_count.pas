{ task 06 char_count — expected output: 10000000 }
{ build: fpc -O3 -oprogram 06_char_count.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

const
  Pattern: array[0..9] of AnsiChar = 'abcdefghij';

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  text: AnsiString;
  i, count: Int64;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  { one hundred million characters, built in one go: the ten character block is
    moved into every tenth slot, so the build is not part of the measurement }
  SetLength(text, 100000000);
  for i := 0 to 9999999 do
    Move(Pattern[0], text[i * 10 + 1], 10);

  count := 0;
  for i := 1 to 100000000 do
    if text[i] = 'h' then
      Inc(count);
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(count);
end.
