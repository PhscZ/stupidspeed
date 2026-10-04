-- task 15 file_write — expected output: 52428800
-- build: gnatmake -O3 t15_file_write.adb    run: ./t15_file_write
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Streams;
with Ada.Streams.Stream_IO;
use type Ada.Streams.Stream_Element_Offset;

with Ada.Real_Time;
procedure T15_File_Write is
   T0 : constant Ada.Real_Time.Time := Ada.Real_Time.Clock;

   procedure Emit_Time is
      package MS_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);
      Micro : constant Duration := 1_000_000.0;
      Half  : constant Duration := 0.5;
      D     : constant Duration := Ada.Real_Time.To_Duration
                (Ada.Real_Time."-"(Ada.Real_Time.Clock, T0));
      Us    : constant Long_Long_Integer :=
                Long_Long_Integer (D * Micro + Half);
      Fr    : constant Long_Long_Integer := Us mod 1000;
   begin
      Ada.Text_IO.Put (Standard_Error, "TIME_MS=");
      MS_IO.Put (Standard_Error, Us / 1000, 1);
      Ada.Text_IO.Put (Standard_Error, ".");
      if Fr < 100 then
         Ada.Text_IO.Put (Standard_Error, "0");
      end if;
      if Fr < 10 then
         Ada.Text_IO.Put (Standard_Error, "0");
      end if;
      MS_IO.Put (Standard_Error, Fr, 1);
      Ada.Text_IO.New_Line (Standard_Error);
   end Emit_Time;
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);
   package SIO renames Ada.Streams.Stream_IO;

   Chunk : constant := 1_048_576;

   F       : SIO.File_Type;
   Buf     : Ada.Streams.Stream_Element_Array (1 .. Chunk);
   Written : Long_Long_Integer := 0;
begin
   --  1 MiB = the bytes 0 .. 255 repeated 4096 times.
   for I in Buf'Range loop
      Buf (I) := Ada.Streams.Stream_Element ((I - 1) mod 256);
   end loop;

   SIO.Create (F, SIO.Out_File, "out.bin");

   for Rep in 1 .. 50 loop
      SIO.Write (F, Buf);
      Written := Written + Long_Long_Integer (Buf'Length);
   end loop;

   SIO.Flush (F);
   SIO.Close (F);

   Emit_Time;
   LL_IO.Put (Item => Written, Width => 1);
   New_Line;
end T15_File_Write;
