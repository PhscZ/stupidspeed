/*
 * Code for class ENCODING_IMP
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "en201.h"
#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INLINE_F823_5161
static EIF_INTEGER_32 inline_F823_5161 (EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	return WideCharToMultiByte (arg1, 0, arg2, arg3, NULL, 0, NULL, NULL);
	;
}
#define INLINE_F823_5161
#endif
#ifndef INLINE_F823_5163
static void inline_F823_5163 (EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3, EIF_POINTER arg4, EIF_INTEGER_32 arg5, EIF_BOOLEAN* arg6, EIF_BOOLEAN* arg7)
{
	DWORD dw;
				BOOL l_lost = EIF_FALSE;
				LPBOOL lpUsedDefaultChar = NULL;
				DWORD dwFlags = WC_NO_BEST_FIT_CHARS;

				if (arg1 == CP_UTF7 || arg1 == CP_UTF8) {
					lpUsedDefaultChar = NULL;
				} else {
					lpUsedDefaultChar = &l_lost;
				}
				
				/* For following values, dwFlags = 0 is required by MSDN
				 * See http://msdn.microsoft.com/en-us/library/windows/desktop/dd374130(v=vs.85).aspx
				 */
				if (arg1 == 50220 || arg1 == 50221 || arg1 == 50222 || arg1 == 50225 || arg1 == 50227 || arg1 == 50229 || arg1 == 65000 || arg1 == 42) {
					dwFlags = 0;
				} else if (arg1 == 65001 || arg1 == 54936) {
					dwFlags = 0;
				} else if (arg1 >= 57002 && arg1 <= 57011) {
					dwFlags = 0;
				}
				
				WideCharToMultiByte ((UINT) arg1, dwFlags, (LPCWSTR) arg2,
					(int) arg3, (LPSTR) arg4, (int) arg5, (LPCCH) NULL, lpUsedDefaultChar);
					
				dw = GetLastError();
				if (dw == ERROR_INSUFFICIENT_BUFFER || dw == ERROR_INVALID_FLAGS || dw == ERROR_INVALID_PARAMETER) {
					*arg6 = 0;
				}
				*arg7 = (l_lost ? EIF_TRUE : EIF_FALSE);
	;
}
#define INLINE_F823_5163
#endif
#ifndef INLINE_F823_5162
static EIF_INTEGER_32 inline_F823_5162 (EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	return MultiByteToWideChar (arg1, 0, arg2, arg3, NULL, 0);
	;
}
#define INLINE_F823_5162
#endif
#ifndef INLINE_F823_5165
static EIF_INTEGER_32 inline_F823_5165 (void)
{
	return sizeof(WCHAR);
	;
}
#define INLINE_F823_5165
#endif
#ifndef INLINE_F823_5164
static void inline_F823_5164 (EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3, EIF_POINTER arg4, EIF_INTEGER_32 arg5, EIF_BOOLEAN* arg6)
{
	DWORD dw;
    
	MultiByteToWideChar ((UINT) arg1, (DWORD) 0, (LPCCH) arg2,
		(int) arg3, (LPWSTR) arg4, (int) arg5);
	dw = GetLastError();
	if (dw == ERROR_INSUFFICIENT_BUFFER || dw == ERROR_INVALID_FLAGS || dw == ERROR_INVALID_PARAMETER || dw == ERROR_NO_UNICODE_TRANSLATION) {
		*arg6 = 0;
	}
	;
}
#define INLINE_F823_5164
#endif

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {ENCODING_IMP}.convert_to */
void F823_5150 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2, EIF_REFERENCE arg3)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_BOOLEAN loc4 = (EIF_BOOLEAN) 0;
	EIF_BOOLEAN loc5 = (EIF_BOOLEAN) 0;
	EIF_REFERENCE loc6 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc7 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(11);
	RTLR(0,Current);
	RTLR(1,arg2);
	RTLR(2,tr1);
	RTLR(3,loc1);
	RTLR(4,arg1);
	RTLR(5,loc2);
	RTLR(6,arg3);
	RTLR(7,loc3);
	RTLR(8,tr2);
	RTLR(9,loc6);
	RTLR(10,loc7);
	RTLIU(11);
	
	RTGC;
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_2_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3462[Dtype(RTCW(arg2))-814])(arg2);
	if (tb1) {
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
		tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3459[Dtype(RTCW(arg2))-814])(arg2);
		if (tb1) {
			tr1 = RTMS_EX_H("",0,0);
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
		} else {
			tr1 = RTMS32_EX_H("",0,0);
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
		}
		tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3460[Dtype(RTCW(arg2))-814])(arg2);
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_1_) = (EIF_BOOLEAN) tb1;
	} else {
		loc1 = F823_5156(Current, arg1);
		loc2 = F823_5156(Current, arg3);
		loc4 = F823_5160(Current, arg1);
		loc5 = F823_5160(Current, arg3);
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
		if (F823_5158(Current, arg1)) {
			loc3 = F811_4660(RTCW(arg2));
			if ((EIF_BOOLEAN)(loc4 == RTOSCF(547,F32_547, (Current)))) {
				tr1 = F32_546(Current, loc3);
				loc3 = (EIF_REFERENCE) tr1;
			}
			if (F823_5159(Current, arg3)) {
				tr1 = RTLNS(eif_new_type(821, 0x01).id, 821, _OBJSIZ_1_2_0_0_0_0_0_0_);
				tr2 = F822_5146(RTCW(tr1), loc3);
				loc3 = (EIF_REFERENCE) tr2;
				if ((EIF_BOOLEAN)(loc5 == RTOSCF(547,F32_547, (Current)))) {
					loc6 = F32_545(Current, loc3);
				} else {
					loc6 = (EIF_REFERENCE) loc3;
				}
				RTAR(Current, loc6);
				*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc6;
			} else {
				if (F823_5158(Current, arg3)) {
					if ((EIF_BOOLEAN)(loc5 == RTOSCF(547,F32_547, (Current)))) {
						loc6 = F32_546(Current, loc3);
					} else {
						loc6 = (EIF_REFERENCE) loc3;
					}
					RTAR(Current, loc6);
					*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc6;
					*(EIF_BOOLEAN *)(Current+ _CHROFF_1_1_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
				} else {
					loc7 = F823_5151(Current, loc2, loc3);
					RTAR(Current, loc7);
					*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc7;
				}
			}
		} else {
			if (F823_5159(Current, arg1)) {
				loc3 = F811_4660(RTCW(arg2));
				if ((EIF_BOOLEAN)(loc4 == RTOSCF(547,F32_547, (Current)))) {
					tr1 = F32_545(Current, loc3);
					loc3 = (EIF_REFERENCE) tr1;
				}
				if (F823_5158(Current, arg3)) {
					tr1 = RTLNS(eif_new_type(821, 0x01).id, 821, _OBJSIZ_1_2_0_0_0_0_0_0_);
					tr2 = F822_5145(RTCW(tr1), loc3);
					loc3 = (EIF_REFERENCE) tr2;
					if ((EIF_BOOLEAN)(loc5 == RTOSCF(547,F32_547, (Current)))) {
						loc6 = F32_546(Current, loc3);
					} else {
						loc6 = (EIF_REFERENCE) loc3;
					}
					RTAR(Current, loc6);
					*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc6;
					*(EIF_BOOLEAN *)(Current+ _CHROFF_1_1_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
				} else {
					if (F823_5159(Current, arg3)) {
						if ((EIF_BOOLEAN)(loc5 == RTOSCF(547,F32_547, (Current)))) {
							loc6 = F32_545(Current, loc3);
						} else {
							loc6 = F1_14(loc3);
						}
						RTAR(Current, loc6);
						*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc6;
					} else {
						tr1 = RTLNS(eif_new_type(821, 0x01).id, 821, _OBJSIZ_1_2_0_0_0_0_0_0_);
						loc6 = F822_5145(RTCW(tr1), loc3);
						loc7 = F823_5151(Current, loc2, loc6);
						RTAR(Current, loc7);
						*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc7;
					}
				}
			} else {
				tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3461[Dtype(RTCW(arg2))-814])(arg2);
				if (tb1) {
					tr1 = F811_4654(RTCW(arg2));
				} else {
					tr2 = RTLNS(eif_new_type(10, 0x00).id, 10, _OBJSIZ_0_0_0_0_0_0_0_0_);
					tr1 = F11_253(RTCW(tr2), arg2);
				}
				loc3 = F823_5152(Current, loc1, tr1);
				if (F823_5158(Current, arg3)) {
					if ((EIF_BOOLEAN)(loc5 == RTOSCF(547,F32_547, (Current)))) {
						loc6 = F32_546(Current, loc3);
					} else {
						loc6 = (EIF_REFERENCE) loc3;
					}
					RTAR(Current, loc6);
					*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc6;
					*(EIF_BOOLEAN *)(Current+ _CHROFF_1_1_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
				} else {
					if (F823_5159(Current, arg3)) {
						tr1 = RTLNS(eif_new_type(821, 0x01).id, 821, _OBJSIZ_1_2_0_0_0_0_0_0_);
						tr2 = F822_5146(RTCW(tr1), loc3);
						loc3 = (EIF_REFERENCE) tr2;
						if ((EIF_BOOLEAN)(loc5 == RTOSCF(547,F32_547, (Current)))) {
							loc6 = F32_545(Current, loc3);
						} else {
							loc6 = (EIF_REFERENCE) loc3;
						}
						RTAR(Current, loc6);
						*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc6;
					} else {
						loc7 = F823_5151(Current, loc2, loc3);
						RTAR(Current, loc7);
						*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) loc7;
					}
				}
			}
		}
	}
	RTLE;
}

