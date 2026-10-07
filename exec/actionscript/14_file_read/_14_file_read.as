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

// timing: getTimer() is the AVM2 clock, whole milliseconds since the VM started. AIR has
//       no stderr, so the contract's fallback applies: TIME_MS goes to time.txt in
//       File.applicationStorageDirectory -- %APPDATA%\stupidspeed.actionscript\Local Store\,
//       the writable directory task 15 writes out.bin to, because the bundle directory is
//       read-only. The read itself is deferred one event-loop turn (see the note below), so
//       the timer starts at the constructor and stops just before the final output, which
//       keeps the whole read inside the measured region; only the write of time.txt and the
//       exit fall outside it.
package
{
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.system.System;
    import flash.desktop.NativeApplication;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    public class _14_file_read extends Sprite
    {
        private static const CHUNK:int = 1048576;

        private var __t0:int = 0;
        private var __ms:int = 0;

        public function _14_file_read()
        {
            __t0 = getTimer();
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

            __ms = getTimer() - __t0;
            System.output(total + "\n");
          }
          catch (err:Error)
          {
            __ms = getTimer() - __t0;
            System.output("error: " + err + "\n");
          }
          setTimeout(__report, 0);
        }

        private function __report():void
        {
          try
          {
            var f:File = File.applicationStorageDirectory.resolvePath("time.txt");
            var s:FileStream = new FileStream();
            s.open(f, FileMode.WRITE);
            s.writeUTFBytes("TIME_MS=" + __ms + "\n");
            s.close();
          }
          catch (e:Error) { }
          NativeApplication.nativeApplication.exit(0);
        }
    }
}
