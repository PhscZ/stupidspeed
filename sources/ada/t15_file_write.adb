-- task 15 file_write — expected output: 104857600
-- build: gnatmake -O3 t15_file_write.adb    run: ./t15_file_write
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;
with Ada.Streams;
with Ada.Streams.Stream_IO;

procedure T15_File_Write is
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

   for Rep in 1 .. 100 loop
      SIO.Write (F, Buf);
      Written := Written + Long_Long_Integer (Buf'Length);
   end loop;

   SIO.Flush (F);
   SIO.Close (F);

   LL_IO.Put (Item => Written, Width => 1);
   New_Line;
end T15_File_Write;
