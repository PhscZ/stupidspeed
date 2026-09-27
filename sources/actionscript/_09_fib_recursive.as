// task 09 fib_recursive — expected output: 102334155
// build: amxmlc -swf-version=51 -output prog.swf __09_fib_recursive.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: fib(40) is about 331 million calls, so this measures the call path. The
//       result 102334155 fits in an int.
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;
    import flash.utils.getTimer;

    public class _09_fib_recursive extends Sprite
    {
        public function _09_fib_recursive()
        {
            System.output(fib(40) + "\n");
            NativeApplication.nativeApplication.exit(0);
        }

        private function fib(n:int):int
        {
            if (n < 2) { return n; }
            return fib(n - 1) + fib(n - 2);
        }
    }
}
