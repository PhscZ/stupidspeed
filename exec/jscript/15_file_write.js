// task 15 file_write — expected output: 52428800
// build: none (interpreted)    run: cscript //nologo //E:JScript 15_file_write.js
// note: out.bin is written into the working directory, 52428800 bytes: the 1 MiB buffer
//       (bytes 0..255 repeated 4096 times) written 50 times.
// note: the buffer is built in one allocation with new Array(4097).join(block), where
//       block is the 256-character string of bytes 0..255 -- a block repeat, not an
//       append loop.
// note: the write goes through ADODB.Stream in text mode with the single-byte ISO-8859-1
//       charset, because Stream.Write rejects a JScript string with error 800a0bb9. One
//       character is one byte in that charset, and the round trip was checked byte for
//       byte against all 256 values, so the file content is the buffer's bytes. The
//       charset spelling matters: "UTF-8" would expand each byte above 0x7F, and the
//       machine's ANSI code page is not Latin-1 either.
// note: ADODB.Stream.Flush() is called before SaveToFile, but the engine has no fsync
//       (no FlushFileBuffers), so SaveToFile plus Close is the commit. That is the
//       deviation from the C row's _commit, the same one the VBScript row carries.
// note: the printed count is the stream's Position, which counts bytes here, 52428800;
//       the file on disk was checked to be that size.
// note: the whole task measures 1.6 s to 3.7 s on this shared host.

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var CHUNKSZ = 1048576, REPEATS = 50;
var block = "", buf, st, i, written;

for (i = 0; i < 256; i++) {
    block += String.fromCharCode(i);
}
buf = new Array(4097).join(block);

st = new ActiveXObject("ADODB.Stream");
st.Type = 2;
st.Charset = "ISO-8859-1";
st.Open();

for (i = 0; i < REPEATS; i++) {
    st.WriteText(buf);
}

st.Flush();
written = st.Position;
st.SaveToFile("out.bin", 2);
st.Close();

ssReport();
WScript.Echo(String(written));