/* {ENCODING_IMP}.wide_char_to_multi_byte */
EIF_REFERENCE F823_5151 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(6);
	RTLR(0,loc2);
	RTLR(1,arg2);
	RTLR(2,Current);
	RTLR(3,arg1);
	RTLR(4,loc3);
	RTLR(5,Result);
	RTLIU(6);
	
	RTGC;
	loc2 = F32_537(Current, arg2);
	ti4_1 = F811_4666(RTCW(arg1));
	tp1 = *(EIF_POINTER *)(RTCW(loc2)+ _PTROFF_0_1_0_1_0_0_);
	ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg2)+ _LNGOFF_1_1_0_2_);
	loc1 = inline_F823_5161(ti4_1, tp1, ti4_2);
	loc3 = RTLNS(eif_new_type(116, 0x01).id, 116, _OBJSIZ_0_1_0_1_0_1_1_0_);
	F117_1201(RTCW(loc3), loc1);
	ti4_1 = F811_4666(RTCW(arg1));
	tp1 = *(EIF_POINTER *)(RTCW(loc2)+ _PTROFF_0_1_0_1_0_0_);
	ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg2)+ _LNGOFF_1_1_0_2_);
	tp2 = *(EIF_POINTER *)(RTCW(loc3)+ _PTROFF_0_1_0_1_0_0_);
	inline_F823_5163(ti4_1, tp1, ti4_2, tp2, loc1, (EIF_BOOLEAN *) &(*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_)), (EIF_BOOLEAN *) &(*(EIF_BOOLEAN *)(Current+ _CHROFF_1_2_)));
	tp1 = *(EIF_POINTER *)(RTCW(loc3)+ _PTROFF_0_1_0_1_0_0_);
	Result = F32_538(Current, tp1, loc1);
	RTLE;
	return Result;
}

