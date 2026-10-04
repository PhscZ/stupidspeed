-- task 11 parallel_sum — expected output: 7500000075000000
-- build: gnatmake -O3 t11_parallel_sum.adb    run: ./t11_parallel_sum
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T11_Parallel_Sum is
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

   task type Worker (T : Integer) is
      entry Done (R : out Long_Long_Integer);
   end Worker;

   task body Worker is
      Acc    : Long_Long_Integer := 0;
      Result : Long_Long_Integer := 0;
      I64    : Long_Long_Integer;
   begin
      for I in T * 25_000_000 .. (T + 1) * 25_000_000 - 1 loop
         I64 := Long_Long_Integer (I);
         case I mod 4 is
            when 0 =>
               Acc := Acc + 1;
            when 1 =>
               Acc := Acc + I64;
            when 2 =>
               Acc := Acc + 2 * I64;
            when others =>
               Acc := Acc + 3 * I64;
         end case;
      end loop;

      Result := Acc;
      accept Done (R : out Long_Long_Integer) do
         R := Result;
      end Done;
   end Worker;

   W0 : Worker (0);
   W1 : Worker (1);
   W2 : Worker (2);
   W3 : Worker (3);

   R0, R1, R2, R3 : Long_Long_Integer;
begin
   W0.Done (R0);
   W1.Done (R1);
   W2.Done (R2);
   W3.Done (R3);

   Emit_Time;
   LL_IO.Put (Item => R0 + R1 + R2 + R3, Width => 1);
   New_Line;
end T11_Parallel_Sum;
