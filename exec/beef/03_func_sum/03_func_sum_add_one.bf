// task 03 func_sum helper — expected output: 100000000
// build: compiled with 03_func_sum.bf, from the source list in sources/beef/03_func_sum/BeefProj.toml
// run:   sources/beef/03_func_sum/out/prog.exe
// note: this is the separate translation unit task 03 asks for. It is not what keeps the
//       call alive -- Beef inlines across source files -- so the call site reaches AddOne
//       through a delegate as well; see the note in 03_func_sum.bf.
// note: `Func` is a plain class holding one static method; the call site is Task.Program, so
//       no using directive is needed for the same-namespace class.

namespace Task;

class Func
{
	public static int64 AddOne(int64 n)
	{
		return n + 1;
	}
}
