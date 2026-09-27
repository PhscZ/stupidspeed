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
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _12_matrix_add extends Sprite
    {
        public function _12_matrix_add()
        {
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
            System.output(total + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
