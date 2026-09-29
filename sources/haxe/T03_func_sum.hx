// task 03 func_sum — expected output: 100000000
// build: haxe -cp sources/haxe -main T03_func_sum -cpp temp/haxe/03_func_sum -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/03_func_sum/T03_func_sum.exe
// note: Haxe has no no-inline attribute at all — its metadata list has no NoInline entry, and
//       Haxe only inlines functions the programmer marked `inline`, so there is nothing on the
//       Haxe side to switch off. The risk is the C++ compiler: hxcpp emits one translation unit
//       per Haxe class and g++ -O2 would inline a static method called from the same unit. The
//       helper therefore lives in its own module, AddOne.hx, which hxcpp compiles as a second
//       .cpp file; without link-time optimisation the call cannot be inlined away. Same route
//       as the Fortran, Tcl, Vala and Modula-2 rows.

class T03_func_sum {
    static function main() {
        var value = 0;

        for (i in 0...100000000) {
            value = AddOne.add_one(value);
        }

        Sys.println(value);
    }
}
