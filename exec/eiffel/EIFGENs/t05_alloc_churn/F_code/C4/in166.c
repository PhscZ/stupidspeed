/*
 * Code for class INTEGER_8
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "in166.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {INTEGER_8}.is_less */
EIF_BOOLEAN F718_3978 (EIF_REFERENCE Current, EIF_INTEGER_8 arg1)
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
	tr1 = RTLNS(eif_new_type(717, 0x00).id, 717, _OBJSIZ_0_1_0_0_0_0_0_0_);
	*(EIF_INTEGER_8 *)tr1 = arg1;
	Result = F716_3915(Current, tr1);
	RTLE;
	return Result;
}

/* {INTEGER_8}.opposite */
EIF_INTEGER_8 F718_3984 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return *(EIF_INTEGER_8 *)F716_3930(Current);
}

/* {INTEGER_8}.integer_quotient */
EIF_INTEGER_8 F718_3985 (EIF_REFERENCE Current, EIF_INTEGER_8 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_8 Result = ((EIF_INTEGER_8) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(717, 0x00).id, 717, _OBJSIZ_0_1_0_0_0_0_0_0_);
	*(EIF_INTEGER_8 *)tr1 = arg1;
	tr1 = F716_3931(Current, tr1);
	Result = *(EIF_INTEGER_8 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_8}.integer_remainder */
EIF_INTEGER_8 F718_3986 (EIF_REFERENCE Current, EIF_INTEGER_8 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_8 Result = ((EIF_INTEGER_8) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(717, 0x00).id, 717, _OBJSIZ_0_1_0_0_0_0_0_0_);
	*(EIF_INTEGER_8 *)tr1 = arg1;
	tr1 = F716_3932(Current, tr1);
	Result = *(EIF_INTEGER_8 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_8}.as_natural_8 */
EIF_NATURAL_8 F718_3988 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_8) F716_3938(Current);
}

/* {INTEGER_8}.as_natural_64 */
EIF_NATURAL_64 F718_3991 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) F716_3941(Current);
}

/* {INTEGER_8}.as_integer_32 */
EIF_INTEGER_32 F718_3994 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) F716_3944(Current);
}

/* {INTEGER_8}.bit_shift_right */
EIF_INTEGER_8 F718_4005 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	
	
	return *(EIF_INTEGER_8 *)F716_3972(Current, arg1);
}

void EIF_Minit166 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
