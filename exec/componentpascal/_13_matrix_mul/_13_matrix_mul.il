// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:30
// from source file <_13_matrix_mul.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_13_matrix_mul' {}

// CPmain entry
// CPmain entry
.namespace _13_matrix_mul
{
.class public sealed _13_matrix_mul
  {
.field assembly static 	int64[][]	'a'
.field assembly static 	int64[][]	'b'
.field assembly static 	int64[][]	'c'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	int64	'sum'
.field assembly static 	int64	'total'
.field assembly static 	int32	'i'
.field assembly static 	int32	'j'
.field assembly static 	int32	'k'

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
.line	67,67:1,6 '_13_matrix_mul.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	68,68:3,8 '_13_matrix_mul.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_13_matrix_mul._13_matrix_mul::'ss_t0'
.line	69,69:3,15 '_13_matrix_mul.cp'
	ldc.i4	500
	ldc.i4	500
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
	stsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'a'
.line	70,70:3,15 '_13_matrix_mul.cp'
	ldc.i4	500
	ldc.i4	500
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
	stsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'b'
.line	71,71:3,15 '_13_matrix_mul.cp'
	ldc.i4	500
	ldc.i4	500
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
	stsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'c'
.line	73,73:3,6 '_13_matrix_mul.cp'
	ldc.i4.0
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
lb4:	// Loop header
.line	74,74:5,8 '_13_matrix_mul.cp'
	ldc.i4.0
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
lb6:	// Loop header
.line	75,75:7,14 '_13_matrix_mul.cp'
	ldsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'a'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldelem.ref
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	add.ovf
	ldc.i4.7
	rem
	dup
	ldc.i4.0
	bge	lb8
	ldc.i4.7
	add
lb8:
	conv.i8
	stelem.i8
.line	76,76:7,14 '_13_matrix_mul.cp'
	ldsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'b'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldelem.ref
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	mul.ovf
	ldc.i4.5
	rem
	dup
	ldc.i4.0
	bge	lb9
	ldc.i4.5
	add
lb9:
	conv.i8
	stelem.i8
	ldc.i4	499
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	bge	lb6
lb7:	// Loop trailer
	ldc.i4	499
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	bge	lb4
lb5:	// Loop trailer
.line	80,80:3,6 '_13_matrix_mul.cp'
	ldc.i4.0
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
lb10:	// Loop header
.line	81,81:5,8 '_13_matrix_mul.cp'
	ldc.i4.0
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
lb12:	// Loop header
.line	82,82:7,15 '_13_matrix_mul.cp'
	ldc.i8	0
	stsfld	int64	_13_matrix_mul._13_matrix_mul::'sum'
.line	83,83:7,10 '_13_matrix_mul.cp'
	ldc.i4.0
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'k'
lb14:	// Loop header
.line	84,84:9,39 '_13_matrix_mul.cp'
	ldsfld	int64	_13_matrix_mul._13_matrix_mul::'sum'
	ldsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'a'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldelem.ref
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'k'
	ldelem.i8
	ldsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'b'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'k'
	ldelem.ref
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldelem.i8
	mul.ovf
	add.ovf
	stsfld	int64	_13_matrix_mul._13_matrix_mul::'sum'
	ldc.i4	499
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'k'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'k'
	bge	lb14
lb15:	// Loop trailer
.line	86,86:7,21 '_13_matrix_mul.cp'
	ldsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'c'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldelem.ref
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldsfld	int64	_13_matrix_mul._13_matrix_mul::'sum'
	stelem.i8
	ldc.i4	499
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	bge	lb12
lb13:	// Loop trailer
	ldc.i4	499
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	bge	lb10
lb11:	// Loop trailer
.line	90,90:3,13 '_13_matrix_mul.cp'
	ldc.i8	0
	stsfld	int64	_13_matrix_mul._13_matrix_mul::'total'
.line	91,91:3,6 '_13_matrix_mul.cp'
	ldc.i4.0
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
lb16:	// Loop header
.line	92,92:5,8 '_13_matrix_mul.cp'
	ldc.i4.0
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
lb18:	// Loop header
.line	93,93:7,31 '_13_matrix_mul.cp'
	ldsfld	int64	_13_matrix_mul._13_matrix_mul::'total'
	ldsfld	int64[][]	_13_matrix_mul._13_matrix_mul::'c'
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldelem.ref
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldelem.i8
	add.ovf
	stsfld	int64	_13_matrix_mul._13_matrix_mul::'total'
	ldc.i4	499
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'j'
	bge	lb18
lb19:	// Loop trailer
	ldc.i4	499
	ldsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_13_matrix_mul._13_matrix_mul::'i'
	bge	lb16
lb17:	// Loop trailer
.line	97,97:3,8 '_13_matrix_mul.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_13_matrix_mul._13_matrix_mul::'ss_t1'
.line	98,98:3,32 '_13_matrix_mul.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	98,98:34,52 '_13_matrix_mul.cp'
//        Start static call sequence
	ldsfld	int64	_13_matrix_mul._13_matrix_mul::'ss_t1'
	ldsfld	int64	_13_matrix_mul._13_matrix_mul::'ss_t0'
	sub.ovf
	call	void  _13_matrix_mul._13_matrix_mul::'WMs'(int64)
//        End call sequence
	nop
.line	98,98:54,69 '_13_matrix_mul.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	100,100:3,19 '_13_matrix_mul.cp'
//        Start static call sequence
	ldsfld	int64	_13_matrix_mul._13_matrix_mul::'total'
	call	void  _13_matrix_mul._13_matrix_mul::'WriteLong'(int64)
//        End call sequence
	nop
.line	100,100:21,36 '_13_matrix_mul.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	101,101:1,4 '_13_matrix_mul.cp'
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
.line	25,25:12,21 '_13_matrix_mul.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	30,30:4,6 '_13_matrix_mul.cp'
	nop
.line	30,30:7,12 '_13_matrix_mul.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb21
.line	30,30:18,36 '_13_matrix_mul.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	30,30:38,44 '_13_matrix_mul.cp'
	nop
.line	44,44:2,15 '_13_matrix_mul.cp'
	ret
lb21:
lb20:
.line	31,31:4,10 '_13_matrix_mul.cp'
	ldc.i4.0
	stloc.1
.line	32,32:4,9 '_13_matrix_mul.cp'
	nop
.line	32,32:10,15 '_13_matrix_mul.cp'
	ldarg.0
	ldc.i8	0
	ble	lb23
lb22:	// Loop header
.line	33,33:6,45 '_13_matrix_mul.cp'
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
.line	34,34:6,19 '_13_matrix_mul.cp'
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
.line	35,35:6,12 '_13_matrix_mul.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	32,32:10,15 '_13_matrix_mul.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb22
lb23:	// Loop exit
.line	37,37:4,14 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	38,38:4,10 '_13_matrix_mul.cp'
	ldc.i4.0
	stloc.2
.line	38,38:12,18 '_13_matrix_mul.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	39,39:4,9 '_13_matrix_mul.cp'
	nop
.line	39,39:10,15 '_13_matrix_mul.cp'
	ldloc.2
	ldloc.1
	bge	lb27
lb26:	// Loop header
.line	40,40:6,15 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	40,40:17,29 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	40,40:31,40 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	41,41:6,12 '_13_matrix_mul.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	41,41:14,20 '_13_matrix_mul.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	39,39:10,15 '_13_matrix_mul.cp'
	ldloc.2
	ldloc.1
	blt	lb26
lb27:	// Loop exit
.line	43,43:4,26 '_13_matrix_mul.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	44,44:2,15 '_13_matrix_mul.cp'
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
.line	46,46:12,15 '_13_matrix_mul.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	51,51:4,6 '_13_matrix_mul.cp'
	nop
.line	51,51:7,12 '_13_matrix_mul.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb29
.line	51,51:18,34 '_13_matrix_mul.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	51,51:36,42 '_13_matrix_mul.cp'
	nop
.line	65,65:2,9 '_13_matrix_mul.cp'
	ret
lb29:
lb28:
.line	52,52:4,10 '_13_matrix_mul.cp'
	ldc.i4.0
	stloc.1
.line	53,53:4,9 '_13_matrix_mul.cp'
	nop
.line	53,53:10,15 '_13_matrix_mul.cp'
	ldarg.0
	ldc.i8	0
	ble	lb31
lb30:	// Loop header
.line	54,54:6,45 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb32
	ldc.i8	10
	add
lb32:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	55,55:6,19 '_13_matrix_mul.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb33
	ldc.i8	9
	sub
lb33:
	ldc.i8	10
	div
	starg.s	0
.line	56,56:6,12 '_13_matrix_mul.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	53,53:10,15 '_13_matrix_mul.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb30
lb31:	// Loop exit
.line	58,58:4,14 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	59,59:4,10 '_13_matrix_mul.cp'
	ldc.i4.0
	stloc.2
.line	59,59:12,18 '_13_matrix_mul.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	60,60:4,9 '_13_matrix_mul.cp'
	nop
.line	60,60:10,15 '_13_matrix_mul.cp'
	ldloc.2
	ldloc.1
	bge	lb35
lb34:	// Loop header
.line	61,61:6,15 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	61,61:17,29 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	61,61:31,40 '_13_matrix_mul.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	62,62:6,12 '_13_matrix_mul.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	62,62:14,20 '_13_matrix_mul.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	60,60:10,15 '_13_matrix_mul.cp'
	ldloc.2
	ldloc.1
	blt	lb34
lb35:	// Loop exit
.line	64,64:4,24 '_13_matrix_mul.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	65,65:2,9 '_13_matrix_mul.cp'
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
// end namespace _13_matrix_mul
// end output produced by gpcp
