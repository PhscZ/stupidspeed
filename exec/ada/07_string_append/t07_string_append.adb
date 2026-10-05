-- task 07 string_append — expected output: 250000
-- build: gnatmake -O3 t07_string_append.adb    run: ./t07_string_append
-- Ada's String is fixed length, so the growing string lives in an access
-- object that is rebound to the freshly concatenated value each iteration;
-- the replaced string is freed explicitly (Ada has no garbage collector).
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

with Ada.Real_Time;
procedure T07_String_Append is
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

   type Str_Access is access String;
   procedure Free is new Ada.Unchecked_Deallocation
     (Object => String, Name => Str_Access);

   Text : Str_Access := new String (1 .. 0);
   Old  : Str_Access;
begin
   for I in 1 .. 250_000 loop
      Old  := Text;
      Text := new String'(Text.all & 'x');
      Free (Old);
   end loop;

   Emit_Time;
   LL_IO.Put (Item => Long_Long_Integer (Text.all'Length), Width => 1);
   New_Line;
end T07_String_Append;
