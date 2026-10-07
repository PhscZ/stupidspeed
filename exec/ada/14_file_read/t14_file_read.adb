-- task 14 file_read — expected output: 2389704704
-- build: gnatmake -O3 t14_file_read.adb    run: ./t14_file_read
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Streams;
with Ada.Streams.Stream_IO;
use type Ada.Streams.Stream_Element_Offset;
with Interfaces; use type Interfaces.Unsigned_32;

with Ada.Real_Time;
procedure T14_File_Read is
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
   Emit_Time;
   LL_IO.Put (Item => Long_Long_Integer (Total), Width => 1);
   New_Line;
end T14_File_Read;
