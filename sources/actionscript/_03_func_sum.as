// task 03 func_sum — expected output: 100000000
// build: amxmlc -swf-version=51 -output prog.swf __03_func_sum.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: AS3 has no no-inline attribute, but it needs none here: AVM2 is a bytecode
//       VM and a method call is a real call frame unless the JIT chooses to inline it,
//       which the interpreted rows document the same way. addOne is a separate method
//       so the call is not textually folded.
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _03_func_sum extends Sprite
    {
        public function _03_func_sum()
        {
            var value:Number = 0;
            for (var i:int = 0; i < 100000000; i++)
            {
                value = addOne(value);
            }
            System.output(value + "\n");
            NativeApplication.nativeApplication.exit(0);
        }

        private function addOne(n:Number):Number
        {
            return n + 1;
        }
    }
}
