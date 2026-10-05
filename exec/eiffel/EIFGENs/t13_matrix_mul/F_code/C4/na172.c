/*
 * Code for class NATURAL_64
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "na172.h"

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
EIF_BOOLEAN F760_4139 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	Result = F758_4080(Current, tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.plus */
EIF_NATURAL_64 F760_4140 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F758_4089(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.product */
EIF_NATURAL_64 F760_4142 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F758_4091(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.integer_quotient */
EIF_NATURAL_64 F760_4145 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F758_4095(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.integer_remainder */
EIF_NATURAL_64 F760_4146 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F758_4096(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {NATURAL_64}.as_natural_32 */
EIF_NATURAL_32 F760_4150 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_32) F758_4103(Current);
}

/* {NATURAL_64}.as_integer_32 */
EIF_INTEGER_32 F760_4154 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) F758_4107(Current);
}

/* {NATURAL_64}.bit_and */
EIF_NATURAL_64 F760_4160 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
	*(EIF_NATURAL_64 *)tr1 = arg1;
	tr1 = F758_4128(Current, tr1);
	Result = *(EIF_NATURAL_64 *)(tr1);
	RTLE;
	return Result;
}

void EIF_Minit172 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
