// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:23
// from source file <_03_func_sum_add_one.cp>

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly '_03_func_sum_add_one' {}

.namespace _03_func_sum_add_one
{
.class public sealed _03_func_sum_add_one
  {
.method	public specialname rtspecialname static void .cctor() il managed
    {
	ret
//	.maxstack	0
	.locals()
    } // end of .cctor method


// PROCEDURE AddOne
.method public static int64 'AddOne'(int64 'n') il managed
    {
.line	10,10:12,18 '_03_func_sum_add_one.cp'
	nop
.line	12,12:4,16 '_03_func_sum_add_one.cp'
	nop
.line	13,13:2,12 '_03_func_sum_add_one.cp'
	ldarg.0
	ldc.i8	1
	add.ovf
	ret
//	.maxstack	2
	.locals()
    } // end of method AddOne
  }

}
// end namespace _03_func_sum_add_one
// end output produced by gpcp
