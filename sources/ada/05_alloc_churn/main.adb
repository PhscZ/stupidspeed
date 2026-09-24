-- task 05 alloc_churn — expected output: 1274991808
-- build: gnatmake -O3 main.adb    run: ./main
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;
with Ada.Unchecked_Deallocation;
with Interfaces;

procedure Main is
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);

   type Buf is array (1 .. 64) of Interfaces.Unsigned_8;
   type Buf_Access is access Buf;
   procedure Free is new Ada.Unchecked_Deallocation
     (Object => Buf, Name => Buf_Access);

   Slots : array (0 .. 255) of Buf_Access := (others => null);
   Total : Long_Long_Integer := 0;
   B     : Buf_Access;
   Idx   : Integer;
begin
   for I in 0 .. 9_999_999 loop
      B := new Buf;
      B (1) := Interfaces.Unsigned_8 (I mod 256);
      Total := Total + Long_Long_Integer (B (1));

      Idx := I mod 256;
      if Slots (Idx) /= null then
         Free (Slots (Idx));
      end if;
      Slots (Idx) := B;
   end loop;

   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end Main;
