{ task 12 matrix_add — expected output: 999000000 }
{ build: fpc -O3 -oprogram 12_matrix_add.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Windows;

const
  N = 1000;

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  a, b, c: array of Int64;
  i, j: Integer;
  total: Int64;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
  SetLength(a, N * N);
  SetLength(b, N * N);
  SetLength(c, N * N);

  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      a[i * N + j] := i + j;
      b[i * N + j] := i - j;
    end;

  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
      c[i * N + j] := a[i * N + j] + b[i * N + j];

  total := 0;
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
      total := total + c[i * N + j];
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(total);
end.
