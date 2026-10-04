// task 06 char_count — expected output: 10000000
// build: amxmlc -swf-version=51 -output prog.swf __06_char_count.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: the 100 MB text is built by doubling the ten-character block (O(log n)
//       concatenations) rather than appending in a loop, so the build is not the
//       benchmark, and the whole string is in place before the scan starts.
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

    public class _06_char_count extends Sprite
    {
        private var __t0:int = 0;
        private var __ms:int = 0;

        public function _06_char_count()
        {
            __t0 = getTimer();
            var block:String = "abcdefghij";
            var text:String = "";
            var reps:int = 10000000;
            var chunk:String = block;
            var n:int = reps;
            while (n > 0)
            {
                if (n % 2 == 1) { text = text + chunk; }
                n = n / 2;
                if (n > 0) { chunk = chunk + chunk; }
            }
            var count:int = 0;
            var len:int = text.length;
            for (var i:int = 0; i < len; i++)
            {
                var ch:String = text.charAt(i);
                if (ch == "a") { }
                else if (ch == "e") { }
                else if (ch == "h") { count = count + 1; }
                else { }
            }
            __ms = getTimer() - __t0;
            System.output(count + "\n");
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
