/*
 * Code for class COUNTABLE_SEQUENCE [INTEGER_32]
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "co800.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {COUNTABLE_SEQUENCE}.index */
EIF_INTEGER_32 F432_2261 (EIF_REFERENCE Current)
{
	return *(EIF_INTEGER_32 *)(Current+ _LNGOFF_0_1_0_0_);
}


/* {COUNTABLE_SEQUENCE}.after */
EIF_BOOLEAN F432_2263 (EIF_REFERENCE Current)
{
	return (EIF_BOOLEAN) EIF_FALSE;
}

/* {COUNTABLE_SEQUENCE}.forth */
void F432_2269 (EIF_REFERENCE Current)
{
	GTCX
	
	
	(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_0_1_0_0_))++;
}

void EIF_Minit800 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
