-- task 12 matrix_add — expected output: 999000000
-- build: gnatmake -O3 t12_matrix_add.adb    run: ./t12_matrix_add
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure T12_Matrix_Add is
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

   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end T12_Matrix_Add;
