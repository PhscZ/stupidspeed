{ task 13 matrix_mul — expected output: 599995000 }
{ build: fpc -O3 -oprogram 13_matrix_mul.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  N = 500;

var
  a, b, c: array of Int64;
  i, j, k: Integer;
  sum, total: Int64;
begin
  SetLength(a, N * N);
  SetLength(b, N * N);
  SetLength(c, N * N);

  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      a[i * N + j] := (i + j) mod 7;
      b[i * N + j] := (i * j) mod 5;
    end;

  { the plain i, j, k triple loop, in that order }
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      sum := 0;
      for k := 0 to N - 1 do
        sum := sum + a[i * N + k] * b[k * N + j];
      c[i * N + j] := sum;
    end;

  total := 0;
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
      total := total + c[i * N + j];
  WriteLn(total);
end.
