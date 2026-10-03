{ task 07 string_append — expected output: 250000 }
{ build: fpc -O3 -oprogram 07_string_append.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

var
  text: AnsiString;
  i: Integer;
begin
  text := '';
  for i := 1 to 250000 do
    text := text + 'x';   { plain AnsiString concatenation, as the task asks }
  WriteLn(Length(text));
end.
