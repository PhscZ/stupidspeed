{ task 14 file_read — expected output: 484442112 }
{ build: fpc -O3 -oprogram 14_file_read.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Classes;

const
  ChunkSize = 1024 * 1024;   { 1 MiB }

var
  fs: TFileStream;
  buf: array[0..ChunkSize - 1] of Byte;
  got, i: Integer;
  total: Int64;
begin
  total := 0;
  fs := TFileStream.Create('data.bin', fmOpenRead);
  try
    repeat
      got := fs.Read(buf, ChunkSize);
      for i := 0 to got - 1 do
        total := total + buf[i];
    until got <= 0;   { 0 means end of file }
  finally
    fs.Free;   { closing the stream is the flush point here }
  end;
  WriteLn(total mod 4294967296);
end.
