// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:30
// from source file <_14_file_read.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly extern GPBinFiles {}
.assembly extern GPFiles {}
.assembly '_14_file_read' {}

// CPmain entry
// CPmain entry
.namespace _14_file_read
{
.class public sealed _14_file_read
  {
.field assembly static 	class [GPBinFiles]GPBinFiles.FILE	'f'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	unsigned int8[]	'buf'
.field assembly static 	int64	'total'
.field assembly static 	int32	'got'
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
.line	70,70:1,6 '_14_file_read.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	71,71:3,8 '_14_file_read.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_14_file_read._14_file_read::'ss_t0'
.line	72,72:3,41 '_14_file_read.cp'
//        Start static call sequence
	ldstr	"data.bin"
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	class [GPBinFiles]GPBinFiles.FILE [GPBinFiles]GPBinFiles.GPBinFiles::'openFileRO'(wchar[])
//        End call sequence
	stsfld	class [GPBinFiles]GPBinFiles.FILE	_14_file_read._14_file_read::'f'
.line	74,74:3,5 '_14_file_read.cp'
	nop
.line	74,74:6,13 '_14_file_read.cp'
	ldsfld	class [GPBinFiles]GPBinFiles.FILE	_14_file_read._14_file_read::'f'
	ldnull
	beq	lb2
.line	75,75:5,20 '_14_file_read.cp'
	ldc.i4	1048576
	newarr	unsigned int8
	stsfld	unsigned int8[]	_14_file_read._14_file_read::'buf'
.line	76,76:5,15 '_14_file_read.cp'
	ldc.i8	0
	stsfld	int64	_14_file_read._14_file_read::'total'
.line	78,78:5,9 '_14_file_read.cp'
lb3:	// Loop header
.line	79,79:7,9 '_14_file_read.cp'
	nop
.line	79,79:10,27 '_14_file_read.cp'
//        Start static call sequence
	ldsfld	class [GPBinFiles]GPBinFiles.FILE	_14_file_read._14_file_read::'f'
	call	bool [GPBinFiles]GPBinFiles.GPBinFiles::'EOF'(class [GPBinFiles]GPBinFiles.FILE)
//        End call sequence
	brfalse	lb6
.line	79,79:33,37 '_14_file_read.cp'
	br	lb4
lb6:
lb5:
.line	80,80:7,51 '_14_file_read.cp'
//        Start static call sequence
	ldsfld	class [GPBinFiles]GPBinFiles.FILE	_14_file_read._14_file_read::'f'
	ldsfld	unsigned int8[]	_14_file_read._14_file_read::'buf'
	ldc.i4	1048576
	call	int32 [GPBinFiles]GPBinFiles.GPBinFiles::'readNBytes'(class [GPBinFiles]GPBinFiles.FILE,unsigned int8[],int32)
//        End call sequence
	stsfld	int32	_14_file_read._14_file_read::'got'
.line	81,81:7,9 '_14_file_read.cp'
	nop
.line	81,81:10,18 '_14_file_read.cp'
	ldsfld	int32	_14_file_read._14_file_read::'got'
	ldc.i4.0
	bgt	lb8
.line	81,81:24,28 '_14_file_read.cp'
	br	lb4
lb8:
lb7:
.line	82,82:7,10 '_14_file_read.cp'
	ldsfld	int32	_14_file_read._14_file_read::'got'
	ldc.i4.1
	sub.ovf
	dup
	stloc.0
	ldc.i4.0
	dup
	stsfld	int32	_14_file_read._14_file_read::'i'
	blt	lb10
lb9:	// Loop header
.line	83,83:9,32 '_14_file_read.cp'
	ldsfld	int64	_14_file_read._14_file_read::'total'
	ldsfld	unsigned int8[]	_14_file_read._14_file_read::'buf'
	ldsfld	int32	_14_file_read._14_file_read::'i'
	ldelem.u1
	conv.i8
	add.ovf
	stsfld	int64	_14_file_read._14_file_read::'total'
	ldloc.0
	ldsfld	int32	_14_file_read._14_file_read::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_14_file_read._14_file_read::'i'
	bge	lb9
lb10:	// Loop trailer
	br	lb3
lb4:	// Loop exit
.line	87,87:5,28 '_14_file_read.cp'
//        Start static call sequence
	ldsfld	class [GPBinFiles]GPBinFiles.FILE	_14_file_read._14_file_read::'f'
	call	void  [GPBinFiles]GPBinFiles.GPBinFiles::'CloseFile'(class [GPBinFiles]GPBinFiles.FILE)
//        End call sequence
	nop
.line	89,89:5,10 '_14_file_read.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_14_file_read._14_file_read::'ss_t1'
.line	90,90:5,34 '_14_file_read.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	90,90:36,54 '_14_file_read.cp'
//        Start static call sequence
	ldsfld	int64	_14_file_read._14_file_read::'ss_t1'
	ldsfld	int64	_14_file_read._14_file_read::'ss_t0'
	sub.ovf
	call	void  _14_file_read._14_file_read::'WMs'(int64)
//        End call sequence
	nop
.line	90,90:56,71 '_14_file_read.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	92,92:5,36 '_14_file_read.cp'
//        Start static call sequence
	ldsfld	int64	_14_file_read._14_file_read::'total'
	ldc.i8	4294967295
	and
	call	void  _14_file_read._14_file_read::'WriteLong'(int64)
//        End call sequence
	nop
.line	92,92:38,53 '_14_file_read.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
lb2:
lb1:
// Continuing directly to CLOSE
.line	94,94:1,4 '_14_file_read.cp'
	ret
//	.maxstack	3
	.locals init (int32)
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	28,28:12,21 '_14_file_read.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	33,33:4,6 '_14_file_read.cp'
	nop
.line	33,33:7,12 '_14_file_read.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb12
.line	33,33:18,36 '_14_file_read.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	33,33:38,44 '_14_file_read.cp'
	nop
.line	47,47:2,15 '_14_file_read.cp'
	ret
lb12:
lb11:
.line	34,34:4,10 '_14_file_read.cp'
	ldc.i4.0
	stloc.1
.line	35,35:4,9 '_14_file_read.cp'
	nop
.line	35,35:10,15 '_14_file_read.cp'
	ldarg.0
	ldc.i8	0
	ble	lb14
lb13:	// Loop header
.line	36,36:6,45 '_14_file_read.cp'
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
.line	37,37:6,19 '_14_file_read.cp'
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
.line	38,38:6,12 '_14_file_read.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	35,35:10,15 '_14_file_read.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb13
lb14:	// Loop exit
.line	40,40:4,14 '_14_file_read.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	41,41:4,10 '_14_file_read.cp'
	ldc.i4.0
	stloc.2
.line	41,41:12,18 '_14_file_read.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	42,42:4,9 '_14_file_read.cp'
	nop
.line	42,42:10,15 '_14_file_read.cp'
	ldloc.2
	ldloc.1
	bge	lb18
lb17:	// Loop header
.line	43,43:6,15 '_14_file_read.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	43,43:17,29 '_14_file_read.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	43,43:31,40 '_14_file_read.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	44,44:6,12 '_14_file_read.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	44,44:14,20 '_14_file_read.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	42,42:10,15 '_14_file_read.cp'
	ldloc.2
	ldloc.1
	blt	lb17
lb18:	// Loop exit
.line	46,46:4,26 '_14_file_read.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	47,47:2,15 '_14_file_read.cp'
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
.line	49,49:12,15 '_14_file_read.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	54,54:4,6 '_14_file_read.cp'
	nop
.line	54,54:7,12 '_14_file_read.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb20
.line	54,54:18,34 '_14_file_read.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	54,54:36,42 '_14_file_read.cp'
	nop
.line	68,68:2,9 '_14_file_read.cp'
	ret
lb20:
lb19:
.line	55,55:4,10 '_14_file_read.cp'
	ldc.i4.0
	stloc.1
.line	56,56:4,9 '_14_file_read.cp'
	nop
.line	56,56:10,15 '_14_file_read.cp'
	ldarg.0
	ldc.i8	0
	ble	lb22
lb21:	// Loop header
.line	57,57:6,45 '_14_file_read.cp'
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
.line	58,58:6,19 '_14_file_read.cp'
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
.line	59,59:6,12 '_14_file_read.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	56,56:10,15 '_14_file_read.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb21
lb22:	// Loop exit
.line	61,61:4,14 '_14_file_read.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	62,62:4,10 '_14_file_read.cp'
	ldc.i4.0
	stloc.2
.line	62,62:12,18 '_14_file_read.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	63,63:4,9 '_14_file_read.cp'
	nop
.line	63,63:10,15 '_14_file_read.cp'
	ldloc.2
	ldloc.1
	bge	lb26
lb25:	// Loop header
.line	64,64:6,15 '_14_file_read.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	64,64:17,29 '_14_file_read.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	64,64:31,40 '_14_file_read.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	65,65:6,12 '_14_file_read.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	65,65:14,20 '_14_file_read.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	63,63:10,15 '_14_file_read.cp'
	ldloc.2
	ldloc.1
	blt	lb25
lb26:	// Loop exit
.line	67,67:4,24 '_14_file_read.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	68,68:2,9 '_14_file_read.cp'
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
// end namespace _14_file_read
// end output produced by gpcp
