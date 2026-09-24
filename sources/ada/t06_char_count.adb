-- task 06 char_count — expected output: 10000000
-- build: gnatmake -O3 t06_char_count.adb    run: ./t06_char_count
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure T06_Char_Count is
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

   LL_IO.Put (Item => Count, Width => 1);
   New_Line;
end T06_Char_Count;
