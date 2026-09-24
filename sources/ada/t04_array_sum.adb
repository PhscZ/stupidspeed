-- task 04 array_sum — expected output: 499999500000
-- build: gnatmake -O3 t04_array_sum.adb    run: ./t04_array_sum
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure T04_Array_Sum is
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);

   Count : constant := 1_000_000;
   type Int_Array is array (0 .. Count - 1) of Long_Long_Integer;
   type Int_Array_Access is access Int_Array;

   Values : constant Int_Array_Access := new Int_Array;
   Total  : Long_Long_Integer := 0;
begin
   for I in 0 .. Count - 1 loop
      Values (I) := Long_Long_Integer (I);
   end loop;

   for I in 0 .. Count - 1 loop
      Total := Total + Values (I);
   end loop;

   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end T04_Array_Sum;
