// task 02 switch_case — expected output: 7500000075000000
// build: amxmlc -swf-version=51 -output prog.swf __02_switch_case.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: the total 7500000075000000 exceeds 2^31, and an AS3 int would silently
//       wrap, so the accumulator is a Number (IEEE double). The value is far below
//       2^53, so the sum is exact and prints without an exponent.
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _02_switch_case extends Sprite
    {
        public function _02_switch_case()
        {
            var acc:Number = 0;
            for (var i:int = 0; i < 100000000; i++)
            {
                switch (i % 4)
                {
                    case 0: acc = acc + 1; break;
                    case 1: acc = acc + i; break;
                    case 2: acc = acc + 2 * i; break;
                    case 3: acc = acc + 3 * i; break;
                }
            }
            System.output(acc + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
