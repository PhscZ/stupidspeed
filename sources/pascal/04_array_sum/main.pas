{ task 04 array_sum — expected output: 499999500000 }
{ build: fpc -O3 -oprogram main.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

var
  arr: array of Int64;
  i: Integer;
  total: Int64;
begin
  SetLength(arr, 1000000);
  for i := 0 to 999999 do
    arr[i] := i;
  total := 0;
  for i := 0 to 999999 do
    total := total + arr[i];
  WriteLn(total);
end.
