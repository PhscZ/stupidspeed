{ task 11 parallel_sum — expected output: 7500000075000000 }
{ build: fpc -O3 -oprogram main.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }
{ note: cthreads is pulled in on Unix so the RTL installs the POSIX thread manager. }

program prog;
{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}cthreads,{$ENDIF}
  SysUtils, Classes;

type
  TWorker = class(TThread)
  private
    FLo, FHi: Int64;
    FPartial: Int64;
  protected
    procedure Execute; override;
  public
    constructor Create(ALo, AHi: Int64);
    property Partial: Int64 read FPartial;
  end;

constructor TWorker.Create(ALo, AHi: Int64);
begin
  FLo := ALo;
  FHi := AHi;
  FPartial := 0;
  inherited Create(True);   { suspended, so the range is in place before Execute runs }
end;

procedure TWorker.Execute;
var
  i, acc: Int64;
begin
  acc := 0;
  for i := FLo to FHi - 1 do
  begin
    case i mod 4 of
      0: Inc(acc);
      1: Inc(acc, i);
      2: Inc(acc, 2 * i);
      3: Inc(acc, 3 * i);
    end;
  end;
  FPartial := acc;
end;

var
  workers: array[0..3] of TWorker;
  i: Integer;
  total: Int64;
begin
  for i := 0 to 3 do
    workers[i] := TWorker.Create(Int64(i) * 25000000, (Int64(i) + 1) * 25000000);
  for i := 0 to 3 do
    workers[i].Start;      { all four run at the same time }
  total := 0;
  for i := 0 to 3 do
  begin
    workers[i].WaitFor;
    total := total + workers[i].Partial;
    workers[i].Free;
  end;
  WriteLn(total);
end.
