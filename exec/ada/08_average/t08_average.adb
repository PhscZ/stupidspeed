-- task 08 average — expected output: 0.498046875
-- build: gnatmake -O3 t08_average.adb    run: ./t08_average
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Real_Time;
procedure T08_Average is
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
   package LF_IO is new Ada.Text_IO.Float_IO (Long_Float);

   Total   : Long_Float := 0.0;
   Reading : Long_Float;
begin
   for I in 0 .. 99_999_999 loop
      Reading := Long_Float (I mod 256) / 256.0;
      Total := Total + Reading;
   end loop;

   Emit_Time;
   LF_IO.Put (Item => Total / 100_000_000.0, Fore => 1, Aft => 9, Exp => 0);
   New_Line;
end T08_Average;
