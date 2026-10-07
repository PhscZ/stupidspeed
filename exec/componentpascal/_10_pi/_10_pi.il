// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:28
// from source file <_10_pi.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_10_pi' {}

// CPmain entry
// CPmain entry
.namespace _10_pi
{
.class public sealed _10_pi
  {
.field assembly static 	class _10_pi.Big	'q'
.field assembly static 	class _10_pi.Big	'r'
.field assembly static 	class _10_pi.Big	't'
.field assembly static 	class _10_pi.Big	'u'
.field assembly static 	class _10_pi.Big	'v'
.field assembly static 	class _10_pi.Big	'w'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	int64	'k'
.field assembly static 	int64	'l'
.field assembly static 	int64	'n'
.field assembly static 	int64	'next'
.field assembly static 	int64	'sum'
.field assembly static 	int32	'produced'

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
.line	239,239:1,6 '_10_pi.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	240,240:3,8 '_10_pi.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_10_pi._10_pi::'ss_t0'
.line	241,241:3,9 '_10_pi.cp'
	newobj	instance void  _10_pi.Big::.ctor() 
	stsfld	class _10_pi.Big	_10_pi._10_pi::'q'
.line	241,241:11,17 '_10_pi.cp'
	newobj	instance void  _10_pi.Big::.ctor() 
	stsfld	class _10_pi.Big	_10_pi._10_pi::'r'
.line	241,241:19,25 '_10_pi.cp'
	newobj	instance void  _10_pi.Big::.ctor() 
	stsfld	class _10_pi.Big	_10_pi._10_pi::'t'
.line	241,241:27,33 '_10_pi.cp'
	newobj	instance void  _10_pi.Big::.ctor() 
	stsfld	class _10_pi.Big	_10_pi._10_pi::'u'
.line	241,241:35,41 '_10_pi.cp'
	newobj	instance void  _10_pi.Big::.ctor() 
	stsfld	class _10_pi.Big	_10_pi._10_pi::'v'
.line	241,241:43,49 '_10_pi.cp'
	newobj	instance void  _10_pi.Big::.ctor() 
	stsfld	class _10_pi.Big	_10_pi._10_pi::'w'
.line	243,243:3,13 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldc.i4.1
	conv.i8
	call	void  _10_pi._10_pi::'Set'(class _10_pi.Big,int64)
//        End call sequence
	nop
.line	244,244:3,13 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	ldc.i4.0
	conv.i8
	call	void  _10_pi._10_pi::'Set'(class _10_pi.Big,int64)
//        End call sequence
	nop
.line	245,245:3,13 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'t'
	ldc.i4.1
	conv.i8
	call	void  _10_pi._10_pi::'Set'(class _10_pi.Big,int64)
//        End call sequence
	nop
.line	247,247:3,9 '_10_pi.cp'
	ldc.i8	1
	stsfld	int64	_10_pi._10_pi::'k'
.line	247,247:11,17 '_10_pi.cp'
	ldc.i8	3
	stsfld	int64	_10_pi._10_pi::'l'
.line	247,247:19,25 '_10_pi.cp'
	ldc.i8	3
	stsfld	int64	_10_pi._10_pi::'n'
.line	248,248:3,11 '_10_pi.cp'
	ldc.i8	0
	stsfld	int64	_10_pi._10_pi::'sum'
.line	248,248:13,26 '_10_pi.cp'
	ldc.i4.0
	stsfld	int32	_10_pi._10_pi::'produced'
.line	250,250:3,8 '_10_pi.cp'
	nop
.line	250,250:9,26 '_10_pi.cp'
	ldsfld	int32	_10_pi._10_pi::'produced'
	ldc.i4	1000
	bge	lb2
lb1:	// Loop header
.line	251,251:5,24 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldc.i4.4
	conv.i8
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	252,252:5,20 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	call	void  _10_pi._10_pi::'Add'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	253,253:5,28 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'t'
	ldsfld	int64	_10_pi._10_pi::'n'
	ldc.i8	1
	add.ovf
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	255,255:5,7 '_10_pi.cp'
	nop
.line	255,255:8,23 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	call	int32 _10_pi._10_pi::'Cmp'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	ldc.i4.0
	bge	lb4
.line	257,257:7,21 '_10_pi.cp'
	ldsfld	int64	_10_pi._10_pi::'sum'
	ldsfld	int64	_10_pi._10_pi::'n'
	add.ovf
	stsfld	int64	_10_pi._10_pi::'sum'
.line	258,258:7,20 '_10_pi.cp'
	ldsfld	int32	_10_pi._10_pi::'produced'
	ldc.i4.1
	add.ovf
	stsfld	int32	_10_pi._10_pi::'produced'
.line	260,260:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldc.i4.3
	conv.i8
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	261,261:7,22 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	call	void  _10_pi._10_pi::'Add'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	262,262:7,27 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldc.i4.s	10
	conv.i8
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	263,263:7,40 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'t'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'w'
	call	int64 _10_pi._10_pi::'Quot'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	ldc.i8	10
	ldsfld	int64	_10_pi._10_pi::'n'
	mul.ovf
	sub.ovf
	stsfld	int64	_10_pi._10_pi::'next'
.line	265,265:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'t'
	ldsfld	int64	_10_pi._10_pi::'n'
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	266,266:7,22 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	call	void  _10_pi._10_pi::'Sub'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	267,267:7,27 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	ldc.i4.s	10
	conv.i8
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	268,268:7,27 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldc.i4.s	10
	conv.i8
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	270,270:7,16 '_10_pi.cp'
	ldsfld	int64	_10_pi._10_pi::'next'
	stsfld	int64	_10_pi._10_pi::'n'
	br	lb3
lb4:
.line	273,273:7,34 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldc.i8	7
	ldsfld	int64	_10_pi._10_pi::'k'
	mul.ovf
	ldc.i8	2
	add.ovf
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	274,274:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	ldsfld	int64	_10_pi._10_pi::'l'
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	275,275:7,22 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	call	void  _10_pi._10_pi::'Add'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	276,276:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'t'
	ldsfld	int64	_10_pi._10_pi::'l'
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	277,277:7,31 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'v'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'w'
	call	int64 _10_pi._10_pi::'Quot'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	stsfld	int64	_10_pi._10_pi::'next'
.line	279,279:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldc.i4.2
	conv.i8
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	280,280:7,22 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	call	void  _10_pi._10_pi::'Add'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	281,281:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	ldsfld	int64	_10_pi._10_pi::'l'
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	282,282:7,19 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'r'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'u'
	call	void  _10_pi._10_pi::'Copy'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	283,283:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'q'
	ldsfld	int64	_10_pi._10_pi::'k'
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	284,284:7,26 '_10_pi.cp'
//        Start static call sequence
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'t'
	ldsfld	class _10_pi.Big	_10_pi._10_pi::'t'
	ldsfld	int64	_10_pi._10_pi::'l'
	call	void  _10_pi._10_pi::'MulSmall'(class _10_pi.Big,class _10_pi.Big,int64)
//        End call sequence
	nop
.line	286,286:7,13 '_10_pi.cp'
	ldsfld	int64	_10_pi._10_pi::'k'
	ldc.i8	1
	add.ovf
	stsfld	int64	_10_pi._10_pi::'k'
.line	287,287:7,17 '_10_pi.cp'
	ldsfld	int64	_10_pi._10_pi::'l'
	ldc.i8	2
	add.ovf
	stsfld	int64	_10_pi._10_pi::'l'
.line	288,288:7,16 '_10_pi.cp'
	ldsfld	int64	_10_pi._10_pi::'next'
	stsfld	int64	_10_pi._10_pi::'n'
lb5:
lb3:
.line	250,250:9,26 '_10_pi.cp'
	ldsfld	int32	_10_pi._10_pi::'produced'
	ldc.i4	1000
	blt	lb1
lb2:	// Loop exit
.line	292,292:3,8 '_10_pi.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_10_pi._10_pi::'ss_t1'
.line	293,293:3,32 '_10_pi.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	293,293:34,52 '_10_pi.cp'
//        Start static call sequence
	ldsfld	int64	_10_pi._10_pi::'ss_t1'
	ldsfld	int64	_10_pi._10_pi::'ss_t0'
	sub.ovf
	call	void  _10_pi._10_pi::'WMs'(int64)
//        End call sequence
	nop
.line	293,293:54,69 '_10_pi.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	295,295:3,17 '_10_pi.cp'
//        Start static call sequence
	ldsfld	int64	_10_pi._10_pi::'sum'
	call	void  _10_pi._10_pi::'WriteLong'(int64)
//        End call sequence
	nop
.line	295,295:19,34 '_10_pi.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	296,296:1,4 '_10_pi.cp'
	ret
//	.maxstack	4
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	44,44:12,21 '_10_pi.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	49,49:4,6 '_10_pi.cp'
	nop
.line	49,49:7,12 '_10_pi.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb7
.line	49,49:18,36 '_10_pi.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	49,49:38,44 '_10_pi.cp'
	nop
.line	63,63:2,15 '_10_pi.cp'
	ret
lb7:
lb6:
.line	50,50:4,10 '_10_pi.cp'
	ldc.i4.0
	stloc.1
.line	51,51:4,9 '_10_pi.cp'
	nop
.line	51,51:10,15 '_10_pi.cp'
	ldarg.0
	ldc.i8	0
	ble	lb9
lb8:	// Loop header
.line	52,52:6,45 '_10_pi.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb10
	ldc.i8	10
	add
lb10:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	53,53:6,19 '_10_pi.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb11
	ldc.i8	9
	sub
lb11:
	ldc.i8	10
	div
	starg.s	0
.line	54,54:6,12 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	51,51:10,15 '_10_pi.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb8
lb9:	// Loop exit
.line	56,56:4,14 '_10_pi.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	57,57:4,10 '_10_pi.cp'
	ldc.i4.0
	stloc.2
.line	57,57:12,18 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	58,58:4,9 '_10_pi.cp'
	nop
.line	58,58:10,15 '_10_pi.cp'
	ldloc.2
	ldloc.1
	bge	lb13
lb12:	// Loop header
.line	59,59:6,15 '_10_pi.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	59,59:17,29 '_10_pi.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	59,59:31,40 '_10_pi.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	60,60:6,12 '_10_pi.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	60,60:14,20 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	58,58:10,15 '_10_pi.cp'
	ldloc.2
	ldloc.1
	blt	lb12
lb13:	// Loop exit
.line	62,62:4,26 '_10_pi.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	63,63:2,15 '_10_pi.cp'
	ret
//	.maxstack	5
	.locals init (
		wchar[]	's',
		int32	'i',
		int32	'k',
		wchar	't')
    } // end of method WriteLong

// PROCEDURE Trim
.method assembly static void  'Trim'(class _10_pi.Big 'x') il managed
    {
.line	65,65:12,16 '_10_pi.cp'
	nop
.line	67,67:4,9 '_10_pi.cp'
	nop
.line	67,67:10,43 '_10_pi.cp'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.0
	ble	lb15
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.1
	sub.ovf
	ldelem.i8
	ldc.i8	0
	bne.un	lb15
lb14:	// Loop header
.line	67,67:47,55 '_10_pi.cp'
	ldarg.0
	dup
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.1
	sub.ovf
	stfld	int32	_10_pi.Big::'n'
.line	67,67:10,43 '_10_pi.cp'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.0
	ble	lb16
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.1
	sub.ovf
	ldelem.i8
	ldc.i8	0
	beq	lb14
lb16:
lb15:	// Loop exit
.line	68,68:4,6 '_10_pi.cp'
	nop
.line	68,68:7,14 '_10_pi.cp'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.0
	bne.un	lb18
.line	68,68:20,25 '_10_pi.cp'
	ldarg.0
	ldc.i4.0
	stfld	bool	_10_pi.Big::'neg'
lb18:
lb17:
.line	69,69:2,10 '_10_pi.cp'
	ret
//	.maxstack	3
	.locals()
    } // end of method Trim

// PROCEDURE Set
.method assembly static void  'Set'( 
		class _10_pi.Big	'x',
		int64	'v') il managed
    {
.line	71,71:12,15 '_10_pi.cp'
	nop
.line	73,73:4,12 '_10_pi.cp'
	ldarg.0
	ldc.i4.0
	stfld	int32	_10_pi.Big::'n'
.line	73,73:14,19 '_10_pi.cp'
	ldarg.0
	ldc.i4.0
	stfld	bool	_10_pi.Big::'neg'
.line	74,74:4,9 '_10_pi.cp'
	nop
.line	74,74:10,15 '_10_pi.cp'
	ldarg.1
	ldc.i8	0
	ble	lb20
lb19:	// Loop header
.line	75,75:6,31 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldarg.1
	ldc.i8	1000000000
	rem
	dup
	ldc.i8	0
	bge	lb21
	ldc.i8	1000000000
	add
lb21:
	stelem.i8
.line	76,76:6,14 '_10_pi.cp'
	ldarg.0
	dup
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.1
	add.ovf
	stfld	int32	_10_pi.Big::'n'
.line	77,77:6,21 '_10_pi.cp'
	ldarg.1
	dup
	ldc.i8	0
	bge	lb22
	ldc.i8	999999999
	sub
lb22:
	ldc.i8	1000000000
	div
	starg.s	1
.line	74,74:10,15 '_10_pi.cp'
	ldarg.1
	ldc.i8	0
	bgt	lb19
lb20:	// Loop exit
.line	79,79:2,9 '_10_pi.cp'
	ret
//	.maxstack	5
	.locals()
    } // end of method Set

// PROCEDURE Copy
.method assembly static void  'Copy'( 
		class _10_pi.Big	'dst',
		class _10_pi.Big	'src') il managed
    {
.line	81,81:12,16 '_10_pi.cp'
	nop
.line	84,84:4,7 '_10_pi.cp'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.1
	sub.ovf
	dup
	stloc.1
	ldc.i4.0
	dup
	stloc.0
	blt	lb24
lb23:	// Loop header
.line	84,84:31,57 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	stelem.i8
	ldloc.1
	ldloc.0
	ldc.i4.1
	add.ovf
	dup
	stloc.0
	bge	lb23
lb24:	// Loop trailer
.line	85,85:4,18 '_10_pi.cp'
	ldarg.0
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	stfld	int32	_10_pi.Big::'n'
.line	86,86:4,22 '_10_pi.cp'
	ldarg.0
	ldarg.1
	ldfld	bool	_10_pi.Big::'neg'
	stfld	bool	_10_pi.Big::'neg'
.line	87,87:2,10 '_10_pi.cp'
	ret
//	.maxstack	4
	.locals init (
		int32	'i',
		int32)
    } // end of method Copy

// PROCEDURE CmpMag
.method assembly static int32 'CmpMag'( 
		class _10_pi.Big	'a',
		class _10_pi.Big	'b') il managed
    {
.line	89,89:12,18 '_10_pi.cp'
	nop
.line	92,92:4,6 '_10_pi.cp'
	nop
.line	92,92:7,16 '_10_pi.cp'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	beq	lb26
.line	93,93:6,8 '_10_pi.cp'
	nop
.line	93,93:9,18 '_10_pi.cp'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	bge	lb28
.line	93,93:24,30 '_10_pi.cp'
	nop
.line	103,103:2,12 '_10_pi.cp'
	ldc.i4.M1
	ret
lb28:
.line	93,93:39,47 '_10_pi.cp'
	nop
.line	103,103:2,12 '_10_pi.cp'
	ldc.i4.1
	ret
lb29:
lb27:
lb26:
lb25:
.line	95,95:4,12 '_10_pi.cp'
	ldarg.0
	ldfld	int32	_10_pi.Big::'n'
	stloc.0
.line	96,96:4,9 '_10_pi.cp'
	nop
.line	96,96:10,15 '_10_pi.cp'
	ldloc.0
	ldc.i4.0
	ble	lb31
lb30:	// Loop header
.line	97,97:6,12 '_10_pi.cp'
	ldloc.0
	ldc.i4.1
	sub.ovf
	stloc.0
.line	98,98:6,8 '_10_pi.cp'
	nop
.line	98,98:9,30 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	beq	lb33
.line	99,99:8,10 '_10_pi.cp'
	nop
.line	99,99:11,32 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	bge	lb35
.line	99,99:38,44 '_10_pi.cp'
	nop
.line	103,103:2,12 '_10_pi.cp'
	ldc.i4.M1
	ret
lb35:
.line	99,99:53,61 '_10_pi.cp'
	nop
.line	103,103:2,12 '_10_pi.cp'
	ldc.i4.1
	ret
lb36:
lb34:
lb33:
lb32:
.line	96,96:10,15 '_10_pi.cp'
	ldloc.0
	ldc.i4.0
	bgt	lb30
lb31:	// Loop exit
.line	102,102:4,12 '_10_pi.cp'
	nop
.line	103,103:2,12 '_10_pi.cp'
	ldc.i4.0
	ret
//	.maxstack	3
	.locals init (int32	'i')
    } // end of method CmpMag

// PROCEDURE Cmp
.method assembly static int32 'Cmp'( 
		class _10_pi.Big	'a',
		class _10_pi.Big	'b') il managed
    {
.line	105,105:12,15 '_10_pi.cp'
	nop
.line	108,108:4,6 '_10_pi.cp'
	nop
.line	108,108:7,20 '_10_pi.cp'
	ldarg.0
	ldfld	bool	_10_pi.Big::'neg'
	ldarg.1
	ldfld	bool	_10_pi.Big::'neg'
	beq	lb38
.line	109,109:6,8 '_10_pi.cp'
	nop
.line	109,109:9,14 '_10_pi.cp'
	ldarg.0
	ldfld	bool	_10_pi.Big::'neg'
	brfalse	lb40
.line	109,109:20,26 '_10_pi.cp'
	nop
.line	113,113:2,9 '_10_pi.cp'
	ldc.i4.M1
	ret
lb40:
.line	109,109:35,43 '_10_pi.cp'
	nop
.line	113,113:2,9 '_10_pi.cp'
	ldc.i4.1
	ret
lb41:
lb39:
lb38:
lb37:
.line	111,111:4,21 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.1
	call	int32 _10_pi._10_pi::'CmpMag'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	stloc.0
.line	112,112:4,6 '_10_pi.cp'
	nop
.line	112,112:7,12 '_10_pi.cp'
	ldarg.0
	ldfld	bool	_10_pi.Big::'neg'
	brfalse	lb43
.line	112,112:18,27 '_10_pi.cp'
	nop
.line	113,113:2,9 '_10_pi.cp'
	ldloc.0
	neg
	ret
lb43:
.line	112,112:33,41 '_10_pi.cp'
	nop
.line	113,113:2,9 '_10_pi.cp'
	ldloc.0
	ret
lb44:
lb42:
//	.maxstack	2
	.locals init (int32	'c')
    } // end of method Cmp

// PROCEDURE AddMag
.method assembly static void  'AddMag'( 
		class _10_pi.Big	'r',
		class _10_pi.Big	'a',
		class _10_pi.Big	'b') il managed
    {
.line	116,116:12,18 '_10_pi.cp'
	nop
.line	120,120:4,6 '_10_pi.cp'
	nop
.line	120,120:7,16 '_10_pi.cp'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	ldarg.2
	ldfld	int32	_10_pi.Big::'n'
	ble	lb46
.line	120,120:22,34 '_10_pi.cp'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	stloc.1
	br	lb45
lb46:
.line	120,120:40,52 '_10_pi.cp'
	ldarg.2
	ldfld	int32	_10_pi.Big::'n'
	stloc.1
lb47:
lb45:
.line	121,121:4,14 '_10_pi.cp'
	ldc.i8	0
	stloc.3
.line	122,122:4,7 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	dup
	stloc.s	4
	ldc.i4.0
	dup
	stloc.0
	blt	lb49
lb48:	// Loop header
.line	123,123:6,16 '_10_pi.cp'
	ldloc.3
	stloc.2
.line	124,124:6,8 '_10_pi.cp'
	nop
.line	124,124:9,16 '_10_pi.cp'
	ldloc.0
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	bge	lb51
.line	124,124:22,40 '_10_pi.cp'
	ldloc.2
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	add.ovf
	stloc.2
lb51:
lb50:
.line	125,125:6,8 '_10_pi.cp'
	nop
.line	125,125:9,16 '_10_pi.cp'
	ldloc.0
	ldarg.2
	ldfld	int32	_10_pi.Big::'n'
	bge	lb53
.line	125,125:22,40 '_10_pi.cp'
	ldloc.2
	ldarg.2
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	add.ovf
	stloc.2
lb53:
lb52:
.line	126,126:6,8 '_10_pi.cp'
	nop
.line	126,126:9,18 '_10_pi.cp'
	ldloc.2
	ldc.i8	1000000000
	blt	lb55
.line	126,126:24,37 '_10_pi.cp'
	ldloc.2
	ldc.i8	1000000000
	sub.ovf
	stloc.2
.line	126,126:39,49 '_10_pi.cp'
	ldc.i8	1
	stloc.3
	br	lb54
lb55:
.line	126,126:55,65 '_10_pi.cp'
	ldc.i8	0
	stloc.3
lb56:
lb54:
.line	127,127:6,20 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldloc.2
	stelem.i8
	ldloc.s	4
	ldloc.0
	ldc.i4.1
	add.ovf
	dup
	stloc.0
	bge	lb48
lb49:	// Loop trailer
.line	129,129:4,26 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.1
	ldloc.3
	stelem.i8
.line	130,130:4,6 '_10_pi.cp'
	nop
.line	130,130:7,16 '_10_pi.cp'
	ldloc.3
	ldc.i8	0
	beq	lb58
.line	130,130:22,38 '_10_pi.cp'
	ldarg.0
	ldloc.1
	ldc.i4.1
	add.ovf
	stfld	int32	_10_pi.Big::'n'
	br	lb57
lb58:
.line	130,130:44,56 '_10_pi.cp'
	ldarg.0
	ldloc.1
	stfld	int32	_10_pi.Big::'n'
lb59:
lb57:
.line	131,131:4,9 '_10_pi.cp'
	ldarg.0
	ldc.i4.0
	stfld	bool	_10_pi.Big::'neg'
.line	132,132:2,12 '_10_pi.cp'
	ret
//	.maxstack	3
	.locals init (
		int32	'i',
		int32	'count',
		int64	's',
		int64	'carry',
		int32)
    } // end of method AddMag

// PROCEDURE SubMag
.method assembly static void  'SubMag'( 
		class _10_pi.Big	'r',
		class _10_pi.Big	'a',
		class _10_pi.Big	'b') il managed
    {
.line	135,135:12,18 '_10_pi.cp'
	nop
.line	139,139:4,15 '_10_pi.cp'
	ldc.i8	0
	stloc.2
.line	140,140:4,7 '_10_pi.cp'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.1
	sub.ovf
	dup
	stloc.3
	ldc.i4.0
	dup
	stloc.0
	blt	lb61
lb60:	// Loop header
.line	141,141:6,8 '_10_pi.cp'
	nop
.line	141,141:9,16 '_10_pi.cp'
	ldloc.0
	ldarg.2
	ldfld	int32	_10_pi.Big::'n'
	bge	lb63
.line	141,141:22,46 '_10_pi.cp'
	ldarg.2
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	ldloc.2
	add.ovf
	stloc.1
	br	lb62
lb63:
.line	141,141:52,64 '_10_pi.cp'
	ldloc.2
	stloc.1
lb64:
lb62:
.line	142,142:6,8 '_10_pi.cp'
	nop
.line	142,142:9,24 '_10_pi.cp'
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	ldloc.1
	blt	lb66
.line	143,143:8,35 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	ldloc.1
	sub.ovf
	stelem.i8
.line	143,143:37,48 '_10_pi.cp'
	ldc.i8	0
	stloc.2
	br	lb65
lb66:
.line	145,145:8,42 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	ldc.i8	1000000000
	add.ovf
	ldloc.1
	sub.ovf
	stelem.i8
.line	145,145:44,55 '_10_pi.cp'
	ldc.i8	1
	stloc.2
lb67:
lb65:
	ldloc.3
	ldloc.0
	ldc.i4.1
	add.ovf
	dup
	stloc.0
	bge	lb60
lb61:	// Loop trailer
.line	148,148:4,14 '_10_pi.cp'
	ldarg.0
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	stfld	int32	_10_pi.Big::'n'
.line	149,149:4,9 '_10_pi.cp'
	ldarg.0
	ldc.i4.0
	stfld	bool	_10_pi.Big::'neg'
.line	150,150:4,11 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	call	void  _10_pi._10_pi::'Trim'(class _10_pi.Big)
//        End call sequence
	nop
.line	151,151:2,12 '_10_pi.cp'
	ret
//	.maxstack	4
	.locals init (
		int32	'i',
		int64	'bi',
		int64	'borrow',
		int32)
    } // end of method SubMag

// PROCEDURE Add
.method assembly static void  'Add'( 
		class _10_pi.Big	'r',
		class _10_pi.Big	'a',
		class _10_pi.Big	'b') il managed
    {
.line	153,153:12,15 '_10_pi.cp'
	nop
.line	156,156:4,15 '_10_pi.cp'
	ldarg.1
	ldfld	bool	_10_pi.Big::'neg'
	stloc.0
.line	156,156:17,28 '_10_pi.cp'
	ldarg.2
	ldfld	bool	_10_pi.Big::'neg'
	stloc.1
.line	157,157:4,6 '_10_pi.cp'
	nop
.line	157,157:7,14 '_10_pi.cp'
	ldloc.0
	ldloc.1
	bne.un	lb69
.line	158,158:6,21 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.1
	ldarg.2
	call	void  _10_pi._10_pi::'AddMag'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	158,158:23,34 '_10_pi.cp'
	ldarg.0
	ldloc.0
	stfld	bool	_10_pi.Big::'neg'
	br	lb68
lb69:
.line	159,159:10,27 '_10_pi.cp'
//        Start static call sequence
	ldarg.1
	ldarg.2
	call	int32 _10_pi._10_pi::'CmpMag'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	ldc.i4.0
	blt	lb70
.line	160,160:6,21 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.1
	ldarg.2
	call	void  _10_pi._10_pi::'SubMag'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	160,160:23,34 '_10_pi.cp'
	ldarg.0
	ldloc.0
	stfld	bool	_10_pi.Big::'neg'
	br	lb68
lb70:
.line	162,162:6,21 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.2
	ldarg.1
	call	void  _10_pi._10_pi::'SubMag'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	162,162:23,34 '_10_pi.cp'
	ldarg.0
	ldloc.1
	stfld	bool	_10_pi.Big::'neg'
lb71:
lb68:
.line	164,164:4,11 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	call	void  _10_pi._10_pi::'Trim'(class _10_pi.Big)
//        End call sequence
	nop
.line	165,165:2,9 '_10_pi.cp'
	ret
//	.maxstack	3
	.locals init (
		bool	'an',
		bool	'bn')
    } // end of method Add

// PROCEDURE Sub
.method assembly static void  'Sub'( 
		class _10_pi.Big	'r',
		class _10_pi.Big	'a',
		class _10_pi.Big	'b') il managed
    {
.line	167,167:12,15 '_10_pi.cp'
	nop
.line	170,170:4,15 '_10_pi.cp'
	ldarg.1
	ldfld	bool	_10_pi.Big::'neg'
	stloc.0
.line	170,170:17,28 '_10_pi.cp'
	ldarg.2
	ldfld	bool	_10_pi.Big::'neg'
	stloc.1
.line	171,171:4,6 '_10_pi.cp'
	nop
.line	171,171:7,14 '_10_pi.cp'
	ldloc.0
	ldloc.1
	beq	lb73
.line	172,172:6,21 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.1
	ldarg.2
	call	void  _10_pi._10_pi::'AddMag'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	172,172:23,34 '_10_pi.cp'
	ldarg.0
	ldloc.0
	stfld	bool	_10_pi.Big::'neg'
	br	lb72
lb73:
.line	173,173:10,27 '_10_pi.cp'
//        Start static call sequence
	ldarg.1
	ldarg.2
	call	int32 _10_pi._10_pi::'CmpMag'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	ldc.i4.0
	blt	lb74
.line	174,174:6,21 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.1
	ldarg.2
	call	void  _10_pi._10_pi::'SubMag'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	174,174:23,34 '_10_pi.cp'
	ldarg.0
	ldloc.0
	stfld	bool	_10_pi.Big::'neg'
	br	lb72
lb74:
.line	176,176:6,21 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.2
	ldarg.1
	call	void  _10_pi._10_pi::'SubMag'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	176,176:23,35 '_10_pi.cp'
	ldarg.0
	ldloc.0
	ldc.i4.1
	xor
	stfld	bool	_10_pi.Big::'neg'
lb75:
lb72:
.line	178,178:4,11 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	call	void  _10_pi._10_pi::'Trim'(class _10_pi.Big)
//        End call sequence
	nop
.line	179,179:2,9 '_10_pi.cp'
	ret
//	.maxstack	3
	.locals init (
		bool	'an',
		bool	'bn')
    } // end of method Sub

// PROCEDURE MulSmall
.method assembly static void  'MulSmall'( 
		class _10_pi.Big	'r',
		class _10_pi.Big	'a',
		int64	'm') il managed
    {
.line	181,181:12,20 '_10_pi.cp'
	nop
.line	185,185:4,6 '_10_pi.cp'
	nop
.line	185,185:7,27 '_10_pi.cp'
	ldarg.2
	ldc.i8	0
	beq	lb78
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.0
	bne.un	lb77
lb78:
.line	185,185:33,41 '_10_pi.cp'
	ldarg.0
	ldc.i4.0
	stfld	int32	_10_pi.Big::'n'
.line	185,185:43,48 '_10_pi.cp'
	ldarg.0
	ldc.i4.0
	stfld	bool	_10_pi.Big::'neg'
.line	185,185:59,65 '_10_pi.cp'
	nop
.line	201,201:2,14 '_10_pi.cp'
	ret
lb77:
lb76:
.line	186,186:4,14 '_10_pi.cp'
	ldc.i8	0
	stloc.3
.line	187,187:4,7 '_10_pi.cp'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.1
	sub.ovf
	dup
	stloc.s	4
	ldc.i4.0
	dup
	stloc.0
	blt	lb80
lb79:	// Loop header
.line	188,188:6,32 '_10_pi.cp'
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldelem.i8
	ldarg.2
	mul.ovf
	ldloc.3
	add.ovf
	stloc.2
.line	189,189:6,29 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.0
	ldloc.2
	ldc.i8	1000000000
	rem
	dup
	ldc.i8	0
	bge	lb81
	ldc.i8	1000000000
	add
lb81:
	stelem.i8
.line	190,190:6,25 '_10_pi.cp'
	ldloc.2
	dup
	ldc.i8	0
	bge	lb82
	ldc.i8	999999999
	sub
lb82:
	ldc.i8	1000000000
	div
	stloc.3
	ldloc.s	4
	ldloc.0
	ldc.i4.1
	add.ovf
	dup
	stloc.0
	bge	lb79
lb80:	// Loop trailer
.line	192,192:4,16 '_10_pi.cp'
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	stloc.1
.line	193,193:4,9 '_10_pi.cp'
	nop
.line	193,193:10,19 '_10_pi.cp'
	ldloc.3
	ldc.i8	0
	ble	lb84
lb83:	// Loop header
.line	194,194:6,37 '_10_pi.cp'
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldloc.1
	ldloc.3
	ldc.i8	1000000000
	rem
	dup
	ldc.i8	0
	bge	lb85
	ldc.i8	1000000000
	add
lb85:
	stelem.i8
.line	195,195:6,29 '_10_pi.cp'
	ldloc.3
	dup
	ldc.i8	0
	bge	lb86
	ldc.i8	999999999
	sub
lb86:
	ldc.i8	1000000000
	div
	stloc.3
.line	196,196:6,16 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	193,193:10,19 '_10_pi.cp'
	ldloc.3
	ldc.i8	0
	bgt	lb83
lb84:	// Loop exit
.line	198,198:4,16 '_10_pi.cp'
	ldarg.0
	ldloc.1
	stfld	int32	_10_pi.Big::'n'
.line	199,199:4,18 '_10_pi.cp'
	ldarg.0
	ldarg.1
	ldfld	bool	_10_pi.Big::'neg'
	stfld	bool	_10_pi.Big::'neg'
.line	200,200:4,11 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	call	void  _10_pi._10_pi::'Trim'(class _10_pi.Big)
//        End call sequence
	nop
.line	201,201:2,14 '_10_pi.cp'
	ret
//	.maxstack	5
	.locals init (
		int32	'i',
		int32	'count',
		int64	'p',
		int64	'carry',
		int32)
    } // end of method MulSmall

// PROCEDURE Quot
.method assembly static int64 'Quot'( 
		class _10_pi.Big	'a',
		class _10_pi.Big	'b',
		class _10_pi.Big	'work') il managed
    {
.line	205,205:12,16 '_10_pi.cp'
	nop
.line	208,208:4,10 '_10_pi.cp'
	ldc.i8	0
	stloc.0
.line	209,209:4,6 '_10_pi.cp'
	nop
.line	209,209:7,34 '_10_pi.cp'
	ldarg.0
	ldfld	bool	_10_pi.Big::'neg'
	brtrue	lb89
	ldarg.1
	ldfld	bool	_10_pi.Big::'neg'
	brtrue	lb89
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	ldc.i4.0
	bne.un	lb88
lb89:
.line	209,209:40,48 '_10_pi.cp'
	nop
.line	216,216:2,10 '_10_pi.cp'
	ldc.i8	0
	ret
lb88:
lb87:
.line	210,210:4,17 '_10_pi.cp'
//        Start static call sequence
	ldarg.2
	ldarg.1
	call	void  _10_pi._10_pi::'Copy'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	211,211:4,9 '_10_pi.cp'
	nop
.line	211,211:10,27 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.2
	call	int32 _10_pi._10_pi::'Cmp'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	ldc.i4.0
	blt	lb91
lb90:	// Loop header
.line	212,212:6,12 '_10_pi.cp'
	ldloc.0
	ldc.i8	1
	add.ovf
	stloc.0
.line	213,213:6,27 '_10_pi.cp'
//        Start static call sequence
	ldarg.2
	ldarg.2
	ldarg.1
	call	void  _10_pi._10_pi::'AddMag'(class _10_pi.Big,class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	nop
.line	211,211:10,27 '_10_pi.cp'
//        Start static call sequence
	ldarg.0
	ldarg.2
	call	int32 _10_pi._10_pi::'Cmp'(class _10_pi.Big,class _10_pi.Big)
//        End call sequence
	ldc.i4.0
	bge	lb90
lb91:	// Loop exit
.line	215,215:4,12 '_10_pi.cp'
	nop
.line	216,216:2,10 '_10_pi.cp'
	ldloc.0
	ret
//	.maxstack	3
	.locals init (int64	'q')
    } // end of method Quot

// PROCEDURE WMs
.method assembly static void  'WMs'(int64 'x') il managed
    {
.line	218,218:12,15 '_10_pi.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	223,223:4,6 '_10_pi.cp'
	nop
.line	223,223:7,12 '_10_pi.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb93
.line	223,223:18,34 '_10_pi.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	223,223:36,42 '_10_pi.cp'
	nop
.line	237,237:2,9 '_10_pi.cp'
	ret
lb93:
lb92:
.line	224,224:4,10 '_10_pi.cp'
	ldc.i4.0
	stloc.1
.line	225,225:4,9 '_10_pi.cp'
	nop
.line	225,225:10,15 '_10_pi.cp'
	ldarg.0
	ldc.i8	0
	ble	lb95
lb94:	// Loop header
.line	226,226:6,45 '_10_pi.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb96
	ldc.i8	10
	add
lb96:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	227,227:6,19 '_10_pi.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb97
	ldc.i8	9
	sub
lb97:
	ldc.i8	10
	div
	starg.s	0
.line	228,228:6,12 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	225,225:10,15 '_10_pi.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb94
lb95:	// Loop exit
.line	230,230:4,14 '_10_pi.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	231,231:4,10 '_10_pi.cp'
	ldc.i4.0
	stloc.2
.line	231,231:12,18 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	232,232:4,9 '_10_pi.cp'
	nop
.line	232,232:10,15 '_10_pi.cp'
	ldloc.2
	ldloc.1
	bge	lb99
lb98:	// Loop header
.line	233,233:6,15 '_10_pi.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	233,233:17,29 '_10_pi.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	233,233:31,40 '_10_pi.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	234,234:6,12 '_10_pi.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	234,234:14,20 '_10_pi.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	232,232:10,15 '_10_pi.cp'
	ldloc.2
	ldloc.1
	blt	lb98
lb99:	// Loop exit
.line	236,236:4,24 '_10_pi.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	237,237:2,9 '_10_pi.cp'
	ret
//	.maxstack	5
	.locals init (
		wchar[]	's',
		int32	'n',
		int32	'k',
		wchar	't')
    } // end of method WMs
  }

// RECORD Big
.class sealed Big
  {
.field assembly 	int64[]	'limb'
.field assembly 	int32	'n'
.field assembly 	bool	'neg'

.method public specialname rtspecialname  instance void  .ctor() il managed
    {
//        Call supertype constructor
	ldarg.0
	call	instance void object::.ctor() 
//        Initialize embedded object
	ldarg.0
// initialize limb
	ldc.i4	40000
	newarr	int64
	stfld	int64[]	_10_pi.Big::'limb'
	ret
//	.maxstack	2
	.locals()
    } // end of method 'Big::.ctor'

// standard record copy method
.method	public void __copy__(class _10_pi.Big) il managed
    {
	ldarg.0
	ldfld	int64[]	_10_pi.Big::'limb'
	ldarg.1
	ldfld	int64[]	_10_pi.Big::'limb'
	stloc.1
	stloc.0
	ldc.i4	40000
	stloc.2
lb100:
	ldloc.2
	ldc.i4.1
	sub
	stloc.2
	ldloc.0
	ldloc.2
	ldloc.1
	ldloc.2
	ldelem.i8
	stelem.i8
	ldloc.2
	brtrue	lb100
	ldarg.0
	ldarg.1
	ldfld	int32	_10_pi.Big::'n'
	stfld	int32	_10_pi.Big::'n'
	ldarg.0
	ldarg.1
	ldfld	bool	_10_pi.Big::'neg'
	stfld	bool	_10_pi.Big::'neg'
	ret
//	.maxstack	4
	.locals init (
		int64[],
		int64[],
		int32)
    } // end of __copy__ method '
  }

}
// end namespace _10_pi
// end output produced by gpcp
