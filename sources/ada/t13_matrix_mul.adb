-- task 13 matrix_mul — expected output: 599995000
-- build: gnatmake -O3 t13_matrix_mul.adb    run: ./t13_matrix_mul
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T13_Matrix_Mul is
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

   N    : constant := 500;
   Size : constant := N * N;

   type Matrix is array (0 .. Size - 1) of Long_Long_Integer;
   type Matrix_Access is access Matrix;

   A : constant Matrix_Access := new Matrix;
   B : constant Matrix_Access := new Matrix;
   C : constant Matrix_Access := new Matrix;

   Total : Long_Long_Integer := 0;
   Sum   : Long_Long_Integer;
begin
   for I in 0 .. N - 1 loop
      for J in 0 .. N - 1 loop
         A (I * N + J) := Long_Long_Integer ((I + J) mod 7);
         B (I * N + J) := Long_Long_Integer ((I * J) mod 5);
      end loop;
   end loop;

   for I in 0 .. N - 1 loop
      for J in 0 .. N - 1 loop
         Sum := 0;
         for K in 0 .. N - 1 loop
            Sum := Sum + A (I * N + K) * B (K * N + J);
         end loop;
         C (I * N + J) := Sum;
      end loop;
   end loop;

   for K in 0 .. Size - 1 loop
      Total := Total + C (K);
   end loop;

   Emit_Time;
   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end T13_Matrix_Mul;
