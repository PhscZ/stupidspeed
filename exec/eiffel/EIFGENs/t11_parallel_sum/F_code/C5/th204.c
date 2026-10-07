/*
 * Code for class THREAD_ATTRIBUTES
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "th204.h"
#include "eif_eiffel.h"
#include "eif_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INLINE_F791_5127
static void inline_F791_5127 (EIF_POINTER arg1, EIF_INTEGER_32 arg2)
{
	#ifdef EIF_THREADS
	((EIF_THR_ATTR_TYPE *) arg1)->priority = arg2;
#endif
	;
}
#define INLINE_F791_5127
#endif
#ifndef INLINE_F791_5131
static EIF_INTEGER_32 inline_F791_5131 (void)
{
	#ifdef EIF_THREADS
	return sizeof(EIF_THR_ATTR_TYPE);
#else
	return 1L;
#endif
	;
}
#define INLINE_F791_5131
#endif

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {THREAD_ATTRIBUTES}.make */
void F791_5119 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	F36_600(Current);
	ti4_1 = (EIF_INTEGER_32) eif_thr_default_priority();
	F791_5120(Current, ti4_1);
	RTLE;
}

/* {THREAD_ATTRIBUTES}.set_priority */
void F791_5120 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_POINTER tp1;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tp1 = F36_603(Current);
	inline_F791_5127(tp1, arg1);
	RTLE;
}

/* {THREAD_ATTRIBUTES}.default_priority */
EIF_INTEGER_32 F791_5124 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	Result = (EIF_INTEGER_32) eif_thr_default_priority();
	
	return Result;
}

/* {THREAD_ATTRIBUTES}.c_set_priority */
void F791_5127 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_INTEGER_32 arg2)
{
	GTCX
	
	
	inline_F791_5127 ((EIF_POINTER) arg1, (EIF_INTEGER_32) arg2);
}

/* {THREAD_ATTRIBUTES}.structure_size */
EIF_INTEGER_32 F791_5131 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	
	Result = inline_F791_5131 ();
	return Result;
}

void EIF_Minit204 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
