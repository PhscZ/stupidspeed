// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:27
// from source file <_09_fib_recursive.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_09_fib_recursive' {}

// CPmain entry
// CPmain entry
.namespace _09_fib_recursive
{
.class public sealed _09_fib_recursive
  {
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	int64	'ss_r'

.method	public specialname rtspecialname static void .cctor() il managed
    {
	ret
//	.maxstack	0
	.locals()
    } // end of .cctor method

// Main entry point
.method	public static void '.CPmain'(string[]) il managed
    {
.entrypoint
.line	67,67:1,6 '_09_fib_recursive.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	68,68:3,8 '_09_fib_recursive.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_09_fib_recursive._09_fib_recursive::'ss_t0'
.line	69,69:3,18 '_09_fib_recursive.cp'
//        Start static call sequence
	ldc.i4.s	40
	conv.i8
	call	int64 _09_fib_recursive._09_fib_recursive::'Fib'(int64)
//        End call sequence
	stsfld	int64	_09_fib_recursive._09_fib_recursive::'ss_r'
.line	70,70:3,8 '_09_fib_recursive.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_09_fib_recursive._09_fib_recursive::'ss_t1'
.line	71,71:3,32 '_09_fib_recursive.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	71,71:34,52 '_09_fib_recursive.cp'
//        Start static call sequence
	ldsfld	int64	_09_fib_recursive._09_fib_recursive::'ss_t1'
	ldsfld	int64	_09_fib_recursive._09_fib_recursive::'ss_t0'
	sub.ovf
	call	void  _09_fib_recursive._09_fib_recursive::'WMs'(int64)
//        End call sequence
	nop
.line	71,71:54,69 '_09_fib_recursive.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	72,72:3,18 '_09_fib_recursive.cp'
//        Start static call sequence
	ldsfld	int64	_09_fib_recursive._09_fib_recursive::'ss_r'
	call	void  _09_fib_recursive._09_fib_recursive::'WriteLong'(int64)
//        End call sequence
	nop
.line	72,72:20,35 '_09_fib_recursive.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	73,73:1,4 '_09_fib_recursive.cp'
	ret
//	.maxstack	2
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	19,19:12,21 '_09_fib_recursive.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	24,24:4,6 '_09_fib_recursive.cp'
	nop
.line	24,24:7,12 '_09_fib_recursive.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb2
.line	24,24:18,36 '_09_fib_recursive.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	24,24:38,44 '_09_fib_recursive.cp'
	nop
.line	38,38:2,15 '_09_fib_recursive.cp'
	ret
lb2:
lb1:
.line	25,25:4,10 '_09_fib_recursive.cp'
	ldc.i4.0
	stloc.1
.line	26,26:4,9 '_09_fib_recursive.cp'
	nop
.line	26,26:10,15 '_09_fib_recursive.cp'
	ldarg.0
	ldc.i8	0
	ble	lb4
lb3:	// Loop header
.line	27,27:6,45 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb5
	ldc.i8	10
	add
lb5:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	28,28:6,19 '_09_fib_recursive.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb6
	ldc.i8	9
	sub
lb6:
	ldc.i8	10
	div
	starg.s	0
.line	29,29:6,12 '_09_fib_recursive.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	26,26:10,15 '_09_fib_recursive.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb3
lb4:	// Loop exit
.line	31,31:4,14 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	32,32:4,10 '_09_fib_recursive.cp'
	ldc.i4.0
	stloc.2
.line	32,32:12,18 '_09_fib_recursive.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	33,33:4,9 '_09_fib_recursive.cp'
	nop
.line	33,33:10,15 '_09_fib_recursive.cp'
	ldloc.2
	ldloc.1
	bge	lb8
lb7:	// Loop header
.line	34,34:6,15 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	34,34:17,29 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	34,34:31,40 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	35,35:6,12 '_09_fib_recursive.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	35,35:14,20 '_09_fib_recursive.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	33,33:10,15 '_09_fib_recursive.cp'
	ldloc.2
	ldloc.1
	blt	lb7
lb8:	// Loop exit
.line	37,37:4,26 '_09_fib_recursive.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	38,38:2,15 '_09_fib_recursive.cp'
	ret
//	.maxstack	5
	.locals init (
		wchar[]	's',
		int32	'n',
		int32	'k',
		wchar	't')
    } // end of method WriteLong

// PROCEDURE Fib
.method assembly static int64 'Fib'(int64 'n') il managed
    {
.line	40,40:12,15 '_09_fib_recursive.cp'
	nop
.line	42,42:4,6 '_09_fib_recursive.cp'
	nop
.line	42,42:7,12 '_09_fib_recursive.cp'
	ldarg.0
	ldc.i8	2
	bge	lb10
.line	42,42:18,26 '_09_fib_recursive.cp'
	nop
.line	44,44:2,9 '_09_fib_recursive.cp'
	ldarg.0
	ret
lb10:
lb9:
.line	43,43:4,34 '_09_fib_recursive.cp'
	nop
.line	44,44:2,9 '_09_fib_recursive.cp'
//        Start static call sequence
	ldarg.0
	ldc.i8	1
	sub.ovf
	call	int64 _09_fib_recursive._09_fib_recursive::'Fib'(int64)
//        End call sequence
//        Start static call sequence
	ldarg.0
	ldc.i8	2
	sub.ovf
	call	int64 _09_fib_recursive._09_fib_recursive::'Fib'(int64)
//        End call sequence
	add.ovf
	ret
//	.maxstack	3
	.locals()
    } // end of method Fib

// PROCEDURE WMs
.method assembly static void  'WMs'(int64 'x') il managed
    {
.line	46,46:12,15 '_09_fib_recursive.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	51,51:4,6 '_09_fib_recursive.cp'
	nop
.line	51,51:7,12 '_09_fib_recursive.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb12
.line	51,51:18,34 '_09_fib_recursive.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	51,51:36,42 '_09_fib_recursive.cp'
	nop
.line	65,65:2,9 '_09_fib_recursive.cp'
	ret
lb12:
lb11:
.line	52,52:4,10 '_09_fib_recursive.cp'
	ldc.i4.0
	stloc.1
.line	53,53:4,9 '_09_fib_recursive.cp'
	nop
.line	53,53:10,15 '_09_fib_recursive.cp'
	ldarg.0
	ldc.i8	0
	ble	lb14
lb13:	// Loop header
.line	54,54:6,45 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb15
	ldc.i8	10
	add
lb15:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	55,55:6,19 '_09_fib_recursive.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb16
	ldc.i8	9
	sub
lb16:
	ldc.i8	10
	div
	starg.s	0
.line	56,56:6,12 '_09_fib_recursive.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	53,53:10,15 '_09_fib_recursive.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb13
lb14:	// Loop exit
.line	58,58:4,14 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	59,59:4,10 '_09_fib_recursive.cp'
	ldc.i4.0
	stloc.2
.line	59,59:12,18 '_09_fib_recursive.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	60,60:4,9 '_09_fib_recursive.cp'
	nop
.line	60,60:10,15 '_09_fib_recursive.cp'
	ldloc.2
	ldloc.1
	bge	lb18
lb17:	// Loop header
.line	61,61:6,15 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	61,61:17,29 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	61,61:31,40 '_09_fib_recursive.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	62,62:6,12 '_09_fib_recursive.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	62,62:14,20 '_09_fib_recursive.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	60,60:10,15 '_09_fib_recursive.cp'
	ldloc.2
	ldloc.1
	blt	lb17
lb18:	// Loop exit
.line	64,64:4,24 '_09_fib_recursive.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	65,65:2,9 '_09_fib_recursive.cp'
	ret
//	.maxstack	5
	.locals init (
		wchar[]	's',
		int32	'n',
		int32	'k',
		wchar	't')
    } // end of method WMs
  }

}
// end namespace _09_fib_recursive
// end output produced by gpcp
