-- task 09 fib_recursive — expected output: 102334155
-- build: gnatmake -O3 t09_fib_recursive.adb    run: ./t09_fib_recursive
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T09_Fib_Recursive is
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

   function Fib (N : Integer) return Long_Long_Integer is
   begin
      if N < 2 then
         return Long_Long_Integer (N);
      else
         return Fib (N - 1) + Fib (N - 2);
      end if;
   end Fib;

   Answer : Long_Long_Integer;
begin
   --  The call is a statement of its own, not the argument to Put.  Written as
   --  `LL_IO.Put (Item => Fib (40), ...)` with Emit_Time first, the timing line
   --  brackets nothing at all: the argument is evaluated after Emit_Time has run,
   --  and the cell reports the microseconds between the clock being read and the
   --  program reaching the Put.
   Answer := Fib (40);

   Emit_Time;
   LL_IO.Put (Item => Answer, Width => 1);
   New_Line;
end T09_Fib_Recursive;
