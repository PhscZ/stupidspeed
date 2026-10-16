// task 03 helper — the no-inline requirement needs a second module
// build: compiled automatically by `haxe -cp sources/hashlink -main T03_func_sum`
// note: Haxe has no @:noinline, so the helper is kept out of the caller's module instead, the
//       same route as the hxcpp row next door. The file is named after the class it holds,
//       which is what Haxe requires.

class AddOne {
    public static function add_one(n:Int):Int {
        return n + 1;
    }
}
