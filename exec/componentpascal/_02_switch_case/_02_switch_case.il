// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:23
// from source file <_02_switch_case.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_02_switch_case' {}

// CPmain entry
// CPmain entry
.namespace _02_switch_case
{
.class public sealed _02_switch_case
  {
.field assembly static 	int64	'acc'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
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
.line	66,66:1,6 '_02_switch_case.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	67,67:3,8 '_02_switch_case.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_02_switch_case._02_switch_case::'ss_t0'
.line	68,68:3,11 '_02_switch_case.cp'
	ldc.i8	0
	stsfld	int64	_02_switch_case._02_switch_case::'acc'
.line	70,70:3,6 '_02_switch_case.cp'
	ldc.i4.0
	stsfld	int32	_02_switch_case._02_switch_case::'i'
lb1:	// Loop header
.line	71,71:5,9 '_02_switch_case.cp'
	ldsfld	int32	_02_switch_case._02_switch_case::'i'
	ldc.i4.3
	and
	stloc.0
	ldloc.0
	switch	( // dispatch table: 4,
	       lb5,
	       lb6,
	       lb7,
	       lb8)
	br	lb4
lb5:
.line	72,72:10,24 '_02_switch_case.cp'
	ldsfld	int64	_02_switch_case._02_switch_case::'acc'
	ldc.i8	1
	add.ovf
	stsfld	int64	_02_switch_case._02_switch_case::'acc'
	br	lb3
lb6:
.line	73,73:10,24 '_02_switch_case.cp'
	ldsfld	int64	_02_switch_case._02_switch_case::'acc'
	ldsfld	int32	_02_switch_case._02_switch_case::'i'
	conv.i8
	add.ovf
	stsfld	int64	_02_switch_case._02_switch_case::'acc'
	br	lb3
lb7:
.line	74,74:10,28 '_02_switch_case.cp'
	ldsfld	int64	_02_switch_case._02_switch_case::'acc'
	ldc.i4.2
	ldsfld	int32	_02_switch_case._02_switch_case::'i'
	mul.ovf
	conv.i8
	add.ovf
	stsfld	int64	_02_switch_case._02_switch_case::'acc'
	br	lb3
lb8:
.line	75,75:10,28 '_02_switch_case.cp'
	ldsfld	int64	_02_switch_case._02_switch_case::'acc'
	ldc.i4.3
	ldsfld	int32	_02_switch_case._02_switch_case::'i'
	mul.ovf
	conv.i8
	add.ovf
	stsfld	int64	_02_switch_case._02_switch_case::'acc'
	br	lb3
lb4:	// Default case
// CaseTrap
	ldloc.0
	call	string [RTS]CP_rts::caseMesg(int32)
	newobj	instance void [mscorlib]System.Exception::.ctor(string)
	throw
lb3:	// Case exit label
	ldc.i4	99999999
	ldsfld	int32	_02_switch_case._02_switch_case::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_02_switch_case._02_switch_case::'i'
	bge	lb1
lb2:	// Loop trailer
.line	79,79:3,8 '_02_switch_case.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_02_switch_case._02_switch_case::'ss_t1'
.line	80,80:3,32 '_02_switch_case.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	80,80:34,52 '_02_switch_case.cp'
//        Start static call sequence
	ldsfld	int64	_02_switch_case._02_switch_case::'ss_t1'
	ldsfld	int64	_02_switch_case._02_switch_case::'ss_t0'
	sub.ovf
	call	void  _02_switch_case._02_switch_case::'WMs'(int64)
//        End call sequence
	nop
.line	80,80:54,69 '_02_switch_case.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	82,82:3,17 '_02_switch_case.cp'
//        Start static call sequence
	ldsfld	int64	_02_switch_case._02_switch_case::'acc'
	call	void  _02_switch_case._02_switch_case::'WriteLong'(int64)
//        End call sequence
	nop
.line	82,82:19,34 '_02_switch_case.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	83,83:1,4 '_02_switch_case.cp'
	ret
//	.maxstack	3
	.locals init (int32)
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	24,24:12,21 '_02_switch_case.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	29,29:4,6 '_02_switch_case.cp'
	nop
.line	29,29:7,12 '_02_switch_case.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb10
.line	29,29:18,36 '_02_switch_case.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	29,29:38,44 '_02_switch_case.cp'
	nop
.line	43,43:2,15 '_02_switch_case.cp'
	ret
lb10:
lb9:
.line	30,30:4,10 '_02_switch_case.cp'
	ldc.i4.0
	stloc.1
.line	31,31:4,9 '_02_switch_case.cp'
	nop
.line	31,31:10,15 '_02_switch_case.cp'
	ldarg.0
	ldc.i8	0
	ble	lb12
lb11:	// Loop header
.line	32,32:6,45 '_02_switch_case.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb13
	ldc.i8	10
	add
lb13:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	33,33:6,19 '_02_switch_case.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb14
	ldc.i8	9
	sub
lb14:
	ldc.i8	10
	div
	starg.s	0
.line	34,34:6,12 '_02_switch_case.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	31,31:10,15 '_02_switch_case.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb11
lb12:	// Loop exit
.line	36,36:4,14 '_02_switch_case.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	37,37:4,10 '_02_switch_case.cp'
	ldc.i4.0
	stloc.2
.line	37,37:12,18 '_02_switch_case.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	38,38:4,9 '_02_switch_case.cp'
	nop
.line	38,38:10,15 '_02_switch_case.cp'
	ldloc.2
	ldloc.1
	bge	lb16
lb15:	// Loop header
.line	39,39:6,15 '_02_switch_case.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	39,39:17,29 '_02_switch_case.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	39,39:31,40 '_02_switch_case.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	40,40:6,12 '_02_switch_case.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	40,40:14,20 '_02_switch_case.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	38,38:10,15 '_02_switch_case.cp'
	ldloc.2
	ldloc.1
	blt	lb15
lb16:	// Loop exit
.line	42,42:4,26 '_02_switch_case.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	43,43:2,15 '_02_switch_case.cp'
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
.line	45,45:12,15 '_02_switch_case.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	50,50:4,6 '_02_switch_case.cp'
	nop
.line	50,50:7,12 '_02_switch_case.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb18
.line	50,50:18,34 '_02_switch_case.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	50,50:36,42 '_02_switch_case.cp'
	nop
.line	64,64:2,9 '_02_switch_case.cp'
	ret
lb18:
lb17:
.line	51,51:4,10 '_02_switch_case.cp'
	ldc.i4.0
	stloc.1
.line	52,52:4,9 '_02_switch_case.cp'
	nop
.line	52,52:10,15 '_02_switch_case.cp'
	ldarg.0
	ldc.i8	0
	ble	lb20
lb19:	// Loop header
.line	53,53:6,45 '_02_switch_case.cp'
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
.line	54,54:6,19 '_02_switch_case.cp'
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
.line	55,55:6,12 '_02_switch_case.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	52,52:10,15 '_02_switch_case.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb19
lb20:	// Loop exit
.line	57,57:4,14 '_02_switch_case.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	58,58:4,10 '_02_switch_case.cp'
	ldc.i4.0
	stloc.2
.line	58,58:12,18 '_02_switch_case.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	59,59:4,9 '_02_switch_case.cp'
	nop
.line	59,59:10,15 '_02_switch_case.cp'
	ldloc.2
	ldloc.1
	bge	lb24
lb23:	// Loop header
.line	60,60:6,15 '_02_switch_case.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	60,60:17,29 '_02_switch_case.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	60,60:31,40 '_02_switch_case.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	61,61:6,12 '_02_switch_case.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	61,61:14,20 '_02_switch_case.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	59,59:10,15 '_02_switch_case.cp'
	ldloc.2
	ldloc.1
	blt	lb23
lb24:	// Loop exit
.line	63,63:4,24 '_02_switch_case.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	64,64:2,9 '_02_switch_case.cp'
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
// end namespace _02_switch_case
// end output produced by gpcp
