-- task 04 array_sum — expected output: 499999500000
-- build: gnatmake -O3 t04_array_sum.adb    run: ./t04_array_sum
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T04_Array_Sum is
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

   Emit_Time;
   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end T04_Array_Sum;
