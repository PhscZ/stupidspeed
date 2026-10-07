-- task 03 func_sum — expected output: 100000000
-- build: gnatmake -O3 t03_func_sum.adb    run: ./t03_func_sum
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T03_Func_Sum is
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

   function Add_One (N : Long_Long_Integer) return Long_Long_Integer;
   pragma No_Inline (Add_One);

   function Add_One (N : Long_Long_Integer) return Long_Long_Integer is
   begin
      return N + 1;
   end Add_One;

   Value : Long_Long_Integer := 0;
begin
   for I in 1 .. 100_000_000 loop
      Value := Add_One (Value);
   end loop;

   Emit_Time;
   LL_IO.Put (Item => Value, Width => 1);
   New_Line;
end T03_Func_Sum;
