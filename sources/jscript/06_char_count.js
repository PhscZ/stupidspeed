// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: cscript //nologo //E:JScript 06_char_count.js
// note: the text is built in one allocation with new Array(10000001).join("abcdefghij"),
//       which is 10000000 copies of the ten-character block, not an append loop. It
//       measures 0.32 s on this machine.
// note: the scan is charCodeAt per character. JScript has no cheaper standard-library
//       idiom that still looks at every character -- indexOf would search rather than
//       scan -- and this engine has no String.prototype.repeat to build the text with.
// note: the C row counts only 'h' -- 'a' and 'e' are skipped -- so this counts only the
//       character code 104, which is the same work per character.
// note: 100000000 characters measure 36 s to 183 s on this shared host, about 0.36 us to
//       1.8 us a character (fastest 36.3 s, slowest 183.1 s).
var text, n, count, i;

text = new Array(10000001).join("abcdefghij");
n = text.length;
count = 0;

for (i = 0; i < n; i++) {
    if (text.charCodeAt(i) === 104) {
        count++;
    }
}

WScript.Echo(String(count));
