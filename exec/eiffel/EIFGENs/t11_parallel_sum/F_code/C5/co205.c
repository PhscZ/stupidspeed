/*
 * Code for class CONSOLE
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "co205.h"
#include "eif_console.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {CONSOLE}.make_open_stdout */
void F792_5141 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	F498_2598(Current, arg1);
	tp1 = (EIF_POINTER) console_def(((EIF_INTEGER_32) 1L));
	*(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_) = (EIF_POINTER) tp1;
	F496_2544(Current);
	RTLE;
}

/* {CONSOLE}.make_open_stderr */
void F792_5142 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	F498_2598(Current, arg1);
	tp1 = (EIF_POINTER) console_def(((EIF_INTEGER_32) 2L));
	*(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_) = (EIF_POINTER) tp1;
	F496_2544(Current);
	RTLE;
}

/* {CONSOLE}.default_encoding */
static EIF_REFERENCE F792_5143_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	
#define Result RTOTRR
	RTOUDR(27)

	
	RTEV;
	RTOTP;
	tr1 = RTLNS(eif_new_type(1, 0x01).id, 1, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = RTOUCR(28,F2_36, (RTCW(tr1)));
	RTOTE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F792_5143 (EIF_REFERENCE Current)
{
	GTCX
	return RTOUCR(27,F792_5143_body,(Current));
}

/* {CONSOLE}.count */
EIF_INTEGER_32 F792_5147 (EIF_REFERENCE Current)
{
	return (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
}

/* {CONSOLE}.dispose */
void F792_5148 (EIF_REFERENCE Current)
{
	GTCX
	
	
	RTGC;
}

/* {CONSOLE}.put_string */
void F792_5169 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,loc2);
	RTLR(2,Current);
	RTLIU(3);
	
	RTGC;
	loc1 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3660[Dtype(arg1)-784]);
	if ((EIF_BOOLEAN) (loc1 > ((EIF_INTEGER_32) 0L))) {
		loc2 = *(EIF_REFERENCE *)(RTCW(arg1));
		tp1 = *(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_);
		console_ps((FILE*) tp1, (char*) loc2, (EIF_INTEGER) loc1);
	}
	RTLE;
}

/* {CONSOLE}.put_new_line */
void F792_5177 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	
	
	tp1 = *(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_);
	console_tnwl((FILE*) tp1);
}

/* {CONSOLE}.console_def */
EIF_POINTER F792_5180 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_POINTER Result = ((EIF_POINTER) 0);
	
	
	Result = (EIF_POINTER) console_def(arg1);
	
	return Result;
}

/* {CONSOLE}.console_ps */
void F792_5187 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	GTCX
	
	console_ps((FILE*) arg1, (char*) arg2, (EIF_INTEGER) arg3);
	
}

/* {CONSOLE}.console_tnwl */
void F792_5192 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	
	console_tnwl((FILE*) arg1);
	
}

void EIF_Minit205 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
