-- task 13 matrix_mul — expected output: 599995000
-- build: gnatmake -O3 main.adb    run: ./main
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure Main is
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

   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end Main;
