-- task 08 average — expected output: 0.498046875
-- build: gnatmake -O3 main.adb    run: ./main
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Float_IO;

procedure Main is
   package LF_IO is new Ada.Text_IO.Float_IO (Long_Float);

   Total   : Long_Float := 0.0;
   Reading : Long_Float;
begin
   for I in 0 .. 99_999_999 loop
      Reading := Long_Float (I mod 256) / 256.0;
      Total := Total + Reading;
   end loop;

   LF_IO.Put (Item => Total / 100_000_000.0, Fore => 1, Aft => 9, Exp => 0);
   New_Line;
end Main;
