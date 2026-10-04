// task 08 average — expected output: 0.498046875
// build: amxmlc -swf-version=51 -output prog.swf __08_average.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: AS3 Number is an IEEE double, the same type the C row uses, and every
//       reading is a multiple of 1/256 with the total far below 2^53, so the sum is
//       exact and the digits do not depend on the order of addition. AS3's default
//       Number-to-String conversion prints 0.498046875 exactly.
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

    public class _08_average extends Sprite
    {
        private var __t0:int = 0;
        private var __ms:int = 0;

        public function _08_average()
        {
            __t0 = getTimer();
            var total:Number = 0.0;
            for (var i:int = 0; i < 100000000; i++)
            {
                var reading:Number = (i % 256) / 256.0;
                total = total + reading;
            }
            __ms = getTimer() - __t0;
            System.output((total / 100000000.0) + "\n");
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
