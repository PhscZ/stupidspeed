/*
 * Code for class MUTEX
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "mu115.h"
#include "eif_built_in.h"
#include "eif_threads.h"
#include <eif_threads.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INLINE_F54_781
static EIF_POINTER inline_F54_781 (void)
{
	return eif_thr_thread_id();
	;
}
#define INLINE_F54_781
#endif

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {MUTEX}.make */
void F137_1425 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tp1 = (EIF_POINTER) eif_thr_mutex_create();
	*(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_1_) = (EIF_POINTER) tp1;
	RTLE;
}

/* {MUTEX}.is_set */
EIF_BOOLEAN F137_1427 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	Result = '\01';
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	if (!(EIF_BOOLEAN)(*(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_1_) != tp1)) {
		Result = (EIF_BOOLEAN) !(EIF_BOOLEAN) eif_builtin_PLATFORM_is_thread_capable__b;
	}
	RTLE;
	return Result;
}

/* {MUTEX}.lock */
void F137_1428 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tp1 = *(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_1_);
	F137_1437(Current, tp1);
	tp1 = inline_F54_781();
	*(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_0_) = (EIF_POINTER) tp1;
	RTLE;
}

/* {MUTEX}.unlock */
void F137_1430 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	tp2 = tp1;
	*(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_0_) = (EIF_POINTER) tp2;
	tp1 = *(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_1_);
	eif_thr_mutex_unlock(tp1);
	RTLE;
}

/* {MUTEX}.destroy */
void F137_1431 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tp1 = *(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_1_);
	eif_thr_mutex_destroy(tp1);
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	tp2 = tp1;
	*(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_1_) = (EIF_POINTER) tp2;
	RTLE;
}

/* {MUTEX}.dispose */
void F137_1434 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN tb2;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tb1 = '\0';
	if (F137_1427(Current)) {
		tb2 = '\01';
		{
			/* INLINED CODE (ANY.default_pointer) */
			tp1 = (EIF_POINTER)  0;
			/* END INLINED CODE */
		}
		if (!(EIF_BOOLEAN)(*(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_0_) == tp1)) {
			tb2 = (EIF_BOOLEAN)(*(EIF_POINTER *)(Current+ _PTROFF_0_0_0_0_0_0_) == inline_F54_781());
		}
		tb1 = tb2;
	}
	if (tb1) {
		F137_1431(Current);
	}
	RTLE;
}

/* {MUTEX}.eif_thr_mutex_create */
EIF_POINTER F137_1436 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER Result = ((EIF_POINTER) 0);
	
	
	Result = (EIF_POINTER) eif_thr_mutex_create();
	
	return Result;
}

/* {MUTEX}.eif_thr_mutex_lock */
void F137_1437 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	
	
	EIF_ENTER_C;eif_thr_mutex_lock(arg1);
	
	EIF_EXIT_C;
	RTGC;
}

/* {MUTEX}.eif_thr_mutex_unlock */
void F137_1438 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	
	eif_thr_mutex_unlock(arg1);
	
}

/* {MUTEX}.eif_thr_mutex_destroy */
void F137_1440 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	
	eif_thr_mutex_destroy(arg1);
	
}

void EIF_Minit115 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
