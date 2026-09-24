-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: gnatmake -O3 t01_branches.adb    run: ./t01_branches
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure T01_Branches is
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);

   A : Long_Long_Integer := 0;
   B : Long_Long_Integer := 0;
   C : Long_Long_Integer := 0;
   D : Long_Long_Integer := 0;
begin
   for I in 0 .. 99_999_999 loop
      if I mod 3 = 0 then
         A := A + 1;
      elsif I mod 5 = 0 then
         B := B + 1;
      elsif I mod 7 = 0 then
         C := C + 1;
      else
         D := D + 1;
      end if;
   end loop;

   LL_IO.Put (Item => A, Width => 1);
   Put (' ');
   LL_IO.Put (Item => B, Width => 1);
   Put (' ');
   LL_IO.Put (Item => C, Width => 1);
   Put (' ');
   LL_IO.Put (Item => D, Width => 1);
   New_Line;
end T01_Branches;
