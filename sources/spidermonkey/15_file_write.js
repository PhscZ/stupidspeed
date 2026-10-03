// task 15 file_write — expected output: 52428800
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 15_file_write.js
// note: a 1 MiB byte array (the bytes 0..255 repeated 4096 times) is laid down 50 times to build
//       the 50 MiB output buffer, which is written to out.bin. The shell's only binary write call,
//       os.file.writeTypedArrayToFile, truncates rather than appends, so the 50 one-megabyte passes
//       are materialised in the buffer before the single write.

var CHUNK = 1048576;
var REPEATS = 50;

var chunk = new Uint8Array(CHUNK);
for (var i = 0; i < CHUNK; i++) {
  chunk[i] = i % 256;
}

var out = new Uint8Array(CHUNK * REPEATS);
for (var pass = 0; pass < REPEATS; pass++) {
  out.set(chunk, pass * CHUNK);
}

os.file.writeTypedArrayToFile("out.bin", out);
print(out.length);
