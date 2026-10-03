// task 07 string_append — expected output: 250000
// build: none (interpreted)    run: cscript //nologo //E:JScript 07_string_append.js
// note: text = text + "x" 250000 times is the spec's loop, but this engine does not pay
//       the quadratic price for it. JScript9Legacy does not flatten the string on each
//       concatenation; it keeps a concatenation tree and materialises the flat string when a
//       character is needed, which is when text.length is read. The same loop in VBScript,
//       whose strings are flat and copied every time, is the slowest cell in that row.
//       Nothing in the standard library is used to avoid the copy; the engine simply does
//       not make it.
// note: text.length is the printed value, so the loop cannot be removed.
var text = "", i;

for (i = 0; i < 250000; i++) {
    text = text + "x";
}

WScript.Echo(String(text.length));
