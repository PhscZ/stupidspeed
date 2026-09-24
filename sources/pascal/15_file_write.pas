{ task 15 file_write — expected output: 104857600 }
{ build: fpc -O3 -oprogram 15_file_write.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }
{ note: fpc's TFileStream exposes no fsync, so the flush point is freeing the stream,
  which closes the handle. }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Classes;

const
  ChunkSize = 1024 * 1024;   { 1 MiB }

var
  fs: TFileStream;
  buf: array[0..ChunkSize - 1] of Byte;
  i, rep: Integer;
  written: Int64;
begin
  for i := 0 to ChunkSize - 1 do
    buf[i] := Byte(i mod 256);   { 0, 1, 2, ... 255, over and over }

  written := 0;
  fs := TFileStream.Create('out.bin', fmCreate);
  try
    for rep := 1 to 100 do
    begin
      fs.WriteBuffer(buf, ChunkSize);
      written := written + ChunkSize;
    end;
  finally
    fs.Free;   { closes the handle, which is the flush }
  end;
  WriteLn(written);
end.
