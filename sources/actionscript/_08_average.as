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
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _08_average extends Sprite
    {
        public function _08_average()
        {
            var total:Number = 0.0;
            for (var i:int = 0; i < 100000000; i++)
            {
                var reading:Number = (i % 256) / 256.0;
                total = total + reading;
            }
            System.output((total / 100000000.0) + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
