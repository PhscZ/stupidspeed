// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 06_char_count.js
// note: the 100 MB text is built in one repeat call, then scanned one character at a time with
//       charCodeAt, as the task requires.

var __t0 = performance.now();
var text = 'abcdefghij'.repeat(10000000);
var count = 0;
for (var i = 0; i < text.length; i++) {
  var ch = text.charCodeAt(i);
  if (ch === 97) continue;        /* 'a' */
  else if (ch === 101) continue;  /* 'e' */
  else if (ch === 104) count += 1; /* 'h' */
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(count);
