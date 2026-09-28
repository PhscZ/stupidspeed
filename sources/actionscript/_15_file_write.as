// task 15 file_write — expected output: 52428800
// build: amxmlc -swf-version=51 -output prog.swf _15_file_write.as  then
//        adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: AIR has no working-directory API and also refuses to write anywhere inside
//       File.applicationDirectory -- an attempt throws SecurityError: fileWriteResource,
//       because the bundle is read-only by design. out.bin therefore goes to
//       File.applicationStorageDirectory, AIR's own writable per-application data
//       directory: %APPDATA%\stupidspeed.actionscript\Local Store\out.bin on Windows.
//       It is a fixed, documented path rather than the working directory, and it is the
//       one place this row's file task differs from every other row's. The bytes written
//       and the answer are identical.
// note: FileStream has no fsync, so the deviation is flush and close -- the same one
//       the Tcl, D, Julia, Nim, Dart, Pascal, COBOL and Dolphin rows note. FileStream
//       buffers internally, so close() is what commits the last block.
// note: the whole body is inside try/catch and the catch still exits. An uncaught error
//       in a deferred callback does not terminate an AIR process, and because the app
//       never reaches exit() it hangs instead -- which is exactly how the first version
//       of this file behaved when it tried to write into the read-only bundle.

package
{
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.system.System;
    import flash.desktop.NativeApplication;
    import flash.utils.ByteArray;
    import flash.utils.setTimeout;

    public class _15_file_write extends Sprite
    {
        private static const CHUNK:int = 1048576;

        public function _15_file_write()
        {
            // See task 14: a FileStream cannot be opened from the constructor, so the
            // work is deferred by one event-loop turn.
            setTimeout(writeFile, 0);
        }

        private function writeFile():void
        {
            try
            {
                var buf:ByteArray = new ByteArray();
                buf.length = CHUNK;
                for (var i:int = 0; i < CHUNK; i++)
                {
                    buf[i] = i % 256;
                }

                var out:File = File.applicationStorageDirectory.resolvePath("out.bin");
                var stream:FileStream = new FileStream();
                stream.open(out, FileMode.WRITE);

                var written:Number = 0;
                for (var t:int = 0; t < 50; t++)
                {
                    stream.writeBytes(buf, 0, CHUNK);
                    written = written + CHUNK;
                }

                stream.close();

                System.output(written + "\n");
            }
            catch (err:Error)
            {
                System.output("error: " + err + "\n");
            }
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
