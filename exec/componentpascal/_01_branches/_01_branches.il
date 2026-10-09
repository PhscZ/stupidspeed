// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:22
// from source file <_01_branches.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_01_branches' {}

// CPmain entry
// CPmain entry
.namespace _01_branches
{
.class public sealed _01_branches
  {
.field assembly static 	int64	'a'
.field assembly static 	int64	'b'
.field assembly static 	int64	'c'
.field assembly static 	int64	'd'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
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
.line	64,64:1,6 '_01_branches.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	65,65:3,8 '_01_branches.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_01_branches._01_branches::'ss_t0'
.line	66,66:3,9 '_01_branches.cp'
	ldc.i8	0
	stsfld	int64	_01_branches._01_branches::'a'
.line	66,66:11,17 '_01_branches.cp'
	ldc.i8	0
	stsfld	int64	_01_branches._01_branches::'b'
.line	66,66:19,25 '_01_branches.cp'
	ldc.i8	0
	stsfld	int64	_01_branches._01_branches::'c'
.line	66,66:27,33 '_01_branches.cp'
	ldc.i8	0
	stsfld	int64	_01_branches._01_branches::'d'
.line	68,68:3,6 '_01_branches.cp'
	ldc.i8	0
	stsfld	int64	_01_branches._01_branches::'i'
lb1:	// Loop header
.line	69,69:5,7 '_01_branches.cp'
	nop
.line	69,69:8,19 '_01_branches.cp'
	ldsfld	int64	_01_branches._01_branches::'i'
	ldc.i8	3
	rem
	dup
	ldc.i8	0
	bge	lb5
	ldc.i8	3
	add
lb5:
	ldc.i8	0
	bne.un	lb4
.line	70,70:7,13 '_01_branches.cp'
	ldsfld	int64	_01_branches._01_branches::'a'
	ldc.i8	1
	add.ovf
	stsfld	int64	_01_branches._01_branches::'a'
	br	lb3
lb4:
.line	71,71:11,22 '_01_branches.cp'
	ldsfld	int64	_01_branches._01_branches::'i'
	ldc.i8	5
	rem
	dup
	ldc.i8	0
	bge	lb7
	ldc.i8	5
	add
lb7:
	ldc.i8	0
	bne.un	lb6
.line	72,72:7,13 '_01_branches.cp'
	ldsfld	int64	_01_branches._01_branches::'b'
	ldc.i8	1
	add.ovf
	stsfld	int64	_01_branches._01_branches::'b'
	br	lb3
lb6:
.line	73,73:11,22 '_01_branches.cp'
	ldsfld	int64	_01_branches._01_branches::'i'
	ldc.i8	7
	rem
	dup
	ldc.i8	0
	bge	lb9
	ldc.i8	7
	add
lb9:
	ldc.i8	0
	bne.un	lb8
.line	74,74:7,13 '_01_branches.cp'
	ldsfld	int64	_01_branches._01_branches::'c'
	ldc.i8	1
	add.ovf
	stsfld	int64	_01_branches._01_branches::'c'
	br	lb3
lb8:
.line	76,76:7,13 '_01_branches.cp'
	ldsfld	int64	_01_branches._01_branches::'d'
	ldc.i8	1
	add.ovf
	stsfld	int64	_01_branches._01_branches::'d'
lb10:
lb3:
	ldc.i8	99999999
	ldsfld	int64	_01_branches._01_branches::'i'
	ldc.i8	1
	add.ovf
	dup
	stsfld	int64	_01_branches._01_branches::'i'
	bge	lb1
lb2:	// Loop trailer
.line	80,80:3,8 '_01_branches.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_01_branches._01_branches::'ss_t1'
.line	81,81:3,32 '_01_branches.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	81,81:34,52 '_01_branches.cp'
//        Start static call sequence
	ldsfld	int64	_01_branches._01_branches::'ss_t1'
	ldsfld	int64	_01_branches._01_branches::'ss_t0'
	sub.ovf
	call	void  _01_branches._01_branches::'WMs'(int64)
//        End call sequence
	nop
.line	81,81:54,69 '_01_branches.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	83,83:3,15 '_01_branches.cp'
//        Start static call sequence
	ldsfld	int64	_01_branches._01_branches::'a'
	call	void  _01_branches._01_branches::'WriteLong'(int64)
//        End call sequence
	nop
.line	83,83:17,35 '_01_branches.cp'
//        Start static call sequence
	ldc.i4.s	32
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	84,84:3,15 '_01_branches.cp'
//        Start static call sequence
	ldsfld	int64	_01_branches._01_branches::'b'
	call	void  _01_branches._01_branches::'WriteLong'(int64)
//        End call sequence
	nop
.line	84,84:17,35 '_01_branches.cp'
//        Start static call sequence
	ldc.i4.s	32
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	85,85:3,15 '_01_branches.cp'
//        Start static call sequence
	ldsfld	int64	_01_branches._01_branches::'c'
	call	void  _01_branches._01_branches::'WriteLong'(int64)
//        End call sequence
	nop
.line	85,85:17,35 '_01_branches.cp'
//        Start static call sequence
	ldc.i4.s	32
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	86,86:3,15 '_01_branches.cp'
//        Start static call sequence
	ldsfld	int64	_01_branches._01_branches::'d'
	call	void  _01_branches._01_branches::'WriteLong'(int64)
//        End call sequence
	nop
.line	86,86:17,32 '_01_branches.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	87,87:1,4 '_01_branches.cp'
	ret
//	.maxstack	3
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	22,22:12,21 '_01_branches.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	27,27:4,6 '_01_branches.cp'
	nop
.line	27,27:7,12 '_01_branches.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb12
.line	27,27:18,36 '_01_branches.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	27,27:38,44 '_01_branches.cp'
	nop
.line	41,41:2,15 '_01_branches.cp'
	ret
lb12:
lb11:
.line	28,28:4,10 '_01_branches.cp'
	ldc.i4.0
	stloc.1
.line	29,29:4,9 '_01_branches.cp'
	nop
.line	29,29:10,15 '_01_branches.cp'
	ldarg.0
	ldc.i8	0
	ble	lb14
lb13:	// Loop header
.line	30,30:6,45 '_01_branches.cp'
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
.line	31,31:6,19 '_01_branches.cp'
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
.line	32,32:6,12 '_01_branches.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	29,29:10,15 '_01_branches.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb13
lb14:	// Loop exit
.line	34,34:4,14 '_01_branches.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	35,35:4,10 '_01_branches.cp'
	ldc.i4.0
	stloc.2
.line	35,35:12,18 '_01_branches.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	36,36:4,9 '_01_branches.cp'
	nop
.line	36,36:10,15 '_01_branches.cp'
	ldloc.2
	ldloc.1
	bge	lb18
lb17:	// Loop header
.line	37,37:6,15 '_01_branches.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	37,37:17,29 '_01_branches.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	37,37:31,40 '_01_branches.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	38,38:6,12 '_01_branches.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	38,38:14,20 '_01_branches.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	36,36:10,15 '_01_branches.cp'
	ldloc.2
	ldloc.1
	blt	lb17
lb18:	// Loop exit
.line	40,40:4,26 '_01_branches.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	41,41:2,15 '_01_branches.cp'
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
.line	43,43:12,15 '_01_branches.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	48,48:4,6 '_01_branches.cp'
	nop
.line	48,48:7,12 '_01_branches.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb20
.line	48,48:18,34 '_01_branches.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	48,48:36,42 '_01_branches.cp'
	nop
.line	62,62:2,9 '_01_branches.cp'
	ret
lb20:
lb19:
.line	49,49:4,10 '_01_branches.cp'
	ldc.i4.0
	stloc.1
.line	50,50:4,9 '_01_branches.cp'
	nop
.line	50,50:10,15 '_01_branches.cp'
	ldarg.0
	ldc.i8	0
	ble	lb22
lb21:	// Loop header
.line	51,51:6,45 '_01_branches.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb23
	ldc.i8	10
	add
lb23:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	52,52:6,19 '_01_branches.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb24
	ldc.i8	9
	sub
lb24:
	ldc.i8	10
	div
	starg.s	0
.line	53,53:6,12 '_01_branches.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	50,50:10,15 '_01_branches.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb21
lb22:	// Loop exit
.line	55,55:4,14 '_01_branches.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	56,56:4,10 '_01_branches.cp'
	ldc.i4.0
	stloc.2
.line	56,56:12,18 '_01_branches.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	57,57:4,9 '_01_branches.cp'
	nop
.line	57,57:10,15 '_01_branches.cp'
	ldloc.2
	ldloc.1
	bge	lb26
lb25:	// Loop header
.line	58,58:6,15 '_01_branches.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	58,58:17,29 '_01_branches.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	58,58:31,40 '_01_branches.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	59,59:6,12 '_01_branches.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	59,59:14,20 '_01_branches.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	57,57:10,15 '_01_branches.cp'
	ldloc.2
	ldloc.1
	blt	lb25
lb26:	// Loop exit
.line	61,61:4,24 '_01_branches.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	62,62:2,9 '_01_branches.cp'
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
// end namespace _01_branches
// end output produced by gpcp