/* {ENCODING_IMP}.multi_byte_to_wide_char */
EIF_REFERENCE F823_5152 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(6);
	RTLR(0,loc2);
	RTLR(1,arg2);
	RTLR(2,Current);
	RTLR(3,arg1);
	RTLR(4,loc3);
	RTLR(5,Result);
	RTLIU(6);
	
	RTGC;
	loc2 = F32_536(Current, arg2);
	ti4_1 = F811_4666(RTCW(arg1));
	tp1 = *(EIF_POINTER *)(RTCW(loc2)+ _PTROFF_0_1_0_1_0_0_);
	ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg2)+ _LNGOFF_1_1_0_2_);
	loc1 = inline_F823_5162(ti4_1, tp1, ti4_2);
	loc3 = RTLNS(eif_new_type(116, 0x01).id, 116, _OBJSIZ_0_1_0_1_0_1_1_0_);
	ti4_1 = inline_F823_5165();
	F117_1201(RTCW(loc3), (EIF_INTEGER_32) (loc1 * ti4_1));
	ti4_1 = F811_4666(RTCW(arg1));
	tp1 = *(EIF_POINTER *)(RTCW(loc2)+ _PTROFF_0_1_0_1_0_0_);
	ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg2)+ _LNGOFF_1_1_0_2_);
	tp2 = *(EIF_POINTER *)(RTCW(loc3)+ _PTROFF_0_1_0_1_0_0_);
	inline_F823_5164(ti4_1, tp1, ti4_2, tp2, loc1, (EIF_BOOLEAN *) &(*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_)));
	tp1 = *(EIF_POINTER *)(RTCW(loc3)+ _PTROFF_0_1_0_1_0_0_);
	ti4_1 = inline_F823_5165();
	Result = F32_539(Current, tp1, (EIF_INTEGER_32) (loc1 * ti4_1));
	RTLE;
	return Result;
}

