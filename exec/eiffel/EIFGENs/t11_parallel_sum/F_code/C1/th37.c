/*
 * Code for class THREAD
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "th37.h"
#include "../C1/th37.h"
#include "eif_threads.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {THREAD}.make */
void F56_785 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNSMART(eif_new_type(136, 1).id);
	F137_1425(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {THREAD}.launch */
void F56_789 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(790, 0x01).id, 790, _OBJSIZ_1_1_0_0_0_1_0_0_);
	F791_5119(RTCW(tr1));
	F56_790(Current, tr1);
	RTLE;
}

/* {THREAD}.launch_with_attributes */
#undef EIF_VOLATILE
#define EIF_VOLATILE volatile
void F56_790 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	RTEX;
	RTED;
	EIF_REFERENCE EIF_VOLATILE saved_except = (EIF_REFERENCE) 0;
	EIF_POINTER  EIF_VOLATILE tp1;
	EIF_REFERENCE  EIF_VOLATILE tr1 = NULL;
	RTLD;
	RTXD;
	
	RTLI(4);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLR(3,saved_except);
	RTLIU(4);
	RTXSLS;
	
	RTEV;
	RTGC;
	RTE_T
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1428(RTCW(tr1));
	if ((EIF_BOOLEAN) !F56_795(Current)) {
		tr1 = RTOUCR(23,F56_803, (Current));
		F49_725(RTCW(tr1), (EIF_BOOLEAN) 0);
	} else {
		tp1 = F36_603(RTCW(arg1));
		F56_804(Current, Current, (EIF_POINTER) F56_799, (EIF_POINTER) F56_801, tp1);
		tp1 = (EIF_POINTER) eif_thr_last_thread();
		*(EIF_POINTER *)(Current+ _PTROFF_1_1_0_1_0_0_) = (EIF_POINTER) tp1;
		tr1 = RTOUCR(23,F56_803, (Current));
		F49_725(RTCW(tr1), (EIF_BOOLEAN) 1);
	}
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1430(RTCW(tr1));
	RTE_E
	RTXSC;
	tr1 = RTOUCR(23,F56_803, (Current));
	F49_725(RTCW(tr1), (EIF_BOOLEAN) 0);
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1430(RTCW(tr1));
	/* NOTREACHED */
	RTE_EE
	RTEOK;
	RTLE;
}
#undef EIF_VOLATILE
#define EIF_VOLATILE

/* {THREAD}.is_launchable */
EIF_BOOLEAN F56_795 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN tb2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	Result = '\0';
	tb1 = '\0';
	tr1 = *(EIF_REFERENCE *)(Current);
	tb2 = F137_1427(RTCW(tr1));
	if (tb2) {
		{
			/* INLINED CODE (ANY.default_pointer) */
			tp1 = (EIF_POINTER)  0;
			/* END INLINED CODE */
		}
		tb1 = (EIF_BOOLEAN)(*(EIF_POINTER *)(Current+ _PTROFF_1_1_0_1_0_0_) == tp1);
	}
	if (tb1) {
		Result = (EIF_BOOLEAN) !*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_);
	}
	RTLE;
	return Result;
}

/* {THREAD}.join */
void F56_797 (EIF_REFERENCE Current)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	if ((EIF_BOOLEAN) !*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_)) {
		F56_805(Current, Current, (EIF_POINTER) F56_800);
	}
	RTLE;
}

/* {THREAD}.thr_main */
#undef EIF_VOLATILE
#define EIF_VOLATILE volatile
void F56_799 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	RTEX;
	RTED;
	EIF_REFERENCE EIF_VOLATILE saved_except = (EIF_REFERENCE) 0;
	EIF_POINTER  EIF_VOLATILE tp1;
	EIF_POINTER  EIF_VOLATILE tp2;
	EIF_REFERENCE  EIF_VOLATILE tr1 = NULL;
	RTLD;
	RTXD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,saved_except);
	RTLIU(3);
	RTXSLS;
	
	RTEV;
	RTGC;
	RTE_T
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1428(RTCW(tr1));
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1430(RTCW(tr1));
	F57_810(Current);
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1428(RTCW(tr1));
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	tp2 = tp1;
	*(EIF_POINTER *)(Current+ _PTROFF_1_1_0_1_0_0_) = (EIF_POINTER) tp2;
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1430(RTCW(tr1));
	RTE_E
	RTXSC;
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1428(RTCW(tr1));
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	tp2 = tp1;
	*(EIF_POINTER *)(Current+ _PTROFF_1_1_0_1_0_0_) = (EIF_POINTER) tp2;
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1430(RTCW(tr1));
	/* NOTREACHED */
	RTE_EE
	RTEOK;
	RTLE;
}
#undef EIF_VOLATILE
#define EIF_VOLATILE

/* {THREAD}.thr_get_terminated */
EIF_BOOLEAN F56_800 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1428(RTCW(tr1));
	Result = *(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_);
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1430(RTCW(tr1));
	RTLE;
	return Result;
}

/* {THREAD}.thr_set_terminated */
void F56_801 (EIF_REFERENCE Current, EIF_BOOLEAN arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1428(RTCW(tr1));
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) arg1;
	tr1 = *(EIF_REFERENCE *)(Current);
	F137_1430(RTCW(tr1));
	RTLE;
}

/* {THREAD}.is_last_launch_successful_cell */
static EIF_REFERENCE F56_803_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
#define Result RTOTRR
	RTOUDR(23)

	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOTP;
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,48,742,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 48, _OBJSIZ_0_1_0_0_0_0_0_0_);
	}
	F49_725(RTCW(tr1), (EIF_BOOLEAN) 0);
	Result = (EIF_REFERENCE) tr1;
	RTOTE;
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F56_803 (EIF_REFERENCE Current)
{
	GTCX
	return RTOUCR(23,F56_803_body,(Current));
}

/* {THREAD}.create_thread_with_attr */
void F56_804 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2, EIF_POINTER arg3, EIF_POINTER arg4)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,arg1);
	RTLIU(1);
	
	{
		EIF_OBJECT larg1 = &arg1;
		EIF_POINTER larg2 = arg2;
		EIF_POINTER larg3 = arg3;
		EIF_POINTER larg4 = arg4;eif_thr_create_with_attr((EIF_OBJECT) larg1, (EIF_PROCEDURE) larg2, (EIF_PROCEDURE) larg3, (EIF_POINTER) larg4);
		
	}
	RTLE;
}

/* {THREAD}.thread_wait */
void F56_805 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,arg1);
	RTLIU(1);
	
	{
		EIF_OBJECT larg1 = &arg1;
		EIF_POINTER larg2 = arg2;eif_thr_wait((EIF_OBJECT) larg1, (EIF_BOOLEAN_FUNCTION) larg2);
		
	}
	RTLE;
}

/* {THREAD}.last_created_thread */
EIF_POINTER F56_807 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER Result = ((EIF_POINTER) 0);
	
	
	Result = (EIF_POINTER) eif_thr_last_thread();
	
	return Result;
}

void EIF_Minit37 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
