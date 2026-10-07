-- task 12 matrix_add — expected output: 999000000
-- build: gnatmake -O3 t12_matrix_add.adb    run: ./t12_matrix_add
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T12_Matrix_Add is
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

   N    : constant := 1000;
   Size : constant := N * N;

   type Matrix is array (0 .. Size - 1) of Long_Long_Integer;
   type Matrix_Access is access Matrix;

   A : constant Matrix_Access := new Matrix;
   B : constant Matrix_Access := new Matrix;
   C : constant Matrix_Access := new Matrix;

   Total : Long_Long_Integer := 0;
begin
   for I in 0 .. N - 1 loop
      for J in 0 .. N - 1 loop
         A (I * N + J) := Long_Long_Integer (I + J);
         B (I * N + J) := Long_Long_Integer (I - J);
      end loop;
   end loop;

   for K in 0 .. Size - 1 loop
      C (K) := A (K) + B (K);
   end loop;

   for K in 0 .. Size - 1 loop
      Total := Total + C (K);
   end loop;

   Emit_Time;
   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end T12_Matrix_Add;
