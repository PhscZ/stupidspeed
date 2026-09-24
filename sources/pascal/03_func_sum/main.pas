{ task 03 func_sum — expected output: 100000000 }
{ build: fpc -O3 -oprogram main.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

{ fpc only inlines a routine that carries the "inline" modifier, and only while the
  $INLINE switch is on; both are off here, so the hundred million calls really happen. }
{$INLINE OFF}

function add_one(n: Int64): Int64;
{$INLINE OFF}
begin
  Result := n + 1;
end;

var
  i, value: Int64;
begin
  value := 0;
  for i := 1 to 100000000 do
    value := add_one(value);
  WriteLn(value);
end.
