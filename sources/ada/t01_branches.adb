-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: gnatmake -O3 t01_branches.adb    run: ./t01_branches
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T01_Branches is
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

   Emit_Time;
   LL_IO.Put (Item => A, Width => 1);
   Put (' ');
   LL_IO.Put (Item => B, Width => 1);
   Put (' ');
   LL_IO.Put (Item => C, Width => 1);
   Put (' ');
   LL_IO.Put (Item => D, Width => 1);
   New_Line;
end T01_Branches;
