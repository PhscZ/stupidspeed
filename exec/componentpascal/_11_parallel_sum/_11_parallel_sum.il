// ILASM output produced by GPCP compiler (net version)
// at date: 04/10/2026 21:40:28
// from source file <_11_parallel_sum.cp>
// This module implements CPmain

.assembly extern RTS {}
.assembly extern mscorlib {}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly extern mscorlib {
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}
.assembly '_11_parallel_sum' {}

// CPmain entry
// CPmain entry
.namespace _11_parallel_sum
{
.class public sealed _11_parallel_sum
  {
.field private static 	class [mscorlib]System.Threading.ThreadStart	's0'
.field private static 	class [mscorlib]System.Threading.ThreadStart	's1'
.field private static 	class [mscorlib]System.Threading.ThreadStart	's2'
.field private static 	class [mscorlib]System.Threading.ThreadStart	's3'
.field assembly static 	int64	'ss_t0'
.field assembly static 	int64	'ss_t1'
.field assembly static 	class [mscorlib]System.Threading.Thread	'th0'
.field assembly static 	class [mscorlib]System.Threading.Thread	'th1'
.field assembly static 	class [mscorlib]System.Threading.Thread	'th2'
.field assembly static 	class [mscorlib]System.Threading.Thread	'th3'
.field assembly static 	class _11_parallel_sum.Worker	'w0'
.field assembly static 	class _11_parallel_sum.Worker	'w1'
.field assembly static 	class _11_parallel_sum.Worker	'w2'
.field assembly static 	class _11_parallel_sum.Worker	'w3'
.field assembly static 	int64	'total'

.method public specialname static void
	add_s0(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s0'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Combine(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s0'
	ret
    }

.method public specialname static void
	remove_s0(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s0'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Remove(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s0'
	ret
    }

.event 	[mscorlib]System.Threading.ThreadStart 's0'
    {
	.addon void _11_parallel_sum._11_parallel_sum::add_s0(class [mscorlib]System.Threading.ThreadStart)
	.removeon void _11_parallel_sum._11_parallel_sum::remove_s0(class [mscorlib]System.Threading.ThreadStart)
    }


.method public specialname static void
	add_s1(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s1'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Combine(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s1'
	ret
    }

.method public specialname static void
	remove_s1(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s1'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Remove(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s1'
	ret
    }

.event 	[mscorlib]System.Threading.ThreadStart 's1'
    {
	.addon void _11_parallel_sum._11_parallel_sum::add_s1(class [mscorlib]System.Threading.ThreadStart)
	.removeon void _11_parallel_sum._11_parallel_sum::remove_s1(class [mscorlib]System.Threading.ThreadStart)
    }


.method public specialname static void
	add_s2(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s2'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Combine(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s2'
	ret
    }

.method public specialname static void
	remove_s2(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s2'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Remove(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s2'
	ret
    }

.event 	[mscorlib]System.Threading.ThreadStart 's2'
    {
	.addon void _11_parallel_sum._11_parallel_sum::add_s2(class [mscorlib]System.Threading.ThreadStart)
	.removeon void _11_parallel_sum._11_parallel_sum::remove_s2(class [mscorlib]System.Threading.ThreadStart)
    }


.method public specialname static void
	add_s3(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s3'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Combine(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s3'
	ret
    }

.method public specialname static void
	remove_s3(class [mscorlib]System.Threading.ThreadStart) il managed synchronized {
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s3'
	ldarg.0
        call        class [mscorlib]System.Delegate 
                       [mscorlib]System.Delegate::Remove(
                               class [mscorlib]System.Delegate,
                               class [mscorlib]System.Delegate)
	castclass	class [mscorlib]System.Threading.ThreadStart
	stsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s3'
	ret
    }

.event 	[mscorlib]System.Threading.ThreadStart 's3'
    {
	.addon void _11_parallel_sum._11_parallel_sum::add_s3(class [mscorlib]System.Threading.ThreadStart)
	.removeon void _11_parallel_sum._11_parallel_sum::remove_s3(class [mscorlib]System.Threading.ThreadStart)
    }


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
.line	98,98:1,6 '_11_parallel_sum.cp'
	ldarg.0
	stsfld	string[] [RTS]ProgArgs::argList
.line	99,99:3,8 '_11_parallel_sum.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_11_parallel_sum._11_parallel_sum::'ss_t0'
.line	100,100:3,10 '_11_parallel_sum.cp'
	newobj	instance void  _11_parallel_sum.Worker::.ctor() 
	stsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w0'
.line	100,100:12,19 '_11_parallel_sum.cp'
	newobj	instance void  _11_parallel_sum.Worker::.ctor() 
	stsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w1'
.line	100,100:21,28 '_11_parallel_sum.cp'
	newobj	instance void  _11_parallel_sum.Worker::.ctor() 
	stsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w2'
.line	100,100:30,37 '_11_parallel_sum.cp'
	newobj	instance void  _11_parallel_sum.Worker::.ctor() 
	stsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w3'
.line	101,101:3,12 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w0'
	ldc.i8	0
	stfld	int64	_11_parallel_sum.Worker::'t'
.line	101,101:14,23 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w1'
	ldc.i8	1
	stfld	int64	_11_parallel_sum.Worker::'t'
.line	101,101:25,34 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w2'
	ldc.i8	2
	stfld	int64	_11_parallel_sum.Worker::'t'
.line	101,101:36,45 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w3'
	ldc.i8	3
	stfld	int64	_11_parallel_sum.Worker::'t'
.line	103,103:3,23 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w0'
	ldftn	instance void  _11_parallel_sum.Worker::'Run'()
	newobj	instance void  [mscorlib]System.Threading.ThreadStart::.ctor(object, native int) 
	call	void _11_parallel_sum._11_parallel_sum::add_s0(class [mscorlib]System.Threading.ThreadStart)
.line	104,104:3,23 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w1'
	ldftn	instance void  _11_parallel_sum.Worker::'Run'()
	newobj	instance void  [mscorlib]System.Threading.ThreadStart::.ctor(object, native int) 
	call	void _11_parallel_sum._11_parallel_sum::add_s1(class [mscorlib]System.Threading.ThreadStart)
.line	105,105:3,23 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w2'
	ldftn	instance void  _11_parallel_sum.Worker::'Run'()
	newobj	instance void  [mscorlib]System.Threading.ThreadStart::.ctor(object, native int) 
	call	void _11_parallel_sum._11_parallel_sum::add_s2(class [mscorlib]System.Threading.ThreadStart)
.line	106,106:3,23 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w3'
	ldftn	instance void  _11_parallel_sum.Worker::'Run'()
	newobj	instance void  [mscorlib]System.Threading.ThreadStart::.ctor(object, native int) 
	call	void _11_parallel_sum._11_parallel_sum::add_s3(class [mscorlib]System.Threading.ThreadStart)
.line	108,108:3,28 '_11_parallel_sum.cp'
//        Start static call sequence
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s0'
	newobj	instance void  [mscorlib]System.Threading.Thread::'.ctor'(class [mscorlib]System.Threading.ThreadStart)
//        End call sequence
	stsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th0'
.line	109,109:3,28 '_11_parallel_sum.cp'
//        Start static call sequence
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s1'
	newobj	instance void  [mscorlib]System.Threading.Thread::'.ctor'(class [mscorlib]System.Threading.ThreadStart)
//        End call sequence
	stsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th1'
.line	110,110:3,28 '_11_parallel_sum.cp'
//        Start static call sequence
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s2'
	newobj	instance void  [mscorlib]System.Threading.Thread::'.ctor'(class [mscorlib]System.Threading.ThreadStart)
//        End call sequence
	stsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th2'
.line	111,111:3,28 '_11_parallel_sum.cp'
//        Start static call sequence
	ldsfld	class [mscorlib]System.Threading.ThreadStart	_11_parallel_sum._11_parallel_sum::'s3'
	newobj	instance void  [mscorlib]System.Threading.Thread::'.ctor'(class [mscorlib]System.Threading.ThreadStart)
//        End call sequence
	stsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th3'
.line	113,113:3,14 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th0'
	call	instance void  [mscorlib]System.Threading.Thread::'Start'()
//        End call sequence
	nop
.line	113,113:16,27 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th1'
	call	instance void  [mscorlib]System.Threading.Thread::'Start'()
//        End call sequence
	nop
.line	113,113:29,40 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th2'
	call	instance void  [mscorlib]System.Threading.Thread::'Start'()
//        End call sequence
	nop
.line	113,113:42,53 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th3'
	call	instance void  [mscorlib]System.Threading.Thread::'Start'()
//        End call sequence
	nop
.line	114,114:3,13 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th0'
	call	instance void  [mscorlib]System.Threading.Thread::'Join'()
//        End call sequence
	nop
.line	114,114:16,26 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th1'
	call	instance void  [mscorlib]System.Threading.Thread::'Join'()
//        End call sequence
	nop
.line	114,114:29,39 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th2'
	call	instance void  [mscorlib]System.Threading.Thread::'Join'()
//        End call sequence
	nop
.line	114,114:42,52 '_11_parallel_sum.cp'
//        Start dispatch sequence
	ldsfld	class [mscorlib]System.Threading.Thread	_11_parallel_sum._11_parallel_sum::'th3'
	call	instance void  [mscorlib]System.Threading.Thread::'Join'()
//        End call sequence
	nop
.line	116,116:3,45 '_11_parallel_sum.cp'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w0'
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w1'
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	add.ovf
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w2'
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	add.ovf
	ldsfld	class _11_parallel_sum.Worker	_11_parallel_sum._11_parallel_sum::'w3'
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	add.ovf
	stsfld	int64	_11_parallel_sum._11_parallel_sum::'total'
.line	118,118:3,8 '_11_parallel_sum.cp'
//        Start static call sequence
	call	int32 [mscorlib]System.Environment::'get_TickCount'()
//        End call sequence
	conv.i8
	stsfld	int64	_11_parallel_sum._11_parallel_sum::'ss_t1'
.line	119,119:3,32 '_11_parallel_sum.cp'
//        Start static call sequence
	ldstr	"TIME_MS="
	call	wchar[] [RTS]CP_rts::strToChO(string)
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	119,119:34,52 '_11_parallel_sum.cp'
//        Start static call sequence
	ldsfld	int64	_11_parallel_sum._11_parallel_sum::'ss_t1'
	ldsfld	int64	_11_parallel_sum._11_parallel_sum::'ss_t0'
	sub.ovf
	call	void  _11_parallel_sum._11_parallel_sum::'WMs'(int64)
//        End call sequence
	nop
.line	119,119:54,69 '_11_parallel_sum.cp'
//        Start static call sequence
	call	void  [RTS]Error::'WriteLn'()
//        End call sequence
	nop
.line	121,121:3,19 '_11_parallel_sum.cp'
//        Start static call sequence
	ldsfld	int64	_11_parallel_sum._11_parallel_sum::'total'
	call	void  _11_parallel_sum._11_parallel_sum::'WriteLong'(int64)
//        End call sequence
	nop
.line	121,121:21,36 '_11_parallel_sum.cp'
//        Start static call sequence
	call	void  [RTS]Console::'WriteLn'()
//        End call sequence
	nop
// Continuing directly to CLOSE
.line	122,122:1,4 '_11_parallel_sum.cp'
	ret
//	.maxstack	2
	.locals()
    } // end of method .CPmain


// PROCEDURE WriteLong
.method assembly static void  'WriteLong'(int64 'x') il managed
    {
.line	56,56:12,21 '_11_parallel_sum.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	61,61:4,6 '_11_parallel_sum.cp'
	nop
.line	61,61:7,12 '_11_parallel_sum.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb2
.line	61,61:18,36 '_11_parallel_sum.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Console::'Write'(wchar)
//        End call sequence
	nop
.line	61,61:38,44 '_11_parallel_sum.cp'
	nop
.line	75,75:2,15 '_11_parallel_sum.cp'
	ret
lb2:
lb1:
.line	62,62:4,10 '_11_parallel_sum.cp'
	ldc.i4.0
	stloc.1
.line	63,63:4,9 '_11_parallel_sum.cp'
	nop
.line	63,63:10,15 '_11_parallel_sum.cp'
	ldarg.0
	ldc.i8	0
	ble	lb4
lb3:	// Loop header
.line	64,64:6,45 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.1
	ldarg.0
	ldc.i8	10
	rem
	dup
	ldc.i8	0
	bge	lb5
	ldc.i8	10
	add
lb5:
	conv.ovf.i4
	ldc.i4.s	48
	add.ovf
	conv.ovf.u2
	stelem.i2
.line	65,65:6,19 '_11_parallel_sum.cp'
	ldarg.0
	dup
	ldc.i8	0
	bge	lb6
	ldc.i8	9
	sub
lb6:
	ldc.i8	10
	div
	starg.s	0
.line	66,66:6,12 '_11_parallel_sum.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	63,63:10,15 '_11_parallel_sum.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb3
lb4:	// Loop exit
.line	68,68:4,14 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	69,69:4,10 '_11_parallel_sum.cp'
	ldc.i4.0
	stloc.2
.line	69,69:12,18 '_11_parallel_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	70,70:4,9 '_11_parallel_sum.cp'
	nop
.line	70,70:10,15 '_11_parallel_sum.cp'
	ldloc.2
	ldloc.1
	bge	lb8
lb7:	// Loop header
.line	71,71:6,15 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	71,71:17,29 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	71,71:31,40 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	72,72:6,12 '_11_parallel_sum.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	72,72:14,20 '_11_parallel_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	70,70:10,15 '_11_parallel_sum.cp'
	ldloc.2
	ldloc.1
	blt	lb7
lb8:	// Loop exit
.line	74,74:4,26 '_11_parallel_sum.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Console::'WriteString'(wchar[])
//        End call sequence
	nop
.line	75,75:2,15 '_11_parallel_sum.cp'
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
.line	77,77:12,15 '_11_parallel_sum.cp'
	nop
// initialize s
	ldc.i4.s	24
	newarr	wchar
	stloc.0
.line	82,82:4,6 '_11_parallel_sum.cp'
	nop
.line	82,82:7,12 '_11_parallel_sum.cp'
	ldarg.0
	ldc.i8	0
	bne.un	lb10
.line	82,82:18,34 '_11_parallel_sum.cp'
//        Start static call sequence
	ldc.i4.s	48
	call	void  [RTS]Error::'Write'(wchar)
//        End call sequence
	nop
.line	82,82:36,42 '_11_parallel_sum.cp'
	nop
.line	96,96:2,9 '_11_parallel_sum.cp'
	ret
lb10:
lb9:
.line	83,83:4,10 '_11_parallel_sum.cp'
	ldc.i4.0
	stloc.1
.line	84,84:4,9 '_11_parallel_sum.cp'
	nop
.line	84,84:10,15 '_11_parallel_sum.cp'
	ldarg.0
	ldc.i8	0
	ble	lb12
lb11:	// Loop header
.line	85,85:6,45 '_11_parallel_sum.cp'
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
.line	86,86:6,19 '_11_parallel_sum.cp'
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
.line	87,87:6,12 '_11_parallel_sum.cp'
	ldloc.1
	ldc.i4.1
	add.ovf
	stloc.1
.line	84,84:10,15 '_11_parallel_sum.cp'
	ldarg.0
	ldc.i8	0
	bgt	lb11
lb12:	// Loop exit
.line	89,89:4,14 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.1
	ldc.i4.0
	stelem.i2
.line	90,90:4,10 '_11_parallel_sum.cp'
	ldc.i4.0
	stloc.2
.line	90,90:12,18 '_11_parallel_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	91,91:4,9 '_11_parallel_sum.cp'
	nop
.line	91,91:10,15 '_11_parallel_sum.cp'
	ldloc.2
	ldloc.1
	bge	lb16
lb15:	// Loop header
.line	92,92:6,15 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.2
	ldelem.u2
	stloc.3
.line	92,92:17,29 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.2
	ldloc.0
	ldloc.1
	ldelem.u2
	stelem.i2
.line	92,92:31,40 '_11_parallel_sum.cp'
	ldloc.0
	ldloc.1
	ldloc.3
	stelem.i2
.line	93,93:6,12 '_11_parallel_sum.cp'
	ldloc.2
	ldc.i4.1
	add.ovf
	stloc.2
.line	93,93:14,20 '_11_parallel_sum.cp'
	ldloc.1
	ldc.i4.1
	sub.ovf
	stloc.1
.line	91,91:10,15 '_11_parallel_sum.cp'
	ldloc.2
	ldloc.1
	blt	lb15
lb16:	// Loop exit
.line	95,95:4,24 '_11_parallel_sum.cp'
//        Start static call sequence
	ldloc.0
	call	void  [RTS]Error::'WriteString'(wchar[])
//        End call sequence
	nop
.line	96,96:2,9 '_11_parallel_sum.cp'
	ret
//	.maxstack	5
	.locals init (
		wchar[]	's',
		int32	'n',
		int32	'k',
		wchar	't')
    } // end of method WMs
  }

