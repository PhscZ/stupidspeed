-- task 02 switch_case — expected output: 7500000075000000
-- build: gnatmake -O3 t02_switch_case.adb    run: ./t02_switch_case
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T02_Switch_Case is
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

   Acc : Long_Long_Integer := 0;
   I64 : Long_Long_Integer;
begin
   for I in 0 .. 99_999_999 loop
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

   Emit_Time;
   LL_IO.Put (Item => Acc, Width => 1);
   New_Line;
end T02_Switch_Case;
