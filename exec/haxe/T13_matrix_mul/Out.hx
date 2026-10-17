// Shared stdout/stderr shim for the haxe row.
//
// Why: the js target has no `sys` package and no `Sys` class at all, so
// `Sys.println` and `Sys.stderr()` do not compile there -- the compiler reports
// "Accessing this field requires a system platform (php,neko,cpp,etc.)". The js
// cell runs under node, so its two output paths are node's process.stdout and
// process.stderr streams instead.
//
// `line` takes Dynamic and formats an `haxe.Int64` itself. Seven of the fifteen
// tasks accumulate into an Int64 (the four counters of task 02, the totals of 10
// to 14), and `Sys.println` renders that type differently on nearly every
// target: hxcpp calls its toString, but js prints `{ high : .., low : .. }`,
// neko `{ high => .., low => .. }`, php `[object haxe._Int64.___Int64]` and
// python `haxe._Int64.___Int64( high : .., low : .. )` -- all of them the right
// number in the wrong shape. `haxe.Int64.toStr` is the one call that produces
// the decimal digits everywhere, so it is applied first and the result is
// printed as a plain string.
//
// `err` stays a String on every target: the timing line is built by the caller.

class Out {
    public static function line(v:Dynamic):Void {
        var s = haxe.Int64.isInt64(v) ? haxe.Int64.toStr(cast v) : Std.string(v);
        #if js
        js.Syntax.code("process.stdout.write({0} + \"\\n\")", s);
        #else
        Sys.println(s);
        #end
    }

    public static function err(s:String):Void {
        #if js
        js.Syntax.code("process.stderr.write({0})", s);
        #else
        Sys.stderr().writeString(s);
        #end
    }
}
