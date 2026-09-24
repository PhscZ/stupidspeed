{ task 08 average — expected output: 0.498046875 }
{ build: fpc -O3 -oprogram 08_average.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

var
  i: Int64;
  total, reading: Double;
begin
  { every reading is a multiple of 1/256 and the sum stays under 2^53, so the total is
    exact; pin the decimal separator to '.' so a locale cannot turn it into a comma }
  DefaultFormatSettings.DecimalSeparator := '.';
  total := 0.0;
  for i := 0 to 99999999 do
  begin
    reading := (i mod 256) / 256.0;
    total := total + reading;
  end;
  WriteLn(FormatFloat('0.000000000', total / 100000000));
end.
