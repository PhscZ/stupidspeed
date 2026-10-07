// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:26
// from source file <_07_string_append.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_07_string_append' {}

// CPmain entry
// CPmain entry
.namespace _07_string_append
{
.class public sealed _07_string_append
  {
.field assembly static 	wchar[]	'textA'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	wchar[]	'textB'
.field assembly static 	int64	'len'
.field assembly static 	int32	'i'
.field assembly static 	int32	'j'
.field assembly static 	int32	'active'

.method	public specialname rtspecialname static void .cctor() il managed
    {
// initialize textA
	ldc.i4	250001
	newarr	wchar
	stsfld	wchar[]	_07_string_append._07_string_append::'textA'
// initialize textB
	ldc.i4	250001
	newarr	wchar
	stsfld	wchar[]	_07_string_append._07_string_append::'textB'
	ret
//	.maxstack	1
	.locals()
    } // end of .cctor method

// Main entry point
.method	public static void '.CPmain'(string[]) il managed
    {
.entrypoint
.line	73,73:1,6 '_07_string_append.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	74,74:3,8 '_07_string_append.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_07_string_append._07_string_append::'ss_t0'
.line	75,75:3,11 '_07_string_append.cp'
	ldc.i8	0
	stsfld	int64	_07_string_append._07_string_append::'len'
.line	76,76:3,14 '_07_string_append.cp'
	ldc.i4.0
	stsfld	int32	_07_string_append._07_string_append::'active'
.line	77,77:3,17 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textA'
	ldc.i4.0
	ldc.i4.0
	stelem.i2
.line	78,78:3,6 '_07_string_append.cp'
	ldc.i4.1
	stsfld	int32	_07_string_append._07_string_append::'i'
lb1:	// Loop header
.line	79,79:5,7 '_07_string_append.cp'
	nop
.line	79,79:8,18 '_07_string_append.cp'
	ldsfld	int32	_07_string_append._07_string_append::'active'
	ldc.i4.0
	bne.un	lb4
.line	80,80:7,10 '_07_string_append.cp'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	dup
	stloc.0
	ldc.i4.0
	dup
	stsfld	int32	_07_string_append._07_string_append::'j'
	blt	lb6
lb5:	// Loop header
.line	80,80:28,48 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textB'
	ldsfld	int32	_07_string_append._07_string_append::'j'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textA'
	ldsfld	int32	_07_string_append._07_string_append::'j'
	ldelem.u2
	stelem.i2
	ldloc.0
	ldsfld	int32	_07_string_append._07_string_append::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_07_string_append._07_string_append::'j'
	bge	lb5
lb6:	// Loop trailer
.line	81,81:7,24 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textB'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldc.i4.s	120
	stelem.i2
.line	82,82:7,15 '_07_string_append.cp'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	ldc.i8	1
	add.ovf
	stsfld	int64	_07_string_append._07_string_append::'len'
.line	83,83:7,23 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textB'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldc.i4.0
	stelem.i2
.line	84,84:7,18 '_07_string_append.cp'
	ldc.i4.1
	stsfld	int32	_07_string_append._07_string_append::'active'
	br	lb3
lb4:
.line	86,86:7,10 '_07_string_append.cp'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	dup
	stloc.0
	ldc.i4.0
	dup
	stsfld	int32	_07_string_append._07_string_append::'j'
	blt	lb9
lb8:	// Loop header
.line	86,86:28,48 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textA'
	ldsfld	int32	_07_string_append._07_string_append::'j'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textB'
	ldsfld	int32	_07_string_append._07_string_append::'j'
	ldelem.u2
	stelem.i2
	ldloc.0
	ldsfld	int32	_07_string_append._07_string_append::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_07_string_append._07_string_append::'j'
	bge	lb8
lb9:	// Loop trailer
.line	87,87:7,24 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textA'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldc.i4.s	120
	stelem.i2
.line	88,88:7,15 '_07_string_append.cp'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	ldc.i8	1
	add.ovf
	stsfld	int64	_07_string_append._07_string_append::'len'
.line	89,89:7,23 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textA'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldc.i4.0
	stelem.i2
.line	90,90:7,18 '_07_string_append.cp'
	ldc.i4.0
	stsfld	int32	_07_string_append._07_string_append::'active'
lb7:
lb3:
	ldc.i4	250000
	ldsfld	int32	_07_string_append._07_string_append::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_07_string_append._07_string_append::'i'
	bge	lb1
lb2:	// Loop trailer
.line	95,95:3,11 '_07_string_append.cp'
	ldc.i8	0
	stsfld	int64	_07_string_append._07_string_append::'len'
.line	96,96:3,5 '_07_string_append.cp'
	nop
.line	96,96:6,16 '_07_string_append.cp'
	ldsfld	int32	_07_string_append._07_string_append::'active'
	ldc.i4.0
	bne.un	lb11
.line	97,97:5,10 '_07_string_append.cp'
	nop
.line	97,97:11,26 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textA'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldelem.u2
	ldc.i4.0
	beq	lb13
lb12:	// Loop header
.line	97,97:30,38 '_07_string_append.cp'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	ldc.i8	1
	add.ovf
	stsfld	int64	_07_string_append._07_string_append::'len'
.line	97,97:11,26 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textA'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldelem.u2
	ldc.i4.0
	bne.un	lb12
lb13:	// Loop exit
	br	lb10
lb11:
.line	99,99:5,10 '_07_string_append.cp'
	nop
.line	99,99:11,26 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textB'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldelem.u2
	ldc.i4.0
	beq	lb16
lb15:	// Loop header
.line	99,99:30,38 '_07_string_append.cp'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	ldc.i8	1
	add.ovf
	stsfld	int64	_07_string_append._07_string_append::'len'
.line	99,99:11,26 '_07_string_append.cp'
	ldsfld	wchar[]	_07_string_append._07_string_append::'textB'
	ldsfld	int64	_07_string_append._07_string_append::'len'
	conv.ovf.i4
	ldelem.u2
	ldc.i4.0
	bne.un	lb15
lb16:	// Loop exit
lb14:
lb10:
.line	102,102:3,8 '_07_string_append.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_07_string_append._07_string_append::'ss_t1'
.line	103,103:3,32 '_07_string_append.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	103,103:34,52 '_07_string_append.cp'
//        Start static call sequence
	ldsfld	int64	_07_string_append._07_string_append::'ss_t1'
	ldsfld	int64	_07_string_append._07_string_append::'ss_t0'
	sub.ovf
	call	void  _07_string_append._07_string_append::'WMs'(int64)
//        End call sequence
	nop
.line	103,103:54,69 '_07_string_append.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	105,105:3,17 '_07_string_append.cp'
//        Start static call sequence
	ldsfld	int64	_07_string_append._07_string_append::'len'
	call	void  _07_string_append._07_string_append::'WriteLong'(int64)
//        End call sequence
	nop
.line	105,105:19,34 '_07_string_append.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	106,106:1,4 '_07_string_append.cp'
	ret
//	.maxstack	4
	.locals init (int32)
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	31,31:12,21 '_07_string_append.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	36,36:4,6 '_07_string_append.cp'
	nop
.line	36,36:7,12 '_07_string_append.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb18
.line	36,36:18,36 '_07_string_append.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	36,36:38,44 '_07_string_append.cp'
	nop
.line	50,50:2,15 '_07_string_append.cp'
	ret
lb18:
lb17:
.line	37,37:4,10 '_07_string_append.cp'
	ldc.i4.0
	stloc.1
.line	38,38:4,9 '_07_string_append.cp'
	nop
.line	38,38:10,15 '_07_string_append.cp'
	ldarg.0
	ldc.i8	0
	ble	lb20
lb19:	// Loop header
.line	39,39:6,45 '_07_string_append.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb21
	ldc.i8	10
	add
lb21:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	40,40:6,19 '_07_string_append.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb22
	ldc.i8	9
	sub
lb22:
	ldc.i8	10
	div
	starg.s	0
.line	41,41:6,12 '_07_string_append.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	38,38:10,15 '_07_string_append.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb19
lb20:	// Loop exit
.line	43,43:4,14 '_07_string_append.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	44,44:4,10 '_07_string_append.cp'
	ldc.i4.0
	stloc.2
.line	44,44:12,18 '_07_string_append.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	45,45:4,9 '_07_string_append.cp'
	nop
.line	45,45:10,15 '_07_string_append.cp'
	ldloc.2
	ldloc.1
	bge	lb24
lb23:	// Loop header
.line	46,46:6,15 '_07_string_append.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	46,46:17,29 '_07_string_append.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	46,46:31,40 '_07_string_append.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	47,47:6,12 '_07_string_append.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	47,47:14,20 '_07_string_append.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	45,45:10,15 '_07_string_append.cp'
	ldloc.2
	ldloc.1
	blt	lb23
lb24:	// Loop exit
.line	49,49:4,26 '_07_string_append.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	50,50:2,15 '_07_string_append.cp'
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
.line	52,52:12,15 '_07_string_append.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	57,57:4,6 '_07_string_append.cp'
	nop
.line	57,57:7,12 '_07_string_append.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb26
.line	57,57:18,34 '_07_string_append.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	57,57:36,42 '_07_string_append.cp'
	nop
.line	71,71:2,9 '_07_string_append.cp'
	ret
lb26:
lb25:
.line	58,58:4,10 '_07_string_append.cp'
	ldc.i4.0
	stloc.1
.line	59,59:4,9 '_07_string_append.cp'
	nop
.line	59,59:10,15 '_07_string_append.cp'
	ldarg.0
	ldc.i8	0
	ble	lb28
lb27:	// Loop header
.line	60,60:6,45 '_07_string_append.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb29
	ldc.i8	10
	add
lb29:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	61,61:6,19 '_07_string_append.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb30
	ldc.i8	9
	sub
lb30:
	ldc.i8	10
	div
	starg.s	0
.line	62,62:6,12 '_07_string_append.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	59,59:10,15 '_07_string_append.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb27
lb28:	// Loop exit
.line	64,64:4,14 '_07_string_append.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	65,65:4,10 '_07_string_append.cp'
	ldc.i4.0
	stloc.2
.line	65,65:12,18 '_07_string_append.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	66,66:4,9 '_07_string_append.cp'
	nop
.line	66,66:10,15 '_07_string_append.cp'
	ldloc.2
	ldloc.1
	bge	lb32
lb31:	// Loop header
.line	67,67:6,15 '_07_string_append.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	67,67:17,29 '_07_string_append.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	67,67:31,40 '_07_string_append.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	68,68:6,12 '_07_string_append.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	68,68:14,20 '_07_string_append.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	66,66:10,15 '_07_string_append.cp'
	ldloc.2
	ldloc.1
	blt	lb31
lb32:	// Loop exit
.line	70,70:4,24 '_07_string_append.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	71,71:2,9 '_07_string_append.cp'
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
// end namespace _07_string_append
// end output produced by gpcp
