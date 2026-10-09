#include "epoly2.h"
#include "../E1/eoffsets.h"


#ifdef __cplusplus
extern "C" {
#endif

char *(*R696[4])();
void R696_init () {
	R696[0] = (char *(*)()) F46_716;
	R696[1] = (char *(*)()) F47_716_696_1;
	R696[2] = (char *(*)()) F48_716_696_1;
	R696[3] = (char *(*)()) F49_716_696_1;
}
static EIF_REFERENCE F47_716_696_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F47_716(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F48_716_696_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F48_716(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F49_716_696_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F49_716(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}

char *(*R1026[39])();
void R1026_init () {
	R1026[0] = (char *(*)()) F77_1086;
	R1026[1] = (char *(*)()) F78_1110;
	R1026[4] = (char *(*)()) F81_1112;
	R1026[6] = (char *(*)()) F83_1114;
	R1026[7] = (char *(*)()) F84_1118;
	R1026[8] = (char *(*)()) F85_1124;
	R1026[10] = (char *(*)()) F87_1141;
	R1026[11] = (char *(*)()) F88_1143;
	R1026[12] = (char *(*)()) F89_1145;
	R1026[14] = (char *(*)()) F91_1147;
	R1026[15] = (char *(*)()) F92_1151;
	R1026[18] = (char *(*)()) F95_1153;
	R1026[19] = (char *(*)()) F96_1155;
	R1026[21] = (char *(*)()) F98_1159;
	R1026[22] = (char *(*)()) F99_1161;
	R1026[23] = (char *(*)()) F100_1167;
	R1026[25] = (char *(*)()) F102_1169;
	R1026[26] = (char *(*)()) F103_1171;
	R1026[27] = (char *(*)()) F104_1175;
	R1026[28] = (char *(*)()) F105_1179;
	R1026[30] = (char *(*)()) F107_1181;
	R1026[31] = (char *(*)()) F108_1183;
	R1026[33] = (char *(*)()) F110_1185;
	R1026[34] = (char *(*)()) F111_1187;
	R1026[35] = (char *(*)()) F112_1189;
	R1026[36] = (char *(*)()) F113_1191;
	R1026[37] = (char *(*)()) F114_1195;
	R1026[38] = (char *(*)()) F115_1197;
}

char *(*R1178[96])();
void R1178_init () {
	R1178[0] = (char *(*)()) F735_3542_1178_2;
	R1178[1] = (char *(*)()) F736_3542_1178_2;
	{long i; for (i = 3; i < 5; i++) R1178[i] = (char *(*)()) F737_3573;}
	{long i; for (i = 6; i < 8; i++) R1178[i] = (char *(*)()) F740_3613;}
	R1178[12] = (char *(*)()) F747_3747_1178_2;
	R1178[13] = (char *(*)()) F748_3747_1178_2;
	R1178[15] = (char *(*)()) F750_3846_1178_2;
	R1178[16] = (char *(*)()) F751_3846_1178_2;
	R1178[18] = (char *(*)()) F753_3945_1178_2;
	R1178[19] = (char *(*)()) F754_3945_1178_2;
	R1178[21] = (char *(*)()) F756_4044_1178_2;
	R1178[22] = (char *(*)()) F757_4044_1178_2;
	R1178[24] = (char *(*)()) F759_4139_1178_2;
	R1178[25] = (char *(*)()) F760_4139_1178_2;
	R1178[27] = (char *(*)()) F762_4233_1178_2;
	R1178[28] = (char *(*)()) F763_4233_1178_2;
	R1178[30] = (char *(*)()) F765_4328_1178_2;
	R1178[31] = (char *(*)()) F766_4328_1178_2;
	R1178[33] = (char *(*)()) F768_4423_1178_2;
	R1178[34] = (char *(*)()) F769_4423_1178_2;
	R1178[36] = (char *(*)()) F771_4492_1178_2;
	R1178[37] = (char *(*)()) F772_4492_1178_2;
	{long i; for (i = 80; i < 82; i++) R1178[i] = (char *(*)()) F814_4760;}
	{long i; for (i = 83; i < 85; i++) R1178[i] = (char *(*)()) F817_4928;}
	R1178[95] = (char *(*)()) F830_5304;
}
static EIF_BOOLEAN F735_3542_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F735_3542(Current, *(EIF_REAL_64 *)arg1);
}
static EIF_BOOLEAN F736_3542_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F736_3542(Current, *(EIF_REAL_64 *)arg1);
}
static EIF_BOOLEAN F747_3747_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F747_3747(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F748_3747_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F748_3747(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F750_3846_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F750_3846(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F751_3846_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F751_3846(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F753_3945_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F753_3945(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F754_3945_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F754_3945(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F756_4044_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F756_4044(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F757_4044_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F757_4044(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F759_4139_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F759_4139(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F760_4139_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F760_4139(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F762_4233_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F762_4233(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F763_4233_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F763_4233(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F765_4328_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F765_4328(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F766_4328_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F766_4328(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F768_4423_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F768_4423(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F769_4423_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F769_4423(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F771_4492_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F771_4492(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F772_4492_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F772_4492(Current, *(EIF_REAL_32 *)arg1);
}

char *(*R1708[663])();
void R1708_init () {
	R1708[0] = (char *(*)()) F147_1884;
	R1708[389] = (char *(*)()) F144_1884;
	R1708[390] = (char *(*)()) F145_1884;
	R1708[391] = (char *(*)()) F146_1884;
	R1708[392] = (char *(*)()) F147_1884;
	R1708[393] = (char *(*)()) F148_1884;
	R1708[394] = (char *(*)()) F149_1884;
	R1708[395] = (char *(*)()) F150_1884;
	R1708[396] = (char *(*)()) F151_1884;
	R1708[397] = (char *(*)()) F152_1884;
	R1708[398] = (char *(*)()) F153_1884;
	R1708[399] = (char *(*)()) F154_1884;
	R1708[400] = (char *(*)()) F155_1884;
	R1708[401] = (char *(*)()) F156_1884;
	R1708[659] = (char *(*)()) F145_1884;
	R1708[662] = (char *(*)()) F146_1884;
}

char *(*R1709[663])();
void R1709_init () {
	R1709[0] = (char *(*)()) F147_1885_1709_115;
	R1709[389] = (char *(*)()) F144_1885;
	R1709[390] = (char *(*)()) F145_1885_1709_115;
	R1709[391] = (char *(*)()) F146_1885_1709_115;
	R1709[392] = (char *(*)()) F147_1885_1709_115;
	R1709[393] = (char *(*)()) F148_1885_1709_115;
	R1709[394] = (char *(*)()) F149_1885_1709_115;
	R1709[395] = (char *(*)()) F150_1885_1709_115;
	R1709[396] = (char *(*)()) F151_1885_1709_115;
	R1709[397] = (char *(*)()) F152_1885_1709_115;
	R1709[398] = (char *(*)()) F153_1885_1709_115;
	R1709[399] = (char *(*)()) F154_1885_1709_115;
	R1709[400] = (char *(*)()) F155_1885_1709_115;
	R1709[401] = (char *(*)()) F156_1885_1709_115;
	R1709[659] = (char *(*)()) F145_1885_1709_115;
	R1709[662] = (char *(*)()) F146_1885_1709_115;
}
static void F147_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F147_1885(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F145_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F145_1885(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F146_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F146_1885(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F148_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F148_1885(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F149_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F149_1885(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F150_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F150_1885(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F151_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F151_1885(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F152_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F152_1885(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F153_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F153_1885(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F154_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F154_1885(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F155_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F155_1885(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F156_1885_1709_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F156_1885(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R1715[663])();
void R1715_init () {
	R1715[0] = (char *(*)()) F147_1891;
	R1715[389] = (char *(*)()) F144_1891;
	R1715[390] = (char *(*)()) F145_1891;
	R1715[391] = (char *(*)()) F146_1891;
	R1715[392] = (char *(*)()) F147_1891;
	R1715[393] = (char *(*)()) F148_1891;
	R1715[394] = (char *(*)()) F149_1891;
	R1715[395] = (char *(*)()) F150_1891;
	R1715[396] = (char *(*)()) F151_1891;
	R1715[397] = (char *(*)()) F152_1891;
	R1715[398] = (char *(*)()) F153_1891;
	R1715[399] = (char *(*)()) F154_1891;
	R1715[400] = (char *(*)()) F155_1891;
	R1715[401] = (char *(*)()) F156_1891;
	R1715[659] = (char *(*)()) F145_1891;
	R1715[662] = (char *(*)()) F146_1891;
}

char *(*R1775[4])();
void R1775_init () {
	R1775[0] = (char *(*)()) F239_2079;
	R1775[1] = (char *(*)()) F240_2079;
	R1775[2] = (char *(*)()) F241_2079_1775_1;
	R1775[3] = (char *(*)()) F242_2079_1775_1;
}
static EIF_REFERENCE F241_2079_1775_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F241_2079(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F242_2079_1775_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F242_2079(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1776[210])();
void R1776_init () {
	R1776[0] = (char *(*)()) F239_2082;
	R1776[1] = (char *(*)()) F240_2082;
	R1776[2] = (char *(*)()) F241_2082;
	R1776[3] = (char *(*)()) F242_2082;
	R1776[209] = (char *(*)()) F447_2208;
}

char *(*R1777[210])();
void R1777_init () {
	R1777[0] = (char *(*)()) F239_2083;
	R1777[1] = (char *(*)()) F240_2083;
	R1777[2] = (char *(*)()) F241_2083;
	R1777[3] = (char *(*)()) F242_2083;
	R1777[209] = (char *(*)()) F447_2214;
}

char *(*R1788[4])();
void R1788_init () {
	R1788[0] = (char *(*)()) F239_2080;
	R1788[1] = (char *(*)()) F240_2080_1788_1;
	R1788[2] = (char *(*)()) F241_2080;
	R1788[3] = (char *(*)()) F242_2080_1788_1;
}
static EIF_REFERENCE F240_2080_1788_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F240_2080(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F242_2080_1788_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F242_2080(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1790[7])();
void R1790_init () {
	R1790[0] = (char *(*)()) F629_2940;
	R1790[1] = (char *(*)()) F630_2940;
	R1790[2] = (char *(*)()) F631_2940;
	R1790[3] = (char *(*)()) F632_2940;
	R1790[4] = (char *(*)()) F629_2940;
	R1790[5] = (char *(*)()) F631_2940;
	R1790[6] = (char *(*)()) F629_2940;
}

static EIF_TYPE_INDEX Y1791_pgtype0[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype1[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype2[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype3[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype4[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype5[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype6[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype7[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype8[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype9[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype10[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype11[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype12[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype13[] = {0xFF01,818,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype14[] = {0xFF01,814,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype15[] = {738,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype16[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype17[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype18[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype19[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype20[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype21[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype22[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype23[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype24[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype25[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype26[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype27[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype28[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype29[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype30[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype31[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype32[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype33[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype34[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype35[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype36[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype37[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype38[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype39[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype40[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype41[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype42[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype43[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype44[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype45[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype46[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype47[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype48[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype49[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype50[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype51[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype52[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype53[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype54[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype55[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype56[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype57[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype58[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype59[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype60[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype61[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype62[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype63[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype64[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype65[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype66[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype67[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype68[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype69[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype70[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype71[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype72[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype73[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype74[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype75[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype76[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype77[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype78[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype79[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype80[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype81[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype82[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype83[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype84[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype85[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype86[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype87[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype88[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype89[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype90[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype91[] = {738,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype92[] = {741,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype93[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype94[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype95[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype96[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype97[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype98[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype99[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype100[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype101[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype102[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype103[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype104[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype105[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype106[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype107[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype108[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype109[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype110[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype111[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype112[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype113[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype114[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype115[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype116[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype117[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype118[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype119[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype120[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype121[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype122[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype123[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype124[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype125[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype126[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype127[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype128[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype129[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype130[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype131[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype132[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype133[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype134[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype135[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype136[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype137[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype138[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype139[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype140[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype141[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype142[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype143[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype144[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype145[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype146[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype147[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype148[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype149[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype150[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype151[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype152[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype153[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype154[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype155[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype156[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype157[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype158[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype159[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype160[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype161[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype162[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype163[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype164[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype165[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype166[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype167[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype168[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype169[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype170[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype171[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype172[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype173[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype174[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype175[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype176[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype177[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype178[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype179[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype180[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype181[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype182[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype183[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype184[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype185[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype186[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype187[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype188[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype189[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype190[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype191[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype192[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype193[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype194[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype195[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype196[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype197[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype198[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype199[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype200[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype201[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype202[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype203[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype204[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype205[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype206[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype207[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype208[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype209[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype210[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype211[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype212[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype213[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype214[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype215[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype216[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype217[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype218[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype219[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype220[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype221[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype222[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype223[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype224[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype225[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype226[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype227[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype228[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype229[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype230[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype231[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype232[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype233[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype234[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype235[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype236[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype237[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype238[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype239[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype240[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype241[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype242[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype243[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype244[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype245[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype246[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype247[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype248[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype249[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype250[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype251[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype252[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype253[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype254[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype255[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype256[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype257[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype258[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype259[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype260[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype261[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype262[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype263[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype264[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype265[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype266[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype267[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype268[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype269[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype270[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype271[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype272[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype273[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype274[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype275[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype276[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype277[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype278[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype279[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype280[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype281[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype282[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype283[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype284[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype285[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype286[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype287[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype288[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype289[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype290[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype291[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype292[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype293[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype294[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype295[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype296[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype297[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype298[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype299[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype300[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype301[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype302[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype303[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype304[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype305[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype306[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype307[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype308[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype309[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype310[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype311[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype312[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype313[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype314[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype315[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype316[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype317[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype318[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype319[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype320[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype321[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype322[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype323[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype324[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype325[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype326[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype327[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype328[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype329[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype330[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype331[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype332[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype333[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype334[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype335[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype336[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype337[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype338[] = {741,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype339[] = {741,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype340[] = {741,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype341[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype342[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype343[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype344[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype345[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype346[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype347[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype348[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype349[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype350[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype351[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype352[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype353[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype354[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype355[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype356[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype357[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype358[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype359[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype360[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype361[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype362[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype363[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype364[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype365[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype366[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype367[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype368[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype369[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype370[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype371[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype372[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype373[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype374[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype375[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype376[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype377[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype378[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype379[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype380[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype381[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype382[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype383[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype384[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype385[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype386[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype387[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype388[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype389[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype390[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype391[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype392[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype393[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype394[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype395[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype396[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype397[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype398[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype399[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype400[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype401[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype402[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype403[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype404[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype405[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype406[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype407[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype408[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype409[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype410[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype411[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype412[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype413[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype414[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype415[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype416[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype417[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype418[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype419[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype420[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype421[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype422[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype423[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype424[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype425[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype426[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype427[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype428[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype429[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype430[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype431[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype432[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype433[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype434[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype435[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype436[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype437[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype438[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype439[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype440[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype441[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype442[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype443[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype444[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype445[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype446[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype447[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype448[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype449[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype450[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype451[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype452[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype453[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype454[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype455[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype456[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype457[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype458[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype459[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype460[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype461[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype462[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype463[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype464[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype465[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype466[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype467[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype468[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype469[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype470[] = {738,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype471[] = {738,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype472[] = {738,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype473[] = {741,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype474[] = {741,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype475[] = {741,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype476[] = {741,0xFFFF};
EIF_TYPE_INDEX *Y1791_gen_type [643];
EIF_TYPE_INDEX Y1791 [643];
void Y1791_init (void)
{
	egc_routines_types [1791] = Y1791;
	egc_routines_gen_types [1791] = Y1791_gen_type;
	egc_routines_offset [1791] = 177;
	Y1791_gen_type [0] = Y1791_pgtype0;
	Y1791_gen_type [1] = Y1791_pgtype1;
	Y1791_gen_type [2] = Y1791_pgtype2;
	Y1791_gen_type [3] = Y1791_pgtype3;
	Y1791_gen_type [4] = Y1791_pgtype4;
	Y1791_gen_type [5] = Y1791_pgtype5;
	Y1791_gen_type [6] = Y1791_pgtype6;
	Y1791_gen_type [7] = Y1791_pgtype7;
	Y1791_gen_type [8] = Y1791_pgtype8;
	Y1791_gen_type [9] = Y1791_pgtype9;
	Y1791_gen_type [10] = Y1791_pgtype10;
	Y1791_gen_type [11] = Y1791_pgtype11;
	Y1791_gen_type [12] = Y1791_pgtype12;
	Y1791_gen_type [13] = Y1791_pgtype13;
	Y1791_gen_type [14] = Y1791_pgtype14;
	Y1791_gen_type [15] = Y1791_pgtype15;
	Y1791_gen_type [16] = Y1791_pgtype16;
	Y1791_gen_type [17] = Y1791_pgtype17;
	Y1791_gen_type [18] = Y1791_pgtype18;
	Y1791_gen_type [19] = Y1791_pgtype19;
	Y1791_gen_type [20] = Y1791_pgtype20;
	Y1791_gen_type [21] = Y1791_pgtype21;
	Y1791_gen_type [22] = Y1791_pgtype22;
	Y1791_gen_type [23] = Y1791_pgtype23;
	Y1791_gen_type [24] = Y1791_pgtype24;
	Y1791_gen_type [25] = Y1791_pgtype25;
	Y1791_gen_type [26] = Y1791_pgtype26;
	Y1791_gen_type [27] = Y1791_pgtype27;
	Y1791_gen_type [28] = Y1791_pgtype28;
	Y1791_gen_type [29] = Y1791_pgtype29;
	Y1791_gen_type [30] = Y1791_pgtype30;
	Y1791_gen_type [31] = Y1791_pgtype31;
	Y1791_gen_type [32] = Y1791_pgtype32;
	Y1791_gen_type [33] = Y1791_pgtype33;
	Y1791_gen_type [34] = Y1791_pgtype34;
	Y1791_gen_type [35] = Y1791_pgtype35;
	Y1791_gen_type [36] = Y1791_pgtype36;
	Y1791_gen_type [37] = Y1791_pgtype37;
	Y1791_gen_type [38] = Y1791_pgtype38;
	Y1791_gen_type [39] = Y1791_pgtype39;
	Y1791_gen_type [40] = Y1791_pgtype40;
	Y1791_gen_type [41] = Y1791_pgtype41;
	Y1791_gen_type [42] = Y1791_pgtype42;
	Y1791_gen_type [43] = Y1791_pgtype43;
	Y1791_gen_type [44] = Y1791_pgtype44;
	Y1791_gen_type [45] = Y1791_pgtype45;
	Y1791_gen_type [46] = Y1791_pgtype46;
	Y1791_gen_type [47] = Y1791_pgtype47;
	Y1791_gen_type [48] = Y1791_pgtype48;
	Y1791_gen_type [49] = Y1791_pgtype49;
	Y1791_gen_type [50] = Y1791_pgtype50;
	Y1791_gen_type [51] = Y1791_pgtype51;
	Y1791_gen_type [52] = Y1791_pgtype52;
	Y1791_gen_type [53] = Y1791_pgtype53;
	Y1791_gen_type [54] = Y1791_pgtype54;
	Y1791_gen_type [55] = Y1791_pgtype55;
	Y1791_gen_type [56] = Y1791_pgtype56;
	Y1791_gen_type [57] = Y1791_pgtype57;
	Y1791_gen_type [58] = Y1791_pgtype58;
	Y1791_gen_type [59] = Y1791_pgtype59;
	Y1791_gen_type [60] = Y1791_pgtype60;
	Y1791_gen_type [61] = Y1791_pgtype61;
	Y1791_gen_type [62] = Y1791_pgtype62;
	Y1791_gen_type [63] = Y1791_pgtype63;
	Y1791_gen_type [64] = Y1791_pgtype64;
	Y1791_gen_type [65] = Y1791_pgtype65;
	Y1791_gen_type [66] = Y1791_pgtype66;
	Y1791_gen_type [67] = Y1791_pgtype67;
	Y1791_gen_type [68] = Y1791_pgtype68;
	Y1791_gen_type [69] = Y1791_pgtype69;
	Y1791_gen_type [70] = Y1791_pgtype70;
	Y1791_gen_type [71] = Y1791_pgtype71;
	Y1791_gen_type [72] = Y1791_pgtype72;
	Y1791_gen_type [73] = Y1791_pgtype73;
	Y1791_gen_type [74] = Y1791_pgtype74;
	Y1791_gen_type [75] = Y1791_pgtype75;
	Y1791_gen_type [76] = Y1791_pgtype76;
	Y1791_gen_type [77] = Y1791_pgtype77;
	Y1791_gen_type [78] = Y1791_pgtype78;
	Y1791_gen_type [79] = Y1791_pgtype79;
	Y1791_gen_type [80] = Y1791_pgtype80;
	Y1791_gen_type [81] = Y1791_pgtype81;
	Y1791_gen_type [82] = Y1791_pgtype82;
	Y1791_gen_type [83] = Y1791_pgtype83;
	Y1791_gen_type [84] = Y1791_pgtype84;
	Y1791_gen_type [85] = Y1791_pgtype85;
	Y1791_gen_type [86] = Y1791_pgtype86;
	Y1791_gen_type [87] = Y1791_pgtype87;
	Y1791_gen_type [88] = Y1791_pgtype88;
	Y1791_gen_type [89] = Y1791_pgtype89;
	Y1791_gen_type [90] = Y1791_pgtype90;
	Y1791_gen_type [91] = Y1791_pgtype91;
	Y1791_gen_type [92] = Y1791_pgtype92;
	Y1791_gen_type [93] = Y1791_pgtype93;
	Y1791_gen_type [94] = Y1791_pgtype94;
	Y1791_gen_type [95] = Y1791_pgtype95;
	Y1791_gen_type [96] = Y1791_pgtype96;
	Y1791_gen_type [97] = Y1791_pgtype97;
	Y1791_gen_type [98] = Y1791_pgtype98;
	Y1791_gen_type [99] = Y1791_pgtype99;
	Y1791_gen_type [100] = Y1791_pgtype100;
	Y1791_gen_type [101] = Y1791_pgtype101;
	Y1791_gen_type [102] = Y1791_pgtype102;
	Y1791_gen_type [103] = Y1791_pgtype103;
	Y1791_gen_type [104] = Y1791_pgtype104;
	Y1791_gen_type [105] = Y1791_pgtype105;
	Y1791_gen_type [106] = Y1791_pgtype106;
	Y1791_gen_type [107] = Y1791_pgtype107;
	Y1791_gen_type [108] = Y1791_pgtype108;
	Y1791_gen_type [109] = Y1791_pgtype109;
	Y1791_gen_type [110] = Y1791_pgtype110;
	Y1791_gen_type [111] = Y1791_pgtype111;
	Y1791_gen_type [112] = Y1791_pgtype112;
	Y1791_gen_type [113] = Y1791_pgtype113;
	Y1791_gen_type [114] = Y1791_pgtype114;
	Y1791_gen_type [115] = Y1791_pgtype115;
	Y1791_gen_type [116] = Y1791_pgtype116;
	Y1791_gen_type [117] = Y1791_pgtype117;
	Y1791_gen_type [118] = Y1791_pgtype118;
	Y1791_gen_type [119] = Y1791_pgtype119;
	Y1791_gen_type [120] = Y1791_pgtype120;
	Y1791_gen_type [121] = Y1791_pgtype121;
	Y1791_gen_type [122] = Y1791_pgtype122;
	Y1791_gen_type [123] = Y1791_pgtype123;
	Y1791_gen_type [124] = Y1791_pgtype124;
	Y1791_gen_type [125] = Y1791_pgtype125;
	Y1791_gen_type [126] = Y1791_pgtype126;
	Y1791_gen_type [127] = Y1791_pgtype127;
	Y1791_gen_type [128] = Y1791_pgtype128;
	Y1791_gen_type [129] = Y1791_pgtype129;
	Y1791_gen_type [130] = Y1791_pgtype130;
	Y1791_gen_type [131] = Y1791_pgtype131;
	Y1791_gen_type [132] = Y1791_pgtype132;
	Y1791_gen_type [133] = Y1791_pgtype133;
	Y1791_gen_type [134] = Y1791_pgtype134;
	Y1791_gen_type [135] = Y1791_pgtype135;
	Y1791_gen_type [136] = Y1791_pgtype136;
	Y1791_gen_type [137] = Y1791_pgtype137;
	Y1791_gen_type [138] = Y1791_pgtype138;
	Y1791_gen_type [139] = Y1791_pgtype139;
	Y1791_gen_type [140] = Y1791_pgtype140;
	Y1791_gen_type [141] = Y1791_pgtype141;
	Y1791_gen_type [142] = Y1791_pgtype142;
	Y1791_gen_type [143] = Y1791_pgtype143;
	Y1791_gen_type [144] = Y1791_pgtype144;
	Y1791_gen_type [145] = Y1791_pgtype145;
	Y1791_gen_type [146] = Y1791_pgtype146;
	Y1791_gen_type [147] = Y1791_pgtype147;
	Y1791_gen_type [148] = Y1791_pgtype148;
	Y1791_gen_type [149] = Y1791_pgtype149;
	Y1791_gen_type [150] = Y1791_pgtype150;
	Y1791_gen_type [151] = Y1791_pgtype151;
	Y1791_gen_type [152] = Y1791_pgtype152;
	Y1791_gen_type [153] = Y1791_pgtype153;
	Y1791_gen_type [154] = Y1791_pgtype154;
	Y1791_gen_type [155] = Y1791_pgtype155;
	Y1791_gen_type [156] = Y1791_pgtype156;
	Y1791_gen_type [157] = Y1791_pgtype157;
	Y1791_gen_type [158] = Y1791_pgtype158;
	Y1791_gen_type [159] = Y1791_pgtype159;
	Y1791_gen_type [160] = Y1791_pgtype160;
	Y1791_gen_type [161] = Y1791_pgtype161;
	Y1791_gen_type [162] = Y1791_pgtype162;
	Y1791_gen_type [163] = Y1791_pgtype163;
	Y1791_gen_type [164] = Y1791_pgtype164;
	Y1791_gen_type [165] = Y1791_pgtype165;
	Y1791_gen_type [166] = Y1791_pgtype166;
	Y1791_gen_type [167] = Y1791_pgtype167;
	Y1791_gen_type [168] = Y1791_pgtype168;
	Y1791_gen_type [169] = Y1791_pgtype169;
	Y1791_gen_type [170] = Y1791_pgtype170;
	Y1791_gen_type [171] = Y1791_pgtype171;
	Y1791_gen_type [172] = Y1791_pgtype172;
	Y1791_gen_type [173] = Y1791_pgtype173;
	Y1791_gen_type [174] = Y1791_pgtype174;
	Y1791_gen_type [175] = Y1791_pgtype175;
	Y1791_gen_type [176] = Y1791_pgtype176;
	Y1791_gen_type [177] = Y1791_pgtype177;
	Y1791_gen_type [178] = Y1791_pgtype178;
	Y1791_gen_type [179] = Y1791_pgtype179;
	Y1791_gen_type [180] = Y1791_pgtype180;
	Y1791_gen_type [181] = Y1791_pgtype181;
	Y1791_gen_type [182] = Y1791_pgtype182;
	Y1791_gen_type [183] = Y1791_pgtype183;
	Y1791_gen_type [184] = Y1791_pgtype184;
	Y1791_gen_type [185] = Y1791_pgtype185;
	Y1791_gen_type [186] = Y1791_pgtype186;
	Y1791_gen_type [187] = Y1791_pgtype187;
	Y1791_gen_type [188] = Y1791_pgtype188;
	Y1791_gen_type [189] = Y1791_pgtype189;
	Y1791_gen_type [190] = Y1791_pgtype190;
	Y1791_gen_type [191] = Y1791_pgtype191;
	Y1791_gen_type [192] = Y1791_pgtype192;
	Y1791_gen_type [193] = Y1791_pgtype193;
	Y1791_gen_type [194] = Y1791_pgtype194;
	Y1791_gen_type [195] = Y1791_pgtype195;
	Y1791_gen_type [196] = Y1791_pgtype196;
	Y1791_gen_type [197] = Y1791_pgtype197;
	Y1791_gen_type [198] = Y1791_pgtype198;
	Y1791_gen_type [199] = Y1791_pgtype199;
	Y1791_gen_type [200] = Y1791_pgtype200;
	Y1791_gen_type [201] = Y1791_pgtype201;
	Y1791_gen_type [202] = Y1791_pgtype202;
	Y1791_gen_type [203] = Y1791_pgtype203;
	Y1791_gen_type [204] = Y1791_pgtype204;
	Y1791_gen_type [205] = Y1791_pgtype205;
	Y1791_gen_type [206] = Y1791_pgtype206;
	Y1791_gen_type [207] = Y1791_pgtype207;
	Y1791_gen_type [208] = Y1791_pgtype208;
	Y1791_gen_type [209] = Y1791_pgtype209;
	Y1791_gen_type [210] = Y1791_pgtype210;
	Y1791_gen_type [211] = Y1791_pgtype211;
	Y1791_gen_type [212] = Y1791_pgtype212;
	Y1791_gen_type [213] = Y1791_pgtype213;
	Y1791_gen_type [214] = Y1791_pgtype214;
	Y1791_gen_type [215] = Y1791_pgtype215;
	Y1791_gen_type [216] = Y1791_pgtype216;
	Y1791_gen_type [217] = Y1791_pgtype217;
	Y1791_gen_type [218] = Y1791_pgtype218;
	Y1791_gen_type [219] = Y1791_pgtype219;
	Y1791_gen_type [220] = Y1791_pgtype220;
	Y1791_gen_type [221] = Y1791_pgtype221;
	Y1791_gen_type [222] = Y1791_pgtype222;
	Y1791_gen_type [223] = Y1791_pgtype223;
	Y1791_gen_type [224] = Y1791_pgtype224;
	Y1791_gen_type [225] = Y1791_pgtype225;
	Y1791_gen_type [226] = Y1791_pgtype226;
	Y1791_gen_type [227] = Y1791_pgtype227;
	Y1791_gen_type [228] = Y1791_pgtype228;
	Y1791_gen_type [229] = Y1791_pgtype229;
	Y1791_gen_type [230] = Y1791_pgtype230;
	Y1791_gen_type [231] = Y1791_pgtype231;
	Y1791_gen_type [232] = Y1791_pgtype232;
	Y1791_gen_type [233] = Y1791_pgtype233;
	Y1791_gen_type [234] = Y1791_pgtype234;
	Y1791_gen_type [235] = Y1791_pgtype235;
	Y1791_gen_type [236] = Y1791_pgtype236;
	Y1791_gen_type [237] = Y1791_pgtype237;
	Y1791_gen_type [238] = Y1791_pgtype238;
	Y1791_gen_type [239] = Y1791_pgtype239;
	Y1791_gen_type [240] = Y1791_pgtype240;
	Y1791_gen_type [241] = Y1791_pgtype241;
	Y1791_gen_type [242] = Y1791_pgtype242;
	Y1791_gen_type [243] = Y1791_pgtype243;
	Y1791_gen_type [244] = Y1791_pgtype244;
	Y1791_gen_type [245] = Y1791_pgtype245;
	Y1791_gen_type [246] = Y1791_pgtype246;
	Y1791_gen_type [247] = Y1791_pgtype247;
	Y1791_gen_type [248] = Y1791_pgtype248;
	Y1791_gen_type [249] = Y1791_pgtype249;
	Y1791_gen_type [250] = Y1791_pgtype250;
	Y1791_gen_type [251] = Y1791_pgtype251;
	Y1791_gen_type [252] = Y1791_pgtype252;
	Y1791_gen_type [253] = Y1791_pgtype253;
	Y1791_gen_type [254] = Y1791_pgtype254;
	Y1791_gen_type [255] = Y1791_pgtype255;
	Y1791_gen_type [256] = Y1791_pgtype256;
	Y1791_gen_type [257] = Y1791_pgtype257;
	Y1791_gen_type [258] = Y1791_pgtype258;
	Y1791_gen_type [259] = Y1791_pgtype259;
	Y1791_gen_type [260] = Y1791_pgtype260;
	Y1791_gen_type [261] = Y1791_pgtype261;
	Y1791_gen_type [262] = Y1791_pgtype262;
	Y1791_gen_type [263] = Y1791_pgtype263;
	Y1791_gen_type [264] = Y1791_pgtype264;
	Y1791_gen_type [265] = Y1791_pgtype265;
	Y1791_gen_type [266] = Y1791_pgtype266;
	Y1791_gen_type [267] = Y1791_pgtype267;
	Y1791_gen_type [268] = Y1791_pgtype268;
	Y1791_gen_type [269] = Y1791_pgtype269;
	Y1791_gen_type [270] = Y1791_pgtype270;
	Y1791_gen_type [271] = Y1791_pgtype271;
	Y1791_gen_type [272] = Y1791_pgtype272;
	Y1791_gen_type [273] = Y1791_pgtype273;
	Y1791_gen_type [274] = Y1791_pgtype274;
	Y1791_gen_type [275] = Y1791_pgtype275;
	Y1791_gen_type [276] = Y1791_pgtype276;
	Y1791_gen_type [277] = Y1791_pgtype277;
	Y1791_gen_type [278] = Y1791_pgtype278;
	Y1791_gen_type [279] = Y1791_pgtype279;
	Y1791_gen_type [280] = Y1791_pgtype280;
	Y1791_gen_type [281] = Y1791_pgtype281;
	Y1791_gen_type [282] = Y1791_pgtype282;
	Y1791_gen_type [283] = Y1791_pgtype283;
	Y1791_gen_type [284] = Y1791_pgtype284;
	Y1791_gen_type [285] = Y1791_pgtype285;
	Y1791_gen_type [286] = Y1791_pgtype286;
	Y1791_gen_type [287] = Y1791_pgtype287;
	Y1791_gen_type [288] = Y1791_pgtype288;
	Y1791_gen_type [289] = Y1791_pgtype289;
	Y1791_gen_type [290] = Y1791_pgtype290;
	Y1791_gen_type [291] = Y1791_pgtype291;
	Y1791_gen_type [292] = Y1791_pgtype292;
	Y1791_gen_type [293] = Y1791_pgtype293;
	Y1791_gen_type [294] = Y1791_pgtype294;
	Y1791_gen_type [295] = Y1791_pgtype295;
	Y1791_gen_type [296] = Y1791_pgtype296;
	Y1791_gen_type [297] = Y1791_pgtype297;
	Y1791_gen_type [298] = Y1791_pgtype298;
	Y1791_gen_type [299] = Y1791_pgtype299;
	Y1791_gen_type [300] = Y1791_pgtype300;
	Y1791_gen_type [301] = Y1791_pgtype301;
	Y1791_gen_type [302] = Y1791_pgtype302;
	Y1791_gen_type [303] = Y1791_pgtype303;
	Y1791_gen_type [304] = Y1791_pgtype304;
	Y1791_gen_type [305] = Y1791_pgtype305;
	Y1791_gen_type [306] = Y1791_pgtype306;
	Y1791_gen_type [307] = Y1791_pgtype307;
	Y1791_gen_type [308] = Y1791_pgtype308;
	Y1791_gen_type [309] = Y1791_pgtype309;
	Y1791_gen_type [310] = Y1791_pgtype310;
	Y1791_gen_type [311] = Y1791_pgtype311;
	Y1791_gen_type [312] = Y1791_pgtype312;
	Y1791_gen_type [313] = Y1791_pgtype313;
	Y1791_gen_type [314] = Y1791_pgtype314;
	Y1791_gen_type [315] = Y1791_pgtype315;
	Y1791_gen_type [316] = Y1791_pgtype316;
	Y1791_gen_type [317] = Y1791_pgtype317;
	Y1791_gen_type [318] = Y1791_pgtype318;
	Y1791_gen_type [319] = Y1791_pgtype319;
	Y1791_gen_type [320] = Y1791_pgtype320;
	Y1791_gen_type [321] = Y1791_pgtype321;
	Y1791_gen_type [322] = Y1791_pgtype322;
	Y1791_gen_type [323] = Y1791_pgtype323;
	Y1791_gen_type [324] = Y1791_pgtype324;
	Y1791_gen_type [325] = Y1791_pgtype325;
	Y1791_gen_type [326] = Y1791_pgtype326;
	Y1791_gen_type [327] = Y1791_pgtype327;
	Y1791_gen_type [328] = Y1791_pgtype328;
	Y1791_gen_type [329] = Y1791_pgtype329;
	Y1791_gen_type [330] = Y1791_pgtype330;
	Y1791_gen_type [331] = Y1791_pgtype331;
	Y1791_gen_type [332] = Y1791_pgtype332;
	Y1791_gen_type [333] = Y1791_pgtype333;
	Y1791_gen_type [334] = Y1791_pgtype334;
	Y1791_gen_type [335] = Y1791_pgtype335;
	Y1791_gen_type [336] = Y1791_pgtype336;
	Y1791_gen_type [337] = Y1791_pgtype337;
	Y1791_gen_type [338] = Y1791_pgtype338;
	Y1791_gen_type [339] = Y1791_pgtype339;
	Y1791_gen_type [340] = Y1791_pgtype340;
	Y1791_gen_type [341] = Y1791_pgtype341;
	Y1791_gen_type [342] = Y1791_pgtype342;
	Y1791_gen_type [343] = Y1791_pgtype343;
	Y1791_gen_type [344] = Y1791_pgtype344;
	Y1791_gen_type [345] = Y1791_pgtype345;
	Y1791_gen_type [346] = Y1791_pgtype346;
	Y1791_gen_type [347] = Y1791_pgtype347;
	Y1791_gen_type [348] = Y1791_pgtype348;
	Y1791_gen_type [349] = Y1791_pgtype349;
	Y1791_gen_type [350] = Y1791_pgtype350;
	Y1791_gen_type [351] = Y1791_pgtype351;
	Y1791_gen_type [352] = Y1791_pgtype352;
	Y1791_gen_type [353] = Y1791_pgtype353;
	Y1791_gen_type [354] = Y1791_pgtype354;
	Y1791_gen_type [355] = Y1791_pgtype355;
	Y1791_gen_type [356] = Y1791_pgtype356;
	Y1791_gen_type [357] = Y1791_pgtype357;
	Y1791_gen_type [358] = Y1791_pgtype358;
	Y1791_gen_type [359] = Y1791_pgtype359;
	Y1791_gen_type [360] = Y1791_pgtype360;
	Y1791_gen_type [361] = Y1791_pgtype361;
	Y1791_gen_type [362] = Y1791_pgtype362;
	Y1791_gen_type [363] = Y1791_pgtype363;
	Y1791_gen_type [364] = Y1791_pgtype364;
	Y1791_gen_type [365] = Y1791_pgtype365;
	Y1791_gen_type [366] = Y1791_pgtype366;
	Y1791_gen_type [367] = Y1791_pgtype367;
	Y1791_gen_type [368] = Y1791_pgtype368;
	Y1791_gen_type [369] = Y1791_pgtype369;
	Y1791_gen_type [370] = Y1791_pgtype370;
	Y1791_gen_type [371] = Y1791_pgtype371;
	Y1791_gen_type [372] = Y1791_pgtype372;
	Y1791_gen_type [373] = Y1791_pgtype373;
	Y1791_gen_type [374] = Y1791_pgtype374;
	Y1791_gen_type [375] = Y1791_pgtype375;
	Y1791_gen_type [376] = Y1791_pgtype376;
	Y1791_gen_type [377] = Y1791_pgtype377;
	Y1791_gen_type [378] = Y1791_pgtype378;
	Y1791_gen_type [379] = Y1791_pgtype379;
	Y1791_gen_type [380] = Y1791_pgtype380;
	Y1791_gen_type [381] = Y1791_pgtype381;
	Y1791_gen_type [382] = Y1791_pgtype382;
	Y1791_gen_type [383] = Y1791_pgtype383;
	Y1791_gen_type [384] = Y1791_pgtype384;
	Y1791_gen_type [385] = Y1791_pgtype385;
	Y1791_gen_type [386] = Y1791_pgtype386;
	Y1791_gen_type [387] = Y1791_pgtype387;
	Y1791_gen_type [388] = Y1791_pgtype388;
	Y1791_gen_type [389] = Y1791_pgtype389;
	Y1791_gen_type [390] = Y1791_pgtype390;
	Y1791_gen_type [391] = Y1791_pgtype391;
	Y1791_gen_type [392] = Y1791_pgtype392;
	Y1791_gen_type [393] = Y1791_pgtype393;
	Y1791_gen_type [394] = Y1791_pgtype394;
	Y1791_gen_type [395] = Y1791_pgtype395;
	Y1791_gen_type [396] = Y1791_pgtype396;
	Y1791_gen_type [397] = Y1791_pgtype397;
	Y1791_gen_type [398] = Y1791_pgtype398;
	Y1791_gen_type [399] = Y1791_pgtype399;
	Y1791_gen_type [400] = Y1791_pgtype400;
	Y1791_gen_type [401] = Y1791_pgtype401;
	Y1791_gen_type [402] = Y1791_pgtype402;
	Y1791_gen_type [403] = Y1791_pgtype403;
	Y1791_gen_type [404] = Y1791_pgtype404;
	Y1791_gen_type [405] = Y1791_pgtype405;
	Y1791_gen_type [406] = Y1791_pgtype406;
	Y1791_gen_type [407] = Y1791_pgtype407;
	Y1791_gen_type [408] = Y1791_pgtype408;
	Y1791_gen_type [409] = Y1791_pgtype409;
	Y1791_gen_type [410] = Y1791_pgtype410;
	Y1791_gen_type [411] = Y1791_pgtype411;
	Y1791_gen_type [412] = Y1791_pgtype412;
	Y1791_gen_type [413] = Y1791_pgtype413;
	Y1791_gen_type [414] = Y1791_pgtype414;
	Y1791_gen_type [415] = Y1791_pgtype415;
	Y1791_gen_type [416] = Y1791_pgtype416;
	Y1791_gen_type [417] = Y1791_pgtype417;
	Y1791_gen_type [418] = Y1791_pgtype418;
	Y1791_gen_type [419] = Y1791_pgtype419;
	Y1791_gen_type [420] = Y1791_pgtype420;
	Y1791_gen_type [421] = Y1791_pgtype421;
	Y1791_gen_type [422] = Y1791_pgtype422;
	Y1791_gen_type [423] = Y1791_pgtype423;
	Y1791_gen_type [424] = Y1791_pgtype424;
	Y1791_gen_type [425] = Y1791_pgtype425;
	Y1791_gen_type [426] = Y1791_pgtype426;
	Y1791_gen_type [427] = Y1791_pgtype427;
	Y1791_gen_type [428] = Y1791_pgtype428;
	Y1791_gen_type [429] = Y1791_pgtype429;
	Y1791_gen_type [430] = Y1791_pgtype430;
	Y1791_gen_type [431] = Y1791_pgtype431;
	Y1791_gen_type [432] = Y1791_pgtype432;
	Y1791_gen_type [433] = Y1791_pgtype433;
	Y1791_gen_type [434] = Y1791_pgtype434;
	Y1791_gen_type [436] = Y1791_pgtype435;
	Y1791_gen_type [437] = Y1791_pgtype436;
	Y1791_gen_type [438] = Y1791_pgtype437;
	Y1791_gen_type [439] = Y1791_pgtype438;
	Y1791_gen_type [440] = Y1791_pgtype439;
	Y1791_gen_type [441] = Y1791_pgtype440;
	Y1791_gen_type [442] = Y1791_pgtype441;
	Y1791_gen_type [443] = Y1791_pgtype442;
	Y1791_gen_type [444] = Y1791_pgtype443;
	Y1791_gen_type [445] = Y1791_pgtype444;
	Y1791_gen_type [446] = Y1791_pgtype445;
	Y1791_gen_type [447] = Y1791_pgtype446;
	Y1791_gen_type [448] = Y1791_pgtype447;
	Y1791_gen_type [449] = Y1791_pgtype448;
	Y1791_gen_type [451] = Y1791_pgtype449;
	Y1791_gen_type [452] = Y1791_pgtype450;
	Y1791_gen_type [453] = Y1791_pgtype451;
	Y1791_gen_type [454] = Y1791_pgtype452;
	Y1791_gen_type [455] = Y1791_pgtype453;
	Y1791_gen_type [456] = Y1791_pgtype454;
	Y1791_gen_type [457] = Y1791_pgtype455;
	Y1791_gen_type [462] = Y1791_pgtype456;
	Y1791_gen_type [463] = Y1791_pgtype457;
	Y1791_gen_type [464] = Y1791_pgtype458;
	Y1791_gen_type [465] = Y1791_pgtype459;
	Y1791_gen_type [466] = Y1791_pgtype460;
	Y1791_gen_type [467] = Y1791_pgtype461;
	Y1791_gen_type [468] = Y1791_pgtype462;
	Y1791_gen_type [469] = Y1791_pgtype463;
	Y1791_gen_type [470] = Y1791_pgtype464;
	Y1791_gen_type [471] = Y1791_pgtype465;
	Y1791_gen_type [472] = Y1791_pgtype466;
	Y1791_gen_type [473] = Y1791_pgtype467;
	Y1791_gen_type [474] = Y1791_pgtype468;
	Y1791_gen_type [555] = Y1791_pgtype469;
	Y1791_gen_type [636] = Y1791_pgtype470;
	Y1791_gen_type [637] = Y1791_pgtype471;
	Y1791_gen_type [638] = Y1791_pgtype472;
	Y1791_gen_type [639] = Y1791_pgtype473;
	Y1791_gen_type [640] = Y1791_pgtype474;
	Y1791_gen_type [641] = Y1791_pgtype475;
	Y1791_gen_type [642] = Y1791_pgtype476;
	Y1791[13] = 818;
	Y1791[14] = 814;
	Y1791[15] = 738;
	Y1791[91] = 738;
	Y1791[92] = 741;
	Y1791[270] = 750;
	{long i; for (i = 338; i < 341; i++) Y1791[i] = 741;};
	Y1791[367] = 750;
	Y1791[457] = 0;
	Y1791[555] = 0;
	{long i; for (i = 636; i < 639; i++) Y1791[i] = 738;};
	{long i; for (i = 639; i < 643; i++) Y1791[i] = 741;};
}

char *(*R1853[4])();
void R1853_init () {
	{long i; for (i = 0; i < 2; i++) R1853[i] = (char *(*)()) F224_2065;}
	{long i; for (i = 2; i < 4; i++) R1853[i] = (char *(*)()) F232_2065;}
}

char *(*R1856[4])();
void R1856_init () {
	{long i; for (i = 0; i < 2; i++) R1856[i] = (char *(*)()) F224_2070;}
	{long i; for (i = 2; i < 4; i++) R1856[i] = (char *(*)()) F232_2070;}
}

char *(*R1859[4])();
void R1859_init () {
	{long i; for (i = 0; i < 2; i++) R1859[i] = (char *(*)()) F224_2052;}
	{long i; for (i = 2; i < 4; i++) R1859[i] = (char *(*)()) F232_2052;}
}

char *(*R1890[373])();
void R1890_init () {
	R1890[0] = (char *(*)()) F305_2138;
	R1890[98] = (char *(*)()) F297_2138;
	R1890[99] = (char *(*)()) F298_2138;
	R1890[100] = (char *(*)()) F299_2138;
	R1890[101] = (char *(*)()) F300_2138;
	R1890[102] = (char *(*)()) F301_2138;
	R1890[103] = (char *(*)()) F302_2138;
	R1890[104] = (char *(*)()) F303_2138;
	R1890[105] = (char *(*)()) F304_2138;
	R1890[106] = (char *(*)()) F305_2138;
	R1890[107] = (char *(*)()) F306_2138;
	R1890[108] = (char *(*)()) F307_2138;
	R1890[109] = (char *(*)()) F308_2138;
	R1890[110] = (char *(*)()) F309_2138;
	{long i; for (i = 181; i < 183; i++) R1890[i] = (char *(*)()) F297_2138;}
	{long i; for (i = 183; i < 185; i++) R1890[i] = (char *(*)()) F305_2138;}
	R1890[185] = (char *(*)()) F297_2138;
	R1890[186] = (char *(*)()) F305_2138;
	R1890[187] = (char *(*)()) F297_2138;
	R1890[368] = (char *(*)()) F298_2138;
	{long i; for (i = 371; i < 373; i++) R1890[i] = (char *(*)()) F299_2138;}
}

char *(*R1923[271])();
void R1923_init () {
	R1923[0] = (char *(*)()) F546_2658_1923_5;
	R1923[1] = (char *(*)()) F547_2658_1923_5;
	R1923[2] = (char *(*)()) F548_2658_1923_5;
	R1923[3] = (char *(*)()) F549_2658_1923_5;
	R1923[4] = (char *(*)()) F550_2658_1923_5;
	R1923[5] = (char *(*)()) F551_2658_1923_5;
	R1923[6] = (char *(*)()) F552_2658_1923_5;
	R1923[7] = (char *(*)()) F553_2658_1923_5;
	R1923[8] = (char *(*)()) F554_2658_1923_5;
	R1923[9] = (char *(*)()) F555_2658_1923_5;
	R1923[10] = (char *(*)()) F556_2658_1923_5;
	R1923[11] = (char *(*)()) F557_2658_1923_5;
	R1923[12] = (char *(*)()) F558_2658_1923_5;
	R1923[270] = (char *(*)()) F816_4813_1923_5;
}
static EIF_REFERENCE F546_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F546_2658(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_REFERENCE F547_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F547_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F548_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F548_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(741, 0x00).id, 741, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F549_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F549_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F550_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F550_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(765, 0x00).id, 765, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F551_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F551_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(804, 0x00).id, 804, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F552_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F552_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(771, 0x00).id, 771, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F553_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F553_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(735, 0x00).id, 735, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F554_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F554_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F555_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F555_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(744, 0x00).id, 744, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F556_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F556_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F557_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F557_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(762, 0x00).id, 762, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F558_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F558_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(747, 0x00).id, 747, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F816_4813_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F816_4813(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R1926[274])();
void R1926_init () {
	R1926[0] = (char *(*)()) F546_2677_1926_8;
	R1926[1] = (char *(*)()) F547_2677_1926_8;
	R1926[2] = (char *(*)()) F548_2677_1926_8;
	R1926[3] = (char *(*)()) F549_2677_1926_8;
	R1926[4] = (char *(*)()) F550_2677_1926_8;
	R1926[5] = (char *(*)()) F551_2677_1926_8;
	R1926[6] = (char *(*)()) F552_2677_1926_8;
	R1926[7] = (char *(*)()) F553_2677_1926_8;
	R1926[8] = (char *(*)()) F554_2677_1926_8;
	R1926[9] = (char *(*)()) F555_2677_1926_8;
	R1926[10] = (char *(*)()) F556_2677_1926_8;
	R1926[11] = (char *(*)()) F557_2677_1926_8;
	R1926[12] = (char *(*)()) F558_2677_1926_8;
	R1926[83] = (char *(*)()) F629_2971;
	R1926[84] = (char *(*)()) F630_2971_1926_8;
	R1926[85] = (char *(*)()) F631_2971_1926_8;
	R1926[86] = (char *(*)()) F632_2971_1926_8;
	R1926[87] = (char *(*)()) F629_2971;
	R1926[88] = (char *(*)()) F631_2971_1926_8;
	R1926[89] = (char *(*)()) F629_2971;
	R1926[273] = (char *(*)()) F819_4998_1926_8;
}
static void F546_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F546_2677(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F547_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F547_2677(Current, *(EIF_CHARACTER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F548_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F548_2677(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F549_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F549_2677(Current, *(EIF_NATURAL_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F550_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F550_2677(Current, *(EIF_NATURAL_16 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F551_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F551_2677(Current, *(EIF_POINTER *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F552_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F552_2677(Current, *(EIF_REAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F553_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F553_2677(Current, *(EIF_REAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F554_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F554_2677(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F555_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F555_2677(Current, *(EIF_BOOLEAN *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F556_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F556_2677(Current, *(EIF_NATURAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F557_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F557_2677(Current, *(EIF_NATURAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F558_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F558_2677(Current, *(EIF_INTEGER_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F630_2971_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F630_2971(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F631_2971_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F631_2971(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F632_2971_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F632_2971(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F819_4998_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F819_4998(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

static EIF_TYPE_INDEX Y1928_pgtype0[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype1[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype2[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype3[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype4[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype5[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype6[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype7[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype8[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype9[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype10[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype11[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype12[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype13[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype14[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype15[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype16[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype17[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype18[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype19[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype20[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype21[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype22[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype23[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype24[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype25[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype26[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype27[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype28[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype29[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype30[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype31[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype32[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype33[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype34[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype35[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype36[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype37[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype38[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype39[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype40[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype41[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype42[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype43[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype44[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype45[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype46[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype47[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype48[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype49[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype50[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype51[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype52[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype53[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype54[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype55[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype56[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype57[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype58[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype59[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype60[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype61[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype62[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype63[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype64[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype65[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype66[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype67[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype68[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype69[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype70[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype71[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype72[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype73[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype74[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype75[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype76[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype77[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype78[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype79[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype80[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype81[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype82[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype83[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype84[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype85[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype86[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype87[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype88[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype89[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype90[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype91[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype92[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype93[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype94[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype95[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype96[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype97[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype98[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype99[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype100[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype101[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype102[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype103[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype104[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype105[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype106[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype107[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype108[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype109[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype110[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype111[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype112[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype113[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype114[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype115[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype116[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype117[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype118[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype119[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype120[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype121[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype122[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype123[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype124[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype125[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype126[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype127[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype128[] = {0xFF01,810,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype129[] = {0xFF01,810,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype130[] = {0xFF01,818,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype131[] = {750,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype132[] = {750,0xFFFF};
EIF_TYPE_INDEX *Y1928_gen_type [444];
EIF_TYPE_INDEX Y1928 [444];
void Y1928_init (void)
{
	egc_routines_types [1928] = Y1928;
	egc_routines_gen_types [1928] = Y1928_gen_type;
	egc_routines_offset [1928] = 375;
	Y1928_gen_type [0] = Y1928_pgtype0;
	Y1928_gen_type [1] = Y1928_pgtype1;
	Y1928_gen_type [2] = Y1928_pgtype2;
	Y1928_gen_type [3] = Y1928_pgtype3;
	Y1928_gen_type [4] = Y1928_pgtype4;
	Y1928_gen_type [5] = Y1928_pgtype5;
	Y1928_gen_type [6] = Y1928_pgtype6;
	Y1928_gen_type [7] = Y1928_pgtype7;
	Y1928_gen_type [8] = Y1928_pgtype8;
	Y1928_gen_type [9] = Y1928_pgtype9;
	Y1928_gen_type [10] = Y1928_pgtype10;
	Y1928_gen_type [11] = Y1928_pgtype11;
	Y1928_gen_type [12] = Y1928_pgtype12;
	Y1928_gen_type [13] = Y1928_pgtype13;
	Y1928_gen_type [14] = Y1928_pgtype14;
	Y1928_gen_type [15] = Y1928_pgtype15;
	Y1928_gen_type [16] = Y1928_pgtype16;
	Y1928_gen_type [17] = Y1928_pgtype17;
	Y1928_gen_type [18] = Y1928_pgtype18;
	Y1928_gen_type [19] = Y1928_pgtype19;
	Y1928_gen_type [20] = Y1928_pgtype20;
	Y1928_gen_type [21] = Y1928_pgtype21;
	Y1928_gen_type [22] = Y1928_pgtype22;
	Y1928_gen_type [23] = Y1928_pgtype23;
	Y1928_gen_type [24] = Y1928_pgtype24;
	Y1928_gen_type [25] = Y1928_pgtype25;
	Y1928_gen_type [26] = Y1928_pgtype26;
	Y1928_gen_type [27] = Y1928_pgtype27;
	Y1928_gen_type [28] = Y1928_pgtype28;
	Y1928_gen_type [29] = Y1928_pgtype29;
	Y1928_gen_type [156] = Y1928_pgtype30;
	Y1928_gen_type [157] = Y1928_pgtype31;
	Y1928_gen_type [158] = Y1928_pgtype32;
	Y1928_gen_type [159] = Y1928_pgtype33;
	Y1928_gen_type [160] = Y1928_pgtype34;
	Y1928_gen_type [161] = Y1928_pgtype35;
	Y1928_gen_type [162] = Y1928_pgtype36;
	Y1928_gen_type [163] = Y1928_pgtype37;
	Y1928_gen_type [164] = Y1928_pgtype38;
	Y1928_gen_type [165] = Y1928_pgtype39;
	Y1928_gen_type [166] = Y1928_pgtype40;
	Y1928_gen_type [167] = Y1928_pgtype41;
	Y1928_gen_type [168] = Y1928_pgtype42;
	Y1928_gen_type [169] = Y1928_pgtype43;
	Y1928_gen_type [170] = Y1928_pgtype44;
	Y1928_gen_type [171] = Y1928_pgtype45;
	Y1928_gen_type [172] = Y1928_pgtype46;
	Y1928_gen_type [173] = Y1928_pgtype47;
	Y1928_gen_type [174] = Y1928_pgtype48;
	Y1928_gen_type [175] = Y1928_pgtype49;
	Y1928_gen_type [176] = Y1928_pgtype50;
	Y1928_gen_type [177] = Y1928_pgtype51;
	Y1928_gen_type [178] = Y1928_pgtype52;
	Y1928_gen_type [179] = Y1928_pgtype53;
	Y1928_gen_type [180] = Y1928_pgtype54;
	Y1928_gen_type [181] = Y1928_pgtype55;
	Y1928_gen_type [182] = Y1928_pgtype56;
	Y1928_gen_type [183] = Y1928_pgtype57;
	Y1928_gen_type [184] = Y1928_pgtype58;
	Y1928_gen_type [185] = Y1928_pgtype59;
	Y1928_gen_type [186] = Y1928_pgtype60;
	Y1928_gen_type [187] = Y1928_pgtype61;
	Y1928_gen_type [188] = Y1928_pgtype62;
	Y1928_gen_type [189] = Y1928_pgtype63;
	Y1928_gen_type [190] = Y1928_pgtype64;
	Y1928_gen_type [191] = Y1928_pgtype65;
	Y1928_gen_type [192] = Y1928_pgtype66;
	Y1928_gen_type [193] = Y1928_pgtype67;
	Y1928_gen_type [194] = Y1928_pgtype68;
	Y1928_gen_type [195] = Y1928_pgtype69;
	Y1928_gen_type [196] = Y1928_pgtype70;
	Y1928_gen_type [197] = Y1928_pgtype71;
	Y1928_gen_type [198] = Y1928_pgtype72;
	Y1928_gen_type [199] = Y1928_pgtype73;
	Y1928_gen_type [200] = Y1928_pgtype74;
	Y1928_gen_type [201] = Y1928_pgtype75;
	Y1928_gen_type [202] = Y1928_pgtype76;
	Y1928_gen_type [203] = Y1928_pgtype77;
	Y1928_gen_type [204] = Y1928_pgtype78;
	Y1928_gen_type [205] = Y1928_pgtype79;
	Y1928_gen_type [206] = Y1928_pgtype80;
	Y1928_gen_type [207] = Y1928_pgtype81;
	Y1928_gen_type [208] = Y1928_pgtype82;
	Y1928_gen_type [209] = Y1928_pgtype83;
	Y1928_gen_type [210] = Y1928_pgtype84;
	Y1928_gen_type [211] = Y1928_pgtype85;
	Y1928_gen_type [212] = Y1928_pgtype86;
	Y1928_gen_type [213] = Y1928_pgtype87;
	Y1928_gen_type [214] = Y1928_pgtype88;
	Y1928_gen_type [215] = Y1928_pgtype89;
	Y1928_gen_type [216] = Y1928_pgtype90;
	Y1928_gen_type [217] = Y1928_pgtype91;
	Y1928_gen_type [218] = Y1928_pgtype92;
	Y1928_gen_type [219] = Y1928_pgtype93;
	Y1928_gen_type [220] = Y1928_pgtype94;
	Y1928_gen_type [221] = Y1928_pgtype95;
	Y1928_gen_type [222] = Y1928_pgtype96;
	Y1928_gen_type [223] = Y1928_pgtype97;
	Y1928_gen_type [224] = Y1928_pgtype98;
	Y1928_gen_type [225] = Y1928_pgtype99;
	Y1928_gen_type [226] = Y1928_pgtype100;
	Y1928_gen_type [227] = Y1928_pgtype101;
	Y1928_gen_type [228] = Y1928_pgtype102;
	Y1928_gen_type [229] = Y1928_pgtype103;
	Y1928_gen_type [230] = Y1928_pgtype104;
	Y1928_gen_type [231] = Y1928_pgtype105;
	Y1928_gen_type [232] = Y1928_pgtype106;
	Y1928_gen_type [233] = Y1928_pgtype107;
	Y1928_gen_type [234] = Y1928_pgtype108;
	Y1928_gen_type [235] = Y1928_pgtype109;
	Y1928_gen_type [236] = Y1928_pgtype110;
	Y1928_gen_type [239] = Y1928_pgtype111;
	Y1928_gen_type [240] = Y1928_pgtype112;
	Y1928_gen_type [241] = Y1928_pgtype113;
	Y1928_gen_type [242] = Y1928_pgtype114;
	Y1928_gen_type [243] = Y1928_pgtype115;
	Y1928_gen_type [244] = Y1928_pgtype116;
	Y1928_gen_type [245] = Y1928_pgtype117;
	Y1928_gen_type [246] = Y1928_pgtype118;
	Y1928_gen_type [247] = Y1928_pgtype119;
	Y1928_gen_type [248] = Y1928_pgtype120;
	Y1928_gen_type [249] = Y1928_pgtype121;
	Y1928_gen_type [250] = Y1928_pgtype122;
	Y1928_gen_type [251] = Y1928_pgtype123;
	Y1928_gen_type [253] = Y1928_pgtype124;
	Y1928_gen_type [254] = Y1928_pgtype125;
	Y1928_gen_type [255] = Y1928_pgtype126;
	Y1928_gen_type [256] = Y1928_pgtype127;
	Y1928_gen_type [257] = Y1928_pgtype128;
	Y1928_gen_type [258] = Y1928_pgtype129;
	Y1928_gen_type [259] = Y1928_pgtype130;
	Y1928_gen_type [440] = Y1928_pgtype131;
	Y1928_gen_type [443] = Y1928_pgtype132;
	{long i; for (i = 156; i < 237; i++) Y1928[i] = 750;};
	{long i; for (i = 239; i < 252; i++) Y1928[i] = 750;};
	{long i; for (i = 257; i < 259; i++) Y1928[i] = 810;};
	Y1928[259] = 818;
	Y1928[440] = 750;
	Y1928[443] = 750;
}

char *(*R1950[275])();
void R1950_init () {
	R1950[0] = (char *(*)()) F546_2665;
	R1950[1] = (char *(*)()) F547_2665;
	R1950[2] = (char *(*)()) F548_2665;
	R1950[3] = (char *(*)()) F549_2665;
	R1950[4] = (char *(*)()) F550_2665;
	R1950[5] = (char *(*)()) F551_2665;
	R1950[6] = (char *(*)()) F552_2665;
	R1950[7] = (char *(*)()) F553_2665;
	R1950[8] = (char *(*)()) F554_2665;
	R1950[9] = (char *(*)()) F555_2665;
	R1950[10] = (char *(*)()) F556_2665;
	R1950[11] = (char *(*)()) F557_2665;
	R1950[12] = (char *(*)()) F558_2665;
	R1950[83] = (char *(*)()) F629_2943;
	R1950[84] = (char *(*)()) F630_2943;
	R1950[85] = (char *(*)()) F631_2943;
	R1950[86] = (char *(*)()) F632_2943;
	R1950[87] = (char *(*)()) F629_2943;
	R1950[88] = (char *(*)()) F631_2943;
	R1950[89] = (char *(*)()) F629_2943;
	R1950[270] = (char *(*)()) F814_4752;
	R1950[273] = (char *(*)()) F817_4920;
	R1950[274] = (char *(*)()) F820_5071;
}

char *(*R1953[274])();
void R1953_init () {
	R1953[0] = (char *(*)()) F546_2666;
	R1953[1] = (char *(*)()) F547_2666;
	R1953[2] = (char *(*)()) F548_2666;
	R1953[3] = (char *(*)()) F549_2666;
	R1953[4] = (char *(*)()) F550_2666;
	R1953[5] = (char *(*)()) F551_2666;
	R1953[6] = (char *(*)()) F552_2666;
	R1953[7] = (char *(*)()) F553_2666;
	R1953[8] = (char *(*)()) F554_2666;
	R1953[9] = (char *(*)()) F555_2666;
	R1953[10] = (char *(*)()) F556_2666;
	R1953[11] = (char *(*)()) F557_2666;
	R1953[12] = (char *(*)()) F558_2666;
	R1953[270] = (char *(*)()) F814_4751;
	R1953[273] = (char *(*)()) F817_4919;
}

char *(*R2160[271])();
void R2160_init () {
	R2160[0] = (char *(*)()) F546_2658;
	R2160[1] = (char *(*)()) F547_2658_2160_33;
	R2160[2] = (char *(*)()) F548_2658_2160_33;
	R2160[3] = (char *(*)()) F549_2658_2160_33;
	R2160[4] = (char *(*)()) F550_2658_2160_33;
	R2160[5] = (char *(*)()) F551_2658_2160_33;
	R2160[6] = (char *(*)()) F552_2658_2160_33;
	R2160[7] = (char *(*)()) F553_2658_2160_33;
	R2160[8] = (char *(*)()) F554_2658_2160_33;
	R2160[9] = (char *(*)()) F555_2658_2160_33;
	R2160[10] = (char *(*)()) F556_2658_2160_33;
	R2160[11] = (char *(*)()) F557_2658_2160_33;
	R2160[12] = (char *(*)()) F558_2658_2160_33;
	R2160[94] = (char *(*)()) F640_3157;
	R2160[95] = (char *(*)()) F641_3157_2160_33;
	R2160[96] = (char *(*)()) F642_3157_2160_33;
	R2160[97] = (char *(*)()) F643_3157_2160_33;
	R2160[98] = (char *(*)()) F644_3157_2160_33;
	R2160[99] = (char *(*)()) F645_3157_2160_33;
	R2160[100] = (char *(*)()) F646_3157_2160_33;
	R2160[101] = (char *(*)()) F647_3157_2160_33;
	R2160[102] = (char *(*)()) F648_3157_2160_33;
	R2160[103] = (char *(*)()) F649_3157_2160_33;
	R2160[104] = (char *(*)()) F650_3157_2160_33;
	R2160[105] = (char *(*)()) F651_3157_2160_33;
	R2160[106] = (char *(*)()) F652_3157_2160_33;
	R2160[187] = (char *(*)()) F733_3368;
	R2160[269] = (char *(*)()) F815_4790_2160_33;
	R2160[270] = (char *(*)()) F816_4813_2160_33;
}
static EIF_REFERENCE F547_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F547_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F548_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F548_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(741, 0x00).id, 741, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F549_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F549_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F550_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F550_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(765, 0x00).id, 765, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F551_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F551_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(804, 0x00).id, 804, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F552_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F552_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(771, 0x00).id, 771, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F553_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F553_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(735, 0x00).id, 735, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F554_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F554_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F555_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F555_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(744, 0x00).id, 744, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F556_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F556_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F557_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F557_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(762, 0x00).id, 762, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F558_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F558_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(747, 0x00).id, 747, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F641_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F641_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F642_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F642_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(741, 0x00).id, 741, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F643_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F643_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F644_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F644_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(765, 0x00).id, 765, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F645_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F645_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(804, 0x00).id, 804, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F646_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F646_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(771, 0x00).id, 771, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F647_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F647_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(735, 0x00).id, 735, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F648_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F648_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F649_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F649_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(744, 0x00).id, 744, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F650_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F650_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F651_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F651_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(762, 0x00).id, 762, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F652_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F652_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(747, 0x00).id, 747, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F815_4790_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F815_4790(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F816_4813_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F816_4813(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R2161[274])();
void R2161_init () {
	R2161[0] = (char *(*)()) F546_2663;
	R2161[1] = (char *(*)()) F547_2663;
	R2161[2] = (char *(*)()) F548_2663;
	R2161[3] = (char *(*)()) F549_2663;
	R2161[4] = (char *(*)()) F550_2663;
	R2161[5] = (char *(*)()) F551_2663;
	R2161[6] = (char *(*)()) F552_2663;
	R2161[7] = (char *(*)()) F553_2663;
	R2161[8] = (char *(*)()) F554_2663;
	R2161[9] = (char *(*)()) F555_2663;
	R2161[10] = (char *(*)()) F556_2663;
	R2161[11] = (char *(*)()) F557_2663;
	R2161[12] = (char *(*)()) F558_2663;
	R2161[83] = (char *(*)()) F629_2946;
	R2161[84] = (char *(*)()) F630_2946;
	R2161[85] = (char *(*)()) F631_2946;
	R2161[86] = (char *(*)()) F632_2946;
	R2161[87] = (char *(*)()) F629_2946;
	R2161[88] = (char *(*)()) F631_2946;
	R2161[89] = (char *(*)()) F629_2946;
	R2161[94] = (char *(*)()) F640_3165;
	R2161[95] = (char *(*)()) F641_3165;
	R2161[96] = (char *(*)()) F642_3165;
	R2161[97] = (char *(*)()) F643_3165;
	R2161[98] = (char *(*)()) F644_3165;
	R2161[99] = (char *(*)()) F645_3165;
	R2161[100] = (char *(*)()) F646_3165;
	R2161[101] = (char *(*)()) F647_3165;
	R2161[102] = (char *(*)()) F648_3165;
	R2161[103] = (char *(*)()) F649_3165;
	R2161[104] = (char *(*)()) F650_3165;
	R2161[105] = (char *(*)()) F651_3165;
	R2161[106] = (char *(*)()) F652_3165;
	R2161[187] = (char *(*)()) F733_3398;
	{long i; for (i = 269; i < 271; i++) R2161[i] = (char *(*)()) F814_4754;}
	{long i; for (i = 272; i < 274; i++) R2161[i] = (char *(*)()) F817_4922;}
}

EIF_TYPE_INDEX *Y2161_gen_type [301];
EIF_TYPE_INDEX Y2161 [301];
void Y2161_init (void)
{
	egc_routines_types [2161] = Y2161;
	egc_routines_gen_types [2161] = Y2161_gen_type;
	egc_routines_offset [2161] = 518;
	{long i; for (i = 0; i < 94; i++) Y2161[i] = 750;};
	{long i; for (i = 96; i < 109; i++) Y2161[i] = 750;};
	{long i; for (i = 110; i < 117; i++) Y2161[i] = 750;};
	{long i; for (i = 121; i < 134; i++) Y2161[i] = 750;};
	Y2161[214] = 750;
	{long i; for (i = 295; i < 301; i++) Y2161[i] = 750;};
}

char *(*R2162[274])();
void R2162_init () {
	R2162[0] = (char *(*)()) F546_2664;
	R2162[1] = (char *(*)()) F547_2664;
	R2162[2] = (char *(*)()) F548_2664;
	R2162[3] = (char *(*)()) F549_2664;
	R2162[4] = (char *(*)()) F550_2664;
	R2162[5] = (char *(*)()) F551_2664;
	R2162[6] = (char *(*)()) F552_2664;
	R2162[7] = (char *(*)()) F553_2664;
	R2162[8] = (char *(*)()) F554_2664;
	R2162[9] = (char *(*)()) F555_2664;
	R2162[10] = (char *(*)()) F556_2664;
	R2162[11] = (char *(*)()) F557_2664;
	R2162[12] = (char *(*)()) F558_2664;
	R2162[83] = (char *(*)()) F629_2947;
	R2162[84] = (char *(*)()) F630_2947;
	R2162[85] = (char *(*)()) F631_2947;
	R2162[86] = (char *(*)()) F632_2947;
	R2162[87] = (char *(*)()) F629_2947;
	R2162[88] = (char *(*)()) F631_2947;
	R2162[89] = (char *(*)()) F629_2947;
	R2162[94] = (char *(*)()) F640_3166;
	R2162[95] = (char *(*)()) F641_3166;
	R2162[96] = (char *(*)()) F642_3166;
	R2162[97] = (char *(*)()) F643_3166;
	R2162[98] = (char *(*)()) F644_3166;
	R2162[99] = (char *(*)()) F645_3166;
	R2162[100] = (char *(*)()) F646_3166;
	R2162[101] = (char *(*)()) F647_3166;
	R2162[102] = (char *(*)()) F648_3166;
	R2162[103] = (char *(*)()) F649_3166;
	R2162[104] = (char *(*)()) F650_3166;
	R2162[105] = (char *(*)()) F651_3166;
	R2162[106] = (char *(*)()) F652_3166;
	R2162[187] = (char *(*)()) F733_3397;
	{long i; for (i = 269; i < 271; i++) R2162[i] = (char *(*)()) F814_4752;}
	{long i; for (i = 272; i < 274; i++) R2162[i] = (char *(*)()) F817_4920;}
}

char *(*R2188[13])();
void R2188_init () {
	R2188[0] = (char *(*)()) F546_2656;
	R2188[1] = (char *(*)()) F547_2656;
	R2188[2] = (char *(*)()) F548_2656;
	R2188[3] = (char *(*)()) F549_2656;
	R2188[4] = (char *(*)()) F550_2656;
	R2188[5] = (char *(*)()) F551_2656;
	R2188[6] = (char *(*)()) F552_2656;
	R2188[7] = (char *(*)()) F553_2656;
	R2188[8] = (char *(*)()) F554_2656;
	R2188[9] = (char *(*)()) F555_2656;
	R2188[10] = (char *(*)()) F556_2656;
	R2188[11] = (char *(*)()) F557_2656;
	R2188[12] = (char *(*)()) F558_2656;
}

char *(*R2253[191])();
void R2253_init () {
	R2253[0] = (char *(*)()) F629_2984;
	R2253[1] = (char *(*)()) F630_2984;
	R2253[2] = (char *(*)()) F631_2984;
	R2253[3] = (char *(*)()) F632_2984;
	R2253[4] = (char *(*)()) F629_2984;
	R2253[5] = (char *(*)()) F631_2984;
	R2253[6] = (char *(*)()) F629_2984;
	R2253[104] = (char *(*)()) F733_3476;
	R2253[186] = (char *(*)()) F815_4806;
	R2253[187] = (char *(*)()) F816_4897;
	R2253[190] = (char *(*)()) F819_5061;
}

char *(*R2290[7])();
void R2290_init () {
	R2290[0] = (char *(*)()) F629_2925;
	R2290[1] = (char *(*)()) F630_2925;
	R2290[2] = (char *(*)()) F631_2925;
	R2290[3] = (char *(*)()) F632_2925;
	R2290[4] = (char *(*)()) F629_2925;
	R2290[5] = (char *(*)()) F631_2925;
	R2290[6] = (char *(*)()) F629_2925;
}

char *(*R2293[7])();
void R2293_init () {
	R2293[0] = (char *(*)()) F629_2928;
	R2293[1] = (char *(*)()) F630_2928;
	R2293[2] = (char *(*)()) F631_2928;
	R2293[3] = (char *(*)()) F632_2928;
	R2293[4] = (char *(*)()) F629_2928;
	R2293[5] = (char *(*)()) F631_2928;
	R2293[6] = (char *(*)()) F629_2928;
}

char *(*R2294[7])();
void R2294_init () {
	R2294[0] = (char *(*)()) F629_2929;
	R2294[1] = (char *(*)()) F630_2929;
	R2294[2] = (char *(*)()) F631_2929_2294_1;
	R2294[3] = (char *(*)()) F632_2929_2294_1;
	R2294[4] = (char *(*)()) F629_2929;
	R2294[5] = (char *(*)()) F631_2929_2294_1;
	R2294[6] = (char *(*)()) F629_2929;
}
static EIF_REFERENCE F631_2929_2294_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F631_2929(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F632_2929_2294_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F632_2929(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2302[7])();
void R2302_init () {
	R2302[0] = (char *(*)()) F629_2942;
	R2302[1] = (char *(*)()) F630_2942_2302_10;
	R2302[2] = (char *(*)()) F631_2942;
	R2302[3] = (char *(*)()) F632_2942_2302_10;
	R2302[4] = (char *(*)()) F633_3039;
	R2302[5] = (char *(*)()) F634_3039;
	R2302[6] = (char *(*)()) F629_2942;
}
static EIF_INTEGER_32 F630_2942_2302_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F630_2942(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_INTEGER_32 F632_2942_2302_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F632_2942(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2304[7])();
void R2304_init () {
	R2304[0] = (char *(*)()) F629_2949;
	R2304[1] = (char *(*)()) F630_2949_2304_3;
	R2304[2] = (char *(*)()) F631_2949;
	R2304[3] = (char *(*)()) F632_2949_2304_3;
	R2304[4] = (char *(*)()) F633_3041;
	R2304[5] = (char *(*)()) F634_3041;
	R2304[6] = (char *(*)()) F629_2949;
}
static EIF_BOOLEAN F630_2949_2304_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F630_2949(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static EIF_BOOLEAN F632_2949_2304_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F632_2949(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

char *(*R2310[7])();
void R2310_init () {
	R2310[0] = (char *(*)()) F629_2957;
	R2310[1] = (char *(*)()) F630_2957;
	R2310[2] = (char *(*)()) F631_2957;
	R2310[3] = (char *(*)()) F632_2957;
	R2310[4] = (char *(*)()) F629_2957;
	R2310[5] = (char *(*)()) F631_2957;
	R2310[6] = (char *(*)()) F629_2957;
}

char *(*R2311[7])();
void R2311_init () {
	R2311[0] = (char *(*)()) F629_2958;
	R2311[1] = (char *(*)()) F630_2958;
	R2311[2] = (char *(*)()) F631_2958;
	R2311[3] = (char *(*)()) F632_2958;
	R2311[4] = (char *(*)()) F629_2958;
	R2311[5] = (char *(*)()) F631_2958;
	R2311[6] = (char *(*)()) F629_2958;
}

char *(*R2319[7])();
void R2319_init () {
	R2319[0] = (char *(*)()) F629_2967;
	R2319[1] = (char *(*)()) F630_2967_2319_4;
	R2319[2] = (char *(*)()) F631_2967;
	R2319[3] = (char *(*)()) F632_2967_2319_4;
	R2319[4] = (char *(*)()) F629_2967;
	R2319[5] = (char *(*)()) F631_2967;
	R2319[6] = (char *(*)()) F629_2967;
}
static void F630_2967_2319_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F630_2967(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F632_2967_2319_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F632_2967(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2321[7])();
void R2321_init () {
	R2321[0] = (char *(*)()) F629_2969;
	R2321[1] = (char *(*)()) F630_2969;
	R2321[2] = (char *(*)()) F631_2969;
	R2321[3] = (char *(*)()) F632_2969;
	R2321[4] = (char *(*)()) F629_2969;
	R2321[5] = (char *(*)()) F631_2969;
	R2321[6] = (char *(*)()) F629_2969;
}

char *(*R2322[7])();
void R2322_init () {
	R2322[0] = (char *(*)()) F629_2970;
	R2322[1] = (char *(*)()) F630_2970;
	R2322[2] = (char *(*)()) F631_2970;
	R2322[3] = (char *(*)()) F632_2970;
	R2322[4] = (char *(*)()) F629_2970;
	R2322[5] = (char *(*)()) F631_2970;
	R2322[6] = (char *(*)()) F629_2970;
}

char *(*R2328[7])();
void R2328_init () {
	R2328[0] = (char *(*)()) F629_2983;
	R2328[1] = (char *(*)()) F630_2983;
	R2328[2] = (char *(*)()) F631_2983;
	R2328[3] = (char *(*)()) F632_2983;
	R2328[4] = (char *(*)()) F633_3043;
	R2328[5] = (char *(*)()) F634_3043;
	R2328[6] = (char *(*)()) F629_2983;
}

char *(*R2337[7])();
void R2337_init () {
	R2337[0] = (char *(*)()) F629_2993;
	R2337[1] = (char *(*)()) F630_2993;
	R2337[2] = (char *(*)()) F631_2993;
	R2337[3] = (char *(*)()) F632_2993;
	R2337[4] = (char *(*)()) F629_2993;
	R2337[5] = (char *(*)()) F631_2993;
	R2337[6] = (char *(*)()) F629_2993;
}

char *(*R2338[7])();
void R2338_init () {
	R2338[0] = (char *(*)()) F629_2994;
	R2338[1] = (char *(*)()) F630_2994;
	R2338[2] = (char *(*)()) F631_2994;
	R2338[3] = (char *(*)()) F632_2994;
	R2338[4] = (char *(*)()) F629_2994;
	R2338[5] = (char *(*)()) F631_2994;
	R2338[6] = (char *(*)()) F629_2994;
}

char *(*R2345[7])();
void R2345_init () {
	R2345[0] = (char *(*)()) F629_3001;
	R2345[1] = (char *(*)()) F630_3001;
	R2345[2] = (char *(*)()) F631_3001_2345_1;
	R2345[3] = (char *(*)()) F632_3001_2345_1;
	R2345[4] = (char *(*)()) F629_3001;
	R2345[5] = (char *(*)()) F631_3001_2345_1;
	R2345[6] = (char *(*)()) F629_3001;
}
static EIF_REFERENCE F631_3001_2345_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F631_3001(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F632_3001_2345_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F632_3001(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2346[7])();
void R2346_init () {
	R2346[0] = (char *(*)()) F629_3002;
	R2346[1] = (char *(*)()) F630_3002_2346_1;
	R2346[2] = (char *(*)()) F631_3002;
	R2346[3] = (char *(*)()) F632_3002_2346_1;
	R2346[4] = (char *(*)()) F629_3002;
	R2346[5] = (char *(*)()) F631_3002;
	R2346[6] = (char *(*)()) F629_3002;
}
static EIF_REFERENCE F630_3002_2346_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F630_3002(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F632_3002_2346_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F632_3002(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2347[7])();
void R2347_init () {
	R2347[0] = (char *(*)()) F629_3003;
	R2347[1] = (char *(*)()) F630_3003;
	R2347[2] = (char *(*)()) F631_3003;
	R2347[3] = (char *(*)()) F632_3003;
	R2347[4] = (char *(*)()) F629_3003;
	R2347[5] = (char *(*)()) F631_3003;
	R2347[6] = (char *(*)()) F629_3003;
}

char *(*R2348[7])();
void R2348_init () {
	R2348[0] = (char *(*)()) F629_3004;
	R2348[1] = (char *(*)()) F630_3004;
	R2348[2] = (char *(*)()) F631_3004;
	R2348[3] = (char *(*)()) F632_3004;
	R2348[4] = (char *(*)()) F629_3004;
	R2348[5] = (char *(*)()) F631_3004;
	R2348[6] = (char *(*)()) F629_3004;
}

char *(*R2351[7])();
void R2351_init () {
	R2351[0] = (char *(*)()) F629_3007;
	R2351[1] = (char *(*)()) F630_3007;
	R2351[2] = (char *(*)()) F631_3007;
	R2351[3] = (char *(*)()) F632_3007;
	R2351[4] = (char *(*)()) F629_3007;
	R2351[5] = (char *(*)()) F631_3007;
	R2351[6] = (char *(*)()) F629_3007;
}

char *(*R2353[7])();
void R2353_init () {
	R2353[0] = (char *(*)()) F629_3009;
	R2353[1] = (char *(*)()) F630_3009;
	R2353[2] = (char *(*)()) F631_3009;
	R2353[3] = (char *(*)()) F632_3009;
	R2353[4] = (char *(*)()) F629_3009;
	R2353[5] = (char *(*)()) F631_3009;
	R2353[6] = (char *(*)()) F629_3009;
}

char *(*R2354[7])();
void R2354_init () {
	R2354[0] = (char *(*)()) F629_3010;
	R2354[1] = (char *(*)()) F630_3010;
	R2354[2] = (char *(*)()) F631_3010;
	R2354[3] = (char *(*)()) F632_3010;
	R2354[4] = (char *(*)()) F629_3010;
	R2354[5] = (char *(*)()) F631_3010;
	R2354[6] = (char *(*)()) F629_3010;
}

char *(*R2355[7])();
void R2355_init () {
	R2355[0] = (char *(*)()) F629_3011;
	R2355[1] = (char *(*)()) F630_3011;
	R2355[2] = (char *(*)()) F631_3011;
	R2355[3] = (char *(*)()) F632_3011;
	R2355[4] = (char *(*)()) F629_3011;
	R2355[5] = (char *(*)()) F631_3011;
	R2355[6] = (char *(*)()) F629_3011;
}

char *(*R2359[7])();
void R2359_init () {
	R2359[0] = (char *(*)()) F629_3015;
	R2359[1] = (char *(*)()) F630_3015_2359_4;
	R2359[2] = (char *(*)()) F631_3015;
	R2359[3] = (char *(*)()) F632_3015_2359_4;
	R2359[4] = (char *(*)()) F629_3015;
	R2359[5] = (char *(*)()) F631_3015;
	R2359[6] = (char *(*)()) F629_3015;
}
static void F630_3015_2359_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F630_3015(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F632_3015_2359_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F632_3015(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2365[7])();
void R2365_init () {
	R2365[0] = (char *(*)()) F629_3021;
	R2365[1] = (char *(*)()) F630_3021;
	R2365[2] = (char *(*)()) F631_3021;
	R2365[3] = (char *(*)()) F632_3021;
	R2365[4] = (char *(*)()) F629_3021;
	R2365[5] = (char *(*)()) F631_3021;
	R2365[6] = (char *(*)()) F629_3021;
}

char *(*R2378[7])();
void R2378_init () {
	R2378[0] = (char *(*)()) F629_3034;
	R2378[1] = (char *(*)()) F630_3034;
	R2378[2] = (char *(*)()) F631_3034;
	R2378[3] = (char *(*)()) F632_3034;
	R2378[4] = (char *(*)()) F629_3034;
	R2378[5] = (char *(*)()) F631_3034;
	R2378[6] = (char *(*)()) F629_3034;
}

char *(*R2381[2])();
void R2381_init () {
	R2381[0] = (char *(*)()) F633_3037;
	R2381[1] = (char *(*)()) F634_3037;
}

char *(*R2486[13])();
void R2486_init () {
	R2486[0] = (char *(*)()) F640_3167;
	R2486[1] = (char *(*)()) F641_3167;
	R2486[2] = (char *(*)()) F642_3167;
	R2486[3] = (char *(*)()) F643_3167;
	R2486[4] = (char *(*)()) F644_3167;
	R2486[5] = (char *(*)()) F645_3167;
	R2486[6] = (char *(*)()) F646_3167;
	R2486[7] = (char *(*)()) F647_3167;
	R2486[8] = (char *(*)()) F648_3167;
	R2486[9] = (char *(*)()) F649_3167;
	R2486[10] = (char *(*)()) F650_3167;
	R2486[11] = (char *(*)()) F651_3167;
	R2486[12] = (char *(*)()) F652_3167;
}

char *(*R2487[13])();
void R2487_init () {
	R2487[0] = (char *(*)()) F640_3168;
	R2487[1] = (char *(*)()) F641_3168;
	R2487[2] = (char *(*)()) F642_3168;
	R2487[3] = (char *(*)()) F643_3168;
	R2487[4] = (char *(*)()) F644_3168;
	R2487[5] = (char *(*)()) F645_3168;
	R2487[6] = (char *(*)()) F646_3168;
	R2487[7] = (char *(*)()) F647_3168;
	R2487[8] = (char *(*)()) F648_3168;
	R2487[9] = (char *(*)()) F649_3168;
	R2487[10] = (char *(*)()) F650_3168;
	R2487[11] = (char *(*)()) F651_3168;
	R2487[12] = (char *(*)()) F652_3168;
}

char *(*R2489[13])();
void R2489_init () {
	R2489[0] = (char *(*)()) F640_3154;
	R2489[1] = (char *(*)()) F641_3154;
	R2489[2] = (char *(*)()) F642_3154;
	R2489[3] = (char *(*)()) F643_3154;
	R2489[4] = (char *(*)()) F644_3154;
	R2489[5] = (char *(*)()) F645_3154;
	R2489[6] = (char *(*)()) F646_3154;
	R2489[7] = (char *(*)()) F647_3154;
	R2489[8] = (char *(*)()) F648_3154;
	R2489[9] = (char *(*)()) F649_3154;
	R2489[10] = (char *(*)()) F650_3154;
	R2489[11] = (char *(*)()) F651_3154;
	R2489[12] = (char *(*)()) F652_3154;
}

char *(*R2490[13])();
void R2490_init () {
	R2490[0] = (char *(*)()) F640_3155;
	R2490[1] = (char *(*)()) F641_3155_2490_115;
	R2490[2] = (char *(*)()) F642_3155_2490_115;
	R2490[3] = (char *(*)()) F643_3155_2490_115;
	R2490[4] = (char *(*)()) F644_3155_2490_115;
	R2490[5] = (char *(*)()) F645_3155_2490_115;
	R2490[6] = (char *(*)()) F646_3155_2490_115;
	R2490[7] = (char *(*)()) F647_3155_2490_115;
	R2490[8] = (char *(*)()) F648_3155_2490_115;
	R2490[9] = (char *(*)()) F649_3155_2490_115;
	R2490[10] = (char *(*)()) F650_3155_2490_115;
	R2490[11] = (char *(*)()) F651_3155_2490_115;
	R2490[12] = (char *(*)()) F652_3155_2490_115;
}
static void F641_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F641_3155(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F642_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F642_3155(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F643_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F643_3155(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F644_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F644_3155(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F645_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F645_3155(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F646_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F646_3155(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F647_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F647_3155(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F648_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F648_3155(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F649_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F649_3155(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F650_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F650_3155(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F651_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F651_3155(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F652_3155_2490_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F652_3155(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R2499[13])();
void R2499_init () {
	R2499[0] = (char *(*)()) F640_3170;
	R2499[1] = (char *(*)()) F641_3170;
	R2499[2] = (char *(*)()) F642_3170;
	R2499[3] = (char *(*)()) F643_3170;
	R2499[4] = (char *(*)()) F644_3170;
	R2499[5] = (char *(*)()) F645_3170;
	R2499[6] = (char *(*)()) F646_3170;
	R2499[7] = (char *(*)()) F647_3170;
	R2499[8] = (char *(*)()) F648_3170;
	R2499[9] = (char *(*)()) F649_3170;
	R2499[10] = (char *(*)()) F650_3170;
	R2499[11] = (char *(*)()) F651_3170;
	R2499[12] = (char *(*)()) F652_3170;
}

char *(*R2500[13])();
void R2500_init () {
	R2500[0] = (char *(*)()) F640_3172;
	R2500[1] = (char *(*)()) F641_3172_2500_115;
	R2500[2] = (char *(*)()) F642_3172_2500_115;
	R2500[3] = (char *(*)()) F643_3172_2500_115;
	R2500[4] = (char *(*)()) F644_3172_2500_115;
	R2500[5] = (char *(*)()) F645_3172_2500_115;
	R2500[6] = (char *(*)()) F646_3172_2500_115;
	R2500[7] = (char *(*)()) F647_3172_2500_115;
	R2500[8] = (char *(*)()) F648_3172_2500_115;
	R2500[9] = (char *(*)()) F649_3172_2500_115;
	R2500[10] = (char *(*)()) F650_3172_2500_115;
	R2500[11] = (char *(*)()) F651_3172_2500_115;
	R2500[12] = (char *(*)()) F652_3172_2500_115;
}
static void F641_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F641_3172(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F642_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F642_3172(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F643_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F643_3172(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F644_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F644_3172(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F645_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F645_3172(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F646_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F646_3172(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F647_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F647_3172(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F648_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F648_3172(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F649_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F649_3172(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F650_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F650_3172(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F651_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F651_3172(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F652_3172_2500_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F652_3172(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R2501[13])();
void R2501_init () {
	R2501[0] = (char *(*)()) F640_3173;
	R2501[1] = (char *(*)()) F641_3173_2501_115;
	R2501[2] = (char *(*)()) F642_3173_2501_115;
	R2501[3] = (char *(*)()) F643_3173_2501_115;
	R2501[4] = (char *(*)()) F644_3173_2501_115;
	R2501[5] = (char *(*)()) F645_3173_2501_115;
	R2501[6] = (char *(*)()) F646_3173_2501_115;
	R2501[7] = (char *(*)()) F647_3173_2501_115;
	R2501[8] = (char *(*)()) F648_3173_2501_115;
	R2501[9] = (char *(*)()) F649_3173_2501_115;
	R2501[10] = (char *(*)()) F650_3173_2501_115;
	R2501[11] = (char *(*)()) F651_3173_2501_115;
	R2501[12] = (char *(*)()) F652_3173_2501_115;
}
static void F641_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F641_3173(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F642_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F642_3173(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F643_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F643_3173(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F644_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F644_3173(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F645_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F645_3173(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F646_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F646_3173(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F647_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F647_3173(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F648_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F648_3173(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F649_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F649_3173(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F650_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F650_3173(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F651_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F651_3173(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F652_3173_2501_115 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F652_3173(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R2504[13])();
void R2504_init () {
	R2504[0] = (char *(*)()) F640_3176;
	R2504[1] = (char *(*)()) F641_3176_2504_145;
	R2504[2] = (char *(*)()) F642_3176_2504_145;
	R2504[3] = (char *(*)()) F643_3176_2504_145;
	R2504[4] = (char *(*)()) F644_3176_2504_145;
	R2504[5] = (char *(*)()) F645_3176_2504_145;
	R2504[6] = (char *(*)()) F646_3176_2504_145;
	R2504[7] = (char *(*)()) F647_3176_2504_145;
	R2504[8] = (char *(*)()) F648_3176_2504_145;
	R2504[9] = (char *(*)()) F649_3176_2504_145;
	R2504[10] = (char *(*)()) F650_3176_2504_145;
	R2504[11] = (char *(*)()) F651_3176_2504_145;
	R2504[12] = (char *(*)()) F652_3176_2504_145;
}
static void F641_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F641_3176(Current, *(EIF_CHARACTER_32 *)arg1, arg2, arg3);
}
static void F642_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F642_3176(Current, *(EIF_CHARACTER_8 *)arg1, arg2, arg3);
}
static void F643_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F643_3176(Current, *(EIF_NATURAL_8 *)arg1, arg2, arg3);
}
static void F644_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F644_3176(Current, *(EIF_NATURAL_16 *)arg1, arg2, arg3);
}
static void F645_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F645_3176(Current, *(EIF_POINTER *)arg1, arg2, arg3);
}
static void F646_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F646_3176(Current, *(EIF_REAL_32 *)arg1, arg2, arg3);
}
static void F647_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F647_3176(Current, *(EIF_REAL_64 *)arg1, arg2, arg3);
}
static void F648_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F648_3176(Current, *(EIF_INTEGER_32 *)arg1, arg2, arg3);
}
static void F649_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F649_3176(Current, *(EIF_BOOLEAN *)arg1, arg2, arg3);
}
static void F650_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F650_3176(Current, *(EIF_NATURAL_64 *)arg1, arg2, arg3);
}
static void F651_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F651_3176(Current, *(EIF_NATURAL_32 *)arg1, arg2, arg3);
}
static void F652_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F652_3176(Current, *(EIF_INTEGER_64 *)arg1, arg2, arg3);
}

char *(*R2507[13])();
void R2507_init () {
	R2507[0] = (char *(*)()) F640_3179;
	R2507[1] = (char *(*)()) F641_3179;
	R2507[2] = (char *(*)()) F642_3179;
	R2507[3] = (char *(*)()) F643_3179;
	R2507[4] = (char *(*)()) F644_3179;
	R2507[5] = (char *(*)()) F645_3179;
	R2507[6] = (char *(*)()) F646_3179;
	R2507[7] = (char *(*)()) F647_3179;
	R2507[8] = (char *(*)()) F648_3179;
	R2507[9] = (char *(*)()) F649_3179;
	R2507[10] = (char *(*)()) F650_3179;
	R2507[11] = (char *(*)()) F651_3179;
	R2507[12] = (char *(*)()) F652_3179;
}

char *(*R2508[13])();
void R2508_init () {
	R2508[0] = (char *(*)()) F640_3180;
	R2508[1] = (char *(*)()) F641_3180;
	R2508[2] = (char *(*)()) F642_3180;
	R2508[3] = (char *(*)()) F643_3180;
	R2508[4] = (char *(*)()) F644_3180;
	R2508[5] = (char *(*)()) F645_3180;
	R2508[6] = (char *(*)()) F646_3180;
	R2508[7] = (char *(*)()) F647_3180;
	R2508[8] = (char *(*)()) F648_3180;
	R2508[9] = (char *(*)()) F649_3180;
	R2508[10] = (char *(*)()) F650_3180;
	R2508[11] = (char *(*)()) F651_3180;
	R2508[12] = (char *(*)()) F652_3180;
}

char *(*R2509[13])();
void R2509_init () {
	R2509[0] = (char *(*)()) F640_3181;
	R2509[1] = (char *(*)()) F641_3181;
	R2509[2] = (char *(*)()) F642_3181;
	R2509[3] = (char *(*)()) F643_3181;
	R2509[4] = (char *(*)()) F644_3181;
	R2509[5] = (char *(*)()) F645_3181;
	R2509[6] = (char *(*)()) F646_3181;
	R2509[7] = (char *(*)()) F647_3181;
	R2509[8] = (char *(*)()) F648_3181;
	R2509[9] = (char *(*)()) F649_3181;
	R2509[10] = (char *(*)()) F650_3181;
	R2509[11] = (char *(*)()) F651_3181;
	R2509[12] = (char *(*)()) F652_3181;
}

char *(*R2510[13])();
void R2510_init () {
	R2510[0] = (char *(*)()) F640_3182;
	R2510[1] = (char *(*)()) F641_3182;
	R2510[2] = (char *(*)()) F642_3182;
	R2510[3] = (char *(*)()) F643_3182;
	R2510[4] = (char *(*)()) F644_3182;
	R2510[5] = (char *(*)()) F645_3182;
	R2510[6] = (char *(*)()) F646_3182;
	R2510[7] = (char *(*)()) F647_3182;
	R2510[8] = (char *(*)()) F648_3182;
	R2510[9] = (char *(*)()) F649_3182;
	R2510[10] = (char *(*)()) F650_3182;
	R2510[11] = (char *(*)()) F651_3182;
	R2510[12] = (char *(*)()) F652_3182;
}

char *(*R2517[13])();
void R2517_init () {
	R2517[0] = (char *(*)()) F640_3189;
	R2517[1] = (char *(*)()) F641_3189;
	R2517[2] = (char *(*)()) F642_3189;
	R2517[3] = (char *(*)()) F643_3189;
	R2517[4] = (char *(*)()) F644_3189;
	R2517[5] = (char *(*)()) F645_3189;
	R2517[6] = (char *(*)()) F646_3189;
	R2517[7] = (char *(*)()) F647_3189;
	R2517[8] = (char *(*)()) F648_3189;
	R2517[9] = (char *(*)()) F649_3189;
	R2517[10] = (char *(*)()) F650_3189;
	R2517[11] = (char *(*)()) F651_3189;
	R2517[12] = (char *(*)()) F652_3189;
}

char *(*R2520[13])();
void R2520_init () {
	R2520[0] = (char *(*)()) F640_3192;
	R2520[1] = (char *(*)()) F641_3192;
	R2520[2] = (char *(*)()) F642_3192;
	R2520[3] = (char *(*)()) F643_3192;
	R2520[4] = (char *(*)()) F644_3192;
	R2520[5] = (char *(*)()) F645_3192;
	R2520[6] = (char *(*)()) F646_3192;
	R2520[7] = (char *(*)()) F647_3192;
	R2520[8] = (char *(*)()) F648_3192;
	R2520[9] = (char *(*)()) F649_3192;
	R2520[10] = (char *(*)()) F650_3192;
	R2520[11] = (char *(*)()) F651_3192;
	R2520[12] = (char *(*)()) F652_3192;
}

char *(*R2529[13])();
void R2529_init () {
	R2529[0] = (char *(*)()) F640_3202;
	R2529[1] = (char *(*)()) F641_3202;
	R2529[2] = (char *(*)()) F642_3202;
	R2529[3] = (char *(*)()) F643_3202;
	R2529[4] = (char *(*)()) F644_3202;
	R2529[5] = (char *(*)()) F645_3202;
	R2529[6] = (char *(*)()) F646_3202;
	R2529[7] = (char *(*)()) F647_3202;
	R2529[8] = (char *(*)()) F648_3202;
	R2529[9] = (char *(*)()) F649_3202;
	R2529[10] = (char *(*)()) F650_3202;
	R2529[11] = (char *(*)()) F651_3202;
	R2529[12] = (char *(*)()) F652_3202;
}

char *(*R2577[118])();
void R2577_init () {
	R2577[0] = (char *(*)()) F702_3342;
	R2577[1] = (char *(*)()) F703_3342;
	R2577[2] = (char *(*)()) F704_3342;
	R2577[3] = (char *(*)()) F705_3342;
	R2577[4] = (char *(*)()) F706_3342;
	R2577[5] = (char *(*)()) F707_3342;
	R2577[6] = (char *(*)()) F708_3342;
	R2577[7] = (char *(*)()) F709_3342;
	R2577[8] = (char *(*)()) F710_3342;
	R2577[9] = (char *(*)()) F711_3342;
	R2577[10] = (char *(*)()) F712_3342;
	R2577[11] = (char *(*)()) F713_3342;
	R2577[12] = (char *(*)()) F714_3342;
	R2577[13] = (char *(*)()) F715_3342;
	R2577[14] = (char *(*)()) F716_3342;
	R2577[15] = (char *(*)()) F717_3342;
	R2577[16] = (char *(*)()) F718_3342;
	R2577[17] = (char *(*)()) F719_3342;
	R2577[18] = (char *(*)()) F720_3342;
	R2577[19] = (char *(*)()) F721_3342;
	R2577[20] = (char *(*)()) F722_3342;
	R2577[21] = (char *(*)()) F723_3342;
	R2577[22] = (char *(*)()) F724_3342;
	R2577[23] = (char *(*)()) F725_3342;
	R2577[24] = (char *(*)()) F726_3342;
	R2577[25] = (char *(*)()) F727_3342;
	R2577[26] = (char *(*)()) F728_3342;
	R2577[27] = (char *(*)()) F729_3342;
	R2577[28] = (char *(*)()) F730_3342;
	R2577[29] = (char *(*)()) F731_3342;
	R2577[30] = (char *(*)()) F732_3342;
	R2577[31] = (char *(*)()) F733_3394;
	{long i; for (i = 33; i < 35; i++) R2577[i] = (char *(*)()) F734_3501;}
	{long i; for (i = 36; i < 38; i++) R2577[i] = (char *(*)()) F737_3568;}
	{long i; for (i = 39; i < 41; i++) R2577[i] = (char *(*)()) F740_3609;}
	{long i; for (i = 42; i < 44; i++) R2577[i] = (char *(*)()) F743_3657;}
	{long i; for (i = 45; i < 47; i++) R2577[i] = (char *(*)()) F746_3678;}
	{long i; for (i = 48; i < 50; i++) R2577[i] = (char *(*)()) F749_3776;}
	{long i; for (i = 51; i < 53; i++) R2577[i] = (char *(*)()) F752_3875;}
	{long i; for (i = 54; i < 56; i++) R2577[i] = (char *(*)()) F755_3974;}
	{long i; for (i = 57; i < 59; i++) R2577[i] = (char *(*)()) F758_4073;}
	{long i; for (i = 60; i < 62; i++) R2577[i] = (char *(*)()) F761_4167;}
	{long i; for (i = 63; i < 65; i++) R2577[i] = (char *(*)()) F764_4261;}
	{long i; for (i = 66; i < 68; i++) R2577[i] = (char *(*)()) F767_4356;}
	{long i; for (i = 69; i < 71; i++) R2577[i] = (char *(*)()) F770_4451;}
	{long i; for (i = 72; i < 102; i++) R2577[i] = (char *(*)()) F773_4517;}
	R2577[102] = (char *(*)()) F804_4543;
	R2577[103] = (char *(*)()) F805_4543;
	{long i; for (i = 113; i < 115; i++) R2577[i] = (char *(*)()) F811_4610;}
	{long i; for (i = 116; i < 118; i++) R2577[i] = (char *(*)()) F811_4610;}
}

char *(*R2635[31])();
void R2635_init () {
	R2635[0] = (char *(*)()) F702_3338;
	R2635[1] = (char *(*)()) F703_3338;
	R2635[2] = (char *(*)()) F704_3338;
	R2635[3] = (char *(*)()) F705_3338;
	R2635[4] = (char *(*)()) F706_3338;
	R2635[5] = (char *(*)()) F707_3338;
	R2635[6] = (char *(*)()) F708_3338;
	R2635[7] = (char *(*)()) F709_3338;
	R2635[8] = (char *(*)()) F710_3338;
	R2635[9] = (char *(*)()) F711_3338;
	R2635[10] = (char *(*)()) F712_3338;
	R2635[11] = (char *(*)()) F713_3338;
	R2635[12] = (char *(*)()) F714_3338;
	R2635[13] = (char *(*)()) F715_3338;
	R2635[14] = (char *(*)()) F716_3338;
	R2635[15] = (char *(*)()) F717_3338;
	R2635[16] = (char *(*)()) F718_3338;
	R2635[17] = (char *(*)()) F719_3338;
	R2635[18] = (char *(*)()) F720_3338;
	R2635[19] = (char *(*)()) F721_3338;
	R2635[20] = (char *(*)()) F722_3338;
	R2635[21] = (char *(*)()) F723_3338;
	R2635[22] = (char *(*)()) F724_3338;
	R2635[23] = (char *(*)()) F725_3338;
	R2635[24] = (char *(*)()) F726_3338;
	R2635[25] = (char *(*)()) F727_3338;
	R2635[26] = (char *(*)()) F728_3338;
	R2635[27] = (char *(*)()) F729_3338;
	R2635[28] = (char *(*)()) F730_3338;
	R2635[29] = (char *(*)()) F731_3338;
	R2635[30] = (char *(*)()) F732_3338;
}

char *(*R2638[31])();
void R2638_init () {
	R2638[0] = (char *(*)()) F702_3341;
	R2638[1] = (char *(*)()) F703_3341;
	R2638[2] = (char *(*)()) F704_3341;
	R2638[3] = (char *(*)()) F705_3341;
	R2638[4] = (char *(*)()) F706_3341;
	R2638[5] = (char *(*)()) F707_3341;
	R2638[6] = (char *(*)()) F708_3341;
	R2638[7] = (char *(*)()) F709_3341;
	R2638[8] = (char *(*)()) F710_3341;
	R2638[9] = (char *(*)()) F711_3341;
	R2638[10] = (char *(*)()) F712_3341;
	R2638[11] = (char *(*)()) F713_3341;
	R2638[12] = (char *(*)()) F714_3341;
	R2638[13] = (char *(*)()) F715_3341;
	R2638[14] = (char *(*)()) F716_3341;
	R2638[15] = (char *(*)()) F717_3341;
	R2638[16] = (char *(*)()) F718_3341;
	R2638[17] = (char *(*)()) F719_3341;
	R2638[18] = (char *(*)()) F720_3341;
	R2638[19] = (char *(*)()) F721_3341;
	R2638[20] = (char *(*)()) F722_3341;
	R2638[21] = (char *(*)()) F723_3341;
	R2638[22] = (char *(*)()) F724_3341;
	R2638[23] = (char *(*)()) F725_3341;
	R2638[24] = (char *(*)()) F726_3341;
	R2638[25] = (char *(*)()) F727_3341;
	R2638[26] = (char *(*)()) F728_3341;
	R2638[27] = (char *(*)()) F729_3341;
	R2638[28] = (char *(*)()) F730_3341;
	R2638[29] = (char *(*)()) F731_3341;
	R2638[30] = (char *(*)()) F732_3341;
}

char *(*R2643[31])();
void R2643_init () {
	R2643[0] = (char *(*)()) F702_3347;
	R2643[1] = (char *(*)()) F703_3347;
	R2643[2] = (char *(*)()) F704_3347;
	R2643[3] = (char *(*)()) F705_3347;
	R2643[4] = (char *(*)()) F706_3347;
	R2643[5] = (char *(*)()) F707_3347;
	R2643[6] = (char *(*)()) F708_3347;
	R2643[7] = (char *(*)()) F709_3347;
	R2643[8] = (char *(*)()) F710_3347;
	R2643[9] = (char *(*)()) F711_3347;
	R2643[10] = (char *(*)()) F712_3347;
	R2643[11] = (char *(*)()) F713_3347;
	R2643[12] = (char *(*)()) F714_3347;
	R2643[13] = (char *(*)()) F715_3347;
	R2643[14] = (char *(*)()) F716_3347;
	R2643[15] = (char *(*)()) F717_3347;
	R2643[16] = (char *(*)()) F718_3347;
	R2643[17] = (char *(*)()) F719_3347;
	R2643[18] = (char *(*)()) F720_3347;
	R2643[19] = (char *(*)()) F721_3347;
	R2643[20] = (char *(*)()) F722_3347;
	R2643[21] = (char *(*)()) F723_3347;
	R2643[22] = (char *(*)()) F724_3347;
	R2643[23] = (char *(*)()) F725_3347;
	R2643[24] = (char *(*)()) F726_3347;
	R2643[25] = (char *(*)()) F727_3347;
	R2643[26] = (char *(*)()) F728_3347;
	R2643[27] = (char *(*)()) F729_3347;
	R2643[28] = (char *(*)()) F730_3347;
	R2643[29] = (char *(*)()) F731_3347;
	R2643[30] = (char *(*)()) F732_3347;
}

char *(*R2650[31])();
void R2650_init () {
	R2650[0] = (char *(*)()) F702_3355;
	R2650[1] = (char *(*)()) F703_3355_2650_1;
	R2650[2] = (char *(*)()) F704_3355_2650_1;
	R2650[3] = (char *(*)()) F705_3355_2650_1;
	R2650[4] = (char *(*)()) F706_3355_2650_1;
	R2650[5] = (char *(*)()) F707_3355_2650_1;
	R2650[6] = (char *(*)()) F708_3355_2650_1;
	R2650[7] = (char *(*)()) F709_3355_2650_1;
	R2650[8] = (char *(*)()) F710_3355_2650_1;
	R2650[9] = (char *(*)()) F711_3355_2650_1;
	R2650[10] = (char *(*)()) F712_3355_2650_1;
	R2650[11] = (char *(*)()) F713_3355_2650_1;
	R2650[12] = (char *(*)()) F714_3355_2650_1;
	R2650[13] = (char *(*)()) F715_3355_2650_1;
	R2650[14] = (char *(*)()) F716_3355_2650_1;
	R2650[15] = (char *(*)()) F717_3355_2650_1;
	R2650[16] = (char *(*)()) F718_3355_2650_1;
	R2650[17] = (char *(*)()) F719_3355;
	R2650[18] = (char *(*)()) F720_3355_2650_1;
	R2650[19] = (char *(*)()) F721_3355_2650_1;
	R2650[20] = (char *(*)()) F722_3355_2650_1;
	R2650[21] = (char *(*)()) F723_3355_2650_1;
	R2650[22] = (char *(*)()) F724_3355_2650_1;
	R2650[23] = (char *(*)()) F725_3355_2650_1;
	R2650[24] = (char *(*)()) F726_3355_2650_1;
	R2650[25] = (char *(*)()) F727_3355_2650_1;
	R2650[26] = (char *(*)()) F728_3355_2650_1;
	R2650[27] = (char *(*)()) F729_3355_2650_1;
	R2650[28] = (char *(*)()) F730_3355_2650_1;
	R2650[29] = (char *(*)()) F731_3355_2650_1;
	R2650[30] = (char *(*)()) F732_3355_2650_1;
}
static EIF_REFERENCE F703_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F703_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(804, 0x00).id, 804, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F704_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REFERENCE* r = F704_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {774,0,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 774, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REFERENCE* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F705_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F705_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(738, 0x00).id, 738, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F706_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F706_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(735, 0x00).id, 735, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F707_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F707_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(771, 0x00).id, 771, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F708_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F708_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F709_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F709_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(765, 0x00).id, 765, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F710_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F710_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(762, 0x00).id, 762, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F711_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F711_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(759, 0x00).id, 759, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F712_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8 r = F712_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i1;
	} else {
		Result = RTLNS(eif_new_type(756, 0x00).id, 756, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_INTEGER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F713_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16 r = F713_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i2;
	} else {
		Result = RTLNS(eif_new_type(753, 0x00).id, 753, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_INTEGER_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F714_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F714_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(750, 0x00).id, 750, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F715_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F715_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(747, 0x00).id, 747, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F716_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F716_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(741, 0x00).id, 741, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F717_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F717_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(744, 0x00).id, 744, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F718_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8* r = F718_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {776,741,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 776, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F720_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8* r = F720_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {778,756,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 778, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F721_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32* r = F721_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {780,762,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 780, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F722_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16* r = F722_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {782,753,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 782, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F723_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32* r = F723_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {784,750,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 784, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F724_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER* r = F724_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {786,804,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 786, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_POINTER* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F725_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32* r = F725_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {788,738,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 788, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F726_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16* r = F726_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {790,765,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 790, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F727_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64* r = F727_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {792,747,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 792, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F728_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN* r = F728_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {794,744,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 794, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_BOOLEAN* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F729_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8* r = F729_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {796,768,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 796, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F730_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32* r = F730_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {798,771,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 798, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F731_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64* r = F731_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {800,735,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 800, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F732_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64* r = F732_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {802,759,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 802, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_64* *)Result = r;
		return Result;
	}
}

char *(*R2660[31])();
void R2660_init () {
	R2660[0] = (char *(*)()) F702_3367;
	R2660[1] = (char *(*)()) F703_3367;
	R2660[2] = (char *(*)()) F704_3367;
	R2660[3] = (char *(*)()) F705_3367;
	R2660[4] = (char *(*)()) F706_3367;
	R2660[5] = (char *(*)()) F707_3367;
	R2660[6] = (char *(*)()) F708_3367;
	R2660[7] = (char *(*)()) F709_3367;
	R2660[8] = (char *(*)()) F710_3367;
	R2660[9] = (char *(*)()) F711_3367;
	R2660[10] = (char *(*)()) F712_3367;
	R2660[11] = (char *(*)()) F713_3367;
	R2660[12] = (char *(*)()) F714_3367;
	R2660[13] = (char *(*)()) F715_3367;
	R2660[14] = (char *(*)()) F716_3367;
	R2660[15] = (char *(*)()) F717_3367;
	R2660[16] = (char *(*)()) F718_3367;
	R2660[17] = (char *(*)()) F719_3367;
	R2660[18] = (char *(*)()) F720_3367;
	R2660[19] = (char *(*)()) F721_3367;
	R2660[20] = (char *(*)()) F722_3367;
	R2660[21] = (char *(*)()) F723_3367;
	R2660[22] = (char *(*)()) F724_3367;
	R2660[23] = (char *(*)()) F725_3367;
	R2660[24] = (char *(*)()) F726_3367;
	R2660[25] = (char *(*)()) F727_3367;
	R2660[26] = (char *(*)()) F728_3367;
	R2660[27] = (char *(*)()) F729_3367;
	R2660[28] = (char *(*)()) F730_3367;
	R2660[29] = (char *(*)()) F731_3367;
	R2660[30] = (char *(*)()) F732_3367;
}

char *(*R2802[2])();
void R2802_init () {
	R2802[0] = (char *(*)()) F735_3546;
	R2802[1] = (char *(*)()) F736_3546;
}

char *(*R2823[2])();
void R2823_init () {
	R2823[0] = (char *(*)()) F738_3604;
	R2823[1] = (char *(*)()) F739_3604;
}

char *(*R2929[2])();
void R2929_init () {
	R2929[0] = (char *(*)()) F747_3760;
	R2929[1] = (char *(*)()) F748_3760;
}

char *(*R2932[2])();
void R2932_init () {
	R2932[0] = (char *(*)()) F747_3763;
	R2932[1] = (char *(*)()) F748_3763;
}

char *(*R2984[2])();
void R2984_init () {
	R2984[0] = (char *(*)()) F750_3858;
	R2984[1] = (char *(*)()) F751_3858;
}

char *(*R2985[2])();
void R2985_init () {
	R2985[0] = (char *(*)()) F750_3859;
	R2985[1] = (char *(*)()) F751_3859;
}

char *(*R2989[2])();
void R2989_init () {
	R2989[0] = (char *(*)()) F750_3863;
	R2989[1] = (char *(*)()) F751_3863;
}

char *(*R3041[2])();
void R3041_init () {
	R3041[0] = (char *(*)()) F753_3958;
	R3041[1] = (char *(*)()) F754_3958;
}

char *(*R3044[2])();
void R3044_init () {
	R3044[0] = (char *(*)()) F753_3961;
	R3044[1] = (char *(*)()) F754_3961;
}

char *(*R3094[2])();
void R3094_init () {
	R3094[0] = (char *(*)()) F756_4054;
	R3094[1] = (char *(*)()) F757_4054;
}

char *(*R3097[2])();
void R3097_init () {
	R3097[0] = (char *(*)()) F756_4057;
	R3097[1] = (char *(*)()) F757_4057;
}

char *(*R3100[2])();
void R3100_init () {
	R3100[0] = (char *(*)()) F756_4060;
	R3100[1] = (char *(*)()) F757_4060;
}

char *(*R3154[2])();
void R3154_init () {
	R3154[0] = (char *(*)()) F759_4154;
	R3154[1] = (char *(*)()) F760_4154;
}

char *(*R3200[2])();
void R3200_init () {
	R3200[0] = (char *(*)()) F762_4242;
	R3200[1] = (char *(*)()) F763_4242;
}

char *(*R3201[2])();
void R3201_init () {
	R3201[0] = (char *(*)()) F762_4243;
	R3201[1] = (char *(*)()) F763_4243;
}

char *(*R3203[2])();
void R3203_init () {
	R3203[0] = (char *(*)()) F762_4245;
	R3203[1] = (char *(*)()) F763_4245;
}

char *(*R3206[2])();
void R3206_init () {
	R3206[0] = (char *(*)()) F762_4248;
	R3206[1] = (char *(*)()) F763_4248;
}

char *(*R3207[2])();
void R3207_init () {
	R3207[0] = (char *(*)()) F762_4249;
	R3207[1] = (char *(*)()) F763_4249;
}

char *(*R3255[2])();
void R3255_init () {
	R3255[0] = (char *(*)()) F765_4339;
	R3255[1] = (char *(*)()) F766_4339;
}

char *(*R3256[2])();
void R3256_init () {
	R3256[0] = (char *(*)()) F765_4340;
	R3256[1] = (char *(*)()) F766_4340;
}

char *(*R3259[2])();
void R3259_init () {
	R3259[0] = (char *(*)()) F765_4343;
	R3259[1] = (char *(*)()) F766_4343;
}

char *(*R3308[2])();
void R3308_init () {
	R3308[0] = (char *(*)()) F768_4434;
	R3308[1] = (char *(*)()) F769_4434;
}

char *(*R3309[2])();
void R3309_init () {
	R3309[0] = (char *(*)()) F768_4435;
	R3309[1] = (char *(*)()) F769_4435;
}

char *(*R3310[2])();
void R3310_init () {
	R3310[0] = (char *(*)()) F768_4436;
	R3310[1] = (char *(*)()) F769_4436;
}

char *(*R3312[2])();
void R3312_init () {
	R3312[0] = (char *(*)()) F768_4438;
	R3312[1] = (char *(*)()) F769_4438;
}

char *(*R3358[2])();
void R3358_init () {
	R3358[0] = (char *(*)()) F771_4496;
	R3358[1] = (char *(*)()) F772_4496;
}

char *(*R3445[5])();
void R3445_init () {
	{long i; for (i = 0; i < 2; i++) R3445[i] = (char *(*)()) F814_4731;}
	{long i; for (i = 3; i < 5; i++) R3445[i] = (char *(*)()) F817_4898;}
}

char *(*R3447[5])();
void R3447_init () {
	R3447[0] = (char *(*)()) F815_4792;
	R3447[1] = (char *(*)()) F816_4815;
	R3447[3] = (char *(*)()) F818_4958;
	R3447[4] = (char *(*)()) F819_4980;
}

char *(*R3448[5])();
void R3448_init () {
	R3448[0] = (char *(*)()) F815_4790;
	R3448[1] = (char *(*)()) F816_4813;
	R3448[3] = (char *(*)()) F818_4957;
	R3448[4] = (char *(*)()) F819_4979;
}

char *(*R3459[5])();
void R3459_init () {
	{long i; for (i = 0; i < 2; i++) R3459[i] = (char *(*)()) F814_4761;}
	{long i; for (i = 3; i < 5; i++) R3459[i] = (char *(*)()) F817_4929;}
}

char *(*R3460[5])();
void R3460_init () {
	{long i; for (i = 0; i < 2; i++) R3460[i] = (char *(*)()) F814_4762;}
	{long i; for (i = 3; i < 5; i++) R3460[i] = (char *(*)()) F817_4930;}
}

char *(*R3461[5])();
void R3461_init () {
	{long i; for (i = 0; i < 2; i++) R3461[i] = (char *(*)()) F814_4763;}
	{long i; for (i = 3; i < 5; i++) R3461[i] = (char *(*)()) F817_4931;}
}

char *(*R3462[5])();
void R3462_init () {
	R3462[0] = (char *(*)()) F815_4802;
	R3462[1] = (char *(*)()) F450_2236;
	R3462[3] = (char *(*)()) F818_4967;
	R3462[4] = (char *(*)()) F451_2236;
}

char *(*R3484[5])();
void R3484_init () {
	{long i; for (i = 0; i < 2; i++) R3484[i] = (char *(*)()) F814_4752;}
	{long i; for (i = 3; i < 5; i++) R3484[i] = (char *(*)()) F817_4920;}
}

char *(*R3485[5])();
void R3485_init () {
	{long i; for (i = 0; i < 2; i++) R3485[i] = (char *(*)()) F814_4751;}
	{long i; for (i = 3; i < 5; i++) R3485[i] = (char *(*)()) F817_4919;}
}

char *(*R3525[5])();
void R3525_init () {
	R3525[0] = (char *(*)()) F815_4799;
	R3525[1] = (char *(*)()) F816_4893;
	R3525[3] = (char *(*)()) F818_4965;
	R3525[4] = (char *(*)()) F819_5058;
}

char *(*R3540[4])();
void R3540_init () {
	R3540[0] = (char *(*)()) F816_4895;
	R3540[3] = (char *(*)()) F819_5060;
}

char *(*R3543[4])();
void R3543_init () {
	R3543[0] = (char *(*)()) F816_4834;
	R3543[3] = (char *(*)()) F819_4999;
}

char *(*R3573[4])();
void R3573_init () {
	R3573[0] = (char *(*)()) F816_4878;
	R3573[3] = (char *(*)()) F819_5043;
}

char *(*R3601[2])();
void R3601_init () {
	R3601[0] = (char *(*)()) F815_4805;
	R3601[1] = (char *(*)()) F814_4782;
}

char *(*R3681[2])();
void R3681_init () {
	R3681[0] = (char *(*)()) F818_4971;
	R3681[1] = (char *(*)()) F817_4950;
}

char *(*R3748[2])();
void R3748_init () {
	R3748[0] = (char *(*)()) F822_5142;
	R3748[1] = (char *(*)()) F823_5150;
}

char *(*R3753[2])();
void R3753_init () {
	R3753[0] = (char *(*)()) F822_5137;
	R3753[1] = (char *(*)()) F823_5153;
}

char *(*R3755[2])();
void R3755_init () {
	R3755[0] = (char *(*)()) F822_5138;
	R3755[1] = (char *(*)()) F823_5154;
}
char *(*R2[833])();
void R2_init () {}
char *(*R6[833])();
void R6_init () {}

char *(*R3[833])();
void R3_init () {
	R3[116] = (char *(*)()) F117_1292;
	R3[819] = (char *(*)()) F820_5072;
}

char *(*R4[833])();
void R4_init () {
	{long i; for (i = 1; i < 4; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 5; i < 7; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 9; i < 12; i++) R4[i] = (char *(*)()) F1_15;}
	R4[25] = (char *(*)()) F1_15;
	R4[27] = (char *(*)()) F1_15;
	R4[35] = (char *(*)()) F1_15;
	R4[39] = (char *(*)()) F1_15;
	{long i; for (i = 43; i < 49; i++) R4[i] = (char *(*)()) F1_15;}
	R4[51] = (char *(*)()) F1_15;
	{long i; for (i = 68; i < 70; i++) R4[i] = (char *(*)()) F1_15;}
	R4[71] = (char *(*)()) F1_15;
	R4[73] = (char *(*)()) F1_15;
	{long i; for (i = 75; i < 78; i++) R4[i] = (char *(*)()) F1_15;}
	R4[80] = (char *(*)()) F1_15;
	{long i; for (i = 82; i < 85; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 86; i < 89; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 90; i < 92; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 94; i < 96; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 97; i < 100; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 101; i < 105; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 106; i < 108; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 109; i < 115; i++) R4[i] = (char *(*)()) F1_15;}
	R4[116] = (char *(*)()) F117_1211;
	R4[126] = (char *(*)()) F1_15;
	R4[138] = (char *(*)()) F1_15;
	R4[156] = (char *(*)()) F157_1935;
	{long i; for (i = 238; i < 242; i++) R4[i] = (char *(*)()) F1_15;}
	R4[447] = (char *(*)()) F1_15;
	R4[545] = (char *(*)()) F546_2706;
	R4[546] = (char *(*)()) F547_2706;
	R4[547] = (char *(*)()) F548_2706;
	R4[548] = (char *(*)()) F549_2706;
	R4[549] = (char *(*)()) F550_2706;
	R4[550] = (char *(*)()) F551_2706;
	R4[551] = (char *(*)()) F552_2706;
	R4[552] = (char *(*)()) F553_2706;
	R4[553] = (char *(*)()) F554_2706;
	R4[554] = (char *(*)()) F555_2706;
	R4[555] = (char *(*)()) F556_2706;
	R4[556] = (char *(*)()) F557_2706;
	R4[557] = (char *(*)()) F558_2706;
	R4[628] = (char *(*)()) F629_2982;
	R4[629] = (char *(*)()) F630_2982;
	R4[630] = (char *(*)()) F631_2982;
	R4[631] = (char *(*)()) F632_2982;
	R4[632] = (char *(*)()) F629_2982;
	R4[633] = (char *(*)()) F631_2982;
	R4[634] = (char *(*)()) F629_2982;
	{long i; for (i = 639; i < 652; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 701; i < 733; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 734; i < 736; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 737; i < 739; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 740; i < 742; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 743; i < 745; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 746; i < 748; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 749; i < 751; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 752; i < 754; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 755; i < 757; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 758; i < 760; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 761; i < 763; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 764; i < 766; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 767; i < 769; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 770; i < 772; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 773; i < 805; i++) R4[i] = (char *(*)()) F1_15;}
	R4[814] = (char *(*)()) F815_4789;
	R4[815] = (char *(*)()) F814_4770;
	R4[817] = (char *(*)()) F818_4954;
	R4[818] = (char *(*)()) F817_4938;
	R4[819] = (char *(*)()) F1_15;
	{long i; for (i = 821; i < 823; i++) R4[i] = (char *(*)()) F1_15;}
	R4[829] = (char *(*)()) F1_15;
}

char *(*R5[833])();
void R5_init () {
	{long i; for (i = 1; i < 4; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 5; i < 7; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 9; i < 12; i++) R5[i] = (char *(*)()) F1_8;}
	R5[25] = (char *(*)()) F1_8;
	R5[27] = (char *(*)()) F1_8;
	R5[35] = (char *(*)()) F1_8;
	R5[39] = (char *(*)()) F1_8;
	{long i; for (i = 43; i < 49; i++) R5[i] = (char *(*)()) F1_8;}
	R5[51] = (char *(*)()) F1_8;
	{long i; for (i = 68; i < 70; i++) R5[i] = (char *(*)()) F1_8;}
	R5[71] = (char *(*)()) F1_8;
	R5[73] = (char *(*)()) F1_8;
	{long i; for (i = 75; i < 78; i++) R5[i] = (char *(*)()) F1_8;}
	R5[80] = (char *(*)()) F1_8;
	{long i; for (i = 82; i < 85; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 86; i < 89; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 90; i < 92; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 94; i < 96; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 97; i < 100; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 101; i < 105; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 106; i < 108; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 109; i < 115; i++) R5[i] = (char *(*)()) F1_8;}
	R5[116] = (char *(*)()) F117_1210;
	R5[126] = (char *(*)()) F1_8;
	R5[138] = (char *(*)()) F1_8;
	R5[156] = (char *(*)()) F157_1934;
	{long i; for (i = 238; i < 242; i++) R5[i] = (char *(*)()) F1_8;}
	R5[447] = (char *(*)()) F1_8;
	R5[545] = (char *(*)()) F546_2668;
	R5[546] = (char *(*)()) F547_2668;
	R5[547] = (char *(*)()) F548_2668;
	R5[548] = (char *(*)()) F549_2668;
	R5[549] = (char *(*)()) F550_2668;
	R5[550] = (char *(*)()) F551_2668;
	R5[551] = (char *(*)()) F552_2668;
	R5[552] = (char *(*)()) F553_2668;
	R5[553] = (char *(*)()) F554_2668;
	R5[554] = (char *(*)()) F555_2668;
	R5[555] = (char *(*)()) F556_2668;
	R5[556] = (char *(*)()) F557_2668;
	R5[557] = (char *(*)()) F558_2668;
	R5[628] = (char *(*)()) F629_2948;
	R5[629] = (char *(*)()) F630_2948;
	R5[630] = (char *(*)()) F631_2948;
	R5[631] = (char *(*)()) F632_2948;
	R5[632] = (char *(*)()) F633_3042;
	R5[633] = (char *(*)()) F634_3042;
	R5[634] = (char *(*)()) F629_2948;
	{long i; for (i = 639; i < 652; i++) R5[i] = (char *(*)()) F1_8;}
	R5[701] = (char *(*)()) F702_3348;
	R5[702] = (char *(*)()) F703_3348;
	R5[703] = (char *(*)()) F704_3348;
	R5[704] = (char *(*)()) F705_3348;
	R5[705] = (char *(*)()) F706_3348;
	R5[706] = (char *(*)()) F707_3348;
	R5[707] = (char *(*)()) F708_3348;
	R5[708] = (char *(*)()) F709_3348;
	R5[709] = (char *(*)()) F710_3348;
	R5[710] = (char *(*)()) F711_3348;
	R5[711] = (char *(*)()) F712_3348;
	R5[712] = (char *(*)()) F713_3348;
	R5[713] = (char *(*)()) F714_3348;
	R5[714] = (char *(*)()) F715_3348;
	R5[715] = (char *(*)()) F716_3348;
	R5[716] = (char *(*)()) F717_3348;
	R5[717] = (char *(*)()) F718_3348;
	R5[718] = (char *(*)()) F719_3348;
	R5[719] = (char *(*)()) F720_3348;
	R5[720] = (char *(*)()) F721_3348;
	R5[721] = (char *(*)()) F722_3348;
	R5[722] = (char *(*)()) F723_3348;
	R5[723] = (char *(*)()) F724_3348;
	R5[724] = (char *(*)()) F725_3348;
	R5[725] = (char *(*)()) F726_3348;
	R5[726] = (char *(*)()) F727_3348;
	R5[727] = (char *(*)()) F728_3348;
	R5[728] = (char *(*)()) F729_3348;
	R5[729] = (char *(*)()) F730_3348;
	R5[730] = (char *(*)()) F731_3348;
	R5[731] = (char *(*)()) F732_3348;
	R5[732] = (char *(*)()) F733_3391;
	{long i; for (i = 734; i < 736; i++) R5[i] = (char *(*)()) F734_3513;}
	{long i; for (i = 737; i < 739; i++) R5[i] = (char *(*)()) F737_3574;}
	{long i; for (i = 740; i < 742; i++) R5[i] = (char *(*)()) F740_3614;}
	{long i; for (i = 743; i < 745; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 746; i < 748; i++) R5[i] = (char *(*)()) F746_3686;}
	{long i; for (i = 749; i < 751; i++) R5[i] = (char *(*)()) F749_3784;}
	{long i; for (i = 752; i < 754; i++) R5[i] = (char *(*)()) F752_3883;}
	{long i; for (i = 755; i < 757; i++) R5[i] = (char *(*)()) F755_3982;}
	{long i; for (i = 758; i < 760; i++) R5[i] = (char *(*)()) F758_4081;}
	{long i; for (i = 761; i < 763; i++) R5[i] = (char *(*)()) F761_4175;}
	{long i; for (i = 764; i < 766; i++) R5[i] = (char *(*)()) F764_4269;}
	{long i; for (i = 767; i < 769; i++) R5[i] = (char *(*)()) F767_4364;}
	{long i; for (i = 770; i < 772; i++) R5[i] = (char *(*)()) F770_4463;}
	{long i; for (i = 773; i < 805; i++) R5[i] = (char *(*)()) F773_4519;}
	{long i; for (i = 814; i < 816; i++) R5[i] = (char *(*)()) F814_4755;}
	{long i; for (i = 817; i < 819; i++) R5[i] = (char *(*)()) F817_4923;}
	R5[819] = (char *(*)()) F1_8;
	{long i; for (i = 821; i < 823; i++) R5[i] = (char *(*)()) F1_8;}
	R5[829] = (char *(*)()) F124_1430;
}


#ifdef __cplusplus
}
#endif
