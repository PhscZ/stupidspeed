/*
 * Code for class INTEGER_64
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "in148.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {INTEGER_64}.is_less */
EIF_BOOLEAN F700_3570 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
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
	tr1 = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_INTEGER_64 *)tr1 = arg1;
	Result = F698_3508(Current, tr1);
	RTLE;
	return Result;
}

/* {INTEGER_64}.plus */
EIF_INTEGER_64 F700_3571 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_INTEGER_64 *)tr1 = arg1;
	tr1 = F698_3518(Current, tr1);
	Result = *(EIF_INTEGER_64 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_64}.minus */
EIF_INTEGER_64 F700_3572 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_INTEGER_64 *)tr1 = arg1;
	tr1 = F698_3519(Current, tr1);
	Result = *(EIF_INTEGER_64 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_64}.opposite */
EIF_INTEGER_64 F700_3576 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return *(EIF_INTEGER_64 *)F698_3523(Current);
}

/* {INTEGER_64}.integer_quotient */
EIF_INTEGER_64 F700_3577 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_INTEGER_64 *)tr1 = arg1;
	tr1 = F698_3524(Current, tr1);
	Result = *(EIF_INTEGER_64 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_64}.integer_remainder */
EIF_INTEGER_64 F700_3578 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_INTEGER_64 *)tr1 = arg1;
	tr1 = F698_3525(Current, tr1);
	Result = *(EIF_INTEGER_64 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_64}.as_natural_64 */
EIF_NATURAL_64 F700_3583 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) F698_3533(Current);
}

/* {INTEGER_64}.as_integer_32 */
EIF_INTEGER_32 F700_3586 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) F698_3536(Current);
}

/* {INTEGER_64}.to_character_8 */
EIF_CHARACTER_8 F700_3590 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_CHARACTER_8) F698_3556(Current);
}

/* {INTEGER_64}.bit_and */
EIF_INTEGER_64 F700_3592 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_INTEGER_64 *)tr1 = arg1;
	tr1 = F698_3558(Current, tr1);
	Result = *(EIF_INTEGER_64 *)(tr1);
	RTLE;
	return Result;
}

void EIF_Minit148 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
