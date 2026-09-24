{ task 02 switch_case — expected output: 7500000075000000 }
{ build: fpc -O3 -oprogram 02_switch_case.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

var
  i, acc: Int64;
begin
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
  WriteLn(acc);
end.
