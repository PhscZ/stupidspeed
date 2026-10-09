/*
 * Code for class CELL [G#1]
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "ce610.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {CELL}.item */
EIF_REFERENCE F46_718 (EIF_REFERENCE Current)
{
	return *(EIF_REFERENCE *)(Current + O698[Dtype(Current)-45]);
}


/* {CELL}.put */
void F46_719 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	tr1 = RTCCL(arg1);
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + O698[Dtype(Current)-45]) = (EIF_REFERENCE) tr1;
	RTLE;
}

void EIF_Minit610 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
