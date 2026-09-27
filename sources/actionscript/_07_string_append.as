// task 07 string_append — expected output: 1000000
// build: amxmlc -swf-version=51 -output prog.swf __07_string_append.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: AS3 String is immutable, so text + "x" allocates a new string and copies the
//       old one, which is the same quadratic copy the C row's realloc plus strcat does.
//       Left at a million for that reason.
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _07_string_append extends Sprite
    {
        public function _07_string_append()
        {
            var text:String = "";
            for (var i:int = 0; i < 1000000; i++)
            {
                text = text + "x";
            }
            System.output(text.length + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
