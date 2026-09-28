// task 14 file_read — expected output: 2389704704
// build: amxmlc -swf-version=51 -output prog.swf _14_file_read.as  then
//        adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf data.bin
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: AIR has no API for the process working directory, and `new File("data.bin")`
//       with a relative path throws rather than resolving against it, so this row
//       reads the fixture from File.applicationDirectory -- the bundle the exe lives
//       in. The build line therefore passes data.bin to adt so it is packaged
//       alongside the exe, and the runner must build with data.bin present. This is
//       the one deviation in this row, and it is a packaging difference only: the
//       bytes read and the answer are the same as every other row's.
// note: read in 1 MiB chunks; the running total is reduced mod 2^32 as it goes so it
//       stays inside the 2^53 range where an AS3 Number is exact, then printed.

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

    public class _14_file_read extends Sprite
    {
        private static const CHUNK:int = 1048576;

        public function _14_file_read()
        {
            // FileStream cannot be opened from the constructor: AIR has not set up the
            // filesystem or security context yet, and a synchronous open here fails the
            // process with exit code 1 and no output. Deferring by one event-loop turn
            // is enough, and is what the probe confirmed.
            setTimeout(readFile, 0);
        }

        private function readFile():void
        {
          try
          {
            var f:File = File.applicationDirectory.resolvePath("data.bin");
            var stream:FileStream = new FileStream();
            stream.open(f, FileMode.READ);

            var buf:ByteArray = new ByteArray();
            var total:Number = 0;

            while (stream.bytesAvailable > 0)
            {
                var want:int = stream.bytesAvailable < CHUNK ? stream.bytesAvailable : CHUNK;
                buf.length = 0;
                stream.readBytes(buf, 0, want);
                for (var i:int = 0; i < want; i++)
                {
                    total = total + (buf[i] & 0xFF);
                }
                total = total % 4294967296;
            }

            stream.close();

            System.output(total + "\n");
          }
          catch (err:Error)
          {
            System.output("error: " + err + "\n");
          }
          NativeApplication.nativeApplication.exit(0);
        }
    }
}
