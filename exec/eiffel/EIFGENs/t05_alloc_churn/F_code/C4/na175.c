/*
 * Code for class NATURAL_16
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "na175.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {NATURAL_16}.is_less */
EIF_BOOLEAN F727_4262 (EIF_REFERENCE Current, EIF_NATURAL_16 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(726, 0x00).id, 726, _OBJSIZ_0_0_1_0_0_0_0_0_);
	*(EIF_NATURAL_16 *)tr1 = arg1;
	Result = F725_4202(Current, tr1);
	RTLE;
	return Result;
}

/* {NATURAL_16}.integer_quotient */
EIF_NATURAL_16 F727_4268 (EIF_REFERENCE Current, EIF_NATURAL_16 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_NATURAL_16 Result = ((EIF_NATURAL_16) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(726, 0x00).id, 726, _OBJSIZ_0_0_1_0_0_0_0_0_);
	*(EIF_NATURAL_16 *)tr1 = arg1;
	tr1 = F725_4217(Current, tr1);
	Result = *(EIF_NATURAL_16 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_16}.integer_remainder */
EIF_NATURAL_16 F727_4269 (EIF_REFERENCE Current, EIF_NATURAL_16 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_NATURAL_16 Result = ((EIF_NATURAL_16) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(726, 0x00).id, 726, _OBJSIZ_0_0_1_0_0_0_0_0_);
	*(EIF_NATURAL_16 *)tr1 = arg1;
	tr1 = F725_4218(Current, tr1);
	Result = *(EIF_NATURAL_16 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_16}.as_natural_32 */
EIF_NATURAL_32 F727_4273 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_32) F725_4226(Current);
}

/* {NATURAL_16}.as_natural_64 */
EIF_NATURAL_64 F727_4274 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) F725_4227(Current);
}

/* {NATURAL_16}.as_integer_32 */
EIF_INTEGER_32 F727_4277 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) F725_4230(Current);
}

/* {NATURAL_16}.to_character_32 */
EIF_CHARACTER_32 F727_4282 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_CHARACTER_32) F725_4250(Current);
}

void EIF_Minit175 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
