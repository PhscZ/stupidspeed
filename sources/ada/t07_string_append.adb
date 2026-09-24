-- task 07 string_append — expected output: 1000000
-- build: gnatmake -O3 t07_string_append.adb    run: ./t07_string_append
-- Ada's String is fixed length, so the growing string lives in an access
-- object that is rebound to the freshly concatenated value each iteration;
-- the replaced string is freed explicitly (Ada has no garbage collector).
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;
with Ada.Unchecked_Deallocation;

procedure T07_String_Append is
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);

   type Str_Access is access String;
   procedure Free is new Ada.Unchecked_Deallocation
     (Object => String, Name => Str_Access);

   Text : Str_Access := new String (1 .. 0);
   Old  : Str_Access;
begin
   for I in 1 .. 1_000_000 loop
      Old  := Text;
      Text := new String'(Text.all & 'x');
      Free (Old);
   end loop;

   LL_IO.Put (Item => Long_Long_Integer (Text.all'Length), Width => 1);
   New_Line;
end T07_String_Append;
