/*
 * Code for class COUNTABLE_SEQUENCE [INTEGER_32]
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "co786.h"

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
EIF_INTEGER_32 F448_2224 (EIF_REFERENCE Current)
{
	return *(EIF_INTEGER_32 *)(Current+ _LNGOFF_0_1_0_0_);
}


/* {COUNTABLE_SEQUENCE}.after */
EIF_BOOLEAN F448_2226 (EIF_REFERENCE Current)
{
	return (EIF_BOOLEAN) EIF_FALSE;
}

/* {COUNTABLE_SEQUENCE}.forth */
void F448_2232 (EIF_REFERENCE Current)
{
	GTCX
	
	
	(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_0_1_0_0_))++;
}

void EIF_Minit786 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
