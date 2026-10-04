{ task 14 file_read — expected output: 2389704704 }
{ build: fpc -O3 -oprogram 14_file_read.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils, Classes, Windows;

const
  ChunkSize = 1024 * 1024;   { 1 MiB }

var
  __clock_t0, __clock_t1, __clock_freq, __clock_us: Int64;
  fs: TFileStream;
  buf: array[0..ChunkSize - 1] of Byte;
  got, i: Integer;
  total: Int64;
begin
  QueryPerformanceFrequency(__clock_freq);
  QueryPerformanceCounter(__clock_t0);
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
  QueryPerformanceCounter(__clock_t1);
  __clock_us := (__clock_t1 - __clock_t0) * 1000000 div __clock_freq;
  Write(StdErr, 'TIME_MS=', __clock_us div 1000, '.');
  if __clock_us mod 1000 < 100 then Write(StdErr, '0');
  if __clock_us mod 1000 < 10 then Write(StdErr, '0');
  WriteLn(StdErr, __clock_us mod 1000);
  WriteLn(total mod 4294967296);
end.
