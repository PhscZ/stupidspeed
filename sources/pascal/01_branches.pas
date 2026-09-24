{ task 01 branches — expected output: 33333334 13333333 7619048 45714285 }
{ build: fpc -O3 -oprogram 01_branches.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

var
  i, a, b, c, d: Int64;
begin
  a := 0;
  b := 0;
  c := 0;
  d := 0;
  for i := 0 to 99999999 do
  begin
    if i mod 3 = 0 then
      Inc(a)
    else if i mod 5 = 0 then
      Inc(b)
    else if i mod 7 = 0 then
      Inc(c)
    else
      Inc(d);
  end;
  WriteLn(a, ' ', b, ' ', c, ' ', d);
end.
