// task 13 matrix_mul — expected output: 599995000
// build: amxmlc -swf-version=51 -output prog.swf __13_matrix_mul.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: the plain i, j, k triple loop in that order, on flat row-major
//       Vector.<int>, so the k loop walks a column of B. Reordering would be faster,
//       which is the point.
package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _13_matrix_mul extends Sprite
    {
        public function _13_matrix_mul()
        {
            var n:int = 500;
            var elems:int = n * n;
            var A:Vector.<int> = new Vector.<int>(elems);
            var B:Vector.<int> = new Vector.<int>(elems);
            var C:Vector.<int> = new Vector.<int>(elems);
            for (var i:int = 0; i < n; i++)
            {
                for (var j:int = 0; j < n; j++)
                {
                    A[i * n + j] = (i + j) % 7;
                    B[i * n + j] = (i * j) % 5;
                }
            }
            for (var r:int = 0; r < n; r++)
            {
                for (var c:int = 0; c < n; c++)
                {
                    var sum:int = 0;
                    for (var k:int = 0; k < n; k++)
                    {
                        sum = sum + A[r * n + k] * B[k * n + c];
                    }
                    C[r * n + c] = sum;
                }
            }
            var total:Number = 0;
            for (var e:int = 0; e < elems; e++)
            {
                total = total + C[e];
            }
            System.output(total + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