/* {ENCODING_IMP}.is_code_page_valid */
EIF_BOOLEAN F823_5153 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN tb2;
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tb1 = '\0';
	if ((EIF_BOOLEAN)(arg1 != NULL)) {
		tb2 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3462[Dtype(RTCW(arg1))-814])(arg1);
		tb1 = (EIF_BOOLEAN) !tb2;
	}
	if (tb1) {
		RTLE;
		return (EIF_BOOLEAN) F823_5157(Current, arg1);
	}
	RTLE;
	return (EIF_BOOLEAN) 0;
}

/* {ENCODING_IMP}.is_code_page_convertible */
EIF_BOOLEAN F823_5154 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	
	
	return (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
}

/* {ENCODING_IMP}.last_conversion_lost_data */
EIF_BOOLEAN F823_5155 (EIF_REFERENCE Current)
{
	return *(EIF_BOOLEAN *)(Current+ _CHROFF_1_2_);
}


/* {ENCODING_IMP}.platform_code_page_from_name */
EIF_REFERENCE F823_5156 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(5);
	RTLR(0,loc1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,arg1);
	RTLR(4,Result);
	RTLIU(5);
	
	RTGC;
	RTCT0("from_precondition", EX_CHECK);
	tr1 = RTOSCF(532,F31_532, (Current));
	tr1 = F629_2931(RTCW(tr1), arg1);
	loc1 = tr1;
	if (EIF_TEST(loc1)) {
		RTCK0;
	} else {
		RTCF0;
	}
	Result = (EIF_REFERENCE) loc1;
	RTLE;
	return Result;
}

/* {ENCODING_IMP}.is_known_code_page */
EIF_BOOLEAN F823_5157 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	tr1 = RTOSCF(532,F31_532, (Current));
	Result = F629_2933(RTCW(tr1), arg1);
	RTLE;
	return Result;
}

/* {ENCODING_IMP}.is_two_byte_code_page */
EIF_BOOLEAN F823_5158 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	tr1 = RTOSCF(533,F31_533, (Current));
	Result = F629_2933(RTCW(tr1), arg1);
	RTLE;
	return Result;
}

/* {ENCODING_IMP}.is_four_bype_code_page */
EIF_BOOLEAN F823_5159 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	tr1 = RTOSCF(534,F31_534, (Current));
	Result = F629_2933(RTCW(tr1), arg1);
	RTLE;
	return Result;
}

/* {ENCODING_IMP}.is_big_endian_code_page */
EIF_BOOLEAN F823_5160 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	tr1 = RTOSCF(535,F31_535, (Current));
	Result = F629_2933(RTCW(tr1), arg1);
	RTLE;
	return Result;
}

/* {ENCODING_IMP}.cwin_widechartomultibyte_buffer_length */
EIF_INTEGER_32 F823_5161 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	
	Result = inline_F823_5161 ((EIF_INTEGER_32) arg1, (EIF_POINTER) arg2, (EIF_INTEGER_32) arg3);
	return Result;
}

/* {ENCODING_IMP}.cwin_multibytetowidechar_buffer_length */
EIF_INTEGER_32 F823_5162 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	
	Result = inline_F823_5162 ((EIF_INTEGER_32) arg1, (EIF_POINTER) arg2, (EIF_INTEGER_32) arg3);
	return Result;
}

/* {ENCODING_IMP}.cwin_wide_char_to_multi_byte */
void F823_5163 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3, EIF_POINTER arg4, EIF_INTEGER_32 arg5, EIF_BOOLEAN* arg6, EIF_BOOLEAN* arg7)
{
	GTCX
	
	
	inline_F823_5163 ((EIF_INTEGER_32) arg1, (EIF_POINTER) arg2, (EIF_INTEGER_32) arg3, (EIF_POINTER) arg4, (EIF_INTEGER_32) arg5, (EIF_BOOLEAN*) arg6, (EIF_BOOLEAN*) arg7);
}

/* {ENCODING_IMP}.cwin_multi_byte_to_wide_char */
void F823_5164 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3, EIF_POINTER arg4, EIF_INTEGER_32 arg5, EIF_BOOLEAN* arg6)
{
	GTCX
	
	
	inline_F823_5164 ((EIF_INTEGER_32) arg1, (EIF_POINTER) arg2, (EIF_INTEGER_32) arg3, (EIF_POINTER) arg4, (EIF_INTEGER_32) arg5, (EIF_BOOLEAN*) arg6);
}

/* {ENCODING_IMP}.wchar_length */
EIF_INTEGER_32 F823_5165 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	
	Result = inline_F823_5165 ();
	return Result;
}

void EIF_Minit201 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