// RECORD Worker^
.class sealed Worker
  {
.field assembly 	int64	't'
.field assembly 	int64	'acc'

.method public specialname rtspecialname  instance void  .ctor() il managed
    {
//        Call supertype constructor
	ldarg.0
	call	instance void object::.ctor() 
	ret
//	.maxstack	1
	.locals()
    } // end of method 'Worker::.ctor'

// standard record copy method
.method	public void __copy__(class _11_parallel_sum.Worker) il managed
    {
	ldarg.0
	ldarg.1
	ldfld	int64	_11_parallel_sum.Worker::'t'
	stfld	int64	_11_parallel_sum.Worker::'t'
	ldarg.0
	ldarg.1
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	stfld	int64	_11_parallel_sum.Worker::'acc'
	ret
//	.maxstack	2
	.locals()
    } // end of __copy__ method '

// PROCEDURE Run
.method assembly instance void  'Run'() il managed
    {
.line	42,42:28,31 '_11_parallel_sum.cp'
	nop
.line	45,45:4,17 '_11_parallel_sum.cp'
	ldarg.0
	ldc.i8	0
	stfld	int64	_11_parallel_sum.Worker::'acc'
.line	46,46:4,7 '_11_parallel_sum.cp'
	ldarg.0
	ldfld	int64	_11_parallel_sum.Worker::'t'
	ldc.i8	1
	add.ovf
	ldc.i8	25000000
	mul.ovf
	conv.ovf.i4
	ldc.i4.1
	sub.ovf
	dup
	stloc.1
	ldarg.0
	ldfld	int64	_11_parallel_sum.Worker::'t'
	ldc.i8	25000000
	mul.ovf
	conv.ovf.i4
	dup
	stloc.0
	blt	lb18
lb17:	// Loop header
.line	47,47:6,10 '_11_parallel_sum.cp'
	ldloc.0
	ldc.i4.3
	and
	stloc.2
	ldloc.2
	switch	( // dispatch table: 4,
	       lb21,
	       lb22,
	       lb23,
	       lb24)
	br	lb20
lb21:
.line	48,48:11,35 '_11_parallel_sum.cp'
	ldarg.0
	ldarg.0
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	ldc.i8	1
	add.ovf
	stfld	int64	_11_parallel_sum.Worker::'acc'
	br	lb19
lb22:
.line	49,49:11,35 '_11_parallel_sum.cp'
	ldarg.0
	ldarg.0
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	ldloc.0
	conv.i8
	add.ovf
	stfld	int64	_11_parallel_sum.Worker::'acc'
	br	lb19
lb23:
.line	50,50:11,39 '_11_parallel_sum.cp'
	ldarg.0
	ldarg.0
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	ldc.i4.2
	ldloc.0
	mul.ovf
	conv.i8
	add.ovf
	stfld	int64	_11_parallel_sum.Worker::'acc'
	br	lb19
lb24:
.line	51,51:11,39 '_11_parallel_sum.cp'
	ldarg.0
	ldarg.0
	ldfld	int64	_11_parallel_sum.Worker::'acc'
	ldc.i4.3
	ldloc.0
	mul.ovf
	conv.i8
	add.ovf
	stfld	int64	_11_parallel_sum.Worker::'acc'
	br	lb19
lb20:	// Default case
// CaseTrap
	ldloc.2
	call	string [RTS]CP_rts::caseMesg(int32)
	newobj	instance void [mscorlib]System.Exception::.ctor(string)
	throw
lb19:	// Case exit label
	ldloc.1
	ldloc.0
	ldc.i4.1
	add.ovf
	dup
	stloc.0
	bge	lb17
lb18:	// Loop trailer
.line	54,54:2,9 '_11_parallel_sum.cp'
	ret
//	.maxstack	4
	.locals init (
		int32	'i',
		int32,
		int32)
    } // end of method Run
  }

}
// end namespace _11_parallel_sum
// end output produced by gpcp
