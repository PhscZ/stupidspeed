/*
 * Code for class CONSOLE
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "co198.h"
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
void F820_5065 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	F518_2543(Current, arg1);
	tp1 = (EIF_POINTER) console_def(((EIF_INTEGER_32) 1L));
	*(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_) = (EIF_POINTER) tp1;
	F516_2489(Current);
	RTLE;
}

/* {CONSOLE}.make_open_stderr */
void F820_5066 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	F518_2543(Current, arg1);
	tp1 = (EIF_POINTER) console_def(((EIF_INTEGER_32) 2L));
	*(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_) = (EIF_POINTER) tp1;
	F516_2489(Current);
	RTLE;
}

/* {CONSOLE}.default_encoding */
static EIF_REFERENCE F820_5067_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	

	
	RTEV;
	RTOSP (5067);
#define Result RTOSR(5067)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(3, 0x01).id, 3, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = RTOSCF(59,F4_59, (RTCW(tr1)));
	RTOSE (5067);
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F820_5067 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(5067,F820_5067_body,(Current));
}

/* {CONSOLE}.count */
EIF_INTEGER_32 F820_5071 (EIF_REFERENCE Current)
{
	return (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
}

/* {CONSOLE}.dispose */
void F820_5072 (EIF_REFERENCE Current)
{
	GTCX
	
	
	RTGC;
}

/* {CONSOLE}.put_string */
void F820_5093 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	loc1 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3683[Dtype(arg1)-816]);
	if ((EIF_BOOLEAN) (loc1 > ((EIF_INTEGER_32) 0L))) {
		loc2 = *(EIF_REFERENCE *)(RTCW(arg1));
		tp1 = *(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_);
		console_ps((FILE*) tp1, (char*) loc2, (EIF_INTEGER) loc1);
	}
	RTLE;
}

/* {CONSOLE}.put_new_line */
void F820_5101 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	
	
	tp1 = *(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_);
	console_tnwl((FILE*) tp1);
}

/* {CONSOLE}.console_def */
EIF_POINTER F820_5104 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_POINTER Result = ((EIF_POINTER) 0);
	
	
	Result = (EIF_POINTER) console_def(arg1);
	
	return Result;
}

/* {CONSOLE}.console_ps */
void F820_5111 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	GTCX
	
	console_ps((FILE*) arg1, (char*) arg2, (EIF_INTEGER) arg3);
	
}

/* {CONSOLE}.console_tnwl */
void F820_5116 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	
	console_tnwl((FILE*) arg1);
	
}

void EIF_Minit198 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
