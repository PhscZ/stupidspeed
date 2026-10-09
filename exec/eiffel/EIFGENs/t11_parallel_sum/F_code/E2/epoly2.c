#include "epoly2.h"
#include "../E1/eoffsets.h"


#ifdef __cplusplus
extern "C" {
#endif

char *(*R704[5])();
void R704_init () {
	R704[0] = (char *(*)()) F46_724;
	R704[1] = (char *(*)()) F47_724_704_1;
	R704[2] = (char *(*)()) F48_724_704_1;
	R704[3] = (char *(*)()) F49_724_704_1;
	R704[4] = (char *(*)()) F50_724_704_1;
}
static EIF_REFERENCE F47_724_704_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F47_724(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F48_724_704_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F48_724(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F49_724_704_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F49_724(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(742, 0x00).id, 742, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F50_724_704_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F50_724(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(718, 0x00).id, 718, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}

char *(*R1064[39])();
void R1064_init () {
	R1064[0] = (char *(*)()) F82_1125;
	R1064[1] = (char *(*)()) F83_1149;
	R1064[4] = (char *(*)()) F86_1151;
	R1064[6] = (char *(*)()) F88_1153;
	R1064[7] = (char *(*)()) F89_1157;
	R1064[8] = (char *(*)()) F90_1163;
	R1064[10] = (char *(*)()) F92_1180;
	R1064[11] = (char *(*)()) F93_1182;
	R1064[12] = (char *(*)()) F94_1184;
	R1064[14] = (char *(*)()) F96_1186;
	R1064[15] = (char *(*)()) F97_1188;
	R1064[18] = (char *(*)()) F100_1192;
	R1064[19] = (char *(*)()) F101_1194;
	R1064[21] = (char *(*)()) F103_1198;
	R1064[22] = (char *(*)()) F104_1204;
	R1064[23] = (char *(*)()) F105_1206;
	R1064[25] = (char *(*)()) F107_1208;
	R1064[26] = (char *(*)()) F108_1210;
	R1064[27] = (char *(*)()) F109_1214;
	R1064[28] = (char *(*)()) F110_1218;
	R1064[30] = (char *(*)()) F112_1220;
	R1064[31] = (char *(*)()) F113_1222;
	R1064[33] = (char *(*)()) F115_1224;
	R1064[34] = (char *(*)()) F116_1226;
	R1064[35] = (char *(*)()) F117_1228;
	R1064[36] = (char *(*)()) F118_1230;
	R1064[37] = (char *(*)()) F119_1234;
	R1064[38] = (char *(*)()) F120_1236;
}

char *(*R1122[97])();
void R1122_init () {
	R1122[0] = (char *(*)()) F706_3625_1122_2;
	R1122[1] = (char *(*)()) F707_3625_1122_2;
	R1122[3] = (char *(*)()) F709_3724_1122_2;
	R1122[4] = (char *(*)()) F710_3724_1122_2;
	R1122[6] = (char *(*)()) F712_3823_1122_2;
	R1122[7] = (char *(*)()) F713_3823_1122_2;
	R1122[9] = (char *(*)()) F715_3922_1122_2;
	R1122[10] = (char *(*)()) F716_3922_1122_2;
	R1122[12] = (char *(*)()) F718_4017_1122_2;
	R1122[13] = (char *(*)()) F719_4017_1122_2;
	R1122[15] = (char *(*)()) F721_4111_1122_2;
	R1122[16] = (char *(*)()) F722_4111_1122_2;
	R1122[18] = (char *(*)()) F724_4206_1122_2;
	R1122[19] = (char *(*)()) F725_4206_1122_2;
	R1122[21] = (char *(*)()) F727_4301_1122_2;
	R1122[22] = (char *(*)()) F728_4301_1122_2;
	R1122[24] = (char *(*)()) F730_4370_1122_2;
	R1122[25] = (char *(*)()) F731_4370_1122_2;
	R1122[27] = (char *(*)()) F733_4436_1122_2;
	R1122[28] = (char *(*)()) F734_4436_1122_2;
	{long i; for (i = 30; i < 32; i++) R1122[i] = (char *(*)()) F735_4467;}
	{long i; for (i = 33; i < 35; i++) R1122[i] = (char *(*)()) F738_4507;}
	{long i; for (i = 80; i < 82; i++) R1122[i] = (char *(*)()) F785_4816;}
	{long i; for (i = 83; i < 85; i++) R1122[i] = (char *(*)()) F788_4981;}
	R1122[96] = (char *(*)()) F802_5380;
}
static EIF_BOOLEAN F706_3625_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F706_3625(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F707_3625_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F707_3625(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F709_3724_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F709_3724(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F710_3724_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F710_3724(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F712_3823_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F712_3823(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F713_3823_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F713_3823(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F715_3922_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F715_3922(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F716_3922_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F716_3922(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F718_4017_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F718_4017(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F719_4017_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F719_4017(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F721_4111_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F721_4111(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F722_4111_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F722_4111(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F724_4206_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F724_4206(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F725_4206_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F725_4206(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F727_4301_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F727_4301(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F728_4301_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F728_4301(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F730_4370_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F730_4370(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F731_4370_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F731_4370(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F733_4436_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F733_4436(Current, *(EIF_REAL_64 *)arg1);
}
static EIF_BOOLEAN F734_4436_1122_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F734_4436(Current, *(EIF_REAL_64 *)arg1);
}

char *(*R1761[629])();
void R1761_init () {
	R1761[0] = (char *(*)()) F155_1939;
	R1761[362] = (char *(*)()) F150_1939;
	R1761[363] = (char *(*)()) F151_1939;
	R1761[364] = (char *(*)()) F152_1939;
	R1761[365] = (char *(*)()) F153_1939;
	R1761[366] = (char *(*)()) F154_1939;
	R1761[367] = (char *(*)()) F155_1939;
	R1761[368] = (char *(*)()) F156_1939;
	R1761[369] = (char *(*)()) F157_1939;
	R1761[370] = (char *(*)()) F158_1939;
	R1761[371] = (char *(*)()) F159_1939;
	R1761[372] = (char *(*)()) F160_1939;
	R1761[373] = (char *(*)()) F161_1939;
	R1761[625] = (char *(*)()) F156_1939;
	R1761[628] = (char *(*)()) F158_1939;
}

char *(*R1762[629])();
void R1762_init () {
	R1762[0] = (char *(*)()) F155_1940_1762_116;
	R1762[362] = (char *(*)()) F150_1940;
	R1762[363] = (char *(*)()) F151_1940_1762_116;
	R1762[364] = (char *(*)()) F152_1940_1762_116;
	R1762[365] = (char *(*)()) F153_1940_1762_116;
	R1762[366] = (char *(*)()) F154_1940_1762_116;
	R1762[367] = (char *(*)()) F155_1940_1762_116;
	R1762[368] = (char *(*)()) F156_1940_1762_116;
	R1762[369] = (char *(*)()) F157_1940_1762_116;
	R1762[370] = (char *(*)()) F158_1940_1762_116;
	R1762[371] = (char *(*)()) F159_1940_1762_116;
	R1762[372] = (char *(*)()) F160_1940_1762_116;
	R1762[373] = (char *(*)()) F161_1940_1762_116;
	R1762[625] = (char *(*)()) F156_1940_1762_116;
	R1762[628] = (char *(*)()) F158_1940_1762_116;
}
static void F155_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F155_1940(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F151_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F151_1940(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F152_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F152_1940(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F153_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F153_1940(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F154_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F154_1940(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F156_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F156_1940(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F157_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F157_1940(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F158_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F158_1940(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F159_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F159_1940(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F160_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F160_1940(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F161_1940_1762_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F161_1940(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R1768[629])();
void R1768_init () {
	R1768[0] = (char *(*)()) F155_1946;
	R1768[362] = (char *(*)()) F150_1946;
	R1768[363] = (char *(*)()) F151_1946;
	R1768[364] = (char *(*)()) F152_1946;
	R1768[365] = (char *(*)()) F153_1946;
	R1768[366] = (char *(*)()) F154_1946;
	R1768[367] = (char *(*)()) F155_1946;
	R1768[368] = (char *(*)()) F156_1946;
	R1768[369] = (char *(*)()) F157_1946;
	R1768[370] = (char *(*)()) F158_1946;
	R1768[371] = (char *(*)()) F159_1946;
	R1768[372] = (char *(*)()) F160_1946;
	R1768[373] = (char *(*)()) F161_1946;
	R1768[625] = (char *(*)()) F156_1946;
	R1768[628] = (char *(*)()) F158_1946;
}

char *(*R1828[4])();
void R1828_init () {
	R1828[0] = (char *(*)()) F239_2134;
	R1828[1] = (char *(*)()) F240_2134;
	R1828[2] = (char *(*)()) F241_2134_1828_1;
	R1828[3] = (char *(*)()) F242_2134_1828_1;
}
static EIF_REFERENCE F241_2134_1828_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F241_2134(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F242_2134_1828_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F242_2134(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1829[195])();
void R1829_init () {
	R1829[0] = (char *(*)()) F239_2137;
	R1829[1] = (char *(*)()) F240_2137;
	R1829[2] = (char *(*)()) F241_2137;
	R1829[3] = (char *(*)()) F242_2137;
	R1829[194] = (char *(*)()) F432_2263;
}

char *(*R1830[195])();
void R1830_init () {
	R1830[0] = (char *(*)()) F239_2138;
	R1830[1] = (char *(*)()) F240_2138;
	R1830[2] = (char *(*)()) F241_2138;
	R1830[3] = (char *(*)()) F242_2138;
	R1830[194] = (char *(*)()) F432_2269;
}

char *(*R1841[4])();
void R1841_init () {
	R1841[0] = (char *(*)()) F239_2135;
	R1841[1] = (char *(*)()) F240_2135_1841_1;
	R1841[2] = (char *(*)()) F241_2135;
	R1841[3] = (char *(*)()) F242_2135_1841_1;
}
static EIF_REFERENCE F240_2135_1841_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F240_2135(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F242_2135_1841_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F242_2135(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1843[7])();
void R1843_init () {
	R1843[0] = (char *(*)()) F601_2995;
	R1843[1] = (char *(*)()) F602_2995;
	R1843[2] = (char *(*)()) F603_2995;
	R1843[3] = (char *(*)()) F604_2995;
	R1843[4] = (char *(*)()) F601_2995;
	R1843[5] = (char *(*)()) F603_2995;
	R1843[6] = (char *(*)()) F601_2995;
}

static EIF_TYPE_INDEX Y1844_pgtype0[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype1[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype2[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype3[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype4[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype5[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype6[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype7[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype8[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype9[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype10[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype11[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype12[] = {0xFF01,786,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype13[] = {0xFF01,788,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype14[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype15[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype16[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype17[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype18[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype19[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype20[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype21[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype22[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype23[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype24[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype25[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype26[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype27[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype28[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype29[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype30[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype31[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype32[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype33[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype34[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype35[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype36[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype37[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype38[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype39[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype40[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype41[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype42[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype43[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype44[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype45[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype46[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype47[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype48[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype49[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype50[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype51[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype52[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype53[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype54[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype55[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype56[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype57[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype58[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype59[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype60[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype61[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype62[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype63[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype64[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype65[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype66[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype67[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype68[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype69[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype70[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype71[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype72[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype73[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype74[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype75[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype76[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype77[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype78[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype79[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype80[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype81[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype82[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype83[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype84[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype85[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype86[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype87[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype88[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype89[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype90[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype91[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype92[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype93[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype94[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype95[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype96[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype97[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype98[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype99[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype100[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype101[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype102[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype103[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype104[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype105[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype106[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype107[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype108[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype109[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype110[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype111[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype112[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype113[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype114[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype115[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype116[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype117[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype118[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype119[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype120[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype121[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype122[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype123[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype124[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype125[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype126[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype127[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype128[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype129[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype130[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype131[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype132[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype133[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype134[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype135[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype136[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype137[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype138[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype139[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype140[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype141[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype142[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype143[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype144[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype145[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype146[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype147[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype148[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype149[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype150[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype151[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype152[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype153[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype154[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype155[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype156[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype157[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype158[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype159[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype160[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype161[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype162[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype163[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype164[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype165[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype166[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype167[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype168[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype169[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype170[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype171[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype172[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype173[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype174[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype175[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype176[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype177[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype178[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype179[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype180[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype181[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype182[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype183[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype184[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype185[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype186[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype187[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype188[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype189[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype190[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype191[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype192[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype193[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype194[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype195[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype196[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype197[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype198[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype199[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype200[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype201[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype202[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype203[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype204[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype205[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype206[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype207[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype208[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype209[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype210[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype211[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype212[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype213[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype214[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype215[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype216[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype217[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype218[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype219[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype220[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype221[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype222[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype223[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype224[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype225[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype226[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype227[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype228[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype229[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype230[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype231[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype232[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype233[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype234[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype235[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype236[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype237[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype238[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype239[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype240[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype241[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype242[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype243[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype244[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype245[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype246[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype247[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype248[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype249[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype250[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype251[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype252[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype253[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype254[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype255[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype256[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype257[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype258[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype259[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype260[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype261[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype262[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype263[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype264[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype265[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype266[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype267[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype268[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype269[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype270[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype271[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype272[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype273[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype274[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype275[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype276[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype277[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype278[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype279[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype280[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype281[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype282[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype283[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype284[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype285[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype286[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype287[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype288[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype289[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype290[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype291[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype292[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype293[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype294[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype295[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype296[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype297[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype298[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype299[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype300[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype301[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype302[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype303[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype304[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype305[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype306[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype307[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype308[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype309[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype310[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype311[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype312[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype313[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype314[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype315[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype316[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype317[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype318[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype319[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype320[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype321[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype322[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype323[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype324[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype325[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype326[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype327[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype328[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype329[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype330[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype331[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype332[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype333[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype334[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype335[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype336[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype337[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype338[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype339[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype340[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype341[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype342[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype343[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype344[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype345[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype346[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype347[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype348[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype349[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype350[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype351[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype352[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype353[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype354[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype355[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype356[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype357[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype358[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype359[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype360[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype361[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype362[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype363[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype364[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype365[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype366[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype367[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype368[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype369[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype370[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype371[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype372[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype373[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype374[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype375[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype376[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype377[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype378[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype379[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype380[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype381[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype382[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype383[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype384[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype385[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype386[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype387[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype388[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype389[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype390[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype391[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype392[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype393[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype394[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype395[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype396[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype397[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype398[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype399[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype400[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype401[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype402[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype403[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype404[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype405[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype406[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype407[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype408[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype409[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype410[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype411[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype412[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype413[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype414[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype415[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype416[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype417[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype418[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype419[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype420[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype421[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype422[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype423[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype424[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype425[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype426[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype427[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype428[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype429[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype430[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype431[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype432[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype433[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype434[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype435[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype436[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype437[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype438[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype439[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype440[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype441[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype442[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1844_pgtype443[] = {739,0xFFFF};
EIF_TYPE_INDEX *Y1844_gen_type [611];
EIF_TYPE_INDEX Y1844 [611];
void Y1844_init (void)
{
	egc_routines_types [1844] = Y1844;
	egc_routines_gen_types [1844] = Y1844_gen_type;
	egc_routines_offset [1844] = 181;
	Y1844_gen_type [0] = Y1844_pgtype0;
	Y1844_gen_type [1] = Y1844_pgtype1;
	Y1844_gen_type [2] = Y1844_pgtype2;
	Y1844_gen_type [3] = Y1844_pgtype3;
	Y1844_gen_type [4] = Y1844_pgtype4;
	Y1844_gen_type [5] = Y1844_pgtype5;
	Y1844_gen_type [6] = Y1844_pgtype6;
	Y1844_gen_type [7] = Y1844_pgtype7;
	Y1844_gen_type [8] = Y1844_pgtype8;
	Y1844_gen_type [9] = Y1844_pgtype9;
	Y1844_gen_type [10] = Y1844_pgtype10;
	Y1844_gen_type [11] = Y1844_pgtype11;
	Y1844_gen_type [12] = Y1844_pgtype12;
	Y1844_gen_type [13] = Y1844_pgtype13;
	Y1844_gen_type [14] = Y1844_pgtype14;
	Y1844_gen_type [15] = Y1844_pgtype15;
	Y1844_gen_type [16] = Y1844_pgtype16;
	Y1844_gen_type [17] = Y1844_pgtype17;
	Y1844_gen_type [18] = Y1844_pgtype18;
	Y1844_gen_type [19] = Y1844_pgtype19;
	Y1844_gen_type [20] = Y1844_pgtype20;
	Y1844_gen_type [21] = Y1844_pgtype21;
	Y1844_gen_type [22] = Y1844_pgtype22;
	Y1844_gen_type [23] = Y1844_pgtype23;
	Y1844_gen_type [24] = Y1844_pgtype24;
	Y1844_gen_type [25] = Y1844_pgtype25;
	Y1844_gen_type [26] = Y1844_pgtype26;
	Y1844_gen_type [27] = Y1844_pgtype27;
	Y1844_gen_type [28] = Y1844_pgtype28;
	Y1844_gen_type [29] = Y1844_pgtype29;
	Y1844_gen_type [30] = Y1844_pgtype30;
	Y1844_gen_type [31] = Y1844_pgtype31;
	Y1844_gen_type [32] = Y1844_pgtype32;
	Y1844_gen_type [33] = Y1844_pgtype33;
	Y1844_gen_type [34] = Y1844_pgtype34;
	Y1844_gen_type [35] = Y1844_pgtype35;
	Y1844_gen_type [36] = Y1844_pgtype36;
	Y1844_gen_type [37] = Y1844_pgtype37;
	Y1844_gen_type [38] = Y1844_pgtype38;
	Y1844_gen_type [39] = Y1844_pgtype39;
	Y1844_gen_type [40] = Y1844_pgtype40;
	Y1844_gen_type [41] = Y1844_pgtype41;
	Y1844_gen_type [42] = Y1844_pgtype42;
	Y1844_gen_type [43] = Y1844_pgtype43;
	Y1844_gen_type [44] = Y1844_pgtype44;
	Y1844_gen_type [45] = Y1844_pgtype45;
	Y1844_gen_type [46] = Y1844_pgtype46;
	Y1844_gen_type [47] = Y1844_pgtype47;
	Y1844_gen_type [48] = Y1844_pgtype48;
	Y1844_gen_type [49] = Y1844_pgtype49;
	Y1844_gen_type [50] = Y1844_pgtype50;
	Y1844_gen_type [51] = Y1844_pgtype51;
	Y1844_gen_type [52] = Y1844_pgtype52;
	Y1844_gen_type [53] = Y1844_pgtype53;
	Y1844_gen_type [54] = Y1844_pgtype54;
	Y1844_gen_type [55] = Y1844_pgtype55;
	Y1844_gen_type [56] = Y1844_pgtype56;
	Y1844_gen_type [57] = Y1844_pgtype57;
	Y1844_gen_type [58] = Y1844_pgtype58;
	Y1844_gen_type [59] = Y1844_pgtype59;
	Y1844_gen_type [60] = Y1844_pgtype60;
	Y1844_gen_type [61] = Y1844_pgtype61;
	Y1844_gen_type [62] = Y1844_pgtype62;
	Y1844_gen_type [63] = Y1844_pgtype63;
	Y1844_gen_type [64] = Y1844_pgtype64;
	Y1844_gen_type [65] = Y1844_pgtype65;
	Y1844_gen_type [66] = Y1844_pgtype66;
	Y1844_gen_type [67] = Y1844_pgtype67;
	Y1844_gen_type [68] = Y1844_pgtype68;
	Y1844_gen_type [69] = Y1844_pgtype69;
	Y1844_gen_type [70] = Y1844_pgtype70;
	Y1844_gen_type [71] = Y1844_pgtype71;
	Y1844_gen_type [72] = Y1844_pgtype72;
	Y1844_gen_type [73] = Y1844_pgtype73;
	Y1844_gen_type [74] = Y1844_pgtype74;
	Y1844_gen_type [75] = Y1844_pgtype75;
	Y1844_gen_type [76] = Y1844_pgtype76;
	Y1844_gen_type [77] = Y1844_pgtype77;
	Y1844_gen_type [78] = Y1844_pgtype78;
	Y1844_gen_type [79] = Y1844_pgtype79;
	Y1844_gen_type [80] = Y1844_pgtype80;
	Y1844_gen_type [81] = Y1844_pgtype81;
	Y1844_gen_type [82] = Y1844_pgtype82;
	Y1844_gen_type [83] = Y1844_pgtype83;
	Y1844_gen_type [84] = Y1844_pgtype84;
	Y1844_gen_type [85] = Y1844_pgtype85;
	Y1844_gen_type [86] = Y1844_pgtype86;
	Y1844_gen_type [87] = Y1844_pgtype87;
	Y1844_gen_type [88] = Y1844_pgtype88;
	Y1844_gen_type [89] = Y1844_pgtype89;
	Y1844_gen_type [90] = Y1844_pgtype90;
	Y1844_gen_type [91] = Y1844_pgtype91;
	Y1844_gen_type [92] = Y1844_pgtype92;
	Y1844_gen_type [93] = Y1844_pgtype93;
	Y1844_gen_type [94] = Y1844_pgtype94;
	Y1844_gen_type [95] = Y1844_pgtype95;
	Y1844_gen_type [96] = Y1844_pgtype96;
	Y1844_gen_type [97] = Y1844_pgtype97;
	Y1844_gen_type [98] = Y1844_pgtype98;
	Y1844_gen_type [99] = Y1844_pgtype99;
	Y1844_gen_type [100] = Y1844_pgtype100;
	Y1844_gen_type [101] = Y1844_pgtype101;
	Y1844_gen_type [102] = Y1844_pgtype102;
	Y1844_gen_type [103] = Y1844_pgtype103;
	Y1844_gen_type [104] = Y1844_pgtype104;
	Y1844_gen_type [105] = Y1844_pgtype105;
	Y1844_gen_type [106] = Y1844_pgtype106;
	Y1844_gen_type [107] = Y1844_pgtype107;
	Y1844_gen_type [108] = Y1844_pgtype108;
	Y1844_gen_type [109] = Y1844_pgtype109;
	Y1844_gen_type [110] = Y1844_pgtype110;
	Y1844_gen_type [111] = Y1844_pgtype111;
	Y1844_gen_type [112] = Y1844_pgtype112;
	Y1844_gen_type [113] = Y1844_pgtype113;
	Y1844_gen_type [114] = Y1844_pgtype114;
	Y1844_gen_type [115] = Y1844_pgtype115;
	Y1844_gen_type [116] = Y1844_pgtype116;
	Y1844_gen_type [117] = Y1844_pgtype117;
	Y1844_gen_type [118] = Y1844_pgtype118;
	Y1844_gen_type [119] = Y1844_pgtype119;
	Y1844_gen_type [120] = Y1844_pgtype120;
	Y1844_gen_type [121] = Y1844_pgtype121;
	Y1844_gen_type [122] = Y1844_pgtype122;
	Y1844_gen_type [123] = Y1844_pgtype123;
	Y1844_gen_type [124] = Y1844_pgtype124;
	Y1844_gen_type [125] = Y1844_pgtype125;
	Y1844_gen_type [126] = Y1844_pgtype126;
	Y1844_gen_type [127] = Y1844_pgtype127;
	Y1844_gen_type [128] = Y1844_pgtype128;
	Y1844_gen_type [129] = Y1844_pgtype129;
	Y1844_gen_type [130] = Y1844_pgtype130;
	Y1844_gen_type [131] = Y1844_pgtype131;
	Y1844_gen_type [132] = Y1844_pgtype132;
	Y1844_gen_type [133] = Y1844_pgtype133;
	Y1844_gen_type [134] = Y1844_pgtype134;
	Y1844_gen_type [135] = Y1844_pgtype135;
	Y1844_gen_type [136] = Y1844_pgtype136;
	Y1844_gen_type [137] = Y1844_pgtype137;
	Y1844_gen_type [138] = Y1844_pgtype138;
	Y1844_gen_type [139] = Y1844_pgtype139;
	Y1844_gen_type [140] = Y1844_pgtype140;
	Y1844_gen_type [141] = Y1844_pgtype141;
	Y1844_gen_type [142] = Y1844_pgtype142;
	Y1844_gen_type [143] = Y1844_pgtype143;
	Y1844_gen_type [144] = Y1844_pgtype144;
	Y1844_gen_type [145] = Y1844_pgtype145;
	Y1844_gen_type [146] = Y1844_pgtype146;
	Y1844_gen_type [147] = Y1844_pgtype147;
	Y1844_gen_type [148] = Y1844_pgtype148;
	Y1844_gen_type [149] = Y1844_pgtype149;
	Y1844_gen_type [150] = Y1844_pgtype150;
	Y1844_gen_type [151] = Y1844_pgtype151;
	Y1844_gen_type [152] = Y1844_pgtype152;
	Y1844_gen_type [153] = Y1844_pgtype153;
	Y1844_gen_type [154] = Y1844_pgtype154;
	Y1844_gen_type [155] = Y1844_pgtype155;
	Y1844_gen_type [156] = Y1844_pgtype156;
	Y1844_gen_type [157] = Y1844_pgtype157;
	Y1844_gen_type [158] = Y1844_pgtype158;
	Y1844_gen_type [159] = Y1844_pgtype159;
	Y1844_gen_type [160] = Y1844_pgtype160;
	Y1844_gen_type [161] = Y1844_pgtype161;
	Y1844_gen_type [162] = Y1844_pgtype162;
	Y1844_gen_type [163] = Y1844_pgtype163;
	Y1844_gen_type [164] = Y1844_pgtype164;
	Y1844_gen_type [165] = Y1844_pgtype165;
	Y1844_gen_type [166] = Y1844_pgtype166;
	Y1844_gen_type [167] = Y1844_pgtype167;
	Y1844_gen_type [168] = Y1844_pgtype168;
	Y1844_gen_type [169] = Y1844_pgtype169;
	Y1844_gen_type [170] = Y1844_pgtype170;
	Y1844_gen_type [171] = Y1844_pgtype171;
	Y1844_gen_type [172] = Y1844_pgtype172;
	Y1844_gen_type [173] = Y1844_pgtype173;
	Y1844_gen_type [174] = Y1844_pgtype174;
	Y1844_gen_type [175] = Y1844_pgtype175;
	Y1844_gen_type [176] = Y1844_pgtype176;
	Y1844_gen_type [177] = Y1844_pgtype177;
	Y1844_gen_type [178] = Y1844_pgtype178;
	Y1844_gen_type [179] = Y1844_pgtype179;
	Y1844_gen_type [180] = Y1844_pgtype180;
	Y1844_gen_type [181] = Y1844_pgtype181;
	Y1844_gen_type [182] = Y1844_pgtype182;
	Y1844_gen_type [183] = Y1844_pgtype183;
	Y1844_gen_type [184] = Y1844_pgtype184;
	Y1844_gen_type [185] = Y1844_pgtype185;
	Y1844_gen_type [186] = Y1844_pgtype186;
	Y1844_gen_type [187] = Y1844_pgtype187;
	Y1844_gen_type [188] = Y1844_pgtype188;
	Y1844_gen_type [189] = Y1844_pgtype189;
	Y1844_gen_type [190] = Y1844_pgtype190;
	Y1844_gen_type [191] = Y1844_pgtype191;
	Y1844_gen_type [192] = Y1844_pgtype192;
	Y1844_gen_type [193] = Y1844_pgtype193;
	Y1844_gen_type [194] = Y1844_pgtype194;
	Y1844_gen_type [195] = Y1844_pgtype195;
	Y1844_gen_type [196] = Y1844_pgtype196;
	Y1844_gen_type [197] = Y1844_pgtype197;
	Y1844_gen_type [198] = Y1844_pgtype198;
	Y1844_gen_type [199] = Y1844_pgtype199;
	Y1844_gen_type [200] = Y1844_pgtype200;
	Y1844_gen_type [201] = Y1844_pgtype201;
	Y1844_gen_type [202] = Y1844_pgtype202;
	Y1844_gen_type [203] = Y1844_pgtype203;
	Y1844_gen_type [204] = Y1844_pgtype204;
	Y1844_gen_type [205] = Y1844_pgtype205;
	Y1844_gen_type [206] = Y1844_pgtype206;
	Y1844_gen_type [207] = Y1844_pgtype207;
	Y1844_gen_type [208] = Y1844_pgtype208;
	Y1844_gen_type [209] = Y1844_pgtype209;
	Y1844_gen_type [210] = Y1844_pgtype210;
	Y1844_gen_type [211] = Y1844_pgtype211;
	Y1844_gen_type [212] = Y1844_pgtype212;
	Y1844_gen_type [213] = Y1844_pgtype213;
	Y1844_gen_type [214] = Y1844_pgtype214;
	Y1844_gen_type [215] = Y1844_pgtype215;
	Y1844_gen_type [216] = Y1844_pgtype216;
	Y1844_gen_type [217] = Y1844_pgtype217;
	Y1844_gen_type [218] = Y1844_pgtype218;
	Y1844_gen_type [219] = Y1844_pgtype219;
	Y1844_gen_type [220] = Y1844_pgtype220;
	Y1844_gen_type [221] = Y1844_pgtype221;
	Y1844_gen_type [222] = Y1844_pgtype222;
	Y1844_gen_type [223] = Y1844_pgtype223;
	Y1844_gen_type [224] = Y1844_pgtype224;
	Y1844_gen_type [225] = Y1844_pgtype225;
	Y1844_gen_type [226] = Y1844_pgtype226;
	Y1844_gen_type [227] = Y1844_pgtype227;
	Y1844_gen_type [228] = Y1844_pgtype228;
	Y1844_gen_type [229] = Y1844_pgtype229;
	Y1844_gen_type [230] = Y1844_pgtype230;
	Y1844_gen_type [231] = Y1844_pgtype231;
	Y1844_gen_type [232] = Y1844_pgtype232;
	Y1844_gen_type [233] = Y1844_pgtype233;
	Y1844_gen_type [234] = Y1844_pgtype234;
	Y1844_gen_type [235] = Y1844_pgtype235;
	Y1844_gen_type [236] = Y1844_pgtype236;
	Y1844_gen_type [237] = Y1844_pgtype237;
	Y1844_gen_type [238] = Y1844_pgtype238;
	Y1844_gen_type [239] = Y1844_pgtype239;
	Y1844_gen_type [240] = Y1844_pgtype240;
	Y1844_gen_type [241] = Y1844_pgtype241;
	Y1844_gen_type [242] = Y1844_pgtype242;
	Y1844_gen_type [243] = Y1844_pgtype243;
	Y1844_gen_type [244] = Y1844_pgtype244;
	Y1844_gen_type [245] = Y1844_pgtype245;
	Y1844_gen_type [246] = Y1844_pgtype246;
	Y1844_gen_type [247] = Y1844_pgtype247;
	Y1844_gen_type [248] = Y1844_pgtype248;
	Y1844_gen_type [249] = Y1844_pgtype249;
	Y1844_gen_type [250] = Y1844_pgtype250;
	Y1844_gen_type [251] = Y1844_pgtype251;
	Y1844_gen_type [252] = Y1844_pgtype252;
	Y1844_gen_type [253] = Y1844_pgtype253;
	Y1844_gen_type [254] = Y1844_pgtype254;
	Y1844_gen_type [255] = Y1844_pgtype255;
	Y1844_gen_type [256] = Y1844_pgtype256;
	Y1844_gen_type [257] = Y1844_pgtype257;
	Y1844_gen_type [258] = Y1844_pgtype258;
	Y1844_gen_type [259] = Y1844_pgtype259;
	Y1844_gen_type [260] = Y1844_pgtype260;
	Y1844_gen_type [261] = Y1844_pgtype261;
	Y1844_gen_type [262] = Y1844_pgtype262;
	Y1844_gen_type [263] = Y1844_pgtype263;
	Y1844_gen_type [264] = Y1844_pgtype264;
	Y1844_gen_type [265] = Y1844_pgtype265;
	Y1844_gen_type [266] = Y1844_pgtype266;
	Y1844_gen_type [267] = Y1844_pgtype267;
	Y1844_gen_type [268] = Y1844_pgtype268;
	Y1844_gen_type [269] = Y1844_pgtype269;
	Y1844_gen_type [270] = Y1844_pgtype270;
	Y1844_gen_type [271] = Y1844_pgtype271;
	Y1844_gen_type [272] = Y1844_pgtype272;
	Y1844_gen_type [273] = Y1844_pgtype273;
	Y1844_gen_type [274] = Y1844_pgtype274;
	Y1844_gen_type [275] = Y1844_pgtype275;
	Y1844_gen_type [276] = Y1844_pgtype276;
	Y1844_gen_type [277] = Y1844_pgtype277;
	Y1844_gen_type [278] = Y1844_pgtype278;
	Y1844_gen_type [279] = Y1844_pgtype279;
	Y1844_gen_type [280] = Y1844_pgtype280;
	Y1844_gen_type [281] = Y1844_pgtype281;
	Y1844_gen_type [282] = Y1844_pgtype282;
	Y1844_gen_type [283] = Y1844_pgtype283;
	Y1844_gen_type [284] = Y1844_pgtype284;
	Y1844_gen_type [285] = Y1844_pgtype285;
	Y1844_gen_type [286] = Y1844_pgtype286;
	Y1844_gen_type [287] = Y1844_pgtype287;
	Y1844_gen_type [288] = Y1844_pgtype288;
	Y1844_gen_type [289] = Y1844_pgtype289;
	Y1844_gen_type [290] = Y1844_pgtype290;
	Y1844_gen_type [291] = Y1844_pgtype291;
	Y1844_gen_type [292] = Y1844_pgtype292;
	Y1844_gen_type [293] = Y1844_pgtype293;
	Y1844_gen_type [294] = Y1844_pgtype294;
	Y1844_gen_type [295] = Y1844_pgtype295;
	Y1844_gen_type [296] = Y1844_pgtype296;
	Y1844_gen_type [297] = Y1844_pgtype297;
	Y1844_gen_type [298] = Y1844_pgtype298;
	Y1844_gen_type [299] = Y1844_pgtype299;
	Y1844_gen_type [300] = Y1844_pgtype300;
	Y1844_gen_type [301] = Y1844_pgtype301;
	Y1844_gen_type [302] = Y1844_pgtype302;
	Y1844_gen_type [303] = Y1844_pgtype303;
	Y1844_gen_type [304] = Y1844_pgtype304;
	Y1844_gen_type [305] = Y1844_pgtype305;
	Y1844_gen_type [306] = Y1844_pgtype306;
	Y1844_gen_type [307] = Y1844_pgtype307;
	Y1844_gen_type [308] = Y1844_pgtype308;
	Y1844_gen_type [309] = Y1844_pgtype309;
	Y1844_gen_type [310] = Y1844_pgtype310;
	Y1844_gen_type [311] = Y1844_pgtype311;
	Y1844_gen_type [312] = Y1844_pgtype312;
	Y1844_gen_type [313] = Y1844_pgtype313;
	Y1844_gen_type [314] = Y1844_pgtype314;
	Y1844_gen_type [315] = Y1844_pgtype315;
	Y1844_gen_type [316] = Y1844_pgtype316;
	Y1844_gen_type [317] = Y1844_pgtype317;
	Y1844_gen_type [318] = Y1844_pgtype318;
	Y1844_gen_type [319] = Y1844_pgtype319;
	Y1844_gen_type [320] = Y1844_pgtype320;
	Y1844_gen_type [321] = Y1844_pgtype321;
	Y1844_gen_type [322] = Y1844_pgtype322;
	Y1844_gen_type [323] = Y1844_pgtype323;
	Y1844_gen_type [324] = Y1844_pgtype324;
	Y1844_gen_type [325] = Y1844_pgtype325;
	Y1844_gen_type [326] = Y1844_pgtype326;
	Y1844_gen_type [327] = Y1844_pgtype327;
	Y1844_gen_type [328] = Y1844_pgtype328;
	Y1844_gen_type [329] = Y1844_pgtype329;
	Y1844_gen_type [330] = Y1844_pgtype330;
	Y1844_gen_type [331] = Y1844_pgtype331;
	Y1844_gen_type [332] = Y1844_pgtype332;
	Y1844_gen_type [333] = Y1844_pgtype333;
	Y1844_gen_type [334] = Y1844_pgtype334;
	Y1844_gen_type [335] = Y1844_pgtype335;
	Y1844_gen_type [336] = Y1844_pgtype336;
	Y1844_gen_type [337] = Y1844_pgtype337;
	Y1844_gen_type [338] = Y1844_pgtype338;
	Y1844_gen_type [339] = Y1844_pgtype339;
	Y1844_gen_type [340] = Y1844_pgtype340;
	Y1844_gen_type [341] = Y1844_pgtype341;
	Y1844_gen_type [342] = Y1844_pgtype342;
	Y1844_gen_type [343] = Y1844_pgtype343;
	Y1844_gen_type [344] = Y1844_pgtype344;
	Y1844_gen_type [345] = Y1844_pgtype345;
	Y1844_gen_type [346] = Y1844_pgtype346;
	Y1844_gen_type [347] = Y1844_pgtype347;
	Y1844_gen_type [348] = Y1844_pgtype348;
	Y1844_gen_type [349] = Y1844_pgtype349;
	Y1844_gen_type [350] = Y1844_pgtype350;
	Y1844_gen_type [351] = Y1844_pgtype351;
	Y1844_gen_type [352] = Y1844_pgtype352;
	Y1844_gen_type [353] = Y1844_pgtype353;
	Y1844_gen_type [354] = Y1844_pgtype354;
	Y1844_gen_type [355] = Y1844_pgtype355;
	Y1844_gen_type [356] = Y1844_pgtype356;
	Y1844_gen_type [357] = Y1844_pgtype357;
	Y1844_gen_type [358] = Y1844_pgtype358;
	Y1844_gen_type [359] = Y1844_pgtype359;
	Y1844_gen_type [360] = Y1844_pgtype360;
	Y1844_gen_type [361] = Y1844_pgtype361;
	Y1844_gen_type [362] = Y1844_pgtype362;
	Y1844_gen_type [363] = Y1844_pgtype363;
	Y1844_gen_type [364] = Y1844_pgtype364;
	Y1844_gen_type [365] = Y1844_pgtype365;
	Y1844_gen_type [366] = Y1844_pgtype366;
	Y1844_gen_type [367] = Y1844_pgtype367;
	Y1844_gen_type [368] = Y1844_pgtype368;
	Y1844_gen_type [369] = Y1844_pgtype369;
	Y1844_gen_type [370] = Y1844_pgtype370;
	Y1844_gen_type [371] = Y1844_pgtype371;
	Y1844_gen_type [372] = Y1844_pgtype372;
	Y1844_gen_type [373] = Y1844_pgtype373;
	Y1844_gen_type [374] = Y1844_pgtype374;
	Y1844_gen_type [375] = Y1844_pgtype375;
	Y1844_gen_type [376] = Y1844_pgtype376;
	Y1844_gen_type [377] = Y1844_pgtype377;
	Y1844_gen_type [378] = Y1844_pgtype378;
	Y1844_gen_type [379] = Y1844_pgtype379;
	Y1844_gen_type [380] = Y1844_pgtype380;
	Y1844_gen_type [381] = Y1844_pgtype381;
	Y1844_gen_type [382] = Y1844_pgtype382;
	Y1844_gen_type [383] = Y1844_pgtype383;
	Y1844_gen_type [384] = Y1844_pgtype384;
	Y1844_gen_type [385] = Y1844_pgtype385;
	Y1844_gen_type [386] = Y1844_pgtype386;
	Y1844_gen_type [387] = Y1844_pgtype387;
	Y1844_gen_type [388] = Y1844_pgtype388;
	Y1844_gen_type [389] = Y1844_pgtype389;
	Y1844_gen_type [390] = Y1844_pgtype390;
	Y1844_gen_type [391] = Y1844_pgtype391;
	Y1844_gen_type [392] = Y1844_pgtype392;
	Y1844_gen_type [393] = Y1844_pgtype393;
	Y1844_gen_type [394] = Y1844_pgtype394;
	Y1844_gen_type [395] = Y1844_pgtype395;
	Y1844_gen_type [396] = Y1844_pgtype396;
	Y1844_gen_type [397] = Y1844_pgtype397;
	Y1844_gen_type [398] = Y1844_pgtype398;
	Y1844_gen_type [399] = Y1844_pgtype399;
	Y1844_gen_type [400] = Y1844_pgtype400;
	Y1844_gen_type [401] = Y1844_pgtype401;
	Y1844_gen_type [402] = Y1844_pgtype402;
	Y1844_gen_type [403] = Y1844_pgtype403;
	Y1844_gen_type [405] = Y1844_pgtype404;
	Y1844_gen_type [406] = Y1844_pgtype405;
	Y1844_gen_type [407] = Y1844_pgtype406;
	Y1844_gen_type [408] = Y1844_pgtype407;
	Y1844_gen_type [409] = Y1844_pgtype408;
	Y1844_gen_type [410] = Y1844_pgtype409;
	Y1844_gen_type [411] = Y1844_pgtype410;
	Y1844_gen_type [412] = Y1844_pgtype411;
	Y1844_gen_type [413] = Y1844_pgtype412;
	Y1844_gen_type [414] = Y1844_pgtype413;
	Y1844_gen_type [415] = Y1844_pgtype414;
	Y1844_gen_type [416] = Y1844_pgtype415;
	Y1844_gen_type [417] = Y1844_pgtype416;
	Y1844_gen_type [419] = Y1844_pgtype417;
	Y1844_gen_type [420] = Y1844_pgtype418;
	Y1844_gen_type [421] = Y1844_pgtype419;
	Y1844_gen_type [422] = Y1844_pgtype420;
	Y1844_gen_type [423] = Y1844_pgtype421;
	Y1844_gen_type [424] = Y1844_pgtype422;
	Y1844_gen_type [425] = Y1844_pgtype423;
	Y1844_gen_type [430] = Y1844_pgtype424;
	Y1844_gen_type [431] = Y1844_pgtype425;
	Y1844_gen_type [432] = Y1844_pgtype426;
	Y1844_gen_type [433] = Y1844_pgtype427;
	Y1844_gen_type [434] = Y1844_pgtype428;
	Y1844_gen_type [435] = Y1844_pgtype429;
	Y1844_gen_type [436] = Y1844_pgtype430;
	Y1844_gen_type [437] = Y1844_pgtype431;
	Y1844_gen_type [438] = Y1844_pgtype432;
	Y1844_gen_type [439] = Y1844_pgtype433;
	Y1844_gen_type [440] = Y1844_pgtype434;
	Y1844_gen_type [441] = Y1844_pgtype435;
	Y1844_gen_type [522] = Y1844_pgtype436;
	Y1844_gen_type [603] = Y1844_pgtype437;
	Y1844_gen_type [604] = Y1844_pgtype438;
	Y1844_gen_type [605] = Y1844_pgtype439;
	Y1844_gen_type [606] = Y1844_pgtype440;
	Y1844_gen_type [607] = Y1844_pgtype441;
	Y1844_gen_type [608] = Y1844_pgtype442;
	Y1844_gen_type [610] = Y1844_pgtype443;
	Y1844[12] = 786;
	Y1844[13] = 788;
	Y1844[14] = 736;
	Y1844[85] = 739;
	Y1844[86] = 736;
	Y1844[251] = 709;
	{long i; for (i = 314; i < 317; i++) Y1844[i] = 739;};
	Y1844[341] = 709;
	Y1844[425] = 0;
	Y1844[522] = 0;
	{long i; for (i = 603; i < 606; i++) Y1844[i] = 739;};
	{long i; for (i = 606; i < 609; i++) Y1844[i] = 736;};
	Y1844[610] = 739;
}

char *(*R1906[4])();
void R1906_init () {
	{long i; for (i = 0; i < 2; i++) R1906[i] = (char *(*)()) F225_2120;}
	{long i; for (i = 2; i < 4; i++) R1906[i] = (char *(*)()) F233_2120;}
}

char *(*R1909[4])();
void R1909_init () {
	{long i; for (i = 0; i < 2; i++) R1909[i] = (char *(*)()) F225_2125;}
	{long i; for (i = 2; i < 4; i++) R1909[i] = (char *(*)()) F233_2125;}
}

char *(*R1912[4])();
void R1912_init () {
	{long i; for (i = 0; i < 2; i++) R1912[i] = (char *(*)()) F225_2107;}
	{long i; for (i = 2; i < 4; i++) R1912[i] = (char *(*)()) F233_2107;}
}

char *(*R1943[360])();
void R1943_init () {
	R1943[0] = (char *(*)()) F301_2193;
	R1943[91] = (char *(*)()) F293_2193;
	R1943[92] = (char *(*)()) F294_2193;
	R1943[93] = (char *(*)()) F297_2193;
	R1943[94] = (char *(*)()) F298_2193;
	R1943[95] = (char *(*)()) F299_2193;
	R1943[96] = (char *(*)()) F300_2193;
	R1943[97] = (char *(*)()) F296_2193;
	R1943[98] = (char *(*)()) F301_2193;
	R1943[99] = (char *(*)()) F295_2193;
	R1943[100] = (char *(*)()) F302_2193;
	R1943[101] = (char *(*)()) F303_2193;
	R1943[102] = (char *(*)()) F304_2193;
	{long i; for (i = 168; i < 170; i++) R1943[i] = (char *(*)()) F293_2193;}
	{long i; for (i = 170; i < 172; i++) R1943[i] = (char *(*)()) F301_2193;}
	R1943[172] = (char *(*)()) F293_2193;
	R1943[173] = (char *(*)()) F301_2193;
	R1943[174] = (char *(*)()) F293_2193;
	R1943[354] = (char *(*)()) F296_2193;
	R1943[357] = (char *(*)()) F295_2193;
	R1943[359] = (char *(*)()) F296_2193;
}

char *(*R1976[267])();
void R1976_init () {
	R1976[0] = (char *(*)()) F524_2713_1976_5;
	R1976[1] = (char *(*)()) F525_2713_1976_5;
	R1976[2] = (char *(*)()) F526_2713_1976_5;
	R1976[3] = (char *(*)()) F527_2713_1976_5;
	R1976[4] = (char *(*)()) F528_2713_1976_5;
	R1976[5] = (char *(*)()) F529_2713_1976_5;
	R1976[6] = (char *(*)()) F530_2713_1976_5;
	R1976[7] = (char *(*)()) F531_2713_1976_5;
	R1976[8] = (char *(*)()) F532_2713_1976_5;
	R1976[9] = (char *(*)()) F533_2713_1976_5;
	R1976[10] = (char *(*)()) F534_2713_1976_5;
	R1976[11] = (char *(*)()) F535_2713_1976_5;
	R1976[266] = (char *(*)()) F790_5034_1976_5;
}
static EIF_REFERENCE F524_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F524_2713(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_REFERENCE F525_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F525_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(742, 0x00).id, 742, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F526_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F526_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(775, 0x00).id, 775, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F527_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F527_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(733, 0x00).id, 733, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F528_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F528_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(724, 0x00).id, 724, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F529_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F529_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(727, 0x00).id, 727, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F530_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F530_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F531_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F531_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F532_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F532_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F533_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F533_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(718, 0x00).id, 718, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F534_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F534_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(730, 0x00).id, 730, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F535_2713_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F535_2713(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(721, 0x00).id, 721, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F790_5034_1976_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F790_5034(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R1979[264])();
void R1979_init () {
	R1979[0] = (char *(*)()) F524_2732_1979_8;
	R1979[1] = (char *(*)()) F525_2732_1979_8;
	R1979[2] = (char *(*)()) F526_2732_1979_8;
	R1979[3] = (char *(*)()) F527_2732_1979_8;
	R1979[4] = (char *(*)()) F528_2732_1979_8;
	R1979[5] = (char *(*)()) F529_2732_1979_8;
	R1979[6] = (char *(*)()) F530_2732_1979_8;
	R1979[7] = (char *(*)()) F531_2732_1979_8;
	R1979[8] = (char *(*)()) F532_2732_1979_8;
	R1979[9] = (char *(*)()) F533_2732_1979_8;
	R1979[10] = (char *(*)()) F534_2732_1979_8;
	R1979[11] = (char *(*)()) F535_2732_1979_8;
	R1979[77] = (char *(*)()) F601_3026;
	R1979[78] = (char *(*)()) F602_3026_1979_8;
	R1979[79] = (char *(*)()) F603_3026_1979_8;
	R1979[80] = (char *(*)()) F604_3026_1979_8;
	R1979[81] = (char *(*)()) F601_3026;
	R1979[82] = (char *(*)()) F603_3026_1979_8;
	R1979[83] = (char *(*)()) F601_3026;
	R1979[263] = (char *(*)()) F787_4886_1979_8;
}
static void F524_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F524_2732(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F525_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F525_2732(Current, *(EIF_BOOLEAN *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F526_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F526_2732(Current, *(EIF_POINTER *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F527_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F527_2732(Current, *(EIF_REAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F528_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F528_2732(Current, *(EIF_NATURAL_16 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F529_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F529_2732(Current, *(EIF_NATURAL_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F530_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F530_2732(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F531_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F531_2732(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F532_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F532_2732(Current, *(EIF_CHARACTER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F533_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F533_2732(Current, *(EIF_NATURAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F534_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F534_2732(Current, *(EIF_REAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F535_2732_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F535_2732(Current, *(EIF_NATURAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F602_3026_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F602_3026(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F603_3026_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F603_3026(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F604_3026_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F604_3026(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F787_4886_1979_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F787_4886(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

static EIF_TYPE_INDEX Y1981_pgtype0[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype1[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype2[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype3[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype4[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype5[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype6[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype7[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype8[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype9[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype10[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype11[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype12[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype13[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype14[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype15[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype16[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype17[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype18[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype19[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype20[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype21[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype22[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype23[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype24[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype25[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype26[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype27[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype28[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype29[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype30[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype31[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype32[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype33[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype34[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype35[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype36[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype37[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype38[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype39[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype40[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype41[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype42[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype43[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype44[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype45[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype46[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype47[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype48[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype49[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype50[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype51[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype52[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype53[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype54[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype55[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype56[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype57[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype58[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype59[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype60[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype61[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype62[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype63[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype64[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype65[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype66[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype67[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype68[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype69[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype70[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype71[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype72[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype73[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype74[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype75[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype76[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype77[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype78[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype79[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype80[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype81[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype82[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype83[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype84[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype85[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype86[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype87[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype88[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype89[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype90[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype91[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype92[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype93[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype94[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype95[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype96[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype97[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype98[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype99[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype100[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype101[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype102[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype103[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype104[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype105[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype106[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype107[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype108[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype109[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype110[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype111[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype112[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype113[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype114[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype115[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype116[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype117[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype118[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype119[] = {0xFF01,781,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype120[] = {0xFF01,781,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype121[] = {0xFF01,786,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype122[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1981_pgtype123[] = {709,0xFFFF};
EIF_TYPE_INDEX *Y1981_gen_type [425];
EIF_TYPE_INDEX Y1981 [425];
void Y1981_init (void)
{
	egc_routines_types [1981] = Y1981;
	egc_routines_gen_types [1981] = Y1981_gen_type;
	egc_routines_offset [1981] = 365;
	Y1981_gen_type [0] = Y1981_pgtype0;
	Y1981_gen_type [1] = Y1981_pgtype1;
	Y1981_gen_type [2] = Y1981_pgtype2;
	Y1981_gen_type [3] = Y1981_pgtype3;
	Y1981_gen_type [4] = Y1981_pgtype4;
	Y1981_gen_type [5] = Y1981_pgtype5;
	Y1981_gen_type [6] = Y1981_pgtype6;
	Y1981_gen_type [7] = Y1981_pgtype7;
	Y1981_gen_type [8] = Y1981_pgtype8;
	Y1981_gen_type [9] = Y1981_pgtype9;
	Y1981_gen_type [10] = Y1981_pgtype10;
	Y1981_gen_type [11] = Y1981_pgtype11;
	Y1981_gen_type [12] = Y1981_pgtype12;
	Y1981_gen_type [13] = Y1981_pgtype13;
	Y1981_gen_type [14] = Y1981_pgtype14;
	Y1981_gen_type [15] = Y1981_pgtype15;
	Y1981_gen_type [16] = Y1981_pgtype16;
	Y1981_gen_type [17] = Y1981_pgtype17;
	Y1981_gen_type [18] = Y1981_pgtype18;
	Y1981_gen_type [19] = Y1981_pgtype19;
	Y1981_gen_type [20] = Y1981_pgtype20;
	Y1981_gen_type [21] = Y1981_pgtype21;
	Y1981_gen_type [22] = Y1981_pgtype22;
	Y1981_gen_type [23] = Y1981_pgtype23;
	Y1981_gen_type [24] = Y1981_pgtype24;
	Y1981_gen_type [25] = Y1981_pgtype25;
	Y1981_gen_type [26] = Y1981_pgtype26;
	Y1981_gen_type [27] = Y1981_pgtype27;
	Y1981_gen_type [145] = Y1981_pgtype28;
	Y1981_gen_type [146] = Y1981_pgtype29;
	Y1981_gen_type [147] = Y1981_pgtype30;
	Y1981_gen_type [148] = Y1981_pgtype31;
	Y1981_gen_type [149] = Y1981_pgtype32;
	Y1981_gen_type [150] = Y1981_pgtype33;
	Y1981_gen_type [151] = Y1981_pgtype34;
	Y1981_gen_type [152] = Y1981_pgtype35;
	Y1981_gen_type [153] = Y1981_pgtype36;
	Y1981_gen_type [154] = Y1981_pgtype37;
	Y1981_gen_type [155] = Y1981_pgtype38;
	Y1981_gen_type [156] = Y1981_pgtype39;
	Y1981_gen_type [157] = Y1981_pgtype40;
	Y1981_gen_type [158] = Y1981_pgtype41;
	Y1981_gen_type [159] = Y1981_pgtype42;
	Y1981_gen_type [160] = Y1981_pgtype43;
	Y1981_gen_type [161] = Y1981_pgtype44;
	Y1981_gen_type [162] = Y1981_pgtype45;
	Y1981_gen_type [163] = Y1981_pgtype46;
	Y1981_gen_type [164] = Y1981_pgtype47;
	Y1981_gen_type [165] = Y1981_pgtype48;
	Y1981_gen_type [166] = Y1981_pgtype49;
	Y1981_gen_type [167] = Y1981_pgtype50;
	Y1981_gen_type [168] = Y1981_pgtype51;
	Y1981_gen_type [169] = Y1981_pgtype52;
	Y1981_gen_type [170] = Y1981_pgtype53;
	Y1981_gen_type [171] = Y1981_pgtype54;
	Y1981_gen_type [172] = Y1981_pgtype55;
	Y1981_gen_type [173] = Y1981_pgtype56;
	Y1981_gen_type [174] = Y1981_pgtype57;
	Y1981_gen_type [175] = Y1981_pgtype58;
	Y1981_gen_type [176] = Y1981_pgtype59;
	Y1981_gen_type [177] = Y1981_pgtype60;
	Y1981_gen_type [178] = Y1981_pgtype61;
	Y1981_gen_type [179] = Y1981_pgtype62;
	Y1981_gen_type [180] = Y1981_pgtype63;
	Y1981_gen_type [181] = Y1981_pgtype64;
	Y1981_gen_type [182] = Y1981_pgtype65;
	Y1981_gen_type [183] = Y1981_pgtype66;
	Y1981_gen_type [184] = Y1981_pgtype67;
	Y1981_gen_type [185] = Y1981_pgtype68;
	Y1981_gen_type [186] = Y1981_pgtype69;
	Y1981_gen_type [187] = Y1981_pgtype70;
	Y1981_gen_type [188] = Y1981_pgtype71;
	Y1981_gen_type [189] = Y1981_pgtype72;
	Y1981_gen_type [190] = Y1981_pgtype73;
	Y1981_gen_type [191] = Y1981_pgtype74;
	Y1981_gen_type [192] = Y1981_pgtype75;
	Y1981_gen_type [193] = Y1981_pgtype76;
	Y1981_gen_type [194] = Y1981_pgtype77;
	Y1981_gen_type [195] = Y1981_pgtype78;
	Y1981_gen_type [196] = Y1981_pgtype79;
	Y1981_gen_type [197] = Y1981_pgtype80;
	Y1981_gen_type [198] = Y1981_pgtype81;
	Y1981_gen_type [199] = Y1981_pgtype82;
	Y1981_gen_type [200] = Y1981_pgtype83;
	Y1981_gen_type [201] = Y1981_pgtype84;
	Y1981_gen_type [202] = Y1981_pgtype85;
	Y1981_gen_type [203] = Y1981_pgtype86;
	Y1981_gen_type [204] = Y1981_pgtype87;
	Y1981_gen_type [205] = Y1981_pgtype88;
	Y1981_gen_type [206] = Y1981_pgtype89;
	Y1981_gen_type [207] = Y1981_pgtype90;
	Y1981_gen_type [208] = Y1981_pgtype91;
	Y1981_gen_type [209] = Y1981_pgtype92;
	Y1981_gen_type [210] = Y1981_pgtype93;
	Y1981_gen_type [211] = Y1981_pgtype94;
	Y1981_gen_type [212] = Y1981_pgtype95;
	Y1981_gen_type [213] = Y1981_pgtype96;
	Y1981_gen_type [214] = Y1981_pgtype97;
	Y1981_gen_type [215] = Y1981_pgtype98;
	Y1981_gen_type [216] = Y1981_pgtype99;
	Y1981_gen_type [217] = Y1981_pgtype100;
	Y1981_gen_type [218] = Y1981_pgtype101;
	Y1981_gen_type [219] = Y1981_pgtype102;
	Y1981_gen_type [222] = Y1981_pgtype103;
	Y1981_gen_type [223] = Y1981_pgtype104;
	Y1981_gen_type [224] = Y1981_pgtype105;
	Y1981_gen_type [225] = Y1981_pgtype106;
	Y1981_gen_type [226] = Y1981_pgtype107;
	Y1981_gen_type [227] = Y1981_pgtype108;
	Y1981_gen_type [228] = Y1981_pgtype109;
	Y1981_gen_type [229] = Y1981_pgtype110;
	Y1981_gen_type [230] = Y1981_pgtype111;
	Y1981_gen_type [231] = Y1981_pgtype112;
	Y1981_gen_type [232] = Y1981_pgtype113;
	Y1981_gen_type [233] = Y1981_pgtype114;
	Y1981_gen_type [235] = Y1981_pgtype115;
	Y1981_gen_type [236] = Y1981_pgtype116;
	Y1981_gen_type [237] = Y1981_pgtype117;
	Y1981_gen_type [238] = Y1981_pgtype118;
	Y1981_gen_type [239] = Y1981_pgtype119;
	Y1981_gen_type [240] = Y1981_pgtype120;
	Y1981_gen_type [241] = Y1981_pgtype121;
	Y1981_gen_type [421] = Y1981_pgtype122;
	Y1981_gen_type [424] = Y1981_pgtype123;
	{long i; for (i = 145; i < 220; i++) Y1981[i] = 709;};
	{long i; for (i = 222; i < 234; i++) Y1981[i] = 709;};
	{long i; for (i = 239; i < 241; i++) Y1981[i] = 781;};
	Y1981[241] = 786;
	Y1981[421] = 709;
	Y1981[424] = 709;
}

char *(*R2003[269])();
void R2003_init () {
	R2003[0] = (char *(*)()) F524_2720;
	R2003[1] = (char *(*)()) F525_2720;
	R2003[2] = (char *(*)()) F526_2720;
	R2003[3] = (char *(*)()) F527_2720;
	R2003[4] = (char *(*)()) F528_2720;
	R2003[5] = (char *(*)()) F529_2720;
	R2003[6] = (char *(*)()) F530_2720;
	R2003[7] = (char *(*)()) F531_2720;
	R2003[8] = (char *(*)()) F532_2720;
	R2003[9] = (char *(*)()) F533_2720;
	R2003[10] = (char *(*)()) F534_2720;
	R2003[11] = (char *(*)()) F535_2720;
	R2003[77] = (char *(*)()) F601_2998;
	R2003[78] = (char *(*)()) F602_2998;
	R2003[79] = (char *(*)()) F603_2998;
	R2003[80] = (char *(*)()) F604_2998;
	R2003[81] = (char *(*)()) F601_2998;
	R2003[82] = (char *(*)()) F603_2998;
	R2003[83] = (char *(*)()) F601_2998;
	R2003[263] = (char *(*)()) F785_4808;
	R2003[266] = (char *(*)()) F788_4973;
	R2003[268] = (char *(*)()) F792_5147;
}

char *(*R2006[267])();
void R2006_init () {
	R2006[0] = (char *(*)()) F524_2721;
	R2006[1] = (char *(*)()) F525_2721;
	R2006[2] = (char *(*)()) F526_2721;
	R2006[3] = (char *(*)()) F527_2721;
	R2006[4] = (char *(*)()) F528_2721;
	R2006[5] = (char *(*)()) F529_2721;
	R2006[6] = (char *(*)()) F530_2721;
	R2006[7] = (char *(*)()) F531_2721;
	R2006[8] = (char *(*)()) F532_2721;
	R2006[9] = (char *(*)()) F533_2721;
	R2006[10] = (char *(*)()) F534_2721;
	R2006[11] = (char *(*)()) F535_2721;
	R2006[263] = (char *(*)()) F785_4807;
	R2006[266] = (char *(*)()) F788_4972;
}

char *(*R2213[267])();
void R2213_init () {
	R2213[0] = (char *(*)()) F524_2713;
	R2213[1] = (char *(*)()) F525_2713_2213_33;
	R2213[2] = (char *(*)()) F526_2713_2213_33;
	R2213[3] = (char *(*)()) F527_2713_2213_33;
	R2213[4] = (char *(*)()) F528_2713_2213_33;
	R2213[5] = (char *(*)()) F529_2713_2213_33;
	R2213[6] = (char *(*)()) F530_2713_2213_33;
	R2213[7] = (char *(*)()) F531_2713_2213_33;
	R2213[8] = (char *(*)()) F532_2713_2213_33;
	R2213[9] = (char *(*)()) F533_2713_2213_33;
	R2213[10] = (char *(*)()) F534_2713_2213_33;
	R2213[11] = (char *(*)()) F535_2713_2213_33;
	R2213[88] = (char *(*)()) F612_3212;
	R2213[89] = (char *(*)()) F613_3212_2213_33;
	R2213[90] = (char *(*)()) F614_3212_2213_33;
	R2213[91] = (char *(*)()) F615_3212_2213_33;
	R2213[92] = (char *(*)()) F616_3212_2213_33;
	R2213[93] = (char *(*)()) F617_3212_2213_33;
	R2213[94] = (char *(*)()) F618_3212_2213_33;
	R2213[95] = (char *(*)()) F619_3212_2213_33;
	R2213[96] = (char *(*)()) F620_3212_2213_33;
	R2213[97] = (char *(*)()) F621_3212_2213_33;
	R2213[98] = (char *(*)()) F622_3212_2213_33;
	R2213[99] = (char *(*)()) F623_3212_2213_33;
	R2213[180] = (char *(*)()) F704_3423;
	R2213[265] = (char *(*)()) F789_5011_2213_33;
	R2213[266] = (char *(*)()) F790_5034_2213_33;
}
static EIF_REFERENCE F525_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F525_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(742, 0x00).id, 742, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F526_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F526_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(775, 0x00).id, 775, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F527_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F527_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(733, 0x00).id, 733, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F528_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F528_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(724, 0x00).id, 724, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F529_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F529_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(727, 0x00).id, 727, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F530_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F530_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F531_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F531_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F532_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F532_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F533_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F533_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(718, 0x00).id, 718, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F534_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F534_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(730, 0x00).id, 730, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F535_2713_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F535_2713(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(721, 0x00).id, 721, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F613_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F613_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(742, 0x00).id, 742, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F614_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F614_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(775, 0x00).id, 775, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F615_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F615_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(733, 0x00).id, 733, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F616_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F616_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(724, 0x00).id, 724, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F617_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F617_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(727, 0x00).id, 727, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F618_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F618_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F619_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F619_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F620_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F620_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F621_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F621_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(718, 0x00).id, 718, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F622_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F622_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(730, 0x00).id, 730, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F623_3212_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F623_3212(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(721, 0x00).id, 721, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F789_5011_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F789_5011(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F790_5034_2213_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F790_5034(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R2214[267])();
void R2214_init () {
	R2214[0] = (char *(*)()) F524_2718;
	R2214[1] = (char *(*)()) F525_2718;
	R2214[2] = (char *(*)()) F526_2718;
	R2214[3] = (char *(*)()) F527_2718;
	R2214[4] = (char *(*)()) F528_2718;
	R2214[5] = (char *(*)()) F529_2718;
	R2214[6] = (char *(*)()) F530_2718;
	R2214[7] = (char *(*)()) F531_2718;
	R2214[8] = (char *(*)()) F532_2718;
	R2214[9] = (char *(*)()) F533_2718;
	R2214[10] = (char *(*)()) F534_2718;
	R2214[11] = (char *(*)()) F535_2718;
	R2214[77] = (char *(*)()) F601_3001;
	R2214[78] = (char *(*)()) F602_3001;
	R2214[79] = (char *(*)()) F603_3001;
	R2214[80] = (char *(*)()) F604_3001;
	R2214[81] = (char *(*)()) F601_3001;
	R2214[82] = (char *(*)()) F603_3001;
	R2214[83] = (char *(*)()) F601_3001;
	R2214[88] = (char *(*)()) F612_3220;
	R2214[89] = (char *(*)()) F613_3220;
	R2214[90] = (char *(*)()) F614_3220;
	R2214[91] = (char *(*)()) F615_3220;
	R2214[92] = (char *(*)()) F616_3220;
	R2214[93] = (char *(*)()) F617_3220;
	R2214[94] = (char *(*)()) F618_3220;
	R2214[95] = (char *(*)()) F619_3220;
	R2214[96] = (char *(*)()) F620_3220;
	R2214[97] = (char *(*)()) F621_3220;
	R2214[98] = (char *(*)()) F622_3220;
	R2214[99] = (char *(*)()) F623_3220;
	R2214[180] = (char *(*)()) F704_3453;
	{long i; for (i = 262; i < 264; i++) R2214[i] = (char *(*)()) F785_4810;}
	{long i; for (i = 265; i < 267; i++) R2214[i] = (char *(*)()) F788_4975;}
}

EIF_TYPE_INDEX *Y2214_gen_type [292];
EIF_TYPE_INDEX Y2214 [292];
void Y2214_init (void)
{
	egc_routines_types [2214] = Y2214;
	egc_routines_gen_types [2214] = Y2214_gen_type;
	egc_routines_offset [2214] = 498;
	{long i; for (i = 0; i < 87; i++) Y2214[i] = 709;};
	{long i; for (i = 89; i < 101; i++) Y2214[i] = 709;};
	{long i; for (i = 102; i < 109; i++) Y2214[i] = 709;};
	{long i; for (i = 113; i < 125; i++) Y2214[i] = 709;};
	Y2214[205] = 709;
	{long i; for (i = 286; i < 292; i++) Y2214[i] = 709;};
}

char *(*R2215[267])();
void R2215_init () {
	R2215[0] = (char *(*)()) F524_2719;
	R2215[1] = (char *(*)()) F525_2719;
	R2215[2] = (char *(*)()) F526_2719;
	R2215[3] = (char *(*)()) F527_2719;
	R2215[4] = (char *(*)()) F528_2719;
	R2215[5] = (char *(*)()) F529_2719;
	R2215[6] = (char *(*)()) F530_2719;
	R2215[7] = (char *(*)()) F531_2719;
	R2215[8] = (char *(*)()) F532_2719;
	R2215[9] = (char *(*)()) F533_2719;
	R2215[10] = (char *(*)()) F534_2719;
	R2215[11] = (char *(*)()) F535_2719;
	R2215[77] = (char *(*)()) F601_3002;
	R2215[78] = (char *(*)()) F602_3002;
	R2215[79] = (char *(*)()) F603_3002;
	R2215[80] = (char *(*)()) F604_3002;
	R2215[81] = (char *(*)()) F601_3002;
	R2215[82] = (char *(*)()) F603_3002;
	R2215[83] = (char *(*)()) F601_3002;
	R2215[88] = (char *(*)()) F612_3221;
	R2215[89] = (char *(*)()) F613_3221;
	R2215[90] = (char *(*)()) F614_3221;
	R2215[91] = (char *(*)()) F615_3221;
	R2215[92] = (char *(*)()) F616_3221;
	R2215[93] = (char *(*)()) F617_3221;
	R2215[94] = (char *(*)()) F618_3221;
	R2215[95] = (char *(*)()) F619_3221;
	R2215[96] = (char *(*)()) F620_3221;
	R2215[97] = (char *(*)()) F621_3221;
	R2215[98] = (char *(*)()) F622_3221;
	R2215[99] = (char *(*)()) F623_3221;
	R2215[180] = (char *(*)()) F704_3452;
	{long i; for (i = 262; i < 264; i++) R2215[i] = (char *(*)()) F785_4808;}
	{long i; for (i = 265; i < 267; i++) R2215[i] = (char *(*)()) F788_4973;}
}

char *(*R2241[12])();
void R2241_init () {
	R2241[0] = (char *(*)()) F524_2711;
	R2241[1] = (char *(*)()) F525_2711;
	R2241[2] = (char *(*)()) F526_2711;
	R2241[3] = (char *(*)()) F527_2711;
	R2241[4] = (char *(*)()) F528_2711;
	R2241[5] = (char *(*)()) F529_2711;
	R2241[6] = (char *(*)()) F530_2711;
	R2241[7] = (char *(*)()) F531_2711;
	R2241[8] = (char *(*)()) F532_2711;
	R2241[9] = (char *(*)()) F533_2711;
	R2241[10] = (char *(*)()) F534_2711;
	R2241[11] = (char *(*)()) F535_2711;
}

char *(*R2306[190])();
void R2306_init () {
	R2306[0] = (char *(*)()) F601_3039;
	R2306[1] = (char *(*)()) F602_3039;
	R2306[2] = (char *(*)()) F603_3039;
	R2306[3] = (char *(*)()) F604_3039;
	R2306[4] = (char *(*)()) F601_3039;
	R2306[5] = (char *(*)()) F603_3039;
	R2306[6] = (char *(*)()) F601_3039;
	R2306[103] = (char *(*)()) F704_3531;
	R2306[186] = (char *(*)()) F787_4949;
	R2306[188] = (char *(*)()) F789_5027;
	R2306[189] = (char *(*)()) F790_5118;
}

char *(*R2343[7])();
void R2343_init () {
	R2343[0] = (char *(*)()) F601_2980;
	R2343[1] = (char *(*)()) F602_2980;
	R2343[2] = (char *(*)()) F603_2980;
	R2343[3] = (char *(*)()) F604_2980;
	R2343[4] = (char *(*)()) F601_2980;
	R2343[5] = (char *(*)()) F603_2980;
	R2343[6] = (char *(*)()) F601_2980;
}

char *(*R2346[7])();
void R2346_init () {
	R2346[0] = (char *(*)()) F601_2983;
	R2346[1] = (char *(*)()) F602_2983;
	R2346[2] = (char *(*)()) F603_2983;
	R2346[3] = (char *(*)()) F604_2983;
	R2346[4] = (char *(*)()) F601_2983;
	R2346[5] = (char *(*)()) F603_2983;
	R2346[6] = (char *(*)()) F601_2983;
}

char *(*R2347[7])();
void R2347_init () {
	R2347[0] = (char *(*)()) F601_2984;
	R2347[1] = (char *(*)()) F602_2984;
	R2347[2] = (char *(*)()) F603_2984_2347_1;
	R2347[3] = (char *(*)()) F604_2984_2347_1;
	R2347[4] = (char *(*)()) F601_2984;
	R2347[5] = (char *(*)()) F603_2984_2347_1;
	R2347[6] = (char *(*)()) F601_2984;
}
static EIF_REFERENCE F603_2984_2347_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F603_2984(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F604_2984_2347_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F604_2984(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2355[7])();
void R2355_init () {
	R2355[0] = (char *(*)()) F601_2997;
	R2355[1] = (char *(*)()) F602_2997_2355_10;
	R2355[2] = (char *(*)()) F603_2997;
	R2355[3] = (char *(*)()) F604_2997_2355_10;
	R2355[4] = (char *(*)()) F605_3094;
	R2355[5] = (char *(*)()) F606_3094;
	R2355[6] = (char *(*)()) F601_2997;
}
static EIF_INTEGER_32 F602_2997_2355_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F602_2997(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_INTEGER_32 F604_2997_2355_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F604_2997(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2357[7])();
void R2357_init () {
	R2357[0] = (char *(*)()) F601_3004;
	R2357[1] = (char *(*)()) F602_3004_2357_3;
	R2357[2] = (char *(*)()) F603_3004;
	R2357[3] = (char *(*)()) F604_3004_2357_3;
	R2357[4] = (char *(*)()) F605_3096;
	R2357[5] = (char *(*)()) F606_3096;
	R2357[6] = (char *(*)()) F601_3004;
}
static EIF_BOOLEAN F602_3004_2357_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F602_3004(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static EIF_BOOLEAN F604_3004_2357_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F604_3004(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

char *(*R2363[7])();
void R2363_init () {
	R2363[0] = (char *(*)()) F601_3012;
	R2363[1] = (char *(*)()) F602_3012;
	R2363[2] = (char *(*)()) F603_3012;
	R2363[3] = (char *(*)()) F604_3012;
	R2363[4] = (char *(*)()) F601_3012;
	R2363[5] = (char *(*)()) F603_3012;
	R2363[6] = (char *(*)()) F601_3012;
}

char *(*R2364[7])();
void R2364_init () {
	R2364[0] = (char *(*)()) F601_3013;
	R2364[1] = (char *(*)()) F602_3013;
	R2364[2] = (char *(*)()) F603_3013;
	R2364[3] = (char *(*)()) F604_3013;
	R2364[4] = (char *(*)()) F601_3013;
	R2364[5] = (char *(*)()) F603_3013;
	R2364[6] = (char *(*)()) F601_3013;
}

char *(*R2372[7])();
void R2372_init () {
	R2372[0] = (char *(*)()) F601_3022;
	R2372[1] = (char *(*)()) F602_3022_2372_4;
	R2372[2] = (char *(*)()) F603_3022;
	R2372[3] = (char *(*)()) F604_3022_2372_4;
	R2372[4] = (char *(*)()) F601_3022;
	R2372[5] = (char *(*)()) F603_3022;
	R2372[6] = (char *(*)()) F601_3022;
}
static void F602_3022_2372_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F602_3022(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F604_3022_2372_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F604_3022(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2374[7])();
void R2374_init () {
	R2374[0] = (char *(*)()) F601_3024;
	R2374[1] = (char *(*)()) F602_3024;
	R2374[2] = (char *(*)()) F603_3024;
	R2374[3] = (char *(*)()) F604_3024;
	R2374[4] = (char *(*)()) F601_3024;
	R2374[5] = (char *(*)()) F603_3024;
	R2374[6] = (char *(*)()) F601_3024;
}

char *(*R2375[7])();
void R2375_init () {
	R2375[0] = (char *(*)()) F601_3025;
	R2375[1] = (char *(*)()) F602_3025;
	R2375[2] = (char *(*)()) F603_3025;
	R2375[3] = (char *(*)()) F604_3025;
	R2375[4] = (char *(*)()) F601_3025;
	R2375[5] = (char *(*)()) F603_3025;
	R2375[6] = (char *(*)()) F601_3025;
}

char *(*R2381[7])();
void R2381_init () {
	R2381[0] = (char *(*)()) F601_3038;
	R2381[1] = (char *(*)()) F602_3038;
	R2381[2] = (char *(*)()) F603_3038;
	R2381[3] = (char *(*)()) F604_3038;
	R2381[4] = (char *(*)()) F605_3098;
	R2381[5] = (char *(*)()) F606_3098;
	R2381[6] = (char *(*)()) F601_3038;
}

char *(*R2390[7])();
void R2390_init () {
	R2390[0] = (char *(*)()) F601_3048;
	R2390[1] = (char *(*)()) F602_3048;
	R2390[2] = (char *(*)()) F603_3048;
	R2390[3] = (char *(*)()) F604_3048;
	R2390[4] = (char *(*)()) F601_3048;
	R2390[5] = (char *(*)()) F603_3048;
	R2390[6] = (char *(*)()) F601_3048;
}

char *(*R2391[7])();
void R2391_init () {
	R2391[0] = (char *(*)()) F601_3049;
	R2391[1] = (char *(*)()) F602_3049;
	R2391[2] = (char *(*)()) F603_3049;
	R2391[3] = (char *(*)()) F604_3049;
	R2391[4] = (char *(*)()) F601_3049;
	R2391[5] = (char *(*)()) F603_3049;
	R2391[6] = (char *(*)()) F601_3049;
}

char *(*R2398[7])();
void R2398_init () {
	R2398[0] = (char *(*)()) F601_3056;
	R2398[1] = (char *(*)()) F602_3056;
	R2398[2] = (char *(*)()) F603_3056_2398_1;
	R2398[3] = (char *(*)()) F604_3056_2398_1;
	R2398[4] = (char *(*)()) F601_3056;
	R2398[5] = (char *(*)()) F603_3056_2398_1;
	R2398[6] = (char *(*)()) F601_3056;
}
static EIF_REFERENCE F603_3056_2398_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F603_3056(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F604_3056_2398_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F604_3056(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2399[7])();
void R2399_init () {
	R2399[0] = (char *(*)()) F601_3057;
	R2399[1] = (char *(*)()) F602_3057_2399_1;
	R2399[2] = (char *(*)()) F603_3057;
	R2399[3] = (char *(*)()) F604_3057_2399_1;
	R2399[4] = (char *(*)()) F601_3057;
	R2399[5] = (char *(*)()) F603_3057;
	R2399[6] = (char *(*)()) F601_3057;
}
static EIF_REFERENCE F602_3057_2399_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F602_3057(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F604_3057_2399_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F604_3057(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2400[7])();
void R2400_init () {
	R2400[0] = (char *(*)()) F601_3058;
	R2400[1] = (char *(*)()) F602_3058;
	R2400[2] = (char *(*)()) F603_3058;
	R2400[3] = (char *(*)()) F604_3058;
	R2400[4] = (char *(*)()) F601_3058;
	R2400[5] = (char *(*)()) F603_3058;
	R2400[6] = (char *(*)()) F601_3058;
}

char *(*R2401[7])();
void R2401_init () {
	R2401[0] = (char *(*)()) F601_3059;
	R2401[1] = (char *(*)()) F602_3059;
	R2401[2] = (char *(*)()) F603_3059;
	R2401[3] = (char *(*)()) F604_3059;
	R2401[4] = (char *(*)()) F601_3059;
	R2401[5] = (char *(*)()) F603_3059;
	R2401[6] = (char *(*)()) F601_3059;
}

char *(*R2404[7])();
void R2404_init () {
	R2404[0] = (char *(*)()) F601_3062;
	R2404[1] = (char *(*)()) F602_3062;
	R2404[2] = (char *(*)()) F603_3062;
	R2404[3] = (char *(*)()) F604_3062;
	R2404[4] = (char *(*)()) F601_3062;
	R2404[5] = (char *(*)()) F603_3062;
	R2404[6] = (char *(*)()) F601_3062;
}

char *(*R2406[7])();
void R2406_init () {
	R2406[0] = (char *(*)()) F601_3064;
	R2406[1] = (char *(*)()) F602_3064;
	R2406[2] = (char *(*)()) F603_3064;
	R2406[3] = (char *(*)()) F604_3064;
	R2406[4] = (char *(*)()) F601_3064;
	R2406[5] = (char *(*)()) F603_3064;
	R2406[6] = (char *(*)()) F601_3064;
}

char *(*R2407[7])();
void R2407_init () {
	R2407[0] = (char *(*)()) F601_3065;
	R2407[1] = (char *(*)()) F602_3065;
	R2407[2] = (char *(*)()) F603_3065;
	R2407[3] = (char *(*)()) F604_3065;
	R2407[4] = (char *(*)()) F601_3065;
	R2407[5] = (char *(*)()) F603_3065;
	R2407[6] = (char *(*)()) F601_3065;
}

char *(*R2408[7])();
void R2408_init () {
	R2408[0] = (char *(*)()) F601_3066;
	R2408[1] = (char *(*)()) F602_3066;
	R2408[2] = (char *(*)()) F603_3066;
	R2408[3] = (char *(*)()) F604_3066;
	R2408[4] = (char *(*)()) F601_3066;
	R2408[5] = (char *(*)()) F603_3066;
	R2408[6] = (char *(*)()) F601_3066;
}

char *(*R2412[7])();
void R2412_init () {
	R2412[0] = (char *(*)()) F601_3070;
	R2412[1] = (char *(*)()) F602_3070_2412_4;
	R2412[2] = (char *(*)()) F603_3070;
	R2412[3] = (char *(*)()) F604_3070_2412_4;
	R2412[4] = (char *(*)()) F601_3070;
	R2412[5] = (char *(*)()) F603_3070;
	R2412[6] = (char *(*)()) F601_3070;
}
static void F602_3070_2412_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F602_3070(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F604_3070_2412_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F604_3070(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2418[7])();
void R2418_init () {
	R2418[0] = (char *(*)()) F601_3076;
	R2418[1] = (char *(*)()) F602_3076;
	R2418[2] = (char *(*)()) F603_3076;
	R2418[3] = (char *(*)()) F604_3076;
	R2418[4] = (char *(*)()) F601_3076;
	R2418[5] = (char *(*)()) F603_3076;
	R2418[6] = (char *(*)()) F601_3076;
}

char *(*R2431[7])();
void R2431_init () {
	R2431[0] = (char *(*)()) F601_3089;
	R2431[1] = (char *(*)()) F602_3089;
	R2431[2] = (char *(*)()) F603_3089;
	R2431[3] = (char *(*)()) F604_3089;
	R2431[4] = (char *(*)()) F601_3089;
	R2431[5] = (char *(*)()) F603_3089;
	R2431[6] = (char *(*)()) F601_3089;
}

char *(*R2434[2])();
void R2434_init () {
	R2434[0] = (char *(*)()) F605_3092;
	R2434[1] = (char *(*)()) F606_3092;
}

char *(*R2539[12])();
void R2539_init () {
	R2539[0] = (char *(*)()) F612_3222;
	R2539[1] = (char *(*)()) F613_3222;
	R2539[2] = (char *(*)()) F614_3222;
	R2539[3] = (char *(*)()) F615_3222;
	R2539[4] = (char *(*)()) F616_3222;
	R2539[5] = (char *(*)()) F617_3222;
	R2539[6] = (char *(*)()) F618_3222;
	R2539[7] = (char *(*)()) F619_3222;
	R2539[8] = (char *(*)()) F620_3222;
	R2539[9] = (char *(*)()) F621_3222;
	R2539[10] = (char *(*)()) F622_3222;
	R2539[11] = (char *(*)()) F623_3222;
}

char *(*R2540[12])();
void R2540_init () {
	R2540[0] = (char *(*)()) F612_3223;
	R2540[1] = (char *(*)()) F613_3223;
	R2540[2] = (char *(*)()) F614_3223;
	R2540[3] = (char *(*)()) F615_3223;
	R2540[4] = (char *(*)()) F616_3223;
	R2540[5] = (char *(*)()) F617_3223;
	R2540[6] = (char *(*)()) F618_3223;
	R2540[7] = (char *(*)()) F619_3223;
	R2540[8] = (char *(*)()) F620_3223;
	R2540[9] = (char *(*)()) F621_3223;
	R2540[10] = (char *(*)()) F622_3223;
	R2540[11] = (char *(*)()) F623_3223;
}

char *(*R2542[12])();
void R2542_init () {
	R2542[0] = (char *(*)()) F612_3209;
	R2542[1] = (char *(*)()) F613_3209;
	R2542[2] = (char *(*)()) F614_3209;
	R2542[3] = (char *(*)()) F615_3209;
	R2542[4] = (char *(*)()) F616_3209;
	R2542[5] = (char *(*)()) F617_3209;
	R2542[6] = (char *(*)()) F618_3209;
	R2542[7] = (char *(*)()) F619_3209;
	R2542[8] = (char *(*)()) F620_3209;
	R2542[9] = (char *(*)()) F621_3209;
	R2542[10] = (char *(*)()) F622_3209;
	R2542[11] = (char *(*)()) F623_3209;
}

char *(*R2543[12])();
void R2543_init () {
	R2543[0] = (char *(*)()) F612_3210;
	R2543[1] = (char *(*)()) F613_3210_2543_116;
	R2543[2] = (char *(*)()) F614_3210_2543_116;
	R2543[3] = (char *(*)()) F615_3210_2543_116;
	R2543[4] = (char *(*)()) F616_3210_2543_116;
	R2543[5] = (char *(*)()) F617_3210_2543_116;
	R2543[6] = (char *(*)()) F618_3210_2543_116;
	R2543[7] = (char *(*)()) F619_3210_2543_116;
	R2543[8] = (char *(*)()) F620_3210_2543_116;
	R2543[9] = (char *(*)()) F621_3210_2543_116;
	R2543[10] = (char *(*)()) F622_3210_2543_116;
	R2543[11] = (char *(*)()) F623_3210_2543_116;
}
static void F613_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3210(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F614_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3210(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F615_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3210(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F616_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3210(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F617_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F617_3210(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F618_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F618_3210(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F619_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F619_3210(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F620_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F620_3210(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F621_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F621_3210(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F622_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F622_3210(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F623_3210_2543_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F623_3210(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2552[12])();
void R2552_init () {
	R2552[0] = (char *(*)()) F612_3225;
	R2552[1] = (char *(*)()) F613_3225;
	R2552[2] = (char *(*)()) F614_3225;
	R2552[3] = (char *(*)()) F615_3225;
	R2552[4] = (char *(*)()) F616_3225;
	R2552[5] = (char *(*)()) F617_3225;
	R2552[6] = (char *(*)()) F618_3225;
	R2552[7] = (char *(*)()) F619_3225;
	R2552[8] = (char *(*)()) F620_3225;
	R2552[9] = (char *(*)()) F621_3225;
	R2552[10] = (char *(*)()) F622_3225;
	R2552[11] = (char *(*)()) F623_3225;
}

char *(*R2553[12])();
void R2553_init () {
	R2553[0] = (char *(*)()) F612_3227;
	R2553[1] = (char *(*)()) F613_3227_2553_116;
	R2553[2] = (char *(*)()) F614_3227_2553_116;
	R2553[3] = (char *(*)()) F615_3227_2553_116;
	R2553[4] = (char *(*)()) F616_3227_2553_116;
	R2553[5] = (char *(*)()) F617_3227_2553_116;
	R2553[6] = (char *(*)()) F618_3227_2553_116;
	R2553[7] = (char *(*)()) F619_3227_2553_116;
	R2553[8] = (char *(*)()) F620_3227_2553_116;
	R2553[9] = (char *(*)()) F621_3227_2553_116;
	R2553[10] = (char *(*)()) F622_3227_2553_116;
	R2553[11] = (char *(*)()) F623_3227_2553_116;
}
static void F613_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3227(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F614_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3227(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F615_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3227(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F616_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3227(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F617_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F617_3227(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F618_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F618_3227(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F619_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F619_3227(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F620_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F620_3227(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F621_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F621_3227(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F622_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F622_3227(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F623_3227_2553_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F623_3227(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2554[12])();
void R2554_init () {
	R2554[0] = (char *(*)()) F612_3228;
	R2554[1] = (char *(*)()) F613_3228_2554_116;
	R2554[2] = (char *(*)()) F614_3228_2554_116;
	R2554[3] = (char *(*)()) F615_3228_2554_116;
	R2554[4] = (char *(*)()) F616_3228_2554_116;
	R2554[5] = (char *(*)()) F617_3228_2554_116;
	R2554[6] = (char *(*)()) F618_3228_2554_116;
	R2554[7] = (char *(*)()) F619_3228_2554_116;
	R2554[8] = (char *(*)()) F620_3228_2554_116;
	R2554[9] = (char *(*)()) F621_3228_2554_116;
	R2554[10] = (char *(*)()) F622_3228_2554_116;
	R2554[11] = (char *(*)()) F623_3228_2554_116;
}
static void F613_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3228(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F614_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3228(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F615_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3228(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F616_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3228(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F617_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F617_3228(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F618_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F618_3228(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F619_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F619_3228(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F620_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F620_3228(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F621_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F621_3228(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F622_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F622_3228(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F623_3228_2554_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F623_3228(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2557[12])();
void R2557_init () {
	R2557[0] = (char *(*)()) F612_3231;
	R2557[1] = (char *(*)()) F613_3231_2557_127;
	R2557[2] = (char *(*)()) F614_3231_2557_127;
	R2557[3] = (char *(*)()) F615_3231_2557_127;
	R2557[4] = (char *(*)()) F616_3231_2557_127;
	R2557[5] = (char *(*)()) F617_3231_2557_127;
	R2557[6] = (char *(*)()) F618_3231_2557_127;
	R2557[7] = (char *(*)()) F619_3231_2557_127;
	R2557[8] = (char *(*)()) F620_3231_2557_127;
	R2557[9] = (char *(*)()) F621_3231_2557_127;
	R2557[10] = (char *(*)()) F622_3231_2557_127;
	R2557[11] = (char *(*)()) F623_3231_2557_127;
}
static void F613_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F613_3231(Current, *(EIF_BOOLEAN *)arg1, arg2, arg3);
}
static void F614_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F614_3231(Current, *(EIF_POINTER *)arg1, arg2, arg3);
}
static void F615_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F615_3231(Current, *(EIF_REAL_64 *)arg1, arg2, arg3);
}
static void F616_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F616_3231(Current, *(EIF_NATURAL_16 *)arg1, arg2, arg3);
}
static void F617_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F617_3231(Current, *(EIF_NATURAL_8 *)arg1, arg2, arg3);
}
static void F618_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F618_3231(Current, *(EIF_CHARACTER_8 *)arg1, arg2, arg3);
}
static void F619_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F619_3231(Current, *(EIF_INTEGER_32 *)arg1, arg2, arg3);
}
static void F620_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F620_3231(Current, *(EIF_CHARACTER_32 *)arg1, arg2, arg3);
}
static void F621_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F621_3231(Current, *(EIF_NATURAL_64 *)arg1, arg2, arg3);
}
static void F622_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F622_3231(Current, *(EIF_REAL_32 *)arg1, arg2, arg3);
}
static void F623_3231_2557_127 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F623_3231(Current, *(EIF_NATURAL_32 *)arg1, arg2, arg3);
}

char *(*R2560[12])();
void R2560_init () {
	R2560[0] = (char *(*)()) F612_3234;
	R2560[1] = (char *(*)()) F613_3234;
	R2560[2] = (char *(*)()) F614_3234;
	R2560[3] = (char *(*)()) F615_3234;
	R2560[4] = (char *(*)()) F616_3234;
	R2560[5] = (char *(*)()) F617_3234;
	R2560[6] = (char *(*)()) F618_3234;
	R2560[7] = (char *(*)()) F619_3234;
	R2560[8] = (char *(*)()) F620_3234;
	R2560[9] = (char *(*)()) F621_3234;
	R2560[10] = (char *(*)()) F622_3234;
	R2560[11] = (char *(*)()) F623_3234;
}

char *(*R2561[12])();
void R2561_init () {
	R2561[0] = (char *(*)()) F612_3235;
	R2561[1] = (char *(*)()) F613_3235;
	R2561[2] = (char *(*)()) F614_3235;
	R2561[3] = (char *(*)()) F615_3235;
	R2561[4] = (char *(*)()) F616_3235;
	R2561[5] = (char *(*)()) F617_3235;
	R2561[6] = (char *(*)()) F618_3235;
	R2561[7] = (char *(*)()) F619_3235;
	R2561[8] = (char *(*)()) F620_3235;
	R2561[9] = (char *(*)()) F621_3235;
	R2561[10] = (char *(*)()) F622_3235;
	R2561[11] = (char *(*)()) F623_3235;
}

char *(*R2562[12])();
void R2562_init () {
	R2562[0] = (char *(*)()) F612_3236;
	R2562[1] = (char *(*)()) F613_3236;
	R2562[2] = (char *(*)()) F614_3236;
	R2562[3] = (char *(*)()) F615_3236;
	R2562[4] = (char *(*)()) F616_3236;
	R2562[5] = (char *(*)()) F617_3236;
	R2562[6] = (char *(*)()) F618_3236;
	R2562[7] = (char *(*)()) F619_3236;
	R2562[8] = (char *(*)()) F620_3236;
	R2562[9] = (char *(*)()) F621_3236;
	R2562[10] = (char *(*)()) F622_3236;
	R2562[11] = (char *(*)()) F623_3236;
}

char *(*R2563[12])();
void R2563_init () {
	R2563[0] = (char *(*)()) F612_3237;
	R2563[1] = (char *(*)()) F613_3237;
	R2563[2] = (char *(*)()) F614_3237;
	R2563[3] = (char *(*)()) F615_3237;
	R2563[4] = (char *(*)()) F616_3237;
	R2563[5] = (char *(*)()) F617_3237;
	R2563[6] = (char *(*)()) F618_3237;
	R2563[7] = (char *(*)()) F619_3237;
	R2563[8] = (char *(*)()) F620_3237;
	R2563[9] = (char *(*)()) F621_3237;
	R2563[10] = (char *(*)()) F622_3237;
	R2563[11] = (char *(*)()) F623_3237;
}

char *(*R2570[12])();
void R2570_init () {
	R2570[0] = (char *(*)()) F612_3244;
	R2570[1] = (char *(*)()) F613_3244;
	R2570[2] = (char *(*)()) F614_3244;
	R2570[3] = (char *(*)()) F615_3244;
	R2570[4] = (char *(*)()) F616_3244;
	R2570[5] = (char *(*)()) F617_3244;
	R2570[6] = (char *(*)()) F618_3244;
	R2570[7] = (char *(*)()) F619_3244;
	R2570[8] = (char *(*)()) F620_3244;
	R2570[9] = (char *(*)()) F621_3244;
	R2570[10] = (char *(*)()) F622_3244;
	R2570[11] = (char *(*)()) F623_3244;
}

char *(*R2573[12])();
void R2573_init () {
	R2573[0] = (char *(*)()) F612_3247;
	R2573[1] = (char *(*)()) F613_3247;
	R2573[2] = (char *(*)()) F614_3247;
	R2573[3] = (char *(*)()) F615_3247;
	R2573[4] = (char *(*)()) F616_3247;
	R2573[5] = (char *(*)()) F617_3247;
	R2573[6] = (char *(*)()) F618_3247;
	R2573[7] = (char *(*)()) F619_3247;
	R2573[8] = (char *(*)()) F620_3247;
	R2573[9] = (char *(*)()) F621_3247;
	R2573[10] = (char *(*)()) F622_3247;
	R2573[11] = (char *(*)()) F623_3247;
}

char *(*R2582[12])();
void R2582_init () {
	R2582[0] = (char *(*)()) F612_3257;
	R2582[1] = (char *(*)()) F613_3257;
	R2582[2] = (char *(*)()) F614_3257;
	R2582[3] = (char *(*)()) F615_3257;
	R2582[4] = (char *(*)()) F616_3257;
	R2582[5] = (char *(*)()) F617_3257;
	R2582[6] = (char *(*)()) F618_3257;
	R2582[7] = (char *(*)()) F619_3257;
	R2582[8] = (char *(*)()) F620_3257;
	R2582[9] = (char *(*)()) F621_3257;
	R2582[10] = (char *(*)()) F622_3257;
	R2582[11] = (char *(*)()) F623_3257;
}

char *(*R2630[118])();
void R2630_init () {
	R2630[0] = (char *(*)()) F673_3397;
	R2630[1] = (char *(*)()) F674_3397;
	R2630[2] = (char *(*)()) F675_3397;
	R2630[3] = (char *(*)()) F676_3397;
	R2630[4] = (char *(*)()) F677_3397;
	R2630[5] = (char *(*)()) F678_3397;
	R2630[6] = (char *(*)()) F679_3397;
	R2630[7] = (char *(*)()) F680_3397;
	R2630[8] = (char *(*)()) F681_3397;
	R2630[9] = (char *(*)()) F682_3397;
	R2630[10] = (char *(*)()) F683_3397;
	R2630[11] = (char *(*)()) F684_3397;
	R2630[12] = (char *(*)()) F685_3397;
	R2630[13] = (char *(*)()) F686_3397;
	R2630[14] = (char *(*)()) F687_3397;
	R2630[15] = (char *(*)()) F688_3397;
	R2630[16] = (char *(*)()) F689_3397;
	R2630[17] = (char *(*)()) F690_3397;
	R2630[18] = (char *(*)()) F691_3397;
	R2630[19] = (char *(*)()) F692_3397;
	R2630[20] = (char *(*)()) F693_3397;
	R2630[21] = (char *(*)()) F694_3397;
	R2630[22] = (char *(*)()) F695_3397;
	R2630[23] = (char *(*)()) F696_3397;
	R2630[24] = (char *(*)()) F697_3397;
	R2630[25] = (char *(*)()) F698_3397;
	R2630[26] = (char *(*)()) F699_3397;
	R2630[27] = (char *(*)()) F700_3397;
	R2630[28] = (char *(*)()) F701_3397;
	R2630[29] = (char *(*)()) F702_3397;
	R2630[30] = (char *(*)()) F703_3397;
	R2630[31] = (char *(*)()) F704_3449;
	{long i; for (i = 33; i < 35; i++) R2630[i] = (char *(*)()) F705_3556;}
	{long i; for (i = 36; i < 38; i++) R2630[i] = (char *(*)()) F708_3654;}
	{long i; for (i = 39; i < 41; i++) R2630[i] = (char *(*)()) F711_3753;}
	{long i; for (i = 42; i < 44; i++) R2630[i] = (char *(*)()) F714_3852;}
	{long i; for (i = 45; i < 47; i++) R2630[i] = (char *(*)()) F717_3951;}
	{long i; for (i = 48; i < 50; i++) R2630[i] = (char *(*)()) F720_4045;}
	{long i; for (i = 51; i < 53; i++) R2630[i] = (char *(*)()) F723_4139;}
	{long i; for (i = 54; i < 56; i++) R2630[i] = (char *(*)()) F726_4234;}
	{long i; for (i = 57; i < 59; i++) R2630[i] = (char *(*)()) F729_4329;}
	{long i; for (i = 60; i < 62; i++) R2630[i] = (char *(*)()) F732_4395;}
	{long i; for (i = 63; i < 65; i++) R2630[i] = (char *(*)()) F735_4462;}
	{long i; for (i = 66; i < 68; i++) R2630[i] = (char *(*)()) F738_4503;}
	{long i; for (i = 69; i < 71; i++) R2630[i] = (char *(*)()) F741_4551;}
	{long i; for (i = 72; i < 102; i++) R2630[i] = (char *(*)()) F744_4572;}
	R2630[102] = (char *(*)()) F775_4598;
	R2630[103] = (char *(*)()) F776_4598;
	{long i; for (i = 113; i < 115; i++) R2630[i] = (char *(*)()) F782_4665;}
	{long i; for (i = 116; i < 118; i++) R2630[i] = (char *(*)()) F782_4665;}
}

char *(*R2688[31])();
void R2688_init () {
	R2688[0] = (char *(*)()) F673_3393;
	R2688[1] = (char *(*)()) F674_3393;
	R2688[2] = (char *(*)()) F675_3393;
	R2688[3] = (char *(*)()) F676_3393;
	R2688[4] = (char *(*)()) F677_3393;
	R2688[5] = (char *(*)()) F678_3393;
	R2688[6] = (char *(*)()) F679_3393;
	R2688[7] = (char *(*)()) F680_3393;
	R2688[8] = (char *(*)()) F681_3393;
	R2688[9] = (char *(*)()) F682_3393;
	R2688[10] = (char *(*)()) F683_3393;
	R2688[11] = (char *(*)()) F684_3393;
	R2688[12] = (char *(*)()) F685_3393;
	R2688[13] = (char *(*)()) F686_3393;
	R2688[14] = (char *(*)()) F687_3393;
	R2688[15] = (char *(*)()) F688_3393;
	R2688[16] = (char *(*)()) F689_3393;
	R2688[17] = (char *(*)()) F690_3393;
	R2688[18] = (char *(*)()) F691_3393;
	R2688[19] = (char *(*)()) F692_3393;
	R2688[20] = (char *(*)()) F693_3393;
	R2688[21] = (char *(*)()) F694_3393;
	R2688[22] = (char *(*)()) F695_3393;
	R2688[23] = (char *(*)()) F696_3393;
	R2688[24] = (char *(*)()) F697_3393;
	R2688[25] = (char *(*)()) F698_3393;
	R2688[26] = (char *(*)()) F699_3393;
	R2688[27] = (char *(*)()) F700_3393;
	R2688[28] = (char *(*)()) F701_3393;
	R2688[29] = (char *(*)()) F702_3393;
	R2688[30] = (char *(*)()) F703_3393;
}

char *(*R2691[31])();
void R2691_init () {
	R2691[0] = (char *(*)()) F673_3396;
	R2691[1] = (char *(*)()) F674_3396;
	R2691[2] = (char *(*)()) F675_3396;
	R2691[3] = (char *(*)()) F676_3396;
	R2691[4] = (char *(*)()) F677_3396;
	R2691[5] = (char *(*)()) F678_3396;
	R2691[6] = (char *(*)()) F679_3396;
	R2691[7] = (char *(*)()) F680_3396;
	R2691[8] = (char *(*)()) F681_3396;
	R2691[9] = (char *(*)()) F682_3396;
	R2691[10] = (char *(*)()) F683_3396;
	R2691[11] = (char *(*)()) F684_3396;
	R2691[12] = (char *(*)()) F685_3396;
	R2691[13] = (char *(*)()) F686_3396;
	R2691[14] = (char *(*)()) F687_3396;
	R2691[15] = (char *(*)()) F688_3396;
	R2691[16] = (char *(*)()) F689_3396;
	R2691[17] = (char *(*)()) F690_3396;
	R2691[18] = (char *(*)()) F691_3396;
	R2691[19] = (char *(*)()) F692_3396;
	R2691[20] = (char *(*)()) F693_3396;
	R2691[21] = (char *(*)()) F694_3396;
	R2691[22] = (char *(*)()) F695_3396;
	R2691[23] = (char *(*)()) F696_3396;
	R2691[24] = (char *(*)()) F697_3396;
	R2691[25] = (char *(*)()) F698_3396;
	R2691[26] = (char *(*)()) F699_3396;
	R2691[27] = (char *(*)()) F700_3396;
	R2691[28] = (char *(*)()) F701_3396;
	R2691[29] = (char *(*)()) F702_3396;
	R2691[30] = (char *(*)()) F703_3396;
}

char *(*R2696[31])();
void R2696_init () {
	R2696[0] = (char *(*)()) F673_3402;
	R2696[1] = (char *(*)()) F674_3402;
	R2696[2] = (char *(*)()) F675_3402;
	R2696[3] = (char *(*)()) F676_3402;
	R2696[4] = (char *(*)()) F677_3402;
	R2696[5] = (char *(*)()) F678_3402;
	R2696[6] = (char *(*)()) F679_3402;
	R2696[7] = (char *(*)()) F680_3402;
	R2696[8] = (char *(*)()) F681_3402;
	R2696[9] = (char *(*)()) F682_3402;
	R2696[10] = (char *(*)()) F683_3402;
	R2696[11] = (char *(*)()) F684_3402;
	R2696[12] = (char *(*)()) F685_3402;
	R2696[13] = (char *(*)()) F686_3402;
	R2696[14] = (char *(*)()) F687_3402;
	R2696[15] = (char *(*)()) F688_3402;
	R2696[16] = (char *(*)()) F689_3402;
	R2696[17] = (char *(*)()) F690_3402;
	R2696[18] = (char *(*)()) F691_3402;
	R2696[19] = (char *(*)()) F692_3402;
	R2696[20] = (char *(*)()) F693_3402;
	R2696[21] = (char *(*)()) F694_3402;
	R2696[22] = (char *(*)()) F695_3402;
	R2696[23] = (char *(*)()) F696_3402;
	R2696[24] = (char *(*)()) F697_3402;
	R2696[25] = (char *(*)()) F698_3402;
	R2696[26] = (char *(*)()) F699_3402;
	R2696[27] = (char *(*)()) F700_3402;
	R2696[28] = (char *(*)()) F701_3402;
	R2696[29] = (char *(*)()) F702_3402;
	R2696[30] = (char *(*)()) F703_3402;
}

char *(*R2703[31])();
void R2703_init () {
	R2703[0] = (char *(*)()) F673_3410;
	R2703[1] = (char *(*)()) F674_3410_2703_1;
	R2703[2] = (char *(*)()) F675_3410_2703_1;
	R2703[3] = (char *(*)()) F676_3410_2703_1;
	R2703[4] = (char *(*)()) F677_3410_2703_1;
	R2703[5] = (char *(*)()) F678_3410_2703_1;
	R2703[6] = (char *(*)()) F679_3410_2703_1;
	R2703[7] = (char *(*)()) F680_3410_2703_1;
	R2703[8] = (char *(*)()) F681_3410_2703_1;
	R2703[9] = (char *(*)()) F682_3410_2703_1;
	R2703[10] = (char *(*)()) F683_3410_2703_1;
	R2703[11] = (char *(*)()) F684_3410_2703_1;
	R2703[12] = (char *(*)()) F685_3410_2703_1;
	R2703[13] = (char *(*)()) F686_3410_2703_1;
	R2703[14] = (char *(*)()) F687_3410_2703_1;
	R2703[15] = (char *(*)()) F688_3410_2703_1;
	R2703[16] = (char *(*)()) F689_3410_2703_1;
	R2703[17] = (char *(*)()) F690_3410_2703_1;
	R2703[18] = (char *(*)()) F691_3410_2703_1;
	R2703[19] = (char *(*)()) F692_3410_2703_1;
	R2703[20] = (char *(*)()) F693_3410_2703_1;
	R2703[21] = (char *(*)()) F694_3410_2703_1;
	R2703[22] = (char *(*)()) F695_3410_2703_1;
	R2703[23] = (char *(*)()) F696_3410_2703_1;
	R2703[24] = (char *(*)()) F697_3410_2703_1;
	R2703[25] = (char *(*)()) F698_3410;
	R2703[26] = (char *(*)()) F699_3410_2703_1;
	R2703[27] = (char *(*)()) F700_3410_2703_1;
	R2703[28] = (char *(*)()) F701_3410_2703_1;
	R2703[29] = (char *(*)()) F702_3410_2703_1;
	R2703[30] = (char *(*)()) F703_3410_2703_1;
}
static EIF_REFERENCE F674_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REFERENCE* r = F674_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {745,0,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 745, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REFERENCE* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F675_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F675_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(775, 0x00).id, 775, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F676_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F676_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(724, 0x00).id, 724, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F677_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64* r = F677_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {747,733,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 747, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F678_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F678_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(730, 0x00).id, 730, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F679_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F679_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(727, 0x00).id, 727, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F680_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F680_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(721, 0x00).id, 721, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F681_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F681_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(718, 0x00).id, 718, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F682_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8 r = F682_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i1;
	} else {
		Result = RTLNS(eif_new_type(715, 0x00).id, 715, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_INTEGER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F683_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16 r = F683_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i2;
	} else {
		Result = RTLNS(eif_new_type(712, 0x00).id, 712, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_INTEGER_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F684_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F684_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(709, 0x00).id, 709, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F685_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F685_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(706, 0x00).id, 706, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F686_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F686_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F687_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F687_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F688_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F688_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(742, 0x00).id, 742, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F689_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F689_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(733, 0x00).id, 733, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F690_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8* r = F690_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {749,727,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 749, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F691_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32* r = F691_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {751,721,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 751, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F692_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32* r = F692_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {753,730,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 753, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F693_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16* r = F693_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {755,724,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 755, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F694_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64* r = F694_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {757,718,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 757, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F695_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER* r = F695_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {759,775,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 759, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_POINTER* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F696_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN* r = F696_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {761,742,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 761, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_BOOLEAN* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F697_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32* r = F697_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {763,736,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 763, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F699_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8* r = F699_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {765,715,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 765, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F700_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64* r = F700_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {767,706,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 767, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F701_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16* r = F701_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {769,712,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 769, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F702_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32* r = F702_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {771,709,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 771, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F703_3410_2703_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8* r = F703_3410(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {773,739,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 773, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_8* *)Result = r;
		return Result;
	}
}

char *(*R2713[31])();
void R2713_init () {
	R2713[0] = (char *(*)()) F673_3422;
	R2713[1] = (char *(*)()) F674_3422;
	R2713[2] = (char *(*)()) F675_3422;
	R2713[3] = (char *(*)()) F676_3422;
	R2713[4] = (char *(*)()) F677_3422;
	R2713[5] = (char *(*)()) F678_3422;
	R2713[6] = (char *(*)()) F679_3422;
	R2713[7] = (char *(*)()) F680_3422;
	R2713[8] = (char *(*)()) F681_3422;
	R2713[9] = (char *(*)()) F682_3422;
	R2713[10] = (char *(*)()) F683_3422;
	R2713[11] = (char *(*)()) F684_3422;
	R2713[12] = (char *(*)()) F685_3422;
	R2713[13] = (char *(*)()) F686_3422;
	R2713[14] = (char *(*)()) F687_3422;
	R2713[15] = (char *(*)()) F688_3422;
	R2713[16] = (char *(*)()) F689_3422;
	R2713[17] = (char *(*)()) F690_3422;
	R2713[18] = (char *(*)()) F691_3422;
	R2713[19] = (char *(*)()) F692_3422;
	R2713[20] = (char *(*)()) F693_3422;
	R2713[21] = (char *(*)()) F694_3422;
	R2713[22] = (char *(*)()) F695_3422;
	R2713[23] = (char *(*)()) F696_3422;
	R2713[24] = (char *(*)()) F697_3422;
	R2713[25] = (char *(*)()) F698_3422;
	R2713[26] = (char *(*)()) F699_3422;
	R2713[27] = (char *(*)()) F700_3422;
	R2713[28] = (char *(*)()) F701_3422;
	R2713[29] = (char *(*)()) F702_3422;
	R2713[30] = (char *(*)()) F703_3422;
}

char *(*R2859[2])();
void R2859_init () {
	R2859[0] = (char *(*)()) F706_3638;
	R2859[1] = (char *(*)()) F707_3638;
}

char *(*R2862[2])();
void R2862_init () {
	R2862[0] = (char *(*)()) F706_3641;
	R2862[1] = (char *(*)()) F707_3641;
}

char *(*R2914[2])();
void R2914_init () {
	R2914[0] = (char *(*)()) F709_3736;
	R2914[1] = (char *(*)()) F710_3736;
}

char *(*R2915[2])();
void R2915_init () {
	R2915[0] = (char *(*)()) F709_3737;
	R2915[1] = (char *(*)()) F710_3737;
}

char *(*R2919[2])();
void R2919_init () {
	R2919[0] = (char *(*)()) F709_3741;
	R2919[1] = (char *(*)()) F710_3741;
}

char *(*R2971[2])();
void R2971_init () {
	R2971[0] = (char *(*)()) F712_3836;
	R2971[1] = (char *(*)()) F713_3836;
}

char *(*R2974[2])();
void R2974_init () {
	R2974[0] = (char *(*)()) F712_3839;
	R2974[1] = (char *(*)()) F713_3839;
}

char *(*R3024[2])();
void R3024_init () {
	R3024[0] = (char *(*)()) F715_3932;
	R3024[1] = (char *(*)()) F716_3932;
}

char *(*R3027[2])();
void R3027_init () {
	R3027[0] = (char *(*)()) F715_3935;
	R3027[1] = (char *(*)()) F716_3935;
}

char *(*R3030[2])();
void R3030_init () {
	R3030[0] = (char *(*)()) F715_3938;
	R3030[1] = (char *(*)()) F716_3938;
}

char *(*R3084[2])();
void R3084_init () {
	R3084[0] = (char *(*)()) F718_4032;
	R3084[1] = (char *(*)()) F719_4032;
}

char *(*R3130[2])();
void R3130_init () {
	R3130[0] = (char *(*)()) F721_4120;
	R3130[1] = (char *(*)()) F722_4120;
}

char *(*R3131[2])();
void R3131_init () {
	R3131[0] = (char *(*)()) F721_4121;
	R3131[1] = (char *(*)()) F722_4121;
}

char *(*R3133[2])();
void R3133_init () {
	R3133[0] = (char *(*)()) F721_4123;
	R3133[1] = (char *(*)()) F722_4123;
}

char *(*R3136[2])();
void R3136_init () {
	R3136[0] = (char *(*)()) F721_4126;
	R3136[1] = (char *(*)()) F722_4126;
}

char *(*R3137[2])();
void R3137_init () {
	R3137[0] = (char *(*)()) F721_4127;
	R3137[1] = (char *(*)()) F722_4127;
}

char *(*R3185[2])();
void R3185_init () {
	R3185[0] = (char *(*)()) F724_4217;
	R3185[1] = (char *(*)()) F725_4217;
}

char *(*R3186[2])();
void R3186_init () {
	R3186[0] = (char *(*)()) F724_4218;
	R3186[1] = (char *(*)()) F725_4218;
}

char *(*R3189[2])();
void R3189_init () {
	R3189[0] = (char *(*)()) F724_4221;
	R3189[1] = (char *(*)()) F725_4221;
}

char *(*R3238[2])();
void R3238_init () {
	R3238[0] = (char *(*)()) F727_4312;
	R3238[1] = (char *(*)()) F728_4312;
}

char *(*R3239[2])();
void R3239_init () {
	R3239[0] = (char *(*)()) F727_4313;
	R3239[1] = (char *(*)()) F728_4313;
}

char *(*R3240[2])();
void R3240_init () {
	R3240[0] = (char *(*)()) F727_4314;
	R3240[1] = (char *(*)()) F728_4314;
}

char *(*R3242[2])();
void R3242_init () {
	R3242[0] = (char *(*)()) F727_4316;
	R3242[1] = (char *(*)()) F728_4316;
}

char *(*R3288[2])();
void R3288_init () {
	R3288[0] = (char *(*)()) F730_4374;
	R3288[1] = (char *(*)()) F731_4374;
}

char *(*R3322[2])();
void R3322_init () {
	R3322[0] = (char *(*)()) F733_4440;
	R3322[1] = (char *(*)()) F734_4440;
}

char *(*R3343[2])();
void R3343_init () {
	R3343[0] = (char *(*)()) F736_4498;
	R3343[1] = (char *(*)()) F737_4498;
}

char *(*R3498[5])();
void R3498_init () {
	{long i; for (i = 0; i < 2; i++) R3498[i] = (char *(*)()) F785_4786;}
	{long i; for (i = 3; i < 5; i++) R3498[i] = (char *(*)()) F788_4952;}
}

char *(*R3500[5])();
void R3500_init () {
	R3500[0] = (char *(*)()) F786_4846;
	R3500[1] = (char *(*)()) F787_4868;
	R3500[3] = (char *(*)()) F789_5013;
	R3500[4] = (char *(*)()) F790_5036;
}

char *(*R3501[5])();
void R3501_init () {
	R3501[0] = (char *(*)()) F786_4845;
	R3501[1] = (char *(*)()) F787_4867;
	R3501[3] = (char *(*)()) F789_5011;
	R3501[4] = (char *(*)()) F790_5034;
}

char *(*R3512[5])();
void R3512_init () {
	{long i; for (i = 0; i < 2; i++) R3512[i] = (char *(*)()) F785_4817;}
	{long i; for (i = 3; i < 5; i++) R3512[i] = (char *(*)()) F788_4982;}
}

char *(*R3513[5])();
void R3513_init () {
	{long i; for (i = 0; i < 2; i++) R3513[i] = (char *(*)()) F785_4818;}
	{long i; for (i = 3; i < 5; i++) R3513[i] = (char *(*)()) F788_4983;}
}

char *(*R3514[5])();
void R3514_init () {
	{long i; for (i = 0; i < 2; i++) R3514[i] = (char *(*)()) F785_4819;}
	{long i; for (i = 3; i < 5; i++) R3514[i] = (char *(*)()) F788_4984;}
}

char *(*R3515[5])();
void R3515_init () {
	R3515[0] = (char *(*)()) F786_4855;
	R3515[1] = (char *(*)()) F437_2291;
	R3515[3] = (char *(*)()) F789_5023;
	R3515[4] = (char *(*)()) F436_2291;
}

char *(*R3537[5])();
void R3537_init () {
	{long i; for (i = 0; i < 2; i++) R3537[i] = (char *(*)()) F785_4808;}
	{long i; for (i = 3; i < 5; i++) R3537[i] = (char *(*)()) F788_4973;}
}

char *(*R3538[5])();
void R3538_init () {
	{long i; for (i = 0; i < 2; i++) R3538[i] = (char *(*)()) F785_4807;}
	{long i; for (i = 3; i < 5; i++) R3538[i] = (char *(*)()) F788_4972;}
}

char *(*R3578[5])();
void R3578_init () {
	R3578[0] = (char *(*)()) F786_4853;
	R3578[1] = (char *(*)()) F787_4946;
	R3578[3] = (char *(*)()) F789_5020;
	R3578[4] = (char *(*)()) F790_5114;
}

char *(*R3593[4])();
void R3593_init () {
	R3593[0] = (char *(*)()) F787_4948;
	R3593[3] = (char *(*)()) F790_5116;
}

char *(*R3596[4])();
void R3596_init () {
	R3596[0] = (char *(*)()) F787_4887;
	R3596[3] = (char *(*)()) F790_5055;
}

char *(*R3626[4])();
void R3626_init () {
	R3626[0] = (char *(*)()) F787_4931;
	R3626[3] = (char *(*)()) F790_5099;
}

char *(*R3658[2])();
void R3658_init () {
	R3658[0] = (char *(*)()) F786_4859;
	R3658[1] = (char *(*)()) F785_4838;
}

char *(*R3733[2])();
void R3733_init () {
	R3733[0] = (char *(*)()) F789_5026;
	R3733[1] = (char *(*)()) F788_5003;
}

char *(*R3821[2])();
void R3821_init () {
	R3821[0] = (char *(*)()) F794_5213;
	R3821[1] = (char *(*)()) F795_5234;
}

char *(*R3826[2])();
void R3826_init () {
	R3826[0] = (char *(*)()) F794_5216;
	R3826[1] = (char *(*)()) F795_5229;
}

char *(*R3828[2])();
void R3828_init () {
	R3828[0] = (char *(*)()) F794_5217;
	R3828[1] = (char *(*)()) F795_5230;
}
char *(*R2[805])();
void R2_init () {}
char *(*R6[805])();
void R6_init () {}

char *(*R3[805])();
void R3_init () {
	R3[136] = (char *(*)()) F137_1434;
	R3[137] = (char *(*)()) F138_1532;
	R3[791] = (char *(*)()) F792_5148;
}

char *(*R4[805])();
void R4_init () {
	{long i; for (i = 1; i < 4; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 5; i < 7; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 9; i < 12; i++) R4[i] = (char *(*)()) F1_15;}
	R4[24] = (char *(*)()) F1_15;
	R4[26] = (char *(*)()) F1_15;
	R4[34] = (char *(*)()) F1_15;
	R4[39] = (char *(*)()) F1_15;
	{long i; for (i = 43; i < 50; i++) R4[i] = (char *(*)()) F1_15;}
	R4[52] = (char *(*)()) F1_15;
	R4[56] = (char *(*)()) F1_15;
	{long i; for (i = 70; i < 72; i++) R4[i] = (char *(*)()) F1_15;}
	R4[73] = (char *(*)()) F1_15;
	R4[75] = (char *(*)()) F1_15;
	{long i; for (i = 80; i < 83; i++) R4[i] = (char *(*)()) F1_15;}
	R4[85] = (char *(*)()) F1_15;
	{long i; for (i = 87; i < 90; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 91; i < 94; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 95; i < 97; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 99; i < 101; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 102; i < 105; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 106; i < 110; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 111; i < 113; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 114; i < 120; i++) R4[i] = (char *(*)()) F1_15;}
	R4[129] = (char *(*)()) F1_15;
	R4[136] = (char *(*)()) F1_15;
	R4[137] = (char *(*)()) F138_1451;
	R4[144] = (char *(*)()) F1_15;
	R4[161] = (char *(*)()) F162_1990;
	{long i; for (i = 238; i < 242; i++) R4[i] = (char *(*)()) F1_15;}
	R4[432] = (char *(*)()) F1_15;
	R4[523] = (char *(*)()) F524_2761;
	R4[524] = (char *(*)()) F525_2761;
	R4[525] = (char *(*)()) F526_2761;
	R4[526] = (char *(*)()) F527_2761;
	R4[527] = (char *(*)()) F528_2761;
	R4[528] = (char *(*)()) F529_2761;
	R4[529] = (char *(*)()) F530_2761;
	R4[530] = (char *(*)()) F531_2761;
	R4[531] = (char *(*)()) F532_2761;
	R4[532] = (char *(*)()) F533_2761;
	R4[533] = (char *(*)()) F534_2761;
	R4[534] = (char *(*)()) F535_2761;
	R4[600] = (char *(*)()) F601_3037;
	R4[601] = (char *(*)()) F602_3037;
	R4[602] = (char *(*)()) F603_3037;
	R4[603] = (char *(*)()) F604_3037;
	R4[604] = (char *(*)()) F601_3037;
	R4[605] = (char *(*)()) F603_3037;
	R4[606] = (char *(*)()) F601_3037;
	{long i; for (i = 611; i < 623; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 672; i < 704; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 705; i < 707; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 708; i < 710; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 711; i < 713; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 714; i < 716; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 717; i < 719; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 720; i < 722; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 723; i < 725; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 726; i < 728; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 729; i < 731; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 732; i < 734; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 735; i < 737; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 738; i < 740; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 741; i < 743; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 744; i < 776; i++) R4[i] = (char *(*)()) F1_15;}
	R4[785] = (char *(*)()) F786_4842;
	R4[786] = (char *(*)()) F785_4826;
	R4[788] = (char *(*)()) F789_5010;
	R4[789] = (char *(*)()) F788_4991;
	{long i; for (i = 790; i < 792; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 793; i < 795; i++) R4[i] = (char *(*)()) F1_15;}
	R4[801] = (char *(*)()) F1_15;
}

char *(*R5[805])();
void R5_init () {
	{long i; for (i = 1; i < 4; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 5; i < 7; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 9; i < 12; i++) R5[i] = (char *(*)()) F1_8;}
	R5[24] = (char *(*)()) F1_8;
	R5[26] = (char *(*)()) F1_8;
	R5[34] = (char *(*)()) F1_8;
	R5[39] = (char *(*)()) F1_8;
	{long i; for (i = 43; i < 50; i++) R5[i] = (char *(*)()) F1_8;}
	R5[52] = (char *(*)()) F1_8;
	R5[56] = (char *(*)()) F1_8;
	{long i; for (i = 70; i < 72; i++) R5[i] = (char *(*)()) F1_8;}
	R5[73] = (char *(*)()) F1_8;
	R5[75] = (char *(*)()) F1_8;
	{long i; for (i = 80; i < 83; i++) R5[i] = (char *(*)()) F1_8;}
	R5[85] = (char *(*)()) F1_8;
	{long i; for (i = 87; i < 90; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 91; i < 94; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 95; i < 97; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 99; i < 101; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 102; i < 105; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 106; i < 110; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 111; i < 113; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 114; i < 120; i++) R5[i] = (char *(*)()) F1_8;}
	R5[129] = (char *(*)()) F1_8;
	R5[136] = (char *(*)()) F1_8;
	R5[137] = (char *(*)()) F138_1450;
	R5[144] = (char *(*)()) F1_8;
	R5[161] = (char *(*)()) F162_1989;
	{long i; for (i = 238; i < 242; i++) R5[i] = (char *(*)()) F1_8;}
	R5[432] = (char *(*)()) F1_8;
	R5[523] = (char *(*)()) F524_2723;
	R5[524] = (char *(*)()) F525_2723;
	R5[525] = (char *(*)()) F526_2723;
	R5[526] = (char *(*)()) F527_2723;
	R5[527] = (char *(*)()) F528_2723;
	R5[528] = (char *(*)()) F529_2723;
	R5[529] = (char *(*)()) F530_2723;
	R5[530] = (char *(*)()) F531_2723;
	R5[531] = (char *(*)()) F532_2723;
	R5[532] = (char *(*)()) F533_2723;
	R5[533] = (char *(*)()) F534_2723;
	R5[534] = (char *(*)()) F535_2723;
	R5[600] = (char *(*)()) F601_3003;
	R5[601] = (char *(*)()) F602_3003;
	R5[602] = (char *(*)()) F603_3003;
	R5[603] = (char *(*)()) F604_3003;
	R5[604] = (char *(*)()) F605_3097;
	R5[605] = (char *(*)()) F606_3097;
	R5[606] = (char *(*)()) F601_3003;
	{long i; for (i = 611; i < 623; i++) R5[i] = (char *(*)()) F1_8;}
	R5[672] = (char *(*)()) F673_3403;
	R5[673] = (char *(*)()) F674_3403;
	R5[674] = (char *(*)()) F675_3403;
	R5[675] = (char *(*)()) F676_3403;
	R5[676] = (char *(*)()) F677_3403;
	R5[677] = (char *(*)()) F678_3403;
	R5[678] = (char *(*)()) F679_3403;
	R5[679] = (char *(*)()) F680_3403;
	R5[680] = (char *(*)()) F681_3403;
	R5[681] = (char *(*)()) F682_3403;
	R5[682] = (char *(*)()) F683_3403;
	R5[683] = (char *(*)()) F684_3403;
	R5[684] = (char *(*)()) F685_3403;
	R5[685] = (char *(*)()) F686_3403;
	R5[686] = (char *(*)()) F687_3403;
	R5[687] = (char *(*)()) F688_3403;
	R5[688] = (char *(*)()) F689_3403;
	R5[689] = (char *(*)()) F690_3403;
	R5[690] = (char *(*)()) F691_3403;
	R5[691] = (char *(*)()) F692_3403;
	R5[692] = (char *(*)()) F693_3403;
	R5[693] = (char *(*)()) F694_3403;
	R5[694] = (char *(*)()) F695_3403;
	R5[695] = (char *(*)()) F696_3403;
	R5[696] = (char *(*)()) F697_3403;
	R5[697] = (char *(*)()) F698_3403;
	R5[698] = (char *(*)()) F699_3403;
	R5[699] = (char *(*)()) F700_3403;
	R5[700] = (char *(*)()) F701_3403;
	R5[701] = (char *(*)()) F702_3403;
	R5[702] = (char *(*)()) F703_3403;
	R5[703] = (char *(*)()) F704_3446;
	{long i; for (i = 705; i < 707; i++) R5[i] = (char *(*)()) F705_3564;}
	{long i; for (i = 708; i < 710; i++) R5[i] = (char *(*)()) F708_3662;}
	{long i; for (i = 711; i < 713; i++) R5[i] = (char *(*)()) F711_3761;}
	{long i; for (i = 714; i < 716; i++) R5[i] = (char *(*)()) F714_3860;}
	{long i; for (i = 717; i < 719; i++) R5[i] = (char *(*)()) F717_3959;}
	{long i; for (i = 720; i < 722; i++) R5[i] = (char *(*)()) F720_4053;}
	{long i; for (i = 723; i < 725; i++) R5[i] = (char *(*)()) F723_4147;}
	{long i; for (i = 726; i < 728; i++) R5[i] = (char *(*)()) F726_4242;}
	{long i; for (i = 729; i < 731; i++) R5[i] = (char *(*)()) F729_4341;}
	{long i; for (i = 732; i < 734; i++) R5[i] = (char *(*)()) F732_4407;}
	{long i; for (i = 735; i < 737; i++) R5[i] = (char *(*)()) F735_4468;}
	{long i; for (i = 738; i < 740; i++) R5[i] = (char *(*)()) F738_4508;}
	{long i; for (i = 741; i < 743; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 744; i < 776; i++) R5[i] = (char *(*)()) F744_4574;}
	{long i; for (i = 785; i < 787; i++) R5[i] = (char *(*)()) F785_4811;}
	{long i; for (i = 788; i < 790; i++) R5[i] = (char *(*)()) F788_4976;}
	{long i; for (i = 790; i < 792; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 793; i < 795; i++) R5[i] = (char *(*)()) F1_8;}
	R5[801] = (char *(*)()) F127_1372;
}


#ifdef __cplusplus
}
#endif
