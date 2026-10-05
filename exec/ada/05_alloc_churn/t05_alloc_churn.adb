-- task 05 alloc_churn — expected output: 1274991808
-- build: gnatmake -O3 t05_alloc_churn.adb    run: ./t05_alloc_churn
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Interfaces;

with Ada.Real_Time;
procedure T05_Alloc_Churn is
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

   Emit_Time;
   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end T05_Alloc_Churn;
