// task 07 string_append — expected output: 250000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 07_string_append.js

var text = '';
for (var i = 0; i < 250000; i++) {
  text = text + 'x';
}
print(text.length);
