{ task 07 string_append — expected output: 250000 }
{ build: fpc -O3 -oprogram 07_string_append.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  text: AnsiString;
  i: Integer;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  text := '';
  for i := 1 to 250000 do
    text := text + 'x';   { plain AnsiString concatenation, as the task asks }
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(Length(text));
end.
