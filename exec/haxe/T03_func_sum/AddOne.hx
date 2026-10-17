// task 03 helper — the no-inline requirement needs a second translation unit
// build: compiled automatically, hxcpp emits one C++ file per Haxe class
// note: Haxe has no @:noinline, so the helper is kept out of the caller's module instead;
//       this is the same route as the Fortran, Tcl, Vala and Modula-2 rows. The file is named
//       after the class it holds, which is what Haxe requires.

class AddOne {
    public static function add_one(n:Int):Int {
        return n + 1;
    }
}
