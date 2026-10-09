// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:29
// from source file <_12_matrix_add.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_12_matrix_add' {}

// CPmain entry
// CPmain entry
.namespace _12_matrix_add
{
.class public sealed _12_matrix_add
  {
.field assembly static 	int64[][]	'a'
.field assembly static 	int64[][]	'b'
.field assembly static 	int64[][]	'c'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	int64	'total'
.field assembly static 	int32	'i'
.field assembly static 	int32	'j'

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
.line	68,68:1,6 '_12_matrix_add.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	69,69:3,8 '_12_matrix_add.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_12_matrix_add._12_matrix_add::'ss_t0'
.line	70,70:3,15 '_12_matrix_add.cp'
	ldc.i4	1000
	ldc.i4	1000
	stloc.0
	stloc.1
	ldloc.0
	newarr	int64[]
	stloc.2
lb1:
	ldloc.0
	ldc.i4.1
	sub
	stloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	newarr	int64
	stelem.ref
	ldloc.0
	brtrue	lb1
	ldloc.2
	stsfld	int64[][]	_12_matrix_add._12_matrix_add::'a'
.line	71,71:3,15 '_12_matrix_add.cp'
	ldc.i4	1000
	ldc.i4	1000
	stloc.0
	stloc.3
	ldloc.0
	newarr	int64[]
	stloc.2
lb2:
	ldloc.0
	ldc.i4.1
	sub
	stloc.0
	ldloc.2
	ldloc.0
	ldloc.3
	newarr	int64
	stelem.ref
	ldloc.0
	brtrue	lb2
	ldloc.2
	stsfld	int64[][]	_12_matrix_add._12_matrix_add::'b'
.line	72,72:3,15 '_12_matrix_add.cp'
	ldc.i4	1000
	ldc.i4	1000
	stloc.0
	stloc.s	4
	ldloc.0
	newarr	int64[]
	stloc.2
lb3:
	ldloc.0
	ldc.i4.1
	sub
	stloc.0
	ldloc.2
	ldloc.0
	ldloc.s	4
	newarr	int64
	stelem.ref
	ldloc.0
	brtrue	lb3
	ldloc.2
	stsfld	int64[][]	_12_matrix_add._12_matrix_add::'c'
.line	74,74:3,6 '_12_matrix_add.cp'
	ldc.i4.0
	stsfld	int32	_12_matrix_add._12_matrix_add::'i'
lb4:	// Loop header
.line	75,75:5,8 '_12_matrix_add.cp'
	ldc.i4.0
	stsfld	int32	_12_matrix_add._12_matrix_add::'j'
lb6:	// Loop header
.line	76,76:7,14 '_12_matrix_add.cp'
	ldsfld	int64[][]	_12_matrix_add._12_matrix_add::'a'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldelem.ref
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	add.ovf
	conv.i8
	stelem.i8
.line	77,77:7,14 '_12_matrix_add.cp'
	ldsfld	int64[][]	_12_matrix_add._12_matrix_add::'b'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldelem.ref
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	sub.ovf
	conv.i8
	stelem.i8
	ldc.i4	999
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_12_matrix_add._12_matrix_add::'j'
	bge	lb6
lb7:	// Loop trailer
	ldc.i4	999
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_12_matrix_add._12_matrix_add::'i'
	bge	lb4
lb5:	// Loop trailer
.line	81,81:3,6 '_12_matrix_add.cp'
	ldc.i4.0
	stsfld	int32	_12_matrix_add._12_matrix_add::'i'
lb8:	// Loop header
.line	82,82:5,8 '_12_matrix_add.cp'
	ldc.i4.0
	stsfld	int32	_12_matrix_add._12_matrix_add::'j'
lb10:	// Loop header
.line	83,83:7,35 '_12_matrix_add.cp'
	ldsfld	int64[][]	_12_matrix_add._12_matrix_add::'c'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldelem.ref
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldsfld	int64[][]	_12_matrix_add._12_matrix_add::'a'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldelem.ref
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldelem.i8
	ldsfld	int64[][]	_12_matrix_add._12_matrix_add::'b'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldelem.ref
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldelem.i8
	add.ovf
	stelem.i8
	ldc.i4	999
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_12_matrix_add._12_matrix_add::'j'
	bge	lb10
lb11:	// Loop trailer
	ldc.i4	999
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_12_matrix_add._12_matrix_add::'i'
	bge	lb8
lb9:	// Loop trailer
.line	87,87:3,13 '_12_matrix_add.cp'
	ldc.i8	0
	stsfld	int64	_12_matrix_add._12_matrix_add::'total'
.line	88,88:3,6 '_12_matrix_add.cp'
	ldc.i4.0
	stsfld	int32	_12_matrix_add._12_matrix_add::'i'
lb12:	// Loop header
.line	89,89:5,8 '_12_matrix_add.cp'
	ldc.i4.0
	stsfld	int32	_12_matrix_add._12_matrix_add::'j'
lb14:	// Loop header
.line	90,90:7,31 '_12_matrix_add.cp'
	ldsfld	int64	_12_matrix_add._12_matrix_add::'total'
	ldsfld	int64[][]	_12_matrix_add._12_matrix_add::'c'
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldelem.ref
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldelem.i8
	add.ovf
	stsfld	int64	_12_matrix_add._12_matrix_add::'total'
	ldc.i4	999
	ldsfld	int32	_12_matrix_add._12_matrix_add::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_12_matrix_add._12_matrix_add::'j'
	bge	lb14
lb15:	// Loop trailer
	ldc.i4	999
	ldsfld	int32	_12_matrix_add._12_matrix_add::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_12_matrix_add._12_matrix_add::'i'
	bge	lb12
lb13:	// Loop trailer
.line	94,94:3,8 '_12_matrix_add.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_12_matrix_add._12_matrix_add::'ss_t1'
.line	95,95:3,32 '_12_matrix_add.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	95,95:34,52 '_12_matrix_add.cp'
//        Start static call sequence
	ldsfld	int64	_12_matrix_add._12_matrix_add::'ss_t1'
	ldsfld	int64	_12_matrix_add._12_matrix_add::'ss_t0'
	sub.ovf
	call	void  _12_matrix_add._12_matrix_add::'WMs'(int64)
//        End call sequence
	nop
.line	95,95:54,69 '_12_matrix_add.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	97,97:3,19 '_12_matrix_add.cp'
//        Start static call sequence
	ldsfld	int64	_12_matrix_add._12_matrix_add::'total'
	call	void  _12_matrix_add._12_matrix_add::'WriteLong'(int64)
//        End call sequence
	nop
.line	97,97:21,36 '_12_matrix_add.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	98,98:1,4 '_12_matrix_add.cp'
	ret
//	.maxstack	5
	.locals init (
		int32,
		int32,
		int64[][],
		int32,
		int32)
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	26,26:12,21 '_12_matrix_add.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	31,31:4,6 '_12_matrix_add.cp'
	nop
.line	31,31:7,12 '_12_matrix_add.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb17
.line	31,31:18,36 '_12_matrix_add.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	31,31:38,44 '_12_matrix_add.cp'
	nop
.line	45,45:2,15 '_12_matrix_add.cp'
	ret
lb17:
lb16:
.line	32,32:4,10 '_12_matrix_add.cp'
	ldc.i4.0
	stloc.1
.line	33,33:4,9 '_12_matrix_add.cp'
	nop
.line	33,33:10,15 '_12_matrix_add.cp'
	ldarg.0
	ldc.i8	0
	ble	lb19
lb18:	// Loop header
.line	34,34:6,45 '_12_matrix_add.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb20
	ldc.i8	10
	add
lb20:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	35,35:6,19 '_12_matrix_add.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb21
	ldc.i8	9
	sub
lb21:
	ldc.i8	10
	div
	starg.s	0
.line	36,36:6,12 '_12_matrix_add.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	33,33:10,15 '_12_matrix_add.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb18
lb19:	// Loop exit
.line	38,38:4,14 '_12_matrix_add.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	39,39:4,10 '_12_matrix_add.cp'
	ldc.i4.0
	stloc.2
.line	39,39:12,18 '_12_matrix_add.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	40,40:4,9 '_12_matrix_add.cp'
	nop
.line	40,40:10,15 '_12_matrix_add.cp'
	ldloc.2
	ldloc.1
	bge	lb23
lb22:	// Loop header
.line	41,41:6,15 '_12_matrix_add.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	41,41:17,29 '_12_matrix_add.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	41,41:31,40 '_12_matrix_add.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	42,42:6,12 '_12_matrix_add.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	42,42:14,20 '_12_matrix_add.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	40,40:10,15 '_12_matrix_add.cp'
	ldloc.2
	ldloc.1
	blt	lb22
lb23:	// Loop exit
.line	44,44:4,26 '_12_matrix_add.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	45,45:2,15 '_12_matrix_add.cp'
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
.line	47,47:12,15 '_12_matrix_add.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	52,52:4,6 '_12_matrix_add.cp'
	nop
.line	52,52:7,12 '_12_matrix_add.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb25
.line	52,52:18,34 '_12_matrix_add.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	52,52:36,42 '_12_matrix_add.cp'
	nop
.line	66,66:2,9 '_12_matrix_add.cp'
	ret
lb25:
lb24:
.line	53,53:4,10 '_12_matrix_add.cp'
	ldc.i4.0
	stloc.1
.line	54,54:4,9 '_12_matrix_add.cp'
	nop
.line	54,54:10,15 '_12_matrix_add.cp'
	ldarg.0
	ldc.i8	0
	ble	lb27
lb26:	// Loop header
.line	55,55:6,45 '_12_matrix_add.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb28
	ldc.i8	10
	add
lb28:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	56,56:6,19 '_12_matrix_add.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb29
	ldc.i8	9
	sub
lb29:
	ldc.i8	10
	div
	starg.s	0
.line	57,57:6,12 '_12_matrix_add.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	54,54:10,15 '_12_matrix_add.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb26
lb27:	// Loop exit
.line	59,59:4,14 '_12_matrix_add.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	60,60:4,10 '_12_matrix_add.cp'
	ldc.i4.0
	stloc.2
.line	60,60:12,18 '_12_matrix_add.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	61,61:4,9 '_12_matrix_add.cp'
	nop
.line	61,61:10,15 '_12_matrix_add.cp'
	ldloc.2
	ldloc.1
	bge	lb31
lb30:	// Loop header
.line	62,62:6,15 '_12_matrix_add.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	62,62:17,29 '_12_matrix_add.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	62,62:31,40 '_12_matrix_add.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	63,63:6,12 '_12_matrix_add.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	63,63:14,20 '_12_matrix_add.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	61,61:10,15 '_12_matrix_add.cp'
	ldloc.2
	ldloc.1
	blt	lb30
lb31:	// Loop exit
.line	65,65:4,24 '_12_matrix_add.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	66,66:2,9 '_12_matrix_add.cp'
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
// end namespace _12_matrix_add
// end output produced by gpcp
