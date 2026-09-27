// task 05 alloc_churn — expected output: 1274991808
// build: amxmlc -swf-version=51 -output prog.swf __05_alloc_churn.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: "allocate 64 bytes" is a ByteArray sized to 64. Storing it in the 256-slot
//       array keeps it reachable and drops the buffer it replaces, so the replaced
//       ByteArrays become garbage for the AVM2 collector -- the same reachability
//       line the C row needs to stop -O2 deleting the allocation.
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;
    import flash.utils.ByteArray;

    public class _05_alloc_churn extends Sprite
    {
        public function _05_alloc_churn()
        {
            var slots:Array = new Array(256);
            for (var s:int = 0; s < 256; s++) { slots[s] = null; }
            var total:int = 0;
            for (var i:int = 0; i < 10000000; i++)
            {
                var buf:ByteArray = new ByteArray();
                buf.length = 64;
                buf[0] = i % 256;
                total = total + buf[0];
                slots[i % 256] = buf;
            }
            System.output(total + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
