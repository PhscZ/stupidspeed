-- task 09 fib_recursive — expected output: 102334155
-- build: gnatmake -O3 t09_fib_recursive.adb    run: ./t09_fib_recursive
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure T09_Fib_Recursive is
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);

   function Fib (N : Integer) return Long_Long_Integer is
   begin
      if N < 2 then
         return Long_Long_Integer (N);
      else
         return Fib (N - 1) + Fib (N - 2);
      end if;
   end Fib;
begin
   LL_IO.Put (Item => Fib (40), Width => 1);
   New_Line;
end T09_Fib_Recursive;
