-- task 02 switch_case — expected output: 7500000075000000
-- build: gnatmake -O3 t02_switch_case.adb    run: ./t02_switch_case
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;

procedure T02_Switch_Case is
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

   LL_IO.Put (Item => Acc, Width => 1);
   New_Line;
end T02_Switch_Case;
