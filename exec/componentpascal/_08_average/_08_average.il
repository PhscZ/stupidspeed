// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:26
// from source file <_08_average.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly extern RealStr {}
.assembly '_08_average' {}

// CPmain entry
// CPmain entry
.namespace _08_average
{
.class public sealed _08_average
  {
.field assembly static 	float64	'total'
.field assembly static 	float64	'reading'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	int64	'i'
.field assembly static 	wchar[]	's'

.method	public specialname rtspecialname static void .cctor() il managed
    {
// initialize s
	ldc.i4.s	32
	newarr	wchar
	stsfld	wchar[]	_08_average._08_average::'s'
	ret
//	.maxstack	1
	.locals()
    } // end of .cctor method

// Main entry point
.method	public static void '.CPmain'(string[]) il managed
    {
.entrypoint
.line	48,48:1,6 '_08_average.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	49,49:3,8 '_08_average.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_08_average._08_average::'ss_t0'
.line	50,50:3,15 '_08_average.cp'
	ldc.r8	0
	stsfld	float64	_08_average._08_average::'total'
.line	52,52:3,6 '_08_average.cp'
	ldc.i8	0
	stsfld	int64	_08_average._08_average::'i'
lb1:	// Loop header
.line	53,53:5,35 '_08_average.cp'
	ldsfld	int64	_08_average._08_average::'i'
	ldc.i8	255
	and
	conv.r8
	ldc.r8	256
	div
	stsfld	float64	_08_average._08_average::'reading'
.line	54,54:5,29 '_08_average.cp'
	ldsfld	float64	_08_average._08_average::'total'
	ldsfld	float64	_08_average._08_average::'reading'
	add
	stsfld	float64	_08_average._08_average::'total'
	ldc.i8	99999999
	ldsfld	int64	_08_average._08_average::'i'
	ldc.i8	1
	add.ovf
	dup
	stsfld	int64	_08_average._08_average::'i'
	bge	lb1
lb2:	// Loop trailer
.line	57,57:3,8 '_08_average.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_08_average._08_average::'ss_t1'
.line	58,58:3,32 '_08_average.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	58,58:34,52 '_08_average.cp'
//        Start static call sequence
	ldsfld	int64	_08_average._08_average::'ss_t1'
	ldsfld	int64	_08_average._08_average::'ss_t0'
	sub.ovf
	call	void  _08_average._08_average::'WMs'(int64)
//        End call sequence
	nop
.line	58,58:54,69 '_08_average.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	60,60:3,49 '_08_average.cp'
//        Start static call sequence
	ldsfld	float64	_08_average._08_average::'total'
	ldc.r8	100000000
	div
	ldc.i4.s	9
	ldsfld	wchar[]	_08_average._08_average::'s'
	call	void  [RealStr]RealStr.RealStr::'RealToFixed'(float64,int32,wchar[])
//        End call sequence
	nop
.line	61,61:3,25 '_08_average.cp'
//        Start static call sequence
	ldsfld	wchar[]	_08_average._08_average::'s'
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	61,61:27,42 '_08_average.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	62,62:1,4 '_08_average.cp'
	ret
//	.maxstack	3
	.locals()
    } // end of method .CPmain


// PROCEDURE WMs
.method assembly static void  'WMs'(int64 'x') il managed
    {
.line	27,27:12,15 '_08_average.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	32,32:4,6 '_08_average.cp'
	nop
.line	32,32:7,12 '_08_average.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb4
.line	32,32:18,34 '_08_average.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	32,32:36,42 '_08_average.cp'
	nop
.line	46,46:2,9 '_08_average.cp'
	ret
lb4:
lb3:
.line	33,33:4,10 '_08_average.cp'
	ldc.i4.0
	stloc.1
.line	34,34:4,9 '_08_average.cp'
	nop
.line	34,34:10,15 '_08_average.cp'
	ldarg.0
	ldc.i8	0
	ble	lb6
lb5:	// Loop header
.line	35,35:6,45 '_08_average.cp'
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
.line	36,36:6,19 '_08_average.cp'
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
.line	37,37:6,12 '_08_average.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	34,34:10,15 '_08_average.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb5
lb6:	// Loop exit
.line	39,39:4,14 '_08_average.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	40,40:4,10 '_08_average.cp'
	ldc.i4.0
	stloc.2
.line	40,40:12,18 '_08_average.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	41,41:4,9 '_08_average.cp'
	nop
.line	41,41:10,15 '_08_average.cp'
	ldloc.2
	ldloc.1
	bge	lb10
lb9:	// Loop header
.line	42,42:6,15 '_08_average.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	42,42:17,29 '_08_average.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	42,42:31,40 '_08_average.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	43,43:6,12 '_08_average.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	43,43:14,20 '_08_average.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	41,41:10,15 '_08_average.cp'
	ldloc.2
	ldloc.1
	blt	lb9
lb10:	// Loop exit
.line	45,45:4,24 '_08_average.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	46,46:2,9 '_08_average.cp'
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
// end namespace _08_average
// end output produced by gpcp
