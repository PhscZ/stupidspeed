// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: amxmlc -swf-version=51 -output prog.swf __01_branches.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: AS3 `int` is 32-bit and all four counters stay under 2^31, so plain ints are
//       exact; the loop index also fits. AS3 ints wrap on overflow rather than
//       promoting, which is why the accumulator in task 02 has to be a Number.
// timing: getTimer() is the AVM2 clock, whole milliseconds since the VM started. AIR has
//       no stderr, so the contract's fallback applies: TIME_MS goes to time.txt in
//       File.applicationStorageDirectory -- %APPDATA%\stupidspeed.actionscript\Local Store\,
//       the writable directory task 15 writes out.bin to, because the bundle directory is
//       read-only. A FileStream cannot be opened from the constructor, so the write and the
//       exit happen one event-loop turn later; the measured region is unchanged.
package
{
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.system.System;
    import flash.desktop.NativeApplication;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    public class _01_branches extends Sprite
    {
        private var __t0:int = 0;
        private var __ms:int = 0;

        public function _01_branches()
        {
            __t0 = getTimer();
            var a:int = 0, b:int = 0, c:int = 0, d:int = 0;
            for (var i:int = 0; i < 100000000; i++)
            {
                if (i % 3 == 0) { a = a + 1; }
                else if (i % 5 == 0) { b = b + 1; }
                else if (i % 7 == 0) { c = c + 1; }
                else { d = d + 1; }
            }
            __ms = getTimer() - __t0;
            System.output(a + " " + b + " " + c + " " + d + "\n");
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
