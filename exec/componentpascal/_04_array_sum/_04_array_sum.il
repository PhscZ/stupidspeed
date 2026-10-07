// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:24
// from source file <_04_array_sum.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_04_array_sum' {}

// CPmain entry
// CPmain entry
.namespace _04_array_sum
{
.class public sealed _04_array_sum
  {
.field assembly static 	int64[]	'data'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	int64	'total'
.field assembly static 	int32	'i'

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
.line	68,68:1,6 '_04_array_sum.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	69,69:3,8 '_04_array_sum.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_04_array_sum._04_array_sum::'ss_t0'
.line	70,70:3,15 '_04_array_sum.cp'
	ldc.i4	1000000
	newarr	int64
	stsfld	int64[]	_04_array_sum._04_array_sum::'data'
.line	72,72:3,6 '_04_array_sum.cp'
	ldc.i4.0
	stsfld	int32	_04_array_sum._04_array_sum::'i'
lb1:	// Loop header
.line	73,73:5,12 '_04_array_sum.cp'
	ldsfld	int64[]	_04_array_sum._04_array_sum::'data'
	ldsfld	int32	_04_array_sum._04_array_sum::'i'
	ldsfld	int32	_04_array_sum._04_array_sum::'i'
	conv.i8
	stelem.i8
	ldc.i4	999999
	ldsfld	int32	_04_array_sum._04_array_sum::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_04_array_sum._04_array_sum::'i'
	bge	lb1
lb2:	// Loop trailer
.line	76,76:3,13 '_04_array_sum.cp'
	ldc.i8	0
	stsfld	int64	_04_array_sum._04_array_sum::'total'
.line	77,77:3,6 '_04_array_sum.cp'
	ldc.i4.0
	stsfld	int32	_04_array_sum._04_array_sum::'i'
lb3:	// Loop header
.line	78,78:5,29 '_04_array_sum.cp'
	ldsfld	int64	_04_array_sum._04_array_sum::'total'
	ldsfld	int64[]	_04_array_sum._04_array_sum::'data'
	ldsfld	int32	_04_array_sum._04_array_sum::'i'
	ldelem.i8
	add.ovf
	stsfld	int64	_04_array_sum._04_array_sum::'total'
	ldc.i4	999999
	ldsfld	int32	_04_array_sum._04_array_sum::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_04_array_sum._04_array_sum::'i'
	bge	lb3
lb4:	// Loop trailer
.line	81,81:3,8 '_04_array_sum.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_04_array_sum._04_array_sum::'ss_t1'
.line	82,82:3,32 '_04_array_sum.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	82,82:34,52 '_04_array_sum.cp'
//        Start static call sequence
	ldsfld	int64	_04_array_sum._04_array_sum::'ss_t1'
	ldsfld	int64	_04_array_sum._04_array_sum::'ss_t0'
	sub.ovf
	call	void  _04_array_sum._04_array_sum::'WMs'(int64)
//        End call sequence
	nop
.line	82,82:54,69 '_04_array_sum.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	84,84:3,19 '_04_array_sum.cp'
//        Start static call sequence
	ldsfld	int64	_04_array_sum._04_array_sum::'total'
	call	void  _04_array_sum._04_array_sum::'WriteLong'(int64)
//        End call sequence
	nop
.line	84,84:21,36 '_04_array_sum.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	85,85:1,4 '_04_array_sum.cp'
	ret
//	.maxstack	3
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	26,26:12,21 '_04_array_sum.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	31,31:4,6 '_04_array_sum.cp'
	nop
.line	31,31:7,12 '_04_array_sum.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb6
.line	31,31:18,36 '_04_array_sum.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	31,31:38,44 '_04_array_sum.cp'
	nop
.line	45,45:2,15 '_04_array_sum.cp'
	ret
lb6:
lb5:
.line	32,32:4,10 '_04_array_sum.cp'
	ldc.i4.0
	stloc.1
.line	33,33:4,9 '_04_array_sum.cp'
	nop
.line	33,33:10,15 '_04_array_sum.cp'
	ldarg.0
	ldc.i8	0
	ble	lb8
lb7:	// Loop header
.line	34,34:6,45 '_04_array_sum.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb9
	ldc.i8	10
	add
lb9:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	35,35:6,19 '_04_array_sum.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb10
	ldc.i8	9
	sub
lb10:
	ldc.i8	10
	div
	starg.s	0
.line	36,36:6,12 '_04_array_sum.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	33,33:10,15 '_04_array_sum.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb7
lb8:	// Loop exit
.line	38,38:4,14 '_04_array_sum.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	39,39:4,10 '_04_array_sum.cp'
	ldc.i4.0
	stloc.2
.line	39,39:12,18 '_04_array_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	40,40:4,9 '_04_array_sum.cp'
	nop
.line	40,40:10,15 '_04_array_sum.cp'
	ldloc.2
	ldloc.1
	bge	lb12
lb11:	// Loop header
.line	41,41:6,15 '_04_array_sum.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	41,41:17,29 '_04_array_sum.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	41,41:31,40 '_04_array_sum.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	42,42:6,12 '_04_array_sum.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	42,42:14,20 '_04_array_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	40,40:10,15 '_04_array_sum.cp'
	ldloc.2
	ldloc.1
	blt	lb11
lb12:	// Loop exit
.line	44,44:4,26 '_04_array_sum.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	45,45:2,15 '_04_array_sum.cp'
	ret
//	.maxstack	5
	.locals init (
		wchar[]	's',
		int32	'n',
		int32	'k',
		wchar	't')
    } // end of method WriteLong

// PROCEDURE WMs
.method assembly static void  'WMs'(int64 'x') il managed
    {
.line	47,47:12,15 '_04_array_sum.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	52,52:4,6 '_04_array_sum.cp'
	nop
.line	52,52:7,12 '_04_array_sum.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb14
.line	52,52:18,34 '_04_array_sum.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	52,52:36,42 '_04_array_sum.cp'
	nop
.line	66,66:2,9 '_04_array_sum.cp'
	ret
lb14:
lb13:
.line	53,53:4,10 '_04_array_sum.cp'
	ldc.i4.0
	stloc.1
.line	54,54:4,9 '_04_array_sum.cp'
	nop
.line	54,54:10,15 '_04_array_sum.cp'
	ldarg.0
	ldc.i8	0
	ble	lb16
lb15:	// Loop header
.line	55,55:6,45 '_04_array_sum.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb17
	ldc.i8	10
	add
lb17:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	56,56:6,19 '_04_array_sum.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb18
	ldc.i8	9
	sub
lb18:
	ldc.i8	10
	div
	starg.s	0
.line	57,57:6,12 '_04_array_sum.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	54,54:10,15 '_04_array_sum.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb15
lb16:	// Loop exit
.line	59,59:4,14 '_04_array_sum.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	60,60:4,10 '_04_array_sum.cp'
	ldc.i4.0
	stloc.2
.line	60,60:12,18 '_04_array_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	61,61:4,9 '_04_array_sum.cp'
	nop
.line	61,61:10,15 '_04_array_sum.cp'
	ldloc.2
	ldloc.1
	bge	lb20
lb19:	// Loop header
.line	62,62:6,15 '_04_array_sum.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	62,62:17,29 '_04_array_sum.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	62,62:31,40 '_04_array_sum.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	63,63:6,12 '_04_array_sum.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	63,63:14,20 '_04_array_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	61,61:10,15 '_04_array_sum.cp'
	ldloc.2
	ldloc.1
	blt	lb19
lb20:	// Loop exit
.line	65,65:4,24 '_04_array_sum.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	66,66:2,9 '_04_array_sum.cp'
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
// end namespace _04_array_sum
// end output produced by gpcp
