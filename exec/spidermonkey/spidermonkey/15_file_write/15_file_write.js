// task 15 file_write — expected output: 419430400
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 15_file_write.js
// note: a 1 MiB byte array (the bytes 0..255 repeated 4096 times) is built once and laid down 50
//       times to build the 50 MiB pass buffer, which is then written to out.bin 8 times over. The
//       shell's only binary write call, os.file.writeTypedArrayToFile, truncates rather than appends,
//       so each of the 8 passes rewrites the file from offset 0; the shell exposes no fsync, so the
//       close inside writeTypedArrayToFile is the per-pass flush.

var __t0 = performance.now();
var CHUNK = 1048576;
var REPEATS = 50;
var PASSES = 8;

var chunk = new Uint8Array(CHUNK);
for (var i = 0; i < CHUNK; i++) {
  chunk[i] = i % 256;
}

var out = new Uint8Array(CHUNK * REPEATS);
for (var rep = 0; rep < REPEATS; rep++) {
  out.set(chunk, rep * CHUNK);
}

var written = 0;
for (var pass = 0; pass < PASSES; pass++) {
  os.file.writeTypedArrayToFile("out.bin", out);
  written += out.length;
}

printErr("TIME_MS=" + (performance.now() - __t0));
print(written);
