/*
 * Code for class RESIZABLE [BOOLEAN]
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "re544.h"
#include "eif_helpers.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {RESIZABLE}.additional_space */
EIF_INTEGER_32 F485_2267 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti4_1 = F554_2684(Current);
	Result = eif_max_int32 ((EIF_INTEGER_32) (ti4_1 / ((EIF_INTEGER_32) 2L)),((EIF_INTEGER_32) 5L));
	RTLE;
	return Result;
}

void EIF_Minit544 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
