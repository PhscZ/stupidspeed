/*
 * Code for class NATURAL_64
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "na161.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {NATURAL_64}.is_less */
EIF_BOOLEAN F749_3980 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	Result = F747_3921(Current, tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.plus */
EIF_NATURAL_64 F749_3981 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F747_3930(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.product */
EIF_NATURAL_64 F749_3983 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F747_3932(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.integer_quotient */
EIF_NATURAL_64 F749_3986 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F747_3936(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.integer_remainder */
EIF_NATURAL_64 F749_3987 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F747_3937(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.as_natural_32 */
EIF_NATURAL_32 F749_3991 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_32) F747_3944(Current);
}

/* {NATURAL_64}.as_integer_32 */
EIF_INTEGER_32 F749_3995 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) F747_3948(Current);
}

/* {NATURAL_64}.bit_and */
EIF_NATURAL_64 F749_4001 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F747_3969(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

void EIF_Minit161 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
