/*
 * Code for class REAL_64
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "re181.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {REAL_64}.is_less */
EIF_BOOLEAN F733_4452 (EIF_REFERENCE Current, EIF_REAL_64 arg1)
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
	tr1 = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_0_0_0_1_);
	*(EIF_REAL_64 *)tr1 = arg1;
	Result = F731_4422(Current, tr1);
	RTLE;
	return Result;
}

/* {REAL_64}.truncated_to_integer */
EIF_INTEGER_32 F733_4456 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) F731_4433(Current);
}

/* {REAL_64}.plus */
EIF_REAL_64 F733_4461 (EIF_REFERENCE Current, EIF_REAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REAL_64 Result = ((EIF_REAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_0_0_0_1_);
	*(EIF_REAL_64 *)tr1 = arg1;
	tr1 = F731_4443(Current, tr1);
	Result = *(EIF_REAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {REAL_64}.minus */
EIF_REAL_64 F733_4462 (EIF_REFERENCE Current, EIF_REAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REAL_64 Result = ((EIF_REAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_0_0_0_1_);
	*(EIF_REAL_64 *)tr1 = arg1;
	tr1 = F731_4444(Current, tr1);
	Result = *(EIF_REAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {REAL_64}.product */
EIF_REAL_64 F733_4463 (EIF_REFERENCE Current, EIF_REAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REAL_64 Result = ((EIF_REAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_0_0_0_1_);
	*(EIF_REAL_64 *)tr1 = arg1;
	tr1 = F731_4445(Current, tr1);
	Result = *(EIF_REAL_64 *)(tr1);
	RTLE;
	return Result;
}

/* {REAL_64}.quotient */
EIF_REAL_64 F733_4464 (EIF_REFERENCE Current, EIF_REAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REAL_64 Result = ((EIF_REAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_0_0_0_1_);
	*(EIF_REAL_64 *)tr1 = arg1;
	tr1 = F731_4446(Current, tr1);
	Result = *(EIF_REAL_64 *)(tr1);
	RTLE;
	return Result;
}

void EIF_Minit181 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
