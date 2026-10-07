// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:25
// from source file <_05_alloc_churn.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_05_alloc_churn' {}

// CPmain entry
// CPmain entry
.namespace _05_alloc_churn
{
.class public sealed _05_alloc_churn
  {
.field assembly static 	unsigned int8[][]	'slots'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	unsigned int8[]	'buf'
.field assembly static 	int64	'total'
.field assembly static 	int64	'i'

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
.line	74,74:1,6 '_05_alloc_churn.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	75,75:3,8 '_05_alloc_churn.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_05_alloc_churn._05_alloc_churn::'ss_t0'
.line	76,76:3,20 '_05_alloc_churn.cp'
	ldc.i4	256
	newarr	unsigned int8[]
	stsfld	unsigned int8[][]	_05_alloc_churn._05_alloc_churn::'slots'
.line	77,77:3,13 '_05_alloc_churn.cp'
	ldc.i8	0
	stsfld	int64	_05_alloc_churn._05_alloc_churn::'total'
.line	79,79:3,6 '_05_alloc_churn.cp'
	ldc.i8	0
	stsfld	int64	_05_alloc_churn._05_alloc_churn::'i'
lb1:	// Loop header
.line	80,80:5,23 '_05_alloc_churn.cp'
	ldc.i4.s	64
	newarr	unsigned int8
	stsfld	unsigned int8[]	_05_alloc_churn._05_alloc_churn::'buf'
.line	81,81:5,32 '_05_alloc_churn.cp'
	ldsfld	unsigned int8[]	_05_alloc_churn._05_alloc_churn::'buf'
	ldc.i4.0
	ldsfld	int64	_05_alloc_churn._05_alloc_churn::'i'
	ldc.i8	255
	and
	conv.ovf.u1
	stelem.i1
.line	82,82:5,28 '_05_alloc_churn.cp'
	ldsfld	int64	_05_alloc_churn._05_alloc_churn::'total'
	ldsfld	unsigned int8[]	_05_alloc_churn._05_alloc_churn::'buf'
	ldc.i4.0
	ldelem.u1
	conv.i8
	add.ovf
	stsfld	int64	_05_alloc_churn._05_alloc_churn::'total'
.line	83,83:5,35 '_05_alloc_churn.cp'
	ldsfld	unsigned int8[][]	_05_alloc_churn._05_alloc_churn::'slots'
	ldsfld	int64	_05_alloc_churn._05_alloc_churn::'i'
	ldc.i8	255
	and
	conv.ovf.i4
	ldsfld	unsigned int8[]	_05_alloc_churn._05_alloc_churn::'buf'
	stelem.ref
	ldc.i8	9999999
	ldsfld	int64	_05_alloc_churn._05_alloc_churn::'i'
	ldc.i8	1
	add.ovf
	dup
	stsfld	int64	_05_alloc_churn._05_alloc_churn::'i'
	bge	lb1
lb2:	// Loop trailer
.line	86,86:3,8 '_05_alloc_churn.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_05_alloc_churn._05_alloc_churn::'ss_t1'
.line	87,87:3,32 '_05_alloc_churn.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	87,87:34,52 '_05_alloc_churn.cp'
//        Start static call sequence
	ldsfld	int64	_05_alloc_churn._05_alloc_churn::'ss_t1'
	ldsfld	int64	_05_alloc_churn._05_alloc_churn::'ss_t0'
	sub.ovf
	call	void  _05_alloc_churn._05_alloc_churn::'WMs'(int64)
//        End call sequence
	nop
.line	87,87:54,69 '_05_alloc_churn.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	89,89:3,19 '_05_alloc_churn.cp'
//        Start static call sequence
	ldsfld	int64	_05_alloc_churn._05_alloc_churn::'total'
	call	void  _05_alloc_churn._05_alloc_churn::'WriteLong'(int64)
//        End call sequence
	nop
.line	89,89:21,36 '_05_alloc_churn.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	90,90:1,4 '_05_alloc_churn.cp'
	ret
//	.maxstack	4
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	32,32:12,21 '_05_alloc_churn.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	37,37:4,6 '_05_alloc_churn.cp'
	nop
.line	37,37:7,12 '_05_alloc_churn.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb4
.line	37,37:18,36 '_05_alloc_churn.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	37,37:38,44 '_05_alloc_churn.cp'
	nop
.line	51,51:2,15 '_05_alloc_churn.cp'
	ret
lb4:
lb3:
.line	38,38:4,10 '_05_alloc_churn.cp'
	ldc.i4.0
	stloc.1
.line	39,39:4,9 '_05_alloc_churn.cp'
	nop
.line	39,39:10,15 '_05_alloc_churn.cp'
	ldarg.0
	ldc.i8	0
	ble	lb6
lb5:	// Loop header
.line	40,40:6,45 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb7
	ldc.i8	10
	add
lb7:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	41,41:6,19 '_05_alloc_churn.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb8
	ldc.i8	9
	sub
lb8:
	ldc.i8	10
	div
	starg.s	0
.line	42,42:6,12 '_05_alloc_churn.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	39,39:10,15 '_05_alloc_churn.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb5
lb6:	// Loop exit
.line	44,44:4,14 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	45,45:4,10 '_05_alloc_churn.cp'
	ldc.i4.0
	stloc.2
.line	45,45:12,18 '_05_alloc_churn.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	46,46:4,9 '_05_alloc_churn.cp'
	nop
.line	46,46:10,15 '_05_alloc_churn.cp'
	ldloc.2
	ldloc.1
	bge	lb10
lb9:	// Loop header
.line	47,47:6,15 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	47,47:17,29 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	47,47:31,40 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	48,48:6,12 '_05_alloc_churn.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	48,48:14,20 '_05_alloc_churn.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	46,46:10,15 '_05_alloc_churn.cp'
	ldloc.2
	ldloc.1
	blt	lb9
lb10:	// Loop exit
.line	50,50:4,26 '_05_alloc_churn.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	51,51:2,15 '_05_alloc_churn.cp'
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
.line	53,53:12,15 '_05_alloc_churn.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	58,58:4,6 '_05_alloc_churn.cp'
	nop
.line	58,58:7,12 '_05_alloc_churn.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb12
.line	58,58:18,34 '_05_alloc_churn.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	58,58:36,42 '_05_alloc_churn.cp'
	nop
.line	72,72:2,9 '_05_alloc_churn.cp'
	ret
lb12:
lb11:
.line	59,59:4,10 '_05_alloc_churn.cp'
	ldc.i4.0
	stloc.1
.line	60,60:4,9 '_05_alloc_churn.cp'
	nop
.line	60,60:10,15 '_05_alloc_churn.cp'
	ldarg.0
	ldc.i8	0
	ble	lb14
lb13:	// Loop header
.line	61,61:6,45 '_05_alloc_churn.cp'
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
.line	62,62:6,19 '_05_alloc_churn.cp'
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
.line	63,63:6,12 '_05_alloc_churn.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	60,60:10,15 '_05_alloc_churn.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb13
lb14:	// Loop exit
.line	65,65:4,14 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	66,66:4,10 '_05_alloc_churn.cp'
	ldc.i4.0
	stloc.2
.line	66,66:12,18 '_05_alloc_churn.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	67,67:4,9 '_05_alloc_churn.cp'
	nop
.line	67,67:10,15 '_05_alloc_churn.cp'
	ldloc.2
	ldloc.1
	bge	lb18
lb17:	// Loop header
.line	68,68:6,15 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	68,68:17,29 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	68,68:31,40 '_05_alloc_churn.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	69,69:6,12 '_05_alloc_churn.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	69,69:14,20 '_05_alloc_churn.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	67,67:10,15 '_05_alloc_churn.cp'
	ldloc.2
	ldloc.1
	blt	lb17
lb18:	// Loop exit
.line	71,71:4,24 '_05_alloc_churn.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	72,72:2,9 '_05_alloc_churn.cp'
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
// end namespace _05_alloc_churn
// end output produced by gpcp
