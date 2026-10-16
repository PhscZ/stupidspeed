// task 14 file_read — expected output: 1937768448
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 14_file_read.js
// note: data.bin must be in the working directory: 52428800 bytes, the bytes 0 through 255
//       repeating. The shell's file API has no chunked read, so os.file.readFile pulls the whole
//       file into one ArrayBuffer and the loop then sums every byte of the view; the whole
//       read-and-sum is repeated eight times.

var __t0 = performance.now();
var total = 0;
for (var pass = 0; pass < 8; pass++) {
  var data = os.file.readFile("data.bin", "binary");
  var u8 = new Uint8Array(data);
  for (var i = 0; i < u8.length; i++) {
    total += u8[i];
  }
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(total % 4294967296);
