// task 07 string_append — expected output: 250000
// build: amxmlc -swf-version=51 -output prog.swf __07_string_append.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: `text = text + "x"` is the spec's own form, but it is *not* the quadratic cell the
//       task is designed to measure: the AVM2 extends the accumulator in place when the
//       value is unshared, so the 250000 appends are amortised. Measured: 52 ms, and linear
//       in the append count — 49 / 101 / 200 ms at 250000 / 500000 / 1000000, an exact
//       doubling per doubling, against the ~7.8 GB a real quadratic copy would move at the
//       row's own loop count. The deviation is recorded in RUN.md, the same one the Tcl,
//       Unicon, AutoHotkey, Dyalog, Lobster, Raku, Erlang and Elixir rows carry.
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

    public class _07_string_append extends Sprite
    {
        private var __t0:int = 0;
        private var __ms:int = 0;

        public function _07_string_append()
        {
            __t0 = getTimer();
            var text:String = "";
            for (var i:int = 0; i < 250000; i++)
            {
                text = text + "x";
            }
            __ms = getTimer() - __t0;
            System.output(text.length + "\n");
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
