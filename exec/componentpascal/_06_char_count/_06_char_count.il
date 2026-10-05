// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:25
// from source file <_06_char_count.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_06_char_count' {}

// CPmain entry
// CPmain entry
.namespace _06_char_count
{
.class public sealed _06_char_count
  {
.field assembly static 	wchar[]	'text'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	wchar[]	'block'
.field assembly static 	int64	'count'
.field assembly static 	int32	'i'
.field assembly static 	int32	'j'
.field assembly static 	int32	'base'

.method	public specialname rtspecialname static void .cctor() il managed
    {
// initialize block
	ldc.i4.s	10
	newarr	wchar
	stsfld	wchar[]	_06_char_count._06_char_count::'block'
	ret
//	.maxstack	1
	.locals()
    } // end of .cctor method

// Main entry point
.method	public static void '.CPmain'(string[]) il managed
    {
.entrypoint
.line	74,74:1,6 '_06_char_count.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	75,75:3,8 '_06_char_count.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_06_char_count._06_char_count::'ss_t0'
.line	76,76:3,18 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.0
	ldc.i4.s	97
	stelem.i2
.line	76,76:20,35 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.1
	ldc.i4.s	98
	stelem.i2
.line	76,76:37,52 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.2
	ldc.i4.s	99
	stelem.i2
.line	76,76:54,69 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.3
	ldc.i4.s	100
	stelem.i2
.line	76,76:71,86 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.4
	ldc.i4.s	101
	stelem.i2
.line	77,77:3,18 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.5
	ldc.i4.s	102
	stelem.i2
.line	77,77:20,35 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.6
	ldc.i4.s	103
	stelem.i2
.line	77,77:37,52 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.7
	ldc.i4.s	104
	stelem.i2
.line	77,77:54,69 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.8
	ldc.i4.s	105
	stelem.i2
.line	77,77:71,86 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldc.i4.s	9
	ldc.i4.s	106
	stelem.i2
.line	79,79:3,22 '_06_char_count.cp'
	ldc.i4	100000000
	newarr	wchar
	stsfld	wchar[]	_06_char_count._06_char_count::'text'
.line	81,81:3,6 '_06_char_count.cp'
	ldc.i4.0
	stsfld	int32	_06_char_count._06_char_count::'i'
lb1:	// Loop header
.line	82,82:5,26 '_06_char_count.cp'
	ldsfld	int32	_06_char_count._06_char_count::'i'
	ldc.i4.s	10
	mul.ovf
	stsfld	int32	_06_char_count._06_char_count::'base'
.line	83,83:5,8 '_06_char_count.cp'
	ldc.i4.0
	stsfld	int32	_06_char_count._06_char_count::'j'
lb3:	// Loop header
.line	84,84:7,33 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'text'
	ldsfld	int32	_06_char_count._06_char_count::'base'
	ldsfld	int32	_06_char_count._06_char_count::'j'
	add.ovf
	ldsfld	wchar[]	_06_char_count._06_char_count::'block'
	ldsfld	int32	_06_char_count._06_char_count::'j'
	ldelem.u2
	stelem.i2
	ldc.i4.s	9
	ldsfld	int32	_06_char_count._06_char_count::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_06_char_count._06_char_count::'j'
	bge	lb3
lb4:	// Loop trailer
	ldc.i4	9999999
	ldsfld	int32	_06_char_count._06_char_count::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_06_char_count._06_char_count::'i'
	bge	lb1
lb2:	// Loop trailer
.line	88,88:3,13 '_06_char_count.cp'
	ldc.i8	0
	stsfld	int64	_06_char_count._06_char_count::'count'
.line	89,89:3,6 '_06_char_count.cp'
	ldc.i4.0
	stsfld	int32	_06_char_count._06_char_count::'i'
lb5:	// Loop header
.line	90,90:5,7 '_06_char_count.cp'
	nop
.line	90,90:8,21 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'text'
	ldsfld	int32	_06_char_count._06_char_count::'i'
	ldelem.u2
	ldc.i4.s	97
	bne.un	lb8
	br	lb7
lb8:
.line	92,92:11,24 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'text'
	ldsfld	int32	_06_char_count._06_char_count::'i'
	ldelem.u2
	ldc.i4.s	101
	bne.un	lb9
	br	lb7
lb9:
.line	94,94:11,24 '_06_char_count.cp'
	ldsfld	wchar[]	_06_char_count._06_char_count::'text'
	ldsfld	int32	_06_char_count._06_char_count::'i'
	ldelem.u2
	ldc.i4.s	104
	bne.un	lb10
.line	95,95:7,17 '_06_char_count.cp'
	ldsfld	int64	_06_char_count._06_char_count::'count'
	ldc.i8	1
	add.ovf
	stsfld	int64	_06_char_count._06_char_count::'count'
	br	lb7
lb10:
lb11:
lb7:
	ldc.i4	99999999
	ldsfld	int32	_06_char_count._06_char_count::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_06_char_count._06_char_count::'i'
	bge	lb5
lb6:	// Loop trailer
.line	101,101:3,8 '_06_char_count.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_06_char_count._06_char_count::'ss_t1'
.line	102,102:3,32 '_06_char_count.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	102,102:34,52 '_06_char_count.cp'
//        Start static call sequence
	ldsfld	int64	_06_char_count._06_char_count::'ss_t1'
	ldsfld	int64	_06_char_count._06_char_count::'ss_t0'
	sub.ovf
	call	void  _06_char_count._06_char_count::'WMs'(int64)
//        End call sequence
	nop
.line	102,102:54,69 '_06_char_count.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	104,104:3,19 '_06_char_count.cp'
//        Start static call sequence
	ldsfld	int64	_06_char_count._06_char_count::'count'
	call	void  _06_char_count._06_char_count::'WriteLong'(int64)
//        End call sequence
	nop
.line	104,104:21,36 '_06_char_count.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	105,105:1,4 '_06_char_count.cp'
	ret
//	.maxstack	4
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	32,32:12,21 '_06_char_count.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	37,37:4,6 '_06_char_count.cp'
	nop
.line	37,37:7,12 '_06_char_count.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb13
.line	37,37:18,36 '_06_char_count.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	37,37:38,44 '_06_char_count.cp'
	nop
.line	51,51:2,15 '_06_char_count.cp'
	ret
lb13:
lb12:
.line	38,38:4,10 '_06_char_count.cp'
	ldc.i4.0
	stloc.1
.line	39,39:4,9 '_06_char_count.cp'
	nop
.line	39,39:10,15 '_06_char_count.cp'
	ldarg.0
	ldc.i8	0
	ble	lb15
lb14:	// Loop header
.line	40,40:6,45 '_06_char_count.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb16
	ldc.i8	10
	add
lb16:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	41,41:6,19 '_06_char_count.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb17
	ldc.i8	9
	sub
lb17:
	ldc.i8	10
	div
	starg.s	0
.line	42,42:6,12 '_06_char_count.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	39,39:10,15 '_06_char_count.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb14
lb15:	// Loop exit
.line	44,44:4,14 '_06_char_count.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	45,45:4,10 '_06_char_count.cp'
	ldc.i4.0
	stloc.2
.line	45,45:12,18 '_06_char_count.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	46,46:4,9 '_06_char_count.cp'
	nop
.line	46,46:10,15 '_06_char_count.cp'
	ldloc.2
	ldloc.1
	bge	lb19
lb18:	// Loop header
.line	47,47:6,15 '_06_char_count.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	47,47:17,29 '_06_char_count.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	47,47:31,40 '_06_char_count.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	48,48:6,12 '_06_char_count.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	48,48:14,20 '_06_char_count.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	46,46:10,15 '_06_char_count.cp'
	ldloc.2
	ldloc.1
	blt	lb18
lb19:	// Loop exit
.line	50,50:4,26 '_06_char_count.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	51,51:2,15 '_06_char_count.cp'
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
.line	53,53:12,15 '_06_char_count.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	58,58:4,6 '_06_char_count.cp'
	nop
.line	58,58:7,12 '_06_char_count.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb21
.line	58,58:18,34 '_06_char_count.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	58,58:36,42 '_06_char_count.cp'
	nop
.line	72,72:2,9 '_06_char_count.cp'
	ret
lb21:
lb20:
.line	59,59:4,10 '_06_char_count.cp'
	ldc.i4.0
	stloc.1
.line	60,60:4,9 '_06_char_count.cp'
	nop
.line	60,60:10,15 '_06_char_count.cp'
	ldarg.0
	ldc.i8	0
	ble	lb23
lb22:	// Loop header
.line	61,61:6,45 '_06_char_count.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb24
	ldc.i8	10
	add
lb24:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	62,62:6,19 '_06_char_count.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb25
	ldc.i8	9
	sub
lb25:
	ldc.i8	10
	div
	starg.s	0
.line	63,63:6,12 '_06_char_count.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	60,60:10,15 '_06_char_count.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb22
lb23:	// Loop exit
.line	65,65:4,14 '_06_char_count.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	66,66:4,10 '_06_char_count.cp'
	ldc.i4.0
	stloc.2
.line	66,66:12,18 '_06_char_count.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	67,67:4,9 '_06_char_count.cp'
	nop
.line	67,67:10,15 '_06_char_count.cp'
	ldloc.2
	ldloc.1
	bge	lb27
lb26:	// Loop header
.line	68,68:6,15 '_06_char_count.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	68,68:17,29 '_06_char_count.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	68,68:31,40 '_06_char_count.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	69,69:6,12 '_06_char_count.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	69,69:14,20 '_06_char_count.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	67,67:10,15 '_06_char_count.cp'
	ldloc.2
	ldloc.1
	blt	lb26
lb27:	// Loop exit
.line	71,71:4,24 '_06_char_count.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	72,72:2,9 '_06_char_count.cp'
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
// end namespace _06_char_count
// end output produced by gpcp
