-- task 03 func_sum — expected output: 100000000
-- build: gnatmake -O3 t03_func_sum.adb    run: ./t03_func_sum
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure T03_Func_Sum is
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

   LL_IO.Put (Item => Value, Width => 1);
   New_Line;
end T03_Func_Sum;
