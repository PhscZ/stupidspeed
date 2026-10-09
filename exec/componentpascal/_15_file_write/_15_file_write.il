// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:31
// from source file <_15_file_write.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly extern GPBinFiles {}
.assembly extern GPFiles {}
.assembly '_15_file_write' {}

// CPmain entry
// CPmain entry
.namespace _15_file_write
{
.class public sealed _15_file_write
  {
.field assembly static 	class [GPBinFiles]GPBinFiles.FILE	'f'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	unsigned int8[]	'buf'
.field assembly static 	int64	'written'
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
.line	72,72:1,6 '_15_file_write.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	73,73:3,8 '_15_file_write.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_15_file_write._15_file_write::'ss_t0'
.line	74,74:3,18 '_15_file_write.cp'
	ldc.i4	1048576
	newarr	unsigned int8
	stsfld	unsigned int8[]	_15_file_write._15_file_write::'buf'
.line	75,75:3,6 '_15_file_write.cp'
	ldc.i4.0
	stsfld	int32	_15_file_write._15_file_write::'i'
lb1:	// Loop header
.line	76,76:5,32 '_15_file_write.cp'
	ldsfld	unsigned int8[]	_15_file_write._15_file_write::'buf'
	ldsfld	int32	_15_file_write._15_file_write::'i'
	ldsfld	int32	_15_file_write._15_file_write::'i'
	ldc.i4	255
	and
	conv.ovf.u1
	stelem.i1
	ldc.i4	1048575
	ldsfld	int32	_15_file_write._15_file_write::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_15_file_write._15_file_write::'i'
	bge	lb1
lb2:	// Loop trailer
.line	79,79:3,40 '_15_file_write.cp'
//        Start static call sequence
	ldstr	"out.bin"
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	class [GPBinFiles]GPBinFiles.FILE [GPBinFiles]GPBinFiles.GPBinFiles::'createFile'(wchar[])
//        End call sequence
	stsfld	class [GPBinFiles]GPBinFiles.FILE	_15_file_write._15_file_write::'f'
.line	81,81:3,5 '_15_file_write.cp'
	nop
.line	81,81:6,13 '_15_file_write.cp'
	ldsfld	class [GPBinFiles]GPBinFiles.FILE	_15_file_write._15_file_write::'f'
	ldnull
	beq	lb4
.line	82,82:5,17 '_15_file_write.cp'
	ldc.i8	0
	stsfld	int64	_15_file_write._15_file_write::'written'
.line	83,83:5,8 '_15_file_write.cp'
	ldc.i4.1
	stsfld	int32	_15_file_write._15_file_write::'i'
lb5:	// Loop header
.line	84,84:7,45 '_15_file_write.cp'
//        Start static call sequence
	ldsfld	class [GPBinFiles]GPBinFiles.FILE	_15_file_write._15_file_write::'f'
	ldsfld	unsigned int8[]	_15_file_write._15_file_write::'buf'
	ldc.i4	1048576
	call	void  [GPBinFiles]GPBinFiles.GPBinFiles::'WriteNBytes'(class [GPBinFiles]GPBinFiles.FILE,unsigned int8[],int32)
//        End call sequence
	nop
.line	85,85:7,33 '_15_file_write.cp'
	ldsfld	int64	_15_file_write._15_file_write::'written'
	ldc.i8	1048576
	add.ovf
	stsfld	int64	_15_file_write._15_file_write::'written'
	ldc.i4.s	50
	ldsfld	int32	_15_file_write._15_file_write::'i'
	ldc.i4.1
	add.ovf
	dup
	stsfld	int32	_15_file_write._15_file_write::'i'
	bge	lb5
lb6:	// Loop trailer
.line	87,87:5,28 '_15_file_write.cp'
//        Start static call sequence
	ldsfld	class [GPBinFiles]GPBinFiles.FILE	_15_file_write._15_file_write::'f'
	call	void  [GPBinFiles]GPBinFiles.GPBinFiles::'CloseFile'(class [GPBinFiles]GPBinFiles.FILE)
//        End call sequence
	nop
.line	89,89:5,10 '_15_file_write.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_15_file_write._15_file_write::'ss_t1'
.line	90,90:5,34 '_15_file_write.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	90,90:36,54 '_15_file_write.cp'
//        Start static call sequence
	ldsfld	int64	_15_file_write._15_file_write::'ss_t1'
	ldsfld	int64	_15_file_write._15_file_write::'ss_t0'
	sub.ovf
	call	void  _15_file_write._15_file_write::'WMs'(int64)
//        End call sequence
	nop
.line	90,90:56,71 '_15_file_write.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	92,92:5,23 '_15_file_write.cp'
//        Start static call sequence
	ldsfld	int64	_15_file_write._15_file_write::'written'
	call	void  _15_file_write._15_file_write::'WriteLong'(int64)
//        End call sequence
	nop
.line	92,92:25,40 '_15_file_write.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
lb4:
lb3:
// Continuing directly to CLOSE
.line	94,94:1,4 '_15_file_write.cp'
	ret
//	.maxstack	4
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	30,30:12,21 '_15_file_write.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	35,35:4,6 '_15_file_write.cp'
	nop
.line	35,35:7,12 '_15_file_write.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb8
.line	35,35:18,36 '_15_file_write.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	35,35:38,44 '_15_file_write.cp'
	nop
.line	49,49:2,15 '_15_file_write.cp'
	ret
lb8:
lb7:
.line	36,36:4,10 '_15_file_write.cp'
	ldc.i4.0
	stloc.1
.line	37,37:4,9 '_15_file_write.cp'
	nop
.line	37,37:10,15 '_15_file_write.cp'
	ldarg.0
	ldc.i8	0
	ble	lb10
lb9:	// Loop header
.line	38,38:6,45 '_15_file_write.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb11
	ldc.i8	10
	add
lb11:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	39,39:6,19 '_15_file_write.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb12
	ldc.i8	9
	sub
lb12:
	ldc.i8	10
	div
	starg.s	0
.line	40,40:6,12 '_15_file_write.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	37,37:10,15 '_15_file_write.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb9
lb10:	// Loop exit
.line	42,42:4,14 '_15_file_write.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	43,43:4,10 '_15_file_write.cp'
	ldc.i4.0
	stloc.2
.line	43,43:12,18 '_15_file_write.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	44,44:4,9 '_15_file_write.cp'
	nop
.line	44,44:10,15 '_15_file_write.cp'
	ldloc.2
	ldloc.1
	bge	lb14
lb13:	// Loop header
.line	45,45:6,15 '_15_file_write.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	45,45:17,29 '_15_file_write.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	45,45:31,40 '_15_file_write.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	46,46:6,12 '_15_file_write.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	46,46:14,20 '_15_file_write.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	44,44:10,15 '_15_file_write.cp'
	ldloc.2
	ldloc.1
	blt	lb13
lb14:	// Loop exit
.line	48,48:4,26 '_15_file_write.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	49,49:2,15 '_15_file_write.cp'
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
.line	51,51:12,15 '_15_file_write.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	56,56:4,6 '_15_file_write.cp'
	nop
.line	56,56:7,12 '_15_file_write.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb16
.line	56,56:18,34 '_15_file_write.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	56,56:36,42 '_15_file_write.cp'
	nop
.line	70,70:2,9 '_15_file_write.cp'
	ret
lb16:
lb15:
.line	57,57:4,10 '_15_file_write.cp'
	ldc.i4.0
	stloc.1
.line	58,58:4,9 '_15_file_write.cp'
	nop
.line	58,58:10,15 '_15_file_write.cp'
	ldarg.0
	ldc.i8	0
	ble	lb18
lb17:	// Loop header
.line	59,59:6,45 '_15_file_write.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb19
	ldc.i8	10
	add
lb19:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	60,60:6,19 '_15_file_write.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb20
	ldc.i8	9
	sub
lb20:
	ldc.i8	10
	div
	starg.s	0
.line	61,61:6,12 '_15_file_write.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	58,58:10,15 '_15_file_write.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb17
lb18:	// Loop exit
.line	63,63:4,14 '_15_file_write.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	64,64:4,10 '_15_file_write.cp'
	ldc.i4.0
	stloc.2
.line	64,64:12,18 '_15_file_write.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	65,65:4,9 '_15_file_write.cp'
	nop
.line	65,65:10,15 '_15_file_write.cp'
	ldloc.2
	ldloc.1
	bge	lb22
lb21:	// Loop header
.line	66,66:6,15 '_15_file_write.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	66,66:17,29 '_15_file_write.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	66,66:31,40 '_15_file_write.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	67,67:6,12 '_15_file_write.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	67,67:14,20 '_15_file_write.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	65,65:10,15 '_15_file_write.cp'
	ldloc.2
	ldloc.1
	blt	lb21
lb22:	// Loop exit
.line	69,69:4,24 '_15_file_write.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	70,70:2,9 '_15_file_write.cp'
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
// end namespace _15_file_write
// end output produced by gpcp
