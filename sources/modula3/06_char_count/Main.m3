(* task 06 char_count — expected output: 10000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Text;

CONST pattern = ARRAY [0..9] OF CHAR{'a','b','c','d','e','f','g','h','i','j'};

VAR chars: ARRAY [0..99999999] OF CHAR;
    i, j, count: INTEGER;
    text: TEXT;

BEGIN
  (* the whole 100 MB text is built up front, block by block *)
  FOR i := 0 TO 9999999 DO
    FOR j := 0 TO 9 DO
      chars[i * 10 + j] := pattern[j]
    END
  END;
  text := Text.FromChars(chars);

  count := 0;
  FOR i := 0 TO Text.Length(text) - 1 DO
    CASE Text.GetChar(text, i) OF
      'a', 'e' => (* skip *)
    | 'h' => count := count + 1
    ELSE (* skip *)
    END
  END;
  IO.Put(Fmt.Int(count) & "\n");
END Main.
