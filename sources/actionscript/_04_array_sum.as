// task 04 array_sum — expected output: 499999500000
// build: amxmlc -swf-version=51 -output prog.swf __04_array_sum.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: Vector.<int> is a packed 32-bit array, so the two loops walk contiguous
//       memory. The total 499999500000 exceeds 2^31, so it is a Number.
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _04_array_sum extends Sprite
    {
        public function _04_array_sum()
        {
            var n:int = 1000000;
            var array:Vector.<int> = new Vector.<int>(n);
            for (var i:int = 0; i < n; i++)
            {
                array[i] = i;
            }
            var total:Number = 0;
            for (var j:int = 0; j < n; j++)
            {
                total = total + array[j];
            }
            System.output(total + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
