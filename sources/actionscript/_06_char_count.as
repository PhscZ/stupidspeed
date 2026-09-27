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
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _06_char_count extends Sprite
    {
        public function _06_char_count()
        {
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
            System.output(count + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
