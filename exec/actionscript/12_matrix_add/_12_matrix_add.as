// task 12 matrix_add — expected output: 999000000
// build: amxmlc -swf-version=51 -output prog.swf __12_matrix_add.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: three packed Vector.<int> of a million elements each, row-major, so the
//       access pattern matches the C row. The total fits an int but is summed in a
//       Number for consistency with the other accumulator tasks.
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

    public class _12_matrix_add extends Sprite
    {
        private var __t0:int = 0;
        private var __ms:int = 0;

        public function _12_matrix_add()
        {
            __t0 = getTimer();
            var n:int = 1000;
            var elems:int = n * n;
            var A:Vector.<int> = new Vector.<int>(elems);
            var B:Vector.<int> = new Vector.<int>(elems);
            var C:Vector.<int> = new Vector.<int>(elems);
            for (var i:int = 0; i < n; i++)
            {
                for (var j:int = 0; j < n; j++)
                {
                    A[i * n + j] = i + j;
                    B[i * n + j] = i - j;
                }
            }
            for (var p:int = 0; p < n; p++)
            {
                for (var q:int = 0; q < n; q++)
                {
                    C[p * n + q] = A[p * n + q] + B[p * n + q];
                }
            }
            var total:Number = 0;
            for (var k:int = 0; k < elems; k++)
            {
                total = total + C[k];
            }
            __ms = getTimer() - __t0;
            System.output(total + "\n");
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
