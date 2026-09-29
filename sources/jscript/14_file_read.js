// task 14 file_read — expected output: 2389704704
// build: none (interpreted)    run: cscript //nologo //E:JScript 14_file_read.js
// note: data.bin must be in the working directory: 52428800 bytes, the bytes 0 through
//       255 repeating.
// note: JScript has no byte type either, but unlike VBScript it can index the safe array
//       ADODB.Stream.Read returns: new VBArray(chunk).toArray() gives an ordinary JScript
//       array of the chunk's bytes. So the file is read in binary mode, one byte at a
//       time, with no charset conversion in the way -- the deviation the VBScript row
//       had to document is not needed here. Chunks are 1 MiB, the size the C row reads.
// note: Read returns null once the file is exhausted, which is what ends the loop.
// note: total is a double. The file's byte sum is 204800 * 32640 = 6684672000, below
//       2^53 and exact. The C row takes total % 2^32 at the end; % on doubles is the
//       IEEE remainder and both operands here are exact integers, so the result is
//       exact: 6684672000 % 4294967296 = 2389704704.
// note: measured on the 50 MiB fixture: 20 s to 108 s on this shared host, about 0.40 us to
//       2.2 us per byte for the 50 million byte reads and adds (fastest 19.8 s, slowest
//       108.0 s).
var st, chunk, arr, total = 0, i, n;

st = new ActiveXObject("ADODB.Stream");
st.Type = 1;
st.Open();
st.LoadFromFile("data.bin");

for (;;) {
    chunk = st.Read(1048576);
    if (chunk === null) {
        break;
    }
    arr = new VBArray(chunk).toArray();
    n = arr.length;
    for (i = 0; i < n; i++) {
        total += arr[i];
    }
}

st.Close();

WScript.Echo(String(total % 4294967296));
