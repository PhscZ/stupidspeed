// task 07 string_append — expected output: 1000000
// build: none (interpreted)    run: cscript //nologo //E:JScript 07_string_append.js
// note: text = text + "x" a million times is the spec's loop, but this engine does not pay
//       the quadratic price for it. Measured in one process, the same loop costs 543 ms at
//       1 million appends, 867 ms at 2 million and 1327 ms at 4 million -- a factor of
//       about 1.6 per doubling, where a string copied on every append would give 4. So
//       JScript9Legacy does not flatten the string on each concatenation; it keeps a
//       concatenation tree and materialises the flat string when a character is needed,
//       which is when text.length is read. The same loop in VBScript, whose strings are
//       flat and copied every time, is the slowest cell in that row at about 9.6 minutes.
//       Nothing in the standard library is used to avoid the copy; the engine simply does
//       not make it.
// note: the task itself measures 0.73 s to 5.3 s on this shared host, usually about a
//       second (the slowest run is the same file on a loaded machine).
// note: text.length is the printed value, so the loop cannot be removed.
var text = "", i;

for (i = 0; i < 1000000; i++) {
    text = text + "x";
}

WScript.Echo(String(text.length));
