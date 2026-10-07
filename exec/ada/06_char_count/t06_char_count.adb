-- task 06 char_count — expected output: 10000000
-- build: gnatmake -O3 t06_char_count.adb    run: ./t06_char_count
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T06_Char_Count is
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

   Block : constant String := "abcdefghij";
   Text  : constant access String := new String (1 .. 100_000_000);
   Count : Long_Long_Integer := 0;
begin
   --  Build the 100 MB text once, ten characters per slice assignment.
   for Rep in 0 .. 9_999_999 loop
      Text (Rep * 10 + 1 .. Rep * 10 + 10) := Block;
   end loop;

   for I in Text.all'Range loop
      if Text.all (I) = 'a' then
         null;
      elsif Text.all (I) = 'e' then
         null;
      elsif Text.all (I) = 'h' then
         Count := Count + 1;
      else
         null;
      end if;
   end loop;

   Emit_Time;
   LL_IO.Put (Item => Count, Width => 1);
   New_Line;
end T06_Char_Count;
