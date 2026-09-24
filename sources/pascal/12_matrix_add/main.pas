{ task 12 matrix_add — expected output: 999000000 }
{ build: fpc -O3 -oprogram main.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  N = 1000;

var
  a, b, c: array of Int64;
  i, j: Integer;
  total: Int64;
begin
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
  WriteLn(total);
end.
