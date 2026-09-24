-- task 14 file_read — expected output: 484442112
-- build: gnatmake -O3 main.adb    run: ./main
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;
with Ada.Streams;
with Ada.Streams.Stream_IO;
with Interfaces; use type Interfaces.Unsigned_32;

procedure Main is
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);
   package SIO renames Ada.Streams.Stream_IO;

   Chunk : constant := 1_048_576;

   F     : SIO.File_Type;
   Buf   : Ada.Streams.Stream_Element_Array (1 .. Chunk);
   Last  : Ada.Streams.Stream_Element_Offset;
   Total : Interfaces.Unsigned_32 := 0;
begin
   SIO.Open (F, SIO.In_File, "data.bin");

   loop
      SIO.Read (F, Buf, Last);
      exit when Last < Buf'First;
      for I in Buf'First .. Last loop
         Total := Total + Interfaces.Unsigned_32 (Buf (I));
      end loop;
   end loop;

   SIO.Close (F);

   --  Unsigned_32 arithmetic already wraps modulo 2**32.
   LL_IO.Put (Item => Long_Long_Integer (Total), Width => 1);
   New_Line;
end Main;
