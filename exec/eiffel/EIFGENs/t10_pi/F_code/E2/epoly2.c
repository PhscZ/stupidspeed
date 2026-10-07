#include "epoly2.h"
#include "../E1/eoffsets.h"


#ifdef __cplusplus
extern "C" {
#endif

char *(*R714[4])();
void R714_init () {
	R714[0] = (char *(*)()) F47_734;
	R714[1] = (char *(*)()) F48_734_714_1;
	R714[2] = (char *(*)()) F49_734_714_1;
	R714[3] = (char *(*)()) F50_734_714_1;
}
static EIF_REFERENCE F48_734_714_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F48_734(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F49_734_714_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F49_734(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F50_734_714_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F50_734(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R1044[39])();
void R1044_init () {
	R1044[0] = (char *(*)()) F78_1104;
	R1044[1] = (char *(*)()) F79_1128;
	R1044[4] = (char *(*)()) F82_1130;
	R1044[6] = (char *(*)()) F84_1132;
	R1044[7] = (char *(*)()) F85_1138;
	R1044[8] = (char *(*)()) F86_1155;
	R1044[10] = (char *(*)()) F88_1159;
	R1044[11] = (char *(*)()) F89_1163;
	R1044[14] = (char *(*)()) F92_1165;
	R1044[15] = (char *(*)()) F93_1167;
	R1044[17] = (char *(*)()) F95_1171;
	R1044[18] = (char *(*)()) F96_1173;
	R1044[19] = (char *(*)()) F97_1175;
	R1044[21] = (char *(*)()) F99_1181;
	R1044[22] = (char *(*)()) F100_1183;
	R1044[23] = (char *(*)()) F101_1187;
	R1044[24] = (char *(*)()) F102_1191;
	R1044[26] = (char *(*)()) F104_1193;
	R1044[27] = (char *(*)()) F105_1195;
	R1044[29] = (char *(*)()) F107_1197;
	R1044[30] = (char *(*)()) F108_1199;
	R1044[31] = (char *(*)()) F109_1201;
	R1044[33] = (char *(*)()) F111_1203;
	R1044[34] = (char *(*)()) F112_1205;
	R1044[35] = (char *(*)()) F113_1207;
	R1044[36] = (char *(*)()) F114_1211;
	R1044[37] = (char *(*)()) F115_1213;
	R1044[38] = (char *(*)()) F116_1215;
}

char *(*R1196[96])();
void R1196_init () {
	R1196[0] = (char *(*)()) F736_3588_1196_2;
	R1196[1] = (char *(*)()) F737_3588_1196_2;
	R1196[3] = (char *(*)()) F739_3687_1196_2;
	R1196[4] = (char *(*)()) F740_3687_1196_2;
	R1196[6] = (char *(*)()) F742_3786_1196_2;
	R1196[7] = (char *(*)()) F743_3786_1196_2;
	R1196[9] = (char *(*)()) F745_3885_1196_2;
	R1196[10] = (char *(*)()) F746_3885_1196_2;
	R1196[12] = (char *(*)()) F748_3980_1196_2;
	R1196[13] = (char *(*)()) F749_3980_1196_2;
	R1196[15] = (char *(*)()) F751_4074_1196_2;
	R1196[16] = (char *(*)()) F752_4074_1196_2;
	R1196[18] = (char *(*)()) F754_4169_1196_2;
	R1196[19] = (char *(*)()) F755_4169_1196_2;
	R1196[21] = (char *(*)()) F757_4264_1196_2;
	R1196[22] = (char *(*)()) F758_4264_1196_2;
	R1196[24] = (char *(*)()) F760_4333_1196_2;
	R1196[25] = (char *(*)()) F761_4333_1196_2;
	R1196[27] = (char *(*)()) F763_4399_1196_2;
	R1196[28] = (char *(*)()) F764_4399_1196_2;
	{long i; for (i = 30; i < 32; i++) R1196[i] = (char *(*)()) F765_4430;}
	{long i; for (i = 33; i < 35; i++) R1196[i] = (char *(*)()) F768_4470;}
	{long i; for (i = 80; i < 82; i++) R1196[i] = (char *(*)()) F815_4779;}
	{long i; for (i = 83; i < 85; i++) R1196[i] = (char *(*)()) F818_4944;}
	R1196[95] = (char *(*)()) F831_5322;
}
static EIF_BOOLEAN F736_3588_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F736_3588(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F737_3588_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F737_3588(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F739_3687_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F739_3687(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F740_3687_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F740_3687(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F742_3786_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F742_3786(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F743_3786_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F743_3786(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F745_3885_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F745_3885(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F746_3885_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F746_3885(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F748_3980_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F748_3980(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F749_3980_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F749_3980(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F751_4074_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F751_4074(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F752_4074_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F752_4074(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F754_4169_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F754_4169(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F755_4169_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F755_4169(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F757_4264_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F757_4264(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F758_4264_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F758_4264(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F760_4333_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F760_4333(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F761_4333_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F761_4333(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F763_4399_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F763_4399(Current, *(EIF_REAL_64 *)arg1);
}
static EIF_BOOLEAN F764_4399_1196_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F764_4399(Current, *(EIF_REAL_64 *)arg1);
}

char *(*R1726[663])();
void R1726_init () {
	R1726[0] = (char *(*)()) F150_1902;
	R1726[389] = (char *(*)()) F145_1902;
	R1726[390] = (char *(*)()) F146_1902;
	R1726[391] = (char *(*)()) F147_1902;
	R1726[392] = (char *(*)()) F148_1902;
	R1726[393] = (char *(*)()) F149_1902;
	R1726[394] = (char *(*)()) F150_1902;
	R1726[395] = (char *(*)()) F151_1902;
	R1726[396] = (char *(*)()) F152_1902;
	R1726[397] = (char *(*)()) F153_1902;
	R1726[398] = (char *(*)()) F154_1902;
	R1726[399] = (char *(*)()) F155_1902;
	R1726[400] = (char *(*)()) F156_1902;
	R1726[401] = (char *(*)()) F157_1902;
	R1726[659] = (char *(*)()) F151_1902;
	R1726[662] = (char *(*)()) F153_1902;
}

char *(*R1727[663])();
void R1727_init () {
	R1727[0] = (char *(*)()) F150_1903_1727_117;
	R1727[389] = (char *(*)()) F145_1903;
	R1727[390] = (char *(*)()) F146_1903_1727_117;
	R1727[391] = (char *(*)()) F147_1903_1727_117;
	R1727[392] = (char *(*)()) F148_1903_1727_117;
	R1727[393] = (char *(*)()) F149_1903_1727_117;
	R1727[394] = (char *(*)()) F150_1903_1727_117;
	R1727[395] = (char *(*)()) F151_1903_1727_117;
	R1727[396] = (char *(*)()) F152_1903_1727_117;
	R1727[397] = (char *(*)()) F153_1903_1727_117;
	R1727[398] = (char *(*)()) F154_1903_1727_117;
	R1727[399] = (char *(*)()) F155_1903_1727_117;
	R1727[400] = (char *(*)()) F156_1903_1727_117;
	R1727[401] = (char *(*)()) F157_1903_1727_117;
	R1727[659] = (char *(*)()) F151_1903_1727_117;
	R1727[662] = (char *(*)()) F153_1903_1727_117;
}
static void F150_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F150_1903(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F146_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F146_1903(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F147_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F147_1903(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F148_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F148_1903(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F149_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F149_1903(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F151_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F151_1903(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F152_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F152_1903(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F153_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F153_1903(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F154_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F154_1903(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F155_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F155_1903(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F156_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F156_1903(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F157_1903_1727_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F157_1903(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R1733[663])();
void R1733_init () {
	R1733[0] = (char *(*)()) F150_1909;
	R1733[389] = (char *(*)()) F145_1909;
	R1733[390] = (char *(*)()) F146_1909;
	R1733[391] = (char *(*)()) F147_1909;
	R1733[392] = (char *(*)()) F148_1909;
	R1733[393] = (char *(*)()) F149_1909;
	R1733[394] = (char *(*)()) F150_1909;
	R1733[395] = (char *(*)()) F151_1909;
	R1733[396] = (char *(*)()) F152_1909;
	R1733[397] = (char *(*)()) F153_1909;
	R1733[398] = (char *(*)()) F154_1909;
	R1733[399] = (char *(*)()) F155_1909;
	R1733[400] = (char *(*)()) F156_1909;
	R1733[401] = (char *(*)()) F157_1909;
	R1733[659] = (char *(*)()) F151_1909;
	R1733[662] = (char *(*)()) F153_1909;
}

char *(*R1793[4])();
void R1793_init () {
	R1793[0] = (char *(*)()) F240_2097;
	R1793[1] = (char *(*)()) F241_2097;
	R1793[2] = (char *(*)()) F242_2097_1793_1;
	R1793[3] = (char *(*)()) F243_2097_1793_1;
}
static EIF_REFERENCE F242_2097_1793_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F242_2097(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F243_2097_1793_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F243_2097(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1794[210])();
void R1794_init () {
	R1794[0] = (char *(*)()) F240_2100;
	R1794[1] = (char *(*)()) F241_2100;
	R1794[2] = (char *(*)()) F242_2100;
	R1794[3] = (char *(*)()) F243_2100;
	R1794[209] = (char *(*)()) F448_2226;
}

char *(*R1795[210])();
void R1795_init () {
	R1795[0] = (char *(*)()) F240_2101;
	R1795[1] = (char *(*)()) F241_2101;
	R1795[2] = (char *(*)()) F242_2101;
	R1795[3] = (char *(*)()) F243_2101;
	R1795[209] = (char *(*)()) F448_2232;
}

char *(*R1806[4])();
void R1806_init () {
	R1806[0] = (char *(*)()) F240_2098;
	R1806[1] = (char *(*)()) F241_2098_1806_1;
	R1806[2] = (char *(*)()) F242_2098;
	R1806[3] = (char *(*)()) F243_2098_1806_1;
}
static EIF_REFERENCE F241_2098_1806_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F241_2098(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F243_2098_1806_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F243_2098(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1808[7])();
void R1808_init () {
	R1808[0] = (char *(*)()) F630_2958;
	R1808[1] = (char *(*)()) F631_2958;
	R1808[2] = (char *(*)()) F632_2958;
	R1808[3] = (char *(*)()) F633_2958;
	R1808[4] = (char *(*)()) F630_2958;
	R1808[5] = (char *(*)()) F632_2958;
	R1808[6] = (char *(*)()) F630_2958;
}

static EIF_TYPE_INDEX Y1809_pgtype0[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype1[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype2[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype3[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype4[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype5[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype6[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype7[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype8[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype9[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype10[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype11[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype12[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype13[] = {0xFF01,818,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype14[] = {0xFF01,816,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype15[] = {766,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype16[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype17[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype18[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype19[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype20[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype21[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype22[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype23[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype24[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype25[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype26[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype27[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype28[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype29[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype30[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype31[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype32[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype33[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype34[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype35[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype36[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype37[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype38[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype39[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype40[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype41[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype42[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype43[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype44[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype45[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype46[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype47[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype48[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype49[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype50[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype51[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype52[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype53[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype54[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype55[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype56[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype57[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype58[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype59[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype60[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype61[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype62[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype63[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype64[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype65[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype66[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype67[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype68[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype69[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype70[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype71[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype72[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype73[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype74[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype75[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype76[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype77[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype78[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype79[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype80[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype81[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype82[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype83[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype84[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype85[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype86[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype87[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype88[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype89[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype90[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype91[] = {769,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype92[] = {766,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype93[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype94[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype95[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype96[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype97[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype98[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype99[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype100[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype101[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype102[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype103[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype104[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype105[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype106[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype107[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype108[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype109[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype110[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype111[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype112[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype113[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype114[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype115[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype116[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype117[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype118[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype119[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype120[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype121[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype122[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype123[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype124[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype125[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype126[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype127[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype128[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype129[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype130[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype131[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype132[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype133[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype134[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype135[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype136[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype137[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype138[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype139[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype140[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype141[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype142[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype143[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype144[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype145[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype146[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype147[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype148[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype149[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype150[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype151[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype152[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype153[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype154[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype155[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype156[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype157[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype158[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype159[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype160[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype161[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype162[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype163[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype164[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype165[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype166[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype167[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype168[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype169[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype170[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype171[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype172[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype173[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype174[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype175[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype176[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype177[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype178[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype179[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype180[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype181[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype182[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype183[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype184[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype185[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype186[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype187[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype188[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype189[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype190[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype191[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype192[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype193[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype194[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype195[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype196[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype197[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype198[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype199[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype200[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype201[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype202[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype203[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype204[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype205[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype206[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype207[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype208[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype209[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype210[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype211[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype212[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype213[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype214[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype215[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype216[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype217[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype218[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype219[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype220[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype221[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype222[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype223[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype224[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype225[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype226[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype227[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype228[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype229[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype230[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype231[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype232[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype233[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype234[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype235[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype236[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype237[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype238[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype239[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype240[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype241[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype242[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype243[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype244[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype245[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype246[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype247[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype248[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype249[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype250[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype251[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype252[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype253[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype254[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype255[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype256[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype257[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype258[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype259[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype260[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype261[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype262[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype263[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype264[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype265[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype266[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype267[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype268[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype269[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype270[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype271[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype272[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype273[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype274[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype275[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype276[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype277[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype278[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype279[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype280[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype281[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype282[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype283[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype284[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype285[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype286[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype287[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype288[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype289[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype290[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype291[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype292[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype293[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype294[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype295[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype296[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype297[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype298[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype299[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype300[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype301[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype302[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype303[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype304[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype305[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype306[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype307[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype308[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype309[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype310[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype311[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype312[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype313[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype314[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype315[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype316[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype317[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype318[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype319[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype320[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype321[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype322[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype323[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype324[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype325[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype326[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype327[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype328[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype329[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype330[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype331[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype332[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype333[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype334[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype335[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype336[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype337[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype338[] = {769,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype339[] = {769,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype340[] = {769,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype341[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype342[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype343[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype344[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype345[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype346[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype347[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype348[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype349[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype350[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype351[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype352[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype353[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype354[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype355[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype356[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype357[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype358[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype359[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype360[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype361[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype362[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype363[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype364[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype365[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype366[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype367[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype368[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype369[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype370[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype371[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype372[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype373[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype374[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype375[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype376[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype377[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype378[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype379[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype380[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype381[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype382[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype383[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype384[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype385[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype386[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype387[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype388[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype389[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype390[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype391[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype392[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype393[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype394[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype395[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype396[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype397[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype398[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype399[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype400[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype401[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype402[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype403[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype404[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype405[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype406[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype407[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype408[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype409[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype410[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype411[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype412[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype413[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype414[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype415[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype416[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype417[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype418[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype419[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype420[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype421[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype422[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype423[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype424[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype425[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype426[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype427[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype428[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype429[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype430[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype431[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype432[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype433[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype434[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype435[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype436[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype437[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype438[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype439[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype440[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype441[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype442[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype443[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype444[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype445[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype446[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype447[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype448[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype449[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype450[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype451[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype452[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype453[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype454[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype455[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype456[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype457[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype458[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype459[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype460[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype461[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype462[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype463[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype464[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype465[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype466[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype467[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype468[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype469[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype470[] = {769,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype471[] = {769,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype472[] = {769,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype473[] = {766,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype474[] = {766,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype475[] = {766,0xFFFF};
static EIF_TYPE_INDEX Y1809_pgtype476[] = {769,0xFFFF};
EIF_TYPE_INDEX *Y1809_gen_type [643];
EIF_TYPE_INDEX Y1809 [643];
void Y1809_init (void)
{
	egc_routines_types [1809] = Y1809;
	egc_routines_gen_types [1809] = Y1809_gen_type;
	egc_routines_offset [1809] = 178;
	Y1809_gen_type [0] = Y1809_pgtype0;
	Y1809_gen_type [1] = Y1809_pgtype1;
	Y1809_gen_type [2] = Y1809_pgtype2;
	Y1809_gen_type [3] = Y1809_pgtype3;
	Y1809_gen_type [4] = Y1809_pgtype4;
	Y1809_gen_type [5] = Y1809_pgtype5;
	Y1809_gen_type [6] = Y1809_pgtype6;
	Y1809_gen_type [7] = Y1809_pgtype7;
	Y1809_gen_type [8] = Y1809_pgtype8;
	Y1809_gen_type [9] = Y1809_pgtype9;
	Y1809_gen_type [10] = Y1809_pgtype10;
	Y1809_gen_type [11] = Y1809_pgtype11;
	Y1809_gen_type [12] = Y1809_pgtype12;
	Y1809_gen_type [13] = Y1809_pgtype13;
	Y1809_gen_type [14] = Y1809_pgtype14;
	Y1809_gen_type [15] = Y1809_pgtype15;
	Y1809_gen_type [16] = Y1809_pgtype16;
	Y1809_gen_type [17] = Y1809_pgtype17;
	Y1809_gen_type [18] = Y1809_pgtype18;
	Y1809_gen_type [19] = Y1809_pgtype19;
	Y1809_gen_type [20] = Y1809_pgtype20;
	Y1809_gen_type [21] = Y1809_pgtype21;
	Y1809_gen_type [22] = Y1809_pgtype22;
	Y1809_gen_type [23] = Y1809_pgtype23;
	Y1809_gen_type [24] = Y1809_pgtype24;
	Y1809_gen_type [25] = Y1809_pgtype25;
	Y1809_gen_type [26] = Y1809_pgtype26;
	Y1809_gen_type [27] = Y1809_pgtype27;
	Y1809_gen_type [28] = Y1809_pgtype28;
	Y1809_gen_type [29] = Y1809_pgtype29;
	Y1809_gen_type [30] = Y1809_pgtype30;
	Y1809_gen_type [31] = Y1809_pgtype31;
	Y1809_gen_type [32] = Y1809_pgtype32;
	Y1809_gen_type [33] = Y1809_pgtype33;
	Y1809_gen_type [34] = Y1809_pgtype34;
	Y1809_gen_type [35] = Y1809_pgtype35;
	Y1809_gen_type [36] = Y1809_pgtype36;
	Y1809_gen_type [37] = Y1809_pgtype37;
	Y1809_gen_type [38] = Y1809_pgtype38;
	Y1809_gen_type [39] = Y1809_pgtype39;
	Y1809_gen_type [40] = Y1809_pgtype40;
	Y1809_gen_type [41] = Y1809_pgtype41;
	Y1809_gen_type [42] = Y1809_pgtype42;
	Y1809_gen_type [43] = Y1809_pgtype43;
	Y1809_gen_type [44] = Y1809_pgtype44;
	Y1809_gen_type [45] = Y1809_pgtype45;
	Y1809_gen_type [46] = Y1809_pgtype46;
	Y1809_gen_type [47] = Y1809_pgtype47;
	Y1809_gen_type [48] = Y1809_pgtype48;
	Y1809_gen_type [49] = Y1809_pgtype49;
	Y1809_gen_type [50] = Y1809_pgtype50;
	Y1809_gen_type [51] = Y1809_pgtype51;
	Y1809_gen_type [52] = Y1809_pgtype52;
	Y1809_gen_type [53] = Y1809_pgtype53;
	Y1809_gen_type [54] = Y1809_pgtype54;
	Y1809_gen_type [55] = Y1809_pgtype55;
	Y1809_gen_type [56] = Y1809_pgtype56;
	Y1809_gen_type [57] = Y1809_pgtype57;
	Y1809_gen_type [58] = Y1809_pgtype58;
	Y1809_gen_type [59] = Y1809_pgtype59;
	Y1809_gen_type [60] = Y1809_pgtype60;
	Y1809_gen_type [61] = Y1809_pgtype61;
	Y1809_gen_type [62] = Y1809_pgtype62;
	Y1809_gen_type [63] = Y1809_pgtype63;
	Y1809_gen_type [64] = Y1809_pgtype64;
	Y1809_gen_type [65] = Y1809_pgtype65;
	Y1809_gen_type [66] = Y1809_pgtype66;
	Y1809_gen_type [67] = Y1809_pgtype67;
	Y1809_gen_type [68] = Y1809_pgtype68;
	Y1809_gen_type [69] = Y1809_pgtype69;
	Y1809_gen_type [70] = Y1809_pgtype70;
	Y1809_gen_type [71] = Y1809_pgtype71;
	Y1809_gen_type [72] = Y1809_pgtype72;
	Y1809_gen_type [73] = Y1809_pgtype73;
	Y1809_gen_type [74] = Y1809_pgtype74;
	Y1809_gen_type [75] = Y1809_pgtype75;
	Y1809_gen_type [76] = Y1809_pgtype76;
	Y1809_gen_type [77] = Y1809_pgtype77;
	Y1809_gen_type [78] = Y1809_pgtype78;
	Y1809_gen_type [79] = Y1809_pgtype79;
	Y1809_gen_type [80] = Y1809_pgtype80;
	Y1809_gen_type [81] = Y1809_pgtype81;
	Y1809_gen_type [82] = Y1809_pgtype82;
	Y1809_gen_type [83] = Y1809_pgtype83;
	Y1809_gen_type [84] = Y1809_pgtype84;
	Y1809_gen_type [85] = Y1809_pgtype85;
	Y1809_gen_type [86] = Y1809_pgtype86;
	Y1809_gen_type [87] = Y1809_pgtype87;
	Y1809_gen_type [88] = Y1809_pgtype88;
	Y1809_gen_type [89] = Y1809_pgtype89;
	Y1809_gen_type [90] = Y1809_pgtype90;
	Y1809_gen_type [91] = Y1809_pgtype91;
	Y1809_gen_type [92] = Y1809_pgtype92;
	Y1809_gen_type [93] = Y1809_pgtype93;
	Y1809_gen_type [94] = Y1809_pgtype94;
	Y1809_gen_type [95] = Y1809_pgtype95;
	Y1809_gen_type [96] = Y1809_pgtype96;
	Y1809_gen_type [97] = Y1809_pgtype97;
	Y1809_gen_type [98] = Y1809_pgtype98;
	Y1809_gen_type [99] = Y1809_pgtype99;
	Y1809_gen_type [100] = Y1809_pgtype100;
	Y1809_gen_type [101] = Y1809_pgtype101;
	Y1809_gen_type [102] = Y1809_pgtype102;
	Y1809_gen_type [103] = Y1809_pgtype103;
	Y1809_gen_type [104] = Y1809_pgtype104;
	Y1809_gen_type [105] = Y1809_pgtype105;
	Y1809_gen_type [106] = Y1809_pgtype106;
	Y1809_gen_type [107] = Y1809_pgtype107;
	Y1809_gen_type [108] = Y1809_pgtype108;
	Y1809_gen_type [109] = Y1809_pgtype109;
	Y1809_gen_type [110] = Y1809_pgtype110;
	Y1809_gen_type [111] = Y1809_pgtype111;
	Y1809_gen_type [112] = Y1809_pgtype112;
	Y1809_gen_type [113] = Y1809_pgtype113;
	Y1809_gen_type [114] = Y1809_pgtype114;
	Y1809_gen_type [115] = Y1809_pgtype115;
	Y1809_gen_type [116] = Y1809_pgtype116;
	Y1809_gen_type [117] = Y1809_pgtype117;
	Y1809_gen_type [118] = Y1809_pgtype118;
	Y1809_gen_type [119] = Y1809_pgtype119;
	Y1809_gen_type [120] = Y1809_pgtype120;
	Y1809_gen_type [121] = Y1809_pgtype121;
	Y1809_gen_type [122] = Y1809_pgtype122;
	Y1809_gen_type [123] = Y1809_pgtype123;
	Y1809_gen_type [124] = Y1809_pgtype124;
	Y1809_gen_type [125] = Y1809_pgtype125;
	Y1809_gen_type [126] = Y1809_pgtype126;
	Y1809_gen_type [127] = Y1809_pgtype127;
	Y1809_gen_type [128] = Y1809_pgtype128;
	Y1809_gen_type [129] = Y1809_pgtype129;
	Y1809_gen_type [130] = Y1809_pgtype130;
	Y1809_gen_type [131] = Y1809_pgtype131;
	Y1809_gen_type [132] = Y1809_pgtype132;
	Y1809_gen_type [133] = Y1809_pgtype133;
	Y1809_gen_type [134] = Y1809_pgtype134;
	Y1809_gen_type [135] = Y1809_pgtype135;
	Y1809_gen_type [136] = Y1809_pgtype136;
	Y1809_gen_type [137] = Y1809_pgtype137;
	Y1809_gen_type [138] = Y1809_pgtype138;
	Y1809_gen_type [139] = Y1809_pgtype139;
	Y1809_gen_type [140] = Y1809_pgtype140;
	Y1809_gen_type [141] = Y1809_pgtype141;
	Y1809_gen_type [142] = Y1809_pgtype142;
	Y1809_gen_type [143] = Y1809_pgtype143;
	Y1809_gen_type [144] = Y1809_pgtype144;
	Y1809_gen_type [145] = Y1809_pgtype145;
	Y1809_gen_type [146] = Y1809_pgtype146;
	Y1809_gen_type [147] = Y1809_pgtype147;
	Y1809_gen_type [148] = Y1809_pgtype148;
	Y1809_gen_type [149] = Y1809_pgtype149;
	Y1809_gen_type [150] = Y1809_pgtype150;
	Y1809_gen_type [151] = Y1809_pgtype151;
	Y1809_gen_type [152] = Y1809_pgtype152;
	Y1809_gen_type [153] = Y1809_pgtype153;
	Y1809_gen_type [154] = Y1809_pgtype154;
	Y1809_gen_type [155] = Y1809_pgtype155;
	Y1809_gen_type [156] = Y1809_pgtype156;
	Y1809_gen_type [157] = Y1809_pgtype157;
	Y1809_gen_type [158] = Y1809_pgtype158;
	Y1809_gen_type [159] = Y1809_pgtype159;
	Y1809_gen_type [160] = Y1809_pgtype160;
	Y1809_gen_type [161] = Y1809_pgtype161;
	Y1809_gen_type [162] = Y1809_pgtype162;
	Y1809_gen_type [163] = Y1809_pgtype163;
	Y1809_gen_type [164] = Y1809_pgtype164;
	Y1809_gen_type [165] = Y1809_pgtype165;
	Y1809_gen_type [166] = Y1809_pgtype166;
	Y1809_gen_type [167] = Y1809_pgtype167;
	Y1809_gen_type [168] = Y1809_pgtype168;
	Y1809_gen_type [169] = Y1809_pgtype169;
	Y1809_gen_type [170] = Y1809_pgtype170;
	Y1809_gen_type [171] = Y1809_pgtype171;
	Y1809_gen_type [172] = Y1809_pgtype172;
	Y1809_gen_type [173] = Y1809_pgtype173;
	Y1809_gen_type [174] = Y1809_pgtype174;
	Y1809_gen_type [175] = Y1809_pgtype175;
	Y1809_gen_type [176] = Y1809_pgtype176;
	Y1809_gen_type [177] = Y1809_pgtype177;
	Y1809_gen_type [178] = Y1809_pgtype178;
	Y1809_gen_type [179] = Y1809_pgtype179;
	Y1809_gen_type [180] = Y1809_pgtype180;
	Y1809_gen_type [181] = Y1809_pgtype181;
	Y1809_gen_type [182] = Y1809_pgtype182;
	Y1809_gen_type [183] = Y1809_pgtype183;
	Y1809_gen_type [184] = Y1809_pgtype184;
	Y1809_gen_type [185] = Y1809_pgtype185;
	Y1809_gen_type [186] = Y1809_pgtype186;
	Y1809_gen_type [187] = Y1809_pgtype187;
	Y1809_gen_type [188] = Y1809_pgtype188;
	Y1809_gen_type [189] = Y1809_pgtype189;
	Y1809_gen_type [190] = Y1809_pgtype190;
	Y1809_gen_type [191] = Y1809_pgtype191;
	Y1809_gen_type [192] = Y1809_pgtype192;
	Y1809_gen_type [193] = Y1809_pgtype193;
	Y1809_gen_type [194] = Y1809_pgtype194;
	Y1809_gen_type [195] = Y1809_pgtype195;
	Y1809_gen_type [196] = Y1809_pgtype196;
	Y1809_gen_type [197] = Y1809_pgtype197;
	Y1809_gen_type [198] = Y1809_pgtype198;
	Y1809_gen_type [199] = Y1809_pgtype199;
	Y1809_gen_type [200] = Y1809_pgtype200;
	Y1809_gen_type [201] = Y1809_pgtype201;
	Y1809_gen_type [202] = Y1809_pgtype202;
	Y1809_gen_type [203] = Y1809_pgtype203;
	Y1809_gen_type [204] = Y1809_pgtype204;
	Y1809_gen_type [205] = Y1809_pgtype205;
	Y1809_gen_type [206] = Y1809_pgtype206;
	Y1809_gen_type [207] = Y1809_pgtype207;
	Y1809_gen_type [208] = Y1809_pgtype208;
	Y1809_gen_type [209] = Y1809_pgtype209;
	Y1809_gen_type [210] = Y1809_pgtype210;
	Y1809_gen_type [211] = Y1809_pgtype211;
	Y1809_gen_type [212] = Y1809_pgtype212;
	Y1809_gen_type [213] = Y1809_pgtype213;
	Y1809_gen_type [214] = Y1809_pgtype214;
	Y1809_gen_type [215] = Y1809_pgtype215;
	Y1809_gen_type [216] = Y1809_pgtype216;
	Y1809_gen_type [217] = Y1809_pgtype217;
	Y1809_gen_type [218] = Y1809_pgtype218;
	Y1809_gen_type [219] = Y1809_pgtype219;
	Y1809_gen_type [220] = Y1809_pgtype220;
	Y1809_gen_type [221] = Y1809_pgtype221;
	Y1809_gen_type [222] = Y1809_pgtype222;
	Y1809_gen_type [223] = Y1809_pgtype223;
	Y1809_gen_type [224] = Y1809_pgtype224;
	Y1809_gen_type [225] = Y1809_pgtype225;
	Y1809_gen_type [226] = Y1809_pgtype226;
	Y1809_gen_type [227] = Y1809_pgtype227;
	Y1809_gen_type [228] = Y1809_pgtype228;
	Y1809_gen_type [229] = Y1809_pgtype229;
	Y1809_gen_type [230] = Y1809_pgtype230;
	Y1809_gen_type [231] = Y1809_pgtype231;
	Y1809_gen_type [232] = Y1809_pgtype232;
	Y1809_gen_type [233] = Y1809_pgtype233;
	Y1809_gen_type [234] = Y1809_pgtype234;
	Y1809_gen_type [235] = Y1809_pgtype235;
	Y1809_gen_type [236] = Y1809_pgtype236;
	Y1809_gen_type [237] = Y1809_pgtype237;
	Y1809_gen_type [238] = Y1809_pgtype238;
	Y1809_gen_type [239] = Y1809_pgtype239;
	Y1809_gen_type [240] = Y1809_pgtype240;
	Y1809_gen_type [241] = Y1809_pgtype241;
	Y1809_gen_type [242] = Y1809_pgtype242;
	Y1809_gen_type [243] = Y1809_pgtype243;
	Y1809_gen_type [244] = Y1809_pgtype244;
	Y1809_gen_type [245] = Y1809_pgtype245;
	Y1809_gen_type [246] = Y1809_pgtype246;
	Y1809_gen_type [247] = Y1809_pgtype247;
	Y1809_gen_type [248] = Y1809_pgtype248;
	Y1809_gen_type [249] = Y1809_pgtype249;
	Y1809_gen_type [250] = Y1809_pgtype250;
	Y1809_gen_type [251] = Y1809_pgtype251;
	Y1809_gen_type [252] = Y1809_pgtype252;
	Y1809_gen_type [253] = Y1809_pgtype253;
	Y1809_gen_type [254] = Y1809_pgtype254;
	Y1809_gen_type [255] = Y1809_pgtype255;
	Y1809_gen_type [256] = Y1809_pgtype256;
	Y1809_gen_type [257] = Y1809_pgtype257;
	Y1809_gen_type [258] = Y1809_pgtype258;
	Y1809_gen_type [259] = Y1809_pgtype259;
	Y1809_gen_type [260] = Y1809_pgtype260;
	Y1809_gen_type [261] = Y1809_pgtype261;
	Y1809_gen_type [262] = Y1809_pgtype262;
	Y1809_gen_type [263] = Y1809_pgtype263;
	Y1809_gen_type [264] = Y1809_pgtype264;
	Y1809_gen_type [265] = Y1809_pgtype265;
	Y1809_gen_type [266] = Y1809_pgtype266;
	Y1809_gen_type [267] = Y1809_pgtype267;
	Y1809_gen_type [268] = Y1809_pgtype268;
	Y1809_gen_type [269] = Y1809_pgtype269;
	Y1809_gen_type [270] = Y1809_pgtype270;
	Y1809_gen_type [271] = Y1809_pgtype271;
	Y1809_gen_type [272] = Y1809_pgtype272;
	Y1809_gen_type [273] = Y1809_pgtype273;
	Y1809_gen_type [274] = Y1809_pgtype274;
	Y1809_gen_type [275] = Y1809_pgtype275;
	Y1809_gen_type [276] = Y1809_pgtype276;
	Y1809_gen_type [277] = Y1809_pgtype277;
	Y1809_gen_type [278] = Y1809_pgtype278;
	Y1809_gen_type [279] = Y1809_pgtype279;
	Y1809_gen_type [280] = Y1809_pgtype280;
	Y1809_gen_type [281] = Y1809_pgtype281;
	Y1809_gen_type [282] = Y1809_pgtype282;
	Y1809_gen_type [283] = Y1809_pgtype283;
	Y1809_gen_type [284] = Y1809_pgtype284;
	Y1809_gen_type [285] = Y1809_pgtype285;
	Y1809_gen_type [286] = Y1809_pgtype286;
	Y1809_gen_type [287] = Y1809_pgtype287;
	Y1809_gen_type [288] = Y1809_pgtype288;
	Y1809_gen_type [289] = Y1809_pgtype289;
	Y1809_gen_type [290] = Y1809_pgtype290;
	Y1809_gen_type [291] = Y1809_pgtype291;
	Y1809_gen_type [292] = Y1809_pgtype292;
	Y1809_gen_type [293] = Y1809_pgtype293;
	Y1809_gen_type [294] = Y1809_pgtype294;
	Y1809_gen_type [295] = Y1809_pgtype295;
	Y1809_gen_type [296] = Y1809_pgtype296;
	Y1809_gen_type [297] = Y1809_pgtype297;
	Y1809_gen_type [298] = Y1809_pgtype298;
	Y1809_gen_type [299] = Y1809_pgtype299;
	Y1809_gen_type [300] = Y1809_pgtype300;
	Y1809_gen_type [301] = Y1809_pgtype301;
	Y1809_gen_type [302] = Y1809_pgtype302;
	Y1809_gen_type [303] = Y1809_pgtype303;
	Y1809_gen_type [304] = Y1809_pgtype304;
	Y1809_gen_type [305] = Y1809_pgtype305;
	Y1809_gen_type [306] = Y1809_pgtype306;
	Y1809_gen_type [307] = Y1809_pgtype307;
	Y1809_gen_type [308] = Y1809_pgtype308;
	Y1809_gen_type [309] = Y1809_pgtype309;
	Y1809_gen_type [310] = Y1809_pgtype310;
	Y1809_gen_type [311] = Y1809_pgtype311;
	Y1809_gen_type [312] = Y1809_pgtype312;
	Y1809_gen_type [313] = Y1809_pgtype313;
	Y1809_gen_type [314] = Y1809_pgtype314;
	Y1809_gen_type [315] = Y1809_pgtype315;
	Y1809_gen_type [316] = Y1809_pgtype316;
	Y1809_gen_type [317] = Y1809_pgtype317;
	Y1809_gen_type [318] = Y1809_pgtype318;
	Y1809_gen_type [319] = Y1809_pgtype319;
	Y1809_gen_type [320] = Y1809_pgtype320;
	Y1809_gen_type [321] = Y1809_pgtype321;
	Y1809_gen_type [322] = Y1809_pgtype322;
	Y1809_gen_type [323] = Y1809_pgtype323;
	Y1809_gen_type [324] = Y1809_pgtype324;
	Y1809_gen_type [325] = Y1809_pgtype325;
	Y1809_gen_type [326] = Y1809_pgtype326;
	Y1809_gen_type [327] = Y1809_pgtype327;
	Y1809_gen_type [328] = Y1809_pgtype328;
	Y1809_gen_type [329] = Y1809_pgtype329;
	Y1809_gen_type [330] = Y1809_pgtype330;
	Y1809_gen_type [331] = Y1809_pgtype331;
	Y1809_gen_type [332] = Y1809_pgtype332;
	Y1809_gen_type [333] = Y1809_pgtype333;
	Y1809_gen_type [334] = Y1809_pgtype334;
	Y1809_gen_type [335] = Y1809_pgtype335;
	Y1809_gen_type [336] = Y1809_pgtype336;
	Y1809_gen_type [337] = Y1809_pgtype337;
	Y1809_gen_type [338] = Y1809_pgtype338;
	Y1809_gen_type [339] = Y1809_pgtype339;
	Y1809_gen_type [340] = Y1809_pgtype340;
	Y1809_gen_type [341] = Y1809_pgtype341;
	Y1809_gen_type [342] = Y1809_pgtype342;
	Y1809_gen_type [343] = Y1809_pgtype343;
	Y1809_gen_type [344] = Y1809_pgtype344;
	Y1809_gen_type [345] = Y1809_pgtype345;
	Y1809_gen_type [346] = Y1809_pgtype346;
	Y1809_gen_type [347] = Y1809_pgtype347;
	Y1809_gen_type [348] = Y1809_pgtype348;
	Y1809_gen_type [349] = Y1809_pgtype349;
	Y1809_gen_type [350] = Y1809_pgtype350;
	Y1809_gen_type [351] = Y1809_pgtype351;
	Y1809_gen_type [352] = Y1809_pgtype352;
	Y1809_gen_type [353] = Y1809_pgtype353;
	Y1809_gen_type [354] = Y1809_pgtype354;
	Y1809_gen_type [355] = Y1809_pgtype355;
	Y1809_gen_type [356] = Y1809_pgtype356;
	Y1809_gen_type [357] = Y1809_pgtype357;
	Y1809_gen_type [358] = Y1809_pgtype358;
	Y1809_gen_type [359] = Y1809_pgtype359;
	Y1809_gen_type [360] = Y1809_pgtype360;
	Y1809_gen_type [361] = Y1809_pgtype361;
	Y1809_gen_type [362] = Y1809_pgtype362;
	Y1809_gen_type [363] = Y1809_pgtype363;
	Y1809_gen_type [364] = Y1809_pgtype364;
	Y1809_gen_type [365] = Y1809_pgtype365;
	Y1809_gen_type [366] = Y1809_pgtype366;
	Y1809_gen_type [367] = Y1809_pgtype367;
	Y1809_gen_type [368] = Y1809_pgtype368;
	Y1809_gen_type [369] = Y1809_pgtype369;
	Y1809_gen_type [370] = Y1809_pgtype370;
	Y1809_gen_type [371] = Y1809_pgtype371;
	Y1809_gen_type [372] = Y1809_pgtype372;
	Y1809_gen_type [373] = Y1809_pgtype373;
	Y1809_gen_type [374] = Y1809_pgtype374;
	Y1809_gen_type [375] = Y1809_pgtype375;
	Y1809_gen_type [376] = Y1809_pgtype376;
	Y1809_gen_type [377] = Y1809_pgtype377;
	Y1809_gen_type [378] = Y1809_pgtype378;
	Y1809_gen_type [379] = Y1809_pgtype379;
	Y1809_gen_type [380] = Y1809_pgtype380;
	Y1809_gen_type [381] = Y1809_pgtype381;
	Y1809_gen_type [382] = Y1809_pgtype382;
	Y1809_gen_type [383] = Y1809_pgtype383;
	Y1809_gen_type [384] = Y1809_pgtype384;
	Y1809_gen_type [385] = Y1809_pgtype385;
	Y1809_gen_type [386] = Y1809_pgtype386;
	Y1809_gen_type [387] = Y1809_pgtype387;
	Y1809_gen_type [388] = Y1809_pgtype388;
	Y1809_gen_type [389] = Y1809_pgtype389;
	Y1809_gen_type [390] = Y1809_pgtype390;
	Y1809_gen_type [391] = Y1809_pgtype391;
	Y1809_gen_type [392] = Y1809_pgtype392;
	Y1809_gen_type [393] = Y1809_pgtype393;
	Y1809_gen_type [394] = Y1809_pgtype394;
	Y1809_gen_type [395] = Y1809_pgtype395;
	Y1809_gen_type [396] = Y1809_pgtype396;
	Y1809_gen_type [397] = Y1809_pgtype397;
	Y1809_gen_type [398] = Y1809_pgtype398;
	Y1809_gen_type [399] = Y1809_pgtype399;
	Y1809_gen_type [400] = Y1809_pgtype400;
	Y1809_gen_type [401] = Y1809_pgtype401;
	Y1809_gen_type [402] = Y1809_pgtype402;
	Y1809_gen_type [403] = Y1809_pgtype403;
	Y1809_gen_type [404] = Y1809_pgtype404;
	Y1809_gen_type [405] = Y1809_pgtype405;
	Y1809_gen_type [406] = Y1809_pgtype406;
	Y1809_gen_type [407] = Y1809_pgtype407;
	Y1809_gen_type [408] = Y1809_pgtype408;
	Y1809_gen_type [409] = Y1809_pgtype409;
	Y1809_gen_type [410] = Y1809_pgtype410;
	Y1809_gen_type [411] = Y1809_pgtype411;
	Y1809_gen_type [412] = Y1809_pgtype412;
	Y1809_gen_type [413] = Y1809_pgtype413;
	Y1809_gen_type [414] = Y1809_pgtype414;
	Y1809_gen_type [415] = Y1809_pgtype415;
	Y1809_gen_type [416] = Y1809_pgtype416;
	Y1809_gen_type [417] = Y1809_pgtype417;
	Y1809_gen_type [418] = Y1809_pgtype418;
	Y1809_gen_type [419] = Y1809_pgtype419;
	Y1809_gen_type [420] = Y1809_pgtype420;
	Y1809_gen_type [421] = Y1809_pgtype421;
	Y1809_gen_type [422] = Y1809_pgtype422;
	Y1809_gen_type [423] = Y1809_pgtype423;
	Y1809_gen_type [424] = Y1809_pgtype424;
	Y1809_gen_type [425] = Y1809_pgtype425;
	Y1809_gen_type [426] = Y1809_pgtype426;
	Y1809_gen_type [427] = Y1809_pgtype427;
	Y1809_gen_type [428] = Y1809_pgtype428;
	Y1809_gen_type [429] = Y1809_pgtype429;
	Y1809_gen_type [430] = Y1809_pgtype430;
	Y1809_gen_type [431] = Y1809_pgtype431;
	Y1809_gen_type [432] = Y1809_pgtype432;
	Y1809_gen_type [433] = Y1809_pgtype433;
	Y1809_gen_type [434] = Y1809_pgtype434;
	Y1809_gen_type [436] = Y1809_pgtype435;
	Y1809_gen_type [437] = Y1809_pgtype436;
	Y1809_gen_type [438] = Y1809_pgtype437;
	Y1809_gen_type [439] = Y1809_pgtype438;
	Y1809_gen_type [440] = Y1809_pgtype439;
	Y1809_gen_type [441] = Y1809_pgtype440;
	Y1809_gen_type [442] = Y1809_pgtype441;
	Y1809_gen_type [443] = Y1809_pgtype442;
	Y1809_gen_type [444] = Y1809_pgtype443;
	Y1809_gen_type [445] = Y1809_pgtype444;
	Y1809_gen_type [446] = Y1809_pgtype445;
	Y1809_gen_type [447] = Y1809_pgtype446;
	Y1809_gen_type [448] = Y1809_pgtype447;
	Y1809_gen_type [449] = Y1809_pgtype448;
	Y1809_gen_type [451] = Y1809_pgtype449;
	Y1809_gen_type [452] = Y1809_pgtype450;
	Y1809_gen_type [453] = Y1809_pgtype451;
	Y1809_gen_type [454] = Y1809_pgtype452;
	Y1809_gen_type [455] = Y1809_pgtype453;
	Y1809_gen_type [456] = Y1809_pgtype454;
	Y1809_gen_type [457] = Y1809_pgtype455;
	Y1809_gen_type [462] = Y1809_pgtype456;
	Y1809_gen_type [463] = Y1809_pgtype457;
	Y1809_gen_type [464] = Y1809_pgtype458;
	Y1809_gen_type [465] = Y1809_pgtype459;
	Y1809_gen_type [466] = Y1809_pgtype460;
	Y1809_gen_type [467] = Y1809_pgtype461;
	Y1809_gen_type [468] = Y1809_pgtype462;
	Y1809_gen_type [469] = Y1809_pgtype463;
	Y1809_gen_type [470] = Y1809_pgtype464;
	Y1809_gen_type [471] = Y1809_pgtype465;
	Y1809_gen_type [472] = Y1809_pgtype466;
	Y1809_gen_type [473] = Y1809_pgtype467;
	Y1809_gen_type [474] = Y1809_pgtype468;
	Y1809_gen_type [555] = Y1809_pgtype469;
	Y1809_gen_type [636] = Y1809_pgtype470;
	Y1809_gen_type [637] = Y1809_pgtype471;
	Y1809_gen_type [638] = Y1809_pgtype472;
	Y1809_gen_type [639] = Y1809_pgtype473;
	Y1809_gen_type [640] = Y1809_pgtype474;
	Y1809_gen_type [641] = Y1809_pgtype475;
	Y1809_gen_type [642] = Y1809_pgtype476;
	Y1809[13] = 818;
	Y1809[14] = 816;
	Y1809[15] = 766;
	Y1809[91] = 769;
	Y1809[92] = 766;
	Y1809[270] = 739;
	{long i; for (i = 338; i < 341; i++) Y1809[i] = 769;};
	Y1809[367] = 739;
	Y1809[457] = 0;
	Y1809[555] = 0;
	{long i; for (i = 636; i < 639; i++) Y1809[i] = 769;};
	{long i; for (i = 639; i < 642; i++) Y1809[i] = 766;};
	Y1809[642] = 769;
}

char *(*R1871[4])();
void R1871_init () {
	{long i; for (i = 0; i < 2; i++) R1871[i] = (char *(*)()) F225_2083;}
	{long i; for (i = 2; i < 4; i++) R1871[i] = (char *(*)()) F226_2083;}
}

char *(*R1874[4])();
void R1874_init () {
	{long i; for (i = 0; i < 2; i++) R1874[i] = (char *(*)()) F225_2088;}
	{long i; for (i = 2; i < 4; i++) R1874[i] = (char *(*)()) F226_2088;}
}

char *(*R1877[4])();
void R1877_init () {
	{long i; for (i = 0; i < 2; i++) R1877[i] = (char *(*)()) F225_2070;}
	{long i; for (i = 2; i < 4; i++) R1877[i] = (char *(*)()) F226_2070;}
}

char *(*R1908[373])();
void R1908_init () {
	R1908[0] = (char *(*)()) F299_2156;
	R1908[98] = (char *(*)()) F298_2156;
	R1908[99] = (char *(*)()) F299_2156;
	R1908[100] = (char *(*)()) F302_2156;
	R1908[101] = (char *(*)()) F303_2156;
	R1908[102] = (char *(*)()) F304_2156;
	R1908[103] = (char *(*)()) F305_2156;
	R1908[104] = (char *(*)()) F301_2156;
	R1908[105] = (char *(*)()) F306_2156;
	R1908[106] = (char *(*)()) F300_2156;
	R1908[107] = (char *(*)()) F307_2156;
	R1908[108] = (char *(*)()) F308_2156;
	R1908[109] = (char *(*)()) F309_2156;
	R1908[110] = (char *(*)()) F310_2156;
	{long i; for (i = 181; i < 183; i++) R1908[i] = (char *(*)()) F298_2156;}
	{long i; for (i = 183; i < 185; i++) R1908[i] = (char *(*)()) F299_2156;}
	R1908[185] = (char *(*)()) F298_2156;
	R1908[186] = (char *(*)()) F299_2156;
	R1908[187] = (char *(*)()) F298_2156;
	R1908[368] = (char *(*)()) F301_2156;
	R1908[371] = (char *(*)()) F300_2156;
	R1908[372] = (char *(*)()) F301_2156;
}

char *(*R1941[274])();
void R1941_init () {
	R1941[0] = (char *(*)()) F547_2676_1941_5;
	R1941[1] = (char *(*)()) F548_2676_1941_5;
	R1941[2] = (char *(*)()) F549_2676_1941_5;
	R1941[3] = (char *(*)()) F550_2676_1941_5;
	R1941[4] = (char *(*)()) F551_2676_1941_5;
	R1941[5] = (char *(*)()) F552_2676_1941_5;
	R1941[6] = (char *(*)()) F553_2676_1941_5;
	R1941[7] = (char *(*)()) F554_2676_1941_5;
	R1941[8] = (char *(*)()) F555_2676_1941_5;
	R1941[9] = (char *(*)()) F556_2676_1941_5;
	R1941[10] = (char *(*)()) F557_2676_1941_5;
	R1941[11] = (char *(*)()) F558_2676_1941_5;
	R1941[12] = (char *(*)()) F559_2676_1941_5;
	R1941[273] = (char *(*)()) F820_4997_1941_5;
}
static EIF_REFERENCE F547_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F547_2676(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_REFERENCE F548_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F548_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F549_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F549_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(760, 0x00).id, 760, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F550_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F550_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(763, 0x00).id, 763, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F551_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F551_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(754, 0x00).id, 754, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F552_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F552_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(757, 0x00).id, 757, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F553_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F553_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F554_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F554_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(772, 0x00).id, 772, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F555_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F555_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F556_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F556_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F557_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F557_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(805, 0x00).id, 805, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F558_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F558_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(751, 0x00).id, 751, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F559_2676_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F559_2676(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F820_4997_1941_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F820_4997(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R1944[271])();
void R1944_init () {
	R1944[0] = (char *(*)()) F547_2695_1944_8;
	R1944[1] = (char *(*)()) F548_2695_1944_8;
	R1944[2] = (char *(*)()) F549_2695_1944_8;
	R1944[3] = (char *(*)()) F550_2695_1944_8;
	R1944[4] = (char *(*)()) F551_2695_1944_8;
	R1944[5] = (char *(*)()) F552_2695_1944_8;
	R1944[6] = (char *(*)()) F553_2695_1944_8;
	R1944[7] = (char *(*)()) F554_2695_1944_8;
	R1944[8] = (char *(*)()) F555_2695_1944_8;
	R1944[9] = (char *(*)()) F556_2695_1944_8;
	R1944[10] = (char *(*)()) F557_2695_1944_8;
	R1944[11] = (char *(*)()) F558_2695_1944_8;
	R1944[12] = (char *(*)()) F559_2695_1944_8;
	R1944[83] = (char *(*)()) F630_2989;
	R1944[84] = (char *(*)()) F631_2989_1944_8;
	R1944[85] = (char *(*)()) F632_2989_1944_8;
	R1944[86] = (char *(*)()) F633_2989_1944_8;
	R1944[87] = (char *(*)()) F630_2989;
	R1944[88] = (char *(*)()) F632_2989_1944_8;
	R1944[89] = (char *(*)()) F630_2989;
	R1944[270] = (char *(*)()) F817_4849_1944_8;
}
static void F547_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F547_2695(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F548_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F548_2695(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F549_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F549_2695(Current, *(EIF_REAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F550_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F550_2695(Current, *(EIF_REAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F551_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F551_2695(Current, *(EIF_NATURAL_16 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F552_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F552_2695(Current, *(EIF_NATURAL_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F553_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F553_2695(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F554_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F554_2695(Current, *(EIF_BOOLEAN *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F555_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F555_2695(Current, *(EIF_CHARACTER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F556_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F556_2695(Current, *(EIF_NATURAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F557_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F557_2695(Current, *(EIF_POINTER *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F558_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F558_2695(Current, *(EIF_NATURAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F559_2695_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F559_2695(Current, *(EIF_INTEGER_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F631_2989_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F631_2989(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F632_2989_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F632_2989(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F633_2989_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F633_2989(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F817_4849_1944_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F817_4849(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

static EIF_TYPE_INDEX Y1946_pgtype0[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype1[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype2[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype3[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype4[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype5[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype6[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype7[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype8[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype9[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype10[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype11[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype12[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype13[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype14[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype15[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype16[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype17[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype18[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype19[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype20[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype21[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype22[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype23[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype24[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype25[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype26[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype27[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype28[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype29[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype30[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype31[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype32[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype33[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype34[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype35[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype36[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype37[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype38[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype39[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype40[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype41[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype42[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype43[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype44[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype45[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype46[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype47[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype48[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype49[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype50[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype51[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype52[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype53[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype54[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype55[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype56[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype57[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype58[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype59[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype60[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype61[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype62[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype63[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype64[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype65[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype66[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype67[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype68[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype69[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype70[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype71[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype72[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype73[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype74[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype75[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype76[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype77[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype78[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype79[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype80[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype81[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype82[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype83[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype84[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype85[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype86[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype87[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype88[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype89[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype90[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype91[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype92[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype93[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype94[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype95[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype96[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype97[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype98[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype99[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype100[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype101[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype102[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype103[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype104[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype105[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype106[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype107[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype108[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype109[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype110[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype111[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype112[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype113[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype114[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype115[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype116[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype117[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype118[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype119[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype120[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype121[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype122[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype123[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype124[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype125[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype126[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype127[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype128[] = {0xFF01,811,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype129[] = {0xFF01,811,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype130[] = {0xFF01,816,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype131[] = {739,0xFFFF};
static EIF_TYPE_INDEX Y1946_pgtype132[] = {739,0xFFFF};
EIF_TYPE_INDEX *Y1946_gen_type [444];
EIF_TYPE_INDEX Y1946 [444];
void Y1946_init (void)
{
	egc_routines_types [1946] = Y1946;
	egc_routines_gen_types [1946] = Y1946_gen_type;
	egc_routines_offset [1946] = 376;
	Y1946_gen_type [0] = Y1946_pgtype0;
	Y1946_gen_type [1] = Y1946_pgtype1;
	Y1946_gen_type [2] = Y1946_pgtype2;
	Y1946_gen_type [3] = Y1946_pgtype3;
	Y1946_gen_type [4] = Y1946_pgtype4;
	Y1946_gen_type [5] = Y1946_pgtype5;
	Y1946_gen_type [6] = Y1946_pgtype6;
	Y1946_gen_type [7] = Y1946_pgtype7;
	Y1946_gen_type [8] = Y1946_pgtype8;
	Y1946_gen_type [9] = Y1946_pgtype9;
	Y1946_gen_type [10] = Y1946_pgtype10;
	Y1946_gen_type [11] = Y1946_pgtype11;
	Y1946_gen_type [12] = Y1946_pgtype12;
	Y1946_gen_type [13] = Y1946_pgtype13;
	Y1946_gen_type [14] = Y1946_pgtype14;
	Y1946_gen_type [15] = Y1946_pgtype15;
	Y1946_gen_type [16] = Y1946_pgtype16;
	Y1946_gen_type [17] = Y1946_pgtype17;
	Y1946_gen_type [18] = Y1946_pgtype18;
	Y1946_gen_type [19] = Y1946_pgtype19;
	Y1946_gen_type [20] = Y1946_pgtype20;
	Y1946_gen_type [21] = Y1946_pgtype21;
	Y1946_gen_type [22] = Y1946_pgtype22;
	Y1946_gen_type [23] = Y1946_pgtype23;
	Y1946_gen_type [24] = Y1946_pgtype24;
	Y1946_gen_type [25] = Y1946_pgtype25;
	Y1946_gen_type [26] = Y1946_pgtype26;
	Y1946_gen_type [27] = Y1946_pgtype27;
	Y1946_gen_type [28] = Y1946_pgtype28;
	Y1946_gen_type [29] = Y1946_pgtype29;
	Y1946_gen_type [156] = Y1946_pgtype30;
	Y1946_gen_type [157] = Y1946_pgtype31;
	Y1946_gen_type [158] = Y1946_pgtype32;
	Y1946_gen_type [159] = Y1946_pgtype33;
	Y1946_gen_type [160] = Y1946_pgtype34;
	Y1946_gen_type [161] = Y1946_pgtype35;
	Y1946_gen_type [162] = Y1946_pgtype36;
	Y1946_gen_type [163] = Y1946_pgtype37;
	Y1946_gen_type [164] = Y1946_pgtype38;
	Y1946_gen_type [165] = Y1946_pgtype39;
	Y1946_gen_type [166] = Y1946_pgtype40;
	Y1946_gen_type [167] = Y1946_pgtype41;
	Y1946_gen_type [168] = Y1946_pgtype42;
	Y1946_gen_type [169] = Y1946_pgtype43;
	Y1946_gen_type [170] = Y1946_pgtype44;
	Y1946_gen_type [171] = Y1946_pgtype45;
	Y1946_gen_type [172] = Y1946_pgtype46;
	Y1946_gen_type [173] = Y1946_pgtype47;
	Y1946_gen_type [174] = Y1946_pgtype48;
	Y1946_gen_type [175] = Y1946_pgtype49;
	Y1946_gen_type [176] = Y1946_pgtype50;
	Y1946_gen_type [177] = Y1946_pgtype51;
	Y1946_gen_type [178] = Y1946_pgtype52;
	Y1946_gen_type [179] = Y1946_pgtype53;
	Y1946_gen_type [180] = Y1946_pgtype54;
	Y1946_gen_type [181] = Y1946_pgtype55;
	Y1946_gen_type [182] = Y1946_pgtype56;
	Y1946_gen_type [183] = Y1946_pgtype57;
	Y1946_gen_type [184] = Y1946_pgtype58;
	Y1946_gen_type [185] = Y1946_pgtype59;
	Y1946_gen_type [186] = Y1946_pgtype60;
	Y1946_gen_type [187] = Y1946_pgtype61;
	Y1946_gen_type [188] = Y1946_pgtype62;
	Y1946_gen_type [189] = Y1946_pgtype63;
	Y1946_gen_type [190] = Y1946_pgtype64;
	Y1946_gen_type [191] = Y1946_pgtype65;
	Y1946_gen_type [192] = Y1946_pgtype66;
	Y1946_gen_type [193] = Y1946_pgtype67;
	Y1946_gen_type [194] = Y1946_pgtype68;
	Y1946_gen_type [195] = Y1946_pgtype69;
	Y1946_gen_type [196] = Y1946_pgtype70;
	Y1946_gen_type [197] = Y1946_pgtype71;
	Y1946_gen_type [198] = Y1946_pgtype72;
	Y1946_gen_type [199] = Y1946_pgtype73;
	Y1946_gen_type [200] = Y1946_pgtype74;
	Y1946_gen_type [201] = Y1946_pgtype75;
	Y1946_gen_type [202] = Y1946_pgtype76;
	Y1946_gen_type [203] = Y1946_pgtype77;
	Y1946_gen_type [204] = Y1946_pgtype78;
	Y1946_gen_type [205] = Y1946_pgtype79;
	Y1946_gen_type [206] = Y1946_pgtype80;
	Y1946_gen_type [207] = Y1946_pgtype81;
	Y1946_gen_type [208] = Y1946_pgtype82;
	Y1946_gen_type [209] = Y1946_pgtype83;
	Y1946_gen_type [210] = Y1946_pgtype84;
	Y1946_gen_type [211] = Y1946_pgtype85;
	Y1946_gen_type [212] = Y1946_pgtype86;
	Y1946_gen_type [213] = Y1946_pgtype87;
	Y1946_gen_type [214] = Y1946_pgtype88;
	Y1946_gen_type [215] = Y1946_pgtype89;
	Y1946_gen_type [216] = Y1946_pgtype90;
	Y1946_gen_type [217] = Y1946_pgtype91;
	Y1946_gen_type [218] = Y1946_pgtype92;
	Y1946_gen_type [219] = Y1946_pgtype93;
	Y1946_gen_type [220] = Y1946_pgtype94;
	Y1946_gen_type [221] = Y1946_pgtype95;
	Y1946_gen_type [222] = Y1946_pgtype96;
	Y1946_gen_type [223] = Y1946_pgtype97;
	Y1946_gen_type [224] = Y1946_pgtype98;
	Y1946_gen_type [225] = Y1946_pgtype99;
	Y1946_gen_type [226] = Y1946_pgtype100;
	Y1946_gen_type [227] = Y1946_pgtype101;
	Y1946_gen_type [228] = Y1946_pgtype102;
	Y1946_gen_type [229] = Y1946_pgtype103;
	Y1946_gen_type [230] = Y1946_pgtype104;
	Y1946_gen_type [231] = Y1946_pgtype105;
	Y1946_gen_type [232] = Y1946_pgtype106;
	Y1946_gen_type [233] = Y1946_pgtype107;
	Y1946_gen_type [234] = Y1946_pgtype108;
	Y1946_gen_type [235] = Y1946_pgtype109;
	Y1946_gen_type [236] = Y1946_pgtype110;
	Y1946_gen_type [239] = Y1946_pgtype111;
	Y1946_gen_type [240] = Y1946_pgtype112;
	Y1946_gen_type [241] = Y1946_pgtype113;
	Y1946_gen_type [242] = Y1946_pgtype114;
	Y1946_gen_type [243] = Y1946_pgtype115;
	Y1946_gen_type [244] = Y1946_pgtype116;
	Y1946_gen_type [245] = Y1946_pgtype117;
	Y1946_gen_type [246] = Y1946_pgtype118;
	Y1946_gen_type [247] = Y1946_pgtype119;
	Y1946_gen_type [248] = Y1946_pgtype120;
	Y1946_gen_type [249] = Y1946_pgtype121;
	Y1946_gen_type [250] = Y1946_pgtype122;
	Y1946_gen_type [251] = Y1946_pgtype123;
	Y1946_gen_type [253] = Y1946_pgtype124;
	Y1946_gen_type [254] = Y1946_pgtype125;
	Y1946_gen_type [255] = Y1946_pgtype126;
	Y1946_gen_type [256] = Y1946_pgtype127;
	Y1946_gen_type [257] = Y1946_pgtype128;
	Y1946_gen_type [258] = Y1946_pgtype129;
	Y1946_gen_type [259] = Y1946_pgtype130;
	Y1946_gen_type [440] = Y1946_pgtype131;
	Y1946_gen_type [443] = Y1946_pgtype132;
	{long i; for (i = 156; i < 237; i++) Y1946[i] = 739;};
	{long i; for (i = 239; i < 252; i++) Y1946[i] = 739;};
	{long i; for (i = 257; i < 259; i++) Y1946[i] = 811;};
	Y1946[259] = 816;
	Y1946[440] = 739;
	Y1946[443] = 739;
}

char *(*R1968[275])();
void R1968_init () {
	R1968[0] = (char *(*)()) F547_2683;
	R1968[1] = (char *(*)()) F548_2683;
	R1968[2] = (char *(*)()) F549_2683;
	R1968[3] = (char *(*)()) F550_2683;
	R1968[4] = (char *(*)()) F551_2683;
	R1968[5] = (char *(*)()) F552_2683;
	R1968[6] = (char *(*)()) F553_2683;
	R1968[7] = (char *(*)()) F554_2683;
	R1968[8] = (char *(*)()) F555_2683;
	R1968[9] = (char *(*)()) F556_2683;
	R1968[10] = (char *(*)()) F557_2683;
	R1968[11] = (char *(*)()) F558_2683;
	R1968[12] = (char *(*)()) F559_2683;
	R1968[83] = (char *(*)()) F630_2961;
	R1968[84] = (char *(*)()) F631_2961;
	R1968[85] = (char *(*)()) F632_2961;
	R1968[86] = (char *(*)()) F633_2961;
	R1968[87] = (char *(*)()) F630_2961;
	R1968[88] = (char *(*)()) F632_2961;
	R1968[89] = (char *(*)()) F630_2961;
	R1968[270] = (char *(*)()) F815_4771;
	R1968[273] = (char *(*)()) F818_4936;
	R1968[274] = (char *(*)()) F821_5089;
}

char *(*R1971[274])();
void R1971_init () {
	R1971[0] = (char *(*)()) F547_2684;
	R1971[1] = (char *(*)()) F548_2684;
	R1971[2] = (char *(*)()) F549_2684;
	R1971[3] = (char *(*)()) F550_2684;
	R1971[4] = (char *(*)()) F551_2684;
	R1971[5] = (char *(*)()) F552_2684;
	R1971[6] = (char *(*)()) F553_2684;
	R1971[7] = (char *(*)()) F554_2684;
	R1971[8] = (char *(*)()) F555_2684;
	R1971[9] = (char *(*)()) F556_2684;
	R1971[10] = (char *(*)()) F557_2684;
	R1971[11] = (char *(*)()) F558_2684;
	R1971[12] = (char *(*)()) F559_2684;
	R1971[270] = (char *(*)()) F815_4770;
	R1971[273] = (char *(*)()) F818_4935;
}

char *(*R2178[274])();
void R2178_init () {
	R2178[0] = (char *(*)()) F547_2676;
	R2178[1] = (char *(*)()) F548_2676_2178_33;
	R2178[2] = (char *(*)()) F549_2676_2178_33;
	R2178[3] = (char *(*)()) F550_2676_2178_33;
	R2178[4] = (char *(*)()) F551_2676_2178_33;
	R2178[5] = (char *(*)()) F552_2676_2178_33;
	R2178[6] = (char *(*)()) F553_2676_2178_33;
	R2178[7] = (char *(*)()) F554_2676_2178_33;
	R2178[8] = (char *(*)()) F555_2676_2178_33;
	R2178[9] = (char *(*)()) F556_2676_2178_33;
	R2178[10] = (char *(*)()) F557_2676_2178_33;
	R2178[11] = (char *(*)()) F558_2676_2178_33;
	R2178[12] = (char *(*)()) F559_2676_2178_33;
	R2178[94] = (char *(*)()) F641_3175;
	R2178[95] = (char *(*)()) F642_3175_2178_33;
	R2178[96] = (char *(*)()) F643_3175_2178_33;
	R2178[97] = (char *(*)()) F644_3175_2178_33;
	R2178[98] = (char *(*)()) F645_3175_2178_33;
	R2178[99] = (char *(*)()) F646_3175_2178_33;
	R2178[100] = (char *(*)()) F647_3175_2178_33;
	R2178[101] = (char *(*)()) F648_3175_2178_33;
	R2178[102] = (char *(*)()) F649_3175_2178_33;
	R2178[103] = (char *(*)()) F650_3175_2178_33;
	R2178[104] = (char *(*)()) F651_3175_2178_33;
	R2178[105] = (char *(*)()) F652_3175_2178_33;
	R2178[106] = (char *(*)()) F653_3175_2178_33;
	R2178[187] = (char *(*)()) F734_3386;
	R2178[272] = (char *(*)()) F819_4974_2178_33;
	R2178[273] = (char *(*)()) F820_4997_2178_33;
}
static EIF_REFERENCE F548_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F548_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F549_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F549_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(760, 0x00).id, 760, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F550_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F550_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(763, 0x00).id, 763, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F551_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F551_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(754, 0x00).id, 754, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F552_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F552_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(757, 0x00).id, 757, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F553_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F553_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F554_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F554_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(772, 0x00).id, 772, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F555_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F555_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F556_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F556_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F557_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F557_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(805, 0x00).id, 805, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F558_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F558_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(751, 0x00).id, 751, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F559_2676_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F559_2676(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F642_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F642_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F643_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F643_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(760, 0x00).id, 760, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F644_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F644_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(763, 0x00).id, 763, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F645_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F645_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(754, 0x00).id, 754, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F646_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F646_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(757, 0x00).id, 757, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F647_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F647_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F648_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F648_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(772, 0x00).id, 772, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F649_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F649_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F650_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F650_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F651_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F651_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(805, 0x00).id, 805, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F652_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F652_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(751, 0x00).id, 751, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F653_3175_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F653_3175(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F819_4974_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F819_4974(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F820_4997_2178_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F820_4997(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R2179[274])();
void R2179_init () {
	R2179[0] = (char *(*)()) F547_2681;
	R2179[1] = (char *(*)()) F548_2681;
	R2179[2] = (char *(*)()) F549_2681;
	R2179[3] = (char *(*)()) F550_2681;
	R2179[4] = (char *(*)()) F551_2681;
	R2179[5] = (char *(*)()) F552_2681;
	R2179[6] = (char *(*)()) F553_2681;
	R2179[7] = (char *(*)()) F554_2681;
	R2179[8] = (char *(*)()) F555_2681;
	R2179[9] = (char *(*)()) F556_2681;
	R2179[10] = (char *(*)()) F557_2681;
	R2179[11] = (char *(*)()) F558_2681;
	R2179[12] = (char *(*)()) F559_2681;
	R2179[83] = (char *(*)()) F630_2964;
	R2179[84] = (char *(*)()) F631_2964;
	R2179[85] = (char *(*)()) F632_2964;
	R2179[86] = (char *(*)()) F633_2964;
	R2179[87] = (char *(*)()) F630_2964;
	R2179[88] = (char *(*)()) F632_2964;
	R2179[89] = (char *(*)()) F630_2964;
	R2179[94] = (char *(*)()) F641_3183;
	R2179[95] = (char *(*)()) F642_3183;
	R2179[96] = (char *(*)()) F643_3183;
	R2179[97] = (char *(*)()) F644_3183;
	R2179[98] = (char *(*)()) F645_3183;
	R2179[99] = (char *(*)()) F646_3183;
	R2179[100] = (char *(*)()) F647_3183;
	R2179[101] = (char *(*)()) F648_3183;
	R2179[102] = (char *(*)()) F649_3183;
	R2179[103] = (char *(*)()) F650_3183;
	R2179[104] = (char *(*)()) F651_3183;
	R2179[105] = (char *(*)()) F652_3183;
	R2179[106] = (char *(*)()) F653_3183;
	R2179[187] = (char *(*)()) F734_3416;
	{long i; for (i = 269; i < 271; i++) R2179[i] = (char *(*)()) F815_4773;}
	{long i; for (i = 272; i < 274; i++) R2179[i] = (char *(*)()) F818_4938;}
}

EIF_TYPE_INDEX *Y2179_gen_type [301];
EIF_TYPE_INDEX Y2179 [301];
void Y2179_init (void)
{
	egc_routines_types [2179] = Y2179;
	egc_routines_gen_types [2179] = Y2179_gen_type;
	egc_routines_offset [2179] = 519;
	{long i; for (i = 0; i < 94; i++) Y2179[i] = 739;};
	{long i; for (i = 96; i < 109; i++) Y2179[i] = 739;};
	{long i; for (i = 110; i < 117; i++) Y2179[i] = 739;};
	{long i; for (i = 121; i < 134; i++) Y2179[i] = 739;};
	Y2179[214] = 739;
	{long i; for (i = 295; i < 301; i++) Y2179[i] = 739;};
}

char *(*R2180[274])();
void R2180_init () {
	R2180[0] = (char *(*)()) F547_2682;
	R2180[1] = (char *(*)()) F548_2682;
	R2180[2] = (char *(*)()) F549_2682;
	R2180[3] = (char *(*)()) F550_2682;
	R2180[4] = (char *(*)()) F551_2682;
	R2180[5] = (char *(*)()) F552_2682;
	R2180[6] = (char *(*)()) F553_2682;
	R2180[7] = (char *(*)()) F554_2682;
	R2180[8] = (char *(*)()) F555_2682;
	R2180[9] = (char *(*)()) F556_2682;
	R2180[10] = (char *(*)()) F557_2682;
	R2180[11] = (char *(*)()) F558_2682;
	R2180[12] = (char *(*)()) F559_2682;
	R2180[83] = (char *(*)()) F630_2965;
	R2180[84] = (char *(*)()) F631_2965;
	R2180[85] = (char *(*)()) F632_2965;
	R2180[86] = (char *(*)()) F633_2965;
	R2180[87] = (char *(*)()) F630_2965;
	R2180[88] = (char *(*)()) F632_2965;
	R2180[89] = (char *(*)()) F630_2965;
	R2180[94] = (char *(*)()) F641_3184;
	R2180[95] = (char *(*)()) F642_3184;
	R2180[96] = (char *(*)()) F643_3184;
	R2180[97] = (char *(*)()) F644_3184;
	R2180[98] = (char *(*)()) F645_3184;
	R2180[99] = (char *(*)()) F646_3184;
	R2180[100] = (char *(*)()) F647_3184;
	R2180[101] = (char *(*)()) F648_3184;
	R2180[102] = (char *(*)()) F649_3184;
	R2180[103] = (char *(*)()) F650_3184;
	R2180[104] = (char *(*)()) F651_3184;
	R2180[105] = (char *(*)()) F652_3184;
	R2180[106] = (char *(*)()) F653_3184;
	R2180[187] = (char *(*)()) F734_3415;
	{long i; for (i = 269; i < 271; i++) R2180[i] = (char *(*)()) F815_4771;}
	{long i; for (i = 272; i < 274; i++) R2180[i] = (char *(*)()) F818_4936;}
}

char *(*R2206[13])();
void R2206_init () {
	R2206[0] = (char *(*)()) F547_2674;
	R2206[1] = (char *(*)()) F548_2674;
	R2206[2] = (char *(*)()) F549_2674;
	R2206[3] = (char *(*)()) F550_2674;
	R2206[4] = (char *(*)()) F551_2674;
	R2206[5] = (char *(*)()) F552_2674;
	R2206[6] = (char *(*)()) F553_2674;
	R2206[7] = (char *(*)()) F554_2674;
	R2206[8] = (char *(*)()) F555_2674;
	R2206[9] = (char *(*)()) F556_2674;
	R2206[10] = (char *(*)()) F557_2674;
	R2206[11] = (char *(*)()) F558_2674;
	R2206[12] = (char *(*)()) F559_2674;
}

char *(*R2271[191])();
void R2271_init () {
	R2271[0] = (char *(*)()) F630_3002;
	R2271[1] = (char *(*)()) F631_3002;
	R2271[2] = (char *(*)()) F632_3002;
	R2271[3] = (char *(*)()) F633_3002;
	R2271[4] = (char *(*)()) F630_3002;
	R2271[5] = (char *(*)()) F632_3002;
	R2271[6] = (char *(*)()) F630_3002;
	R2271[104] = (char *(*)()) F734_3494;
	R2271[187] = (char *(*)()) F817_4912;
	R2271[189] = (char *(*)()) F819_4990;
	R2271[190] = (char *(*)()) F820_5081;
}

char *(*R2308[7])();
void R2308_init () {
	R2308[0] = (char *(*)()) F630_2943;
	R2308[1] = (char *(*)()) F631_2943;
	R2308[2] = (char *(*)()) F632_2943;
	R2308[3] = (char *(*)()) F633_2943;
	R2308[4] = (char *(*)()) F630_2943;
	R2308[5] = (char *(*)()) F632_2943;
	R2308[6] = (char *(*)()) F630_2943;
}

char *(*R2311[7])();
void R2311_init () {
	R2311[0] = (char *(*)()) F630_2946;
	R2311[1] = (char *(*)()) F631_2946;
	R2311[2] = (char *(*)()) F632_2946;
	R2311[3] = (char *(*)()) F633_2946;
	R2311[4] = (char *(*)()) F630_2946;
	R2311[5] = (char *(*)()) F632_2946;
	R2311[6] = (char *(*)()) F630_2946;
}

char *(*R2312[7])();
void R2312_init () {
	R2312[0] = (char *(*)()) F630_2947;
	R2312[1] = (char *(*)()) F631_2947;
	R2312[2] = (char *(*)()) F632_2947_2312_1;
	R2312[3] = (char *(*)()) F633_2947_2312_1;
	R2312[4] = (char *(*)()) F630_2947;
	R2312[5] = (char *(*)()) F632_2947_2312_1;
	R2312[6] = (char *(*)()) F630_2947;
}
static EIF_REFERENCE F632_2947_2312_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F632_2947(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F633_2947_2312_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F633_2947(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2320[7])();
void R2320_init () {
	R2320[0] = (char *(*)()) F630_2960;
	R2320[1] = (char *(*)()) F631_2960_2320_10;
	R2320[2] = (char *(*)()) F632_2960;
	R2320[3] = (char *(*)()) F633_2960_2320_10;
	R2320[4] = (char *(*)()) F634_3057;
	R2320[5] = (char *(*)()) F635_3057;
	R2320[6] = (char *(*)()) F630_2960;
}
static EIF_INTEGER_32 F631_2960_2320_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F631_2960(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_INTEGER_32 F633_2960_2320_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F633_2960(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2322[7])();
void R2322_init () {
	R2322[0] = (char *(*)()) F630_2967;
	R2322[1] = (char *(*)()) F631_2967_2322_3;
	R2322[2] = (char *(*)()) F632_2967;
	R2322[3] = (char *(*)()) F633_2967_2322_3;
	R2322[4] = (char *(*)()) F634_3059;
	R2322[5] = (char *(*)()) F635_3059;
	R2322[6] = (char *(*)()) F630_2967;
}
static EIF_BOOLEAN F631_2967_2322_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F631_2967(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static EIF_BOOLEAN F633_2967_2322_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F633_2967(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

char *(*R2328[7])();
void R2328_init () {
	R2328[0] = (char *(*)()) F630_2975;
	R2328[1] = (char *(*)()) F631_2975;
	R2328[2] = (char *(*)()) F632_2975;
	R2328[3] = (char *(*)()) F633_2975;
	R2328[4] = (char *(*)()) F630_2975;
	R2328[5] = (char *(*)()) F632_2975;
	R2328[6] = (char *(*)()) F630_2975;
}

char *(*R2329[7])();
void R2329_init () {
	R2329[0] = (char *(*)()) F630_2976;
	R2329[1] = (char *(*)()) F631_2976;
	R2329[2] = (char *(*)()) F632_2976;
	R2329[3] = (char *(*)()) F633_2976;
	R2329[4] = (char *(*)()) F630_2976;
	R2329[5] = (char *(*)()) F632_2976;
	R2329[6] = (char *(*)()) F630_2976;
}

char *(*R2337[7])();
void R2337_init () {
	R2337[0] = (char *(*)()) F630_2985;
	R2337[1] = (char *(*)()) F631_2985_2337_4;
	R2337[2] = (char *(*)()) F632_2985;
	R2337[3] = (char *(*)()) F633_2985_2337_4;
	R2337[4] = (char *(*)()) F630_2985;
	R2337[5] = (char *(*)()) F632_2985;
	R2337[6] = (char *(*)()) F630_2985;
}
static void F631_2985_2337_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F631_2985(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F633_2985_2337_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F633_2985(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2339[7])();
void R2339_init () {
	R2339[0] = (char *(*)()) F630_2987;
	R2339[1] = (char *(*)()) F631_2987;
	R2339[2] = (char *(*)()) F632_2987;
	R2339[3] = (char *(*)()) F633_2987;
	R2339[4] = (char *(*)()) F630_2987;
	R2339[5] = (char *(*)()) F632_2987;
	R2339[6] = (char *(*)()) F630_2987;
}

char *(*R2340[7])();
void R2340_init () {
	R2340[0] = (char *(*)()) F630_2988;
	R2340[1] = (char *(*)()) F631_2988;
	R2340[2] = (char *(*)()) F632_2988;
	R2340[3] = (char *(*)()) F633_2988;
	R2340[4] = (char *(*)()) F630_2988;
	R2340[5] = (char *(*)()) F632_2988;
	R2340[6] = (char *(*)()) F630_2988;
}

char *(*R2346[7])();
void R2346_init () {
	R2346[0] = (char *(*)()) F630_3001;
	R2346[1] = (char *(*)()) F631_3001;
	R2346[2] = (char *(*)()) F632_3001;
	R2346[3] = (char *(*)()) F633_3001;
	R2346[4] = (char *(*)()) F634_3061;
	R2346[5] = (char *(*)()) F635_3061;
	R2346[6] = (char *(*)()) F630_3001;
}

char *(*R2355[7])();
void R2355_init () {
	R2355[0] = (char *(*)()) F630_3011;
	R2355[1] = (char *(*)()) F631_3011;
	R2355[2] = (char *(*)()) F632_3011;
	R2355[3] = (char *(*)()) F633_3011;
	R2355[4] = (char *(*)()) F630_3011;
	R2355[5] = (char *(*)()) F632_3011;
	R2355[6] = (char *(*)()) F630_3011;
}

char *(*R2356[7])();
void R2356_init () {
	R2356[0] = (char *(*)()) F630_3012;
	R2356[1] = (char *(*)()) F631_3012;
	R2356[2] = (char *(*)()) F632_3012;
	R2356[3] = (char *(*)()) F633_3012;
	R2356[4] = (char *(*)()) F630_3012;
	R2356[5] = (char *(*)()) F632_3012;
	R2356[6] = (char *(*)()) F630_3012;
}

char *(*R2363[7])();
void R2363_init () {
	R2363[0] = (char *(*)()) F630_3019;
	R2363[1] = (char *(*)()) F631_3019;
	R2363[2] = (char *(*)()) F632_3019_2363_1;
	R2363[3] = (char *(*)()) F633_3019_2363_1;
	R2363[4] = (char *(*)()) F630_3019;
	R2363[5] = (char *(*)()) F632_3019_2363_1;
	R2363[6] = (char *(*)()) F630_3019;
}
static EIF_REFERENCE F632_3019_2363_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F632_3019(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F633_3019_2363_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F633_3019(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2364[7])();
void R2364_init () {
	R2364[0] = (char *(*)()) F630_3020;
	R2364[1] = (char *(*)()) F631_3020_2364_1;
	R2364[2] = (char *(*)()) F632_3020;
	R2364[3] = (char *(*)()) F633_3020_2364_1;
	R2364[4] = (char *(*)()) F630_3020;
	R2364[5] = (char *(*)()) F632_3020;
	R2364[6] = (char *(*)()) F630_3020;
}
static EIF_REFERENCE F631_3020_2364_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F631_3020(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F633_3020_2364_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F633_3020(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2365[7])();
void R2365_init () {
	R2365[0] = (char *(*)()) F630_3021;
	R2365[1] = (char *(*)()) F631_3021;
	R2365[2] = (char *(*)()) F632_3021;
	R2365[3] = (char *(*)()) F633_3021;
	R2365[4] = (char *(*)()) F630_3021;
	R2365[5] = (char *(*)()) F632_3021;
	R2365[6] = (char *(*)()) F630_3021;
}

char *(*R2366[7])();
void R2366_init () {
	R2366[0] = (char *(*)()) F630_3022;
	R2366[1] = (char *(*)()) F631_3022;
	R2366[2] = (char *(*)()) F632_3022;
	R2366[3] = (char *(*)()) F633_3022;
	R2366[4] = (char *(*)()) F630_3022;
	R2366[5] = (char *(*)()) F632_3022;
	R2366[6] = (char *(*)()) F630_3022;
}

char *(*R2369[7])();
void R2369_init () {
	R2369[0] = (char *(*)()) F630_3025;
	R2369[1] = (char *(*)()) F631_3025;
	R2369[2] = (char *(*)()) F632_3025;
	R2369[3] = (char *(*)()) F633_3025;
	R2369[4] = (char *(*)()) F630_3025;
	R2369[5] = (char *(*)()) F632_3025;
	R2369[6] = (char *(*)()) F630_3025;
}

char *(*R2371[7])();
void R2371_init () {
	R2371[0] = (char *(*)()) F630_3027;
	R2371[1] = (char *(*)()) F631_3027;
	R2371[2] = (char *(*)()) F632_3027;
	R2371[3] = (char *(*)()) F633_3027;
	R2371[4] = (char *(*)()) F630_3027;
	R2371[5] = (char *(*)()) F632_3027;
	R2371[6] = (char *(*)()) F630_3027;
}

char *(*R2372[7])();
void R2372_init () {
	R2372[0] = (char *(*)()) F630_3028;
	R2372[1] = (char *(*)()) F631_3028;
	R2372[2] = (char *(*)()) F632_3028;
	R2372[3] = (char *(*)()) F633_3028;
	R2372[4] = (char *(*)()) F630_3028;
	R2372[5] = (char *(*)()) F632_3028;
	R2372[6] = (char *(*)()) F630_3028;
}

char *(*R2373[7])();
void R2373_init () {
	R2373[0] = (char *(*)()) F630_3029;
	R2373[1] = (char *(*)()) F631_3029;
	R2373[2] = (char *(*)()) F632_3029;
	R2373[3] = (char *(*)()) F633_3029;
	R2373[4] = (char *(*)()) F630_3029;
	R2373[5] = (char *(*)()) F632_3029;
	R2373[6] = (char *(*)()) F630_3029;
}

char *(*R2377[7])();
void R2377_init () {
	R2377[0] = (char *(*)()) F630_3033;
	R2377[1] = (char *(*)()) F631_3033_2377_4;
	R2377[2] = (char *(*)()) F632_3033;
	R2377[3] = (char *(*)()) F633_3033_2377_4;
	R2377[4] = (char *(*)()) F630_3033;
	R2377[5] = (char *(*)()) F632_3033;
	R2377[6] = (char *(*)()) F630_3033;
}
static void F631_3033_2377_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F631_3033(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F633_3033_2377_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F633_3033(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2383[7])();
void R2383_init () {
	R2383[0] = (char *(*)()) F630_3039;
	R2383[1] = (char *(*)()) F631_3039;
	R2383[2] = (char *(*)()) F632_3039;
	R2383[3] = (char *(*)()) F633_3039;
	R2383[4] = (char *(*)()) F630_3039;
	R2383[5] = (char *(*)()) F632_3039;
	R2383[6] = (char *(*)()) F630_3039;
}

char *(*R2396[7])();
void R2396_init () {
	R2396[0] = (char *(*)()) F630_3052;
	R2396[1] = (char *(*)()) F631_3052;
	R2396[2] = (char *(*)()) F632_3052;
	R2396[3] = (char *(*)()) F633_3052;
	R2396[4] = (char *(*)()) F630_3052;
	R2396[5] = (char *(*)()) F632_3052;
	R2396[6] = (char *(*)()) F630_3052;
}

char *(*R2399[2])();
void R2399_init () {
	R2399[0] = (char *(*)()) F634_3055;
	R2399[1] = (char *(*)()) F635_3055;
}

char *(*R2504[13])();
void R2504_init () {
	R2504[0] = (char *(*)()) F641_3185;
	R2504[1] = (char *(*)()) F642_3185;
	R2504[2] = (char *(*)()) F643_3185;
	R2504[3] = (char *(*)()) F644_3185;
	R2504[4] = (char *(*)()) F645_3185;
	R2504[5] = (char *(*)()) F646_3185;
	R2504[6] = (char *(*)()) F647_3185;
	R2504[7] = (char *(*)()) F648_3185;
	R2504[8] = (char *(*)()) F649_3185;
	R2504[9] = (char *(*)()) F650_3185;
	R2504[10] = (char *(*)()) F651_3185;
	R2504[11] = (char *(*)()) F652_3185;
	R2504[12] = (char *(*)()) F653_3185;
}

char *(*R2505[13])();
void R2505_init () {
	R2505[0] = (char *(*)()) F641_3186;
	R2505[1] = (char *(*)()) F642_3186;
	R2505[2] = (char *(*)()) F643_3186;
	R2505[3] = (char *(*)()) F644_3186;
	R2505[4] = (char *(*)()) F645_3186;
	R2505[5] = (char *(*)()) F646_3186;
	R2505[6] = (char *(*)()) F647_3186;
	R2505[7] = (char *(*)()) F648_3186;
	R2505[8] = (char *(*)()) F649_3186;
	R2505[9] = (char *(*)()) F650_3186;
	R2505[10] = (char *(*)()) F651_3186;
	R2505[11] = (char *(*)()) F652_3186;
	R2505[12] = (char *(*)()) F653_3186;
}

char *(*R2507[13])();
void R2507_init () {
	R2507[0] = (char *(*)()) F641_3172;
	R2507[1] = (char *(*)()) F642_3172;
	R2507[2] = (char *(*)()) F643_3172;
	R2507[3] = (char *(*)()) F644_3172;
	R2507[4] = (char *(*)()) F645_3172;
	R2507[5] = (char *(*)()) F646_3172;
	R2507[6] = (char *(*)()) F647_3172;
	R2507[7] = (char *(*)()) F648_3172;
	R2507[8] = (char *(*)()) F649_3172;
	R2507[9] = (char *(*)()) F650_3172;
	R2507[10] = (char *(*)()) F651_3172;
	R2507[11] = (char *(*)()) F652_3172;
	R2507[12] = (char *(*)()) F653_3172;
}

char *(*R2508[13])();
void R2508_init () {
	R2508[0] = (char *(*)()) F641_3173;
	R2508[1] = (char *(*)()) F642_3173_2508_117;
	R2508[2] = (char *(*)()) F643_3173_2508_117;
	R2508[3] = (char *(*)()) F644_3173_2508_117;
	R2508[4] = (char *(*)()) F645_3173_2508_117;
	R2508[5] = (char *(*)()) F646_3173_2508_117;
	R2508[6] = (char *(*)()) F647_3173_2508_117;
	R2508[7] = (char *(*)()) F648_3173_2508_117;
	R2508[8] = (char *(*)()) F649_3173_2508_117;
	R2508[9] = (char *(*)()) F650_3173_2508_117;
	R2508[10] = (char *(*)()) F651_3173_2508_117;
	R2508[11] = (char *(*)()) F652_3173_2508_117;
	R2508[12] = (char *(*)()) F653_3173_2508_117;
}
static void F642_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F642_3173(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F643_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F643_3173(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F644_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F644_3173(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F645_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F645_3173(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F646_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F646_3173(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F647_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F647_3173(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F648_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F648_3173(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F649_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F649_3173(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F650_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F650_3173(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F651_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F651_3173(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F652_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F652_3173(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F653_3173_2508_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F653_3173(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R2517[13])();
void R2517_init () {
	R2517[0] = (char *(*)()) F641_3188;
	R2517[1] = (char *(*)()) F642_3188;
	R2517[2] = (char *(*)()) F643_3188;
	R2517[3] = (char *(*)()) F644_3188;
	R2517[4] = (char *(*)()) F645_3188;
	R2517[5] = (char *(*)()) F646_3188;
	R2517[6] = (char *(*)()) F647_3188;
	R2517[7] = (char *(*)()) F648_3188;
	R2517[8] = (char *(*)()) F649_3188;
	R2517[9] = (char *(*)()) F650_3188;
	R2517[10] = (char *(*)()) F651_3188;
	R2517[11] = (char *(*)()) F652_3188;
	R2517[12] = (char *(*)()) F653_3188;
}

char *(*R2518[13])();
void R2518_init () {
	R2518[0] = (char *(*)()) F641_3190;
	R2518[1] = (char *(*)()) F642_3190_2518_117;
	R2518[2] = (char *(*)()) F643_3190_2518_117;
	R2518[3] = (char *(*)()) F644_3190_2518_117;
	R2518[4] = (char *(*)()) F645_3190_2518_117;
	R2518[5] = (char *(*)()) F646_3190_2518_117;
	R2518[6] = (char *(*)()) F647_3190_2518_117;
	R2518[7] = (char *(*)()) F648_3190_2518_117;
	R2518[8] = (char *(*)()) F649_3190_2518_117;
	R2518[9] = (char *(*)()) F650_3190_2518_117;
	R2518[10] = (char *(*)()) F651_3190_2518_117;
	R2518[11] = (char *(*)()) F652_3190_2518_117;
	R2518[12] = (char *(*)()) F653_3190_2518_117;
}
static void F642_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F642_3190(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F643_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F643_3190(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F644_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F644_3190(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F645_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F645_3190(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F646_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F646_3190(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F647_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F647_3190(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F648_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F648_3190(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F649_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F649_3190(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F650_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F650_3190(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F651_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F651_3190(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F652_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F652_3190(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F653_3190_2518_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F653_3190(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R2519[13])();
void R2519_init () {
	R2519[0] = (char *(*)()) F641_3191;
	R2519[1] = (char *(*)()) F642_3191_2519_117;
	R2519[2] = (char *(*)()) F643_3191_2519_117;
	R2519[3] = (char *(*)()) F644_3191_2519_117;
	R2519[4] = (char *(*)()) F645_3191_2519_117;
	R2519[5] = (char *(*)()) F646_3191_2519_117;
	R2519[6] = (char *(*)()) F647_3191_2519_117;
	R2519[7] = (char *(*)()) F648_3191_2519_117;
	R2519[8] = (char *(*)()) F649_3191_2519_117;
	R2519[9] = (char *(*)()) F650_3191_2519_117;
	R2519[10] = (char *(*)()) F651_3191_2519_117;
	R2519[11] = (char *(*)()) F652_3191_2519_117;
	R2519[12] = (char *(*)()) F653_3191_2519_117;
}
static void F642_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F642_3191(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F643_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F643_3191(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F644_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F644_3191(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F645_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F645_3191(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F646_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F646_3191(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F647_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F647_3191(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F648_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F648_3191(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F649_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F649_3191(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F650_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F650_3191(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F651_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F651_3191(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F652_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F652_3191(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}
static void F653_3191_2519_117 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F653_3191(Current, *(EIF_INTEGER_64 *)arg1, arg2);
}

char *(*R2522[13])();
void R2522_init () {
	R2522[0] = (char *(*)()) F641_3194;
	R2522[1] = (char *(*)()) F642_3194_2522_147;
	R2522[2] = (char *(*)()) F643_3194_2522_147;
	R2522[3] = (char *(*)()) F644_3194_2522_147;
	R2522[4] = (char *(*)()) F645_3194_2522_147;
	R2522[5] = (char *(*)()) F646_3194_2522_147;
	R2522[6] = (char *(*)()) F647_3194_2522_147;
	R2522[7] = (char *(*)()) F648_3194_2522_147;
	R2522[8] = (char *(*)()) F649_3194_2522_147;
	R2522[9] = (char *(*)()) F650_3194_2522_147;
	R2522[10] = (char *(*)()) F651_3194_2522_147;
	R2522[11] = (char *(*)()) F652_3194_2522_147;
	R2522[12] = (char *(*)()) F653_3194_2522_147;
}
static void F642_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F642_3194(Current, *(EIF_INTEGER_32 *)arg1, arg2, arg3);
}
static void F643_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F643_3194(Current, *(EIF_REAL_32 *)arg1, arg2, arg3);
}
static void F644_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F644_3194(Current, *(EIF_REAL_64 *)arg1, arg2, arg3);
}
static void F645_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F645_3194(Current, *(EIF_NATURAL_16 *)arg1, arg2, arg3);
}
static void F646_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F646_3194(Current, *(EIF_NATURAL_8 *)arg1, arg2, arg3);
}
static void F647_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F647_3194(Current, *(EIF_CHARACTER_8 *)arg1, arg2, arg3);
}
static void F648_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F648_3194(Current, *(EIF_BOOLEAN *)arg1, arg2, arg3);
}
static void F649_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F649_3194(Current, *(EIF_CHARACTER_32 *)arg1, arg2, arg3);
}
static void F650_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F650_3194(Current, *(EIF_NATURAL_64 *)arg1, arg2, arg3);
}
static void F651_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F651_3194(Current, *(EIF_POINTER *)arg1, arg2, arg3);
}
static void F652_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F652_3194(Current, *(EIF_NATURAL_32 *)arg1, arg2, arg3);
}
static void F653_3194_2522_147 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F653_3194(Current, *(EIF_INTEGER_64 *)arg1, arg2, arg3);
}

char *(*R2525[13])();
void R2525_init () {
	R2525[0] = (char *(*)()) F641_3197;
	R2525[1] = (char *(*)()) F642_3197;
	R2525[2] = (char *(*)()) F643_3197;
	R2525[3] = (char *(*)()) F644_3197;
	R2525[4] = (char *(*)()) F645_3197;
	R2525[5] = (char *(*)()) F646_3197;
	R2525[6] = (char *(*)()) F647_3197;
	R2525[7] = (char *(*)()) F648_3197;
	R2525[8] = (char *(*)()) F649_3197;
	R2525[9] = (char *(*)()) F650_3197;
	R2525[10] = (char *(*)()) F651_3197;
	R2525[11] = (char *(*)()) F652_3197;
	R2525[12] = (char *(*)()) F653_3197;
}

char *(*R2526[13])();
void R2526_init () {
	R2526[0] = (char *(*)()) F641_3198;
	R2526[1] = (char *(*)()) F642_3198;
	R2526[2] = (char *(*)()) F643_3198;
	R2526[3] = (char *(*)()) F644_3198;
	R2526[4] = (char *(*)()) F645_3198;
	R2526[5] = (char *(*)()) F646_3198;
	R2526[6] = (char *(*)()) F647_3198;
	R2526[7] = (char *(*)()) F648_3198;
	R2526[8] = (char *(*)()) F649_3198;
	R2526[9] = (char *(*)()) F650_3198;
	R2526[10] = (char *(*)()) F651_3198;
	R2526[11] = (char *(*)()) F652_3198;
	R2526[12] = (char *(*)()) F653_3198;
}

char *(*R2527[13])();
void R2527_init () {
	R2527[0] = (char *(*)()) F641_3199;
	R2527[1] = (char *(*)()) F642_3199;
	R2527[2] = (char *(*)()) F643_3199;
	R2527[3] = (char *(*)()) F644_3199;
	R2527[4] = (char *(*)()) F645_3199;
	R2527[5] = (char *(*)()) F646_3199;
	R2527[6] = (char *(*)()) F647_3199;
	R2527[7] = (char *(*)()) F648_3199;
	R2527[8] = (char *(*)()) F649_3199;
	R2527[9] = (char *(*)()) F650_3199;
	R2527[10] = (char *(*)()) F651_3199;
	R2527[11] = (char *(*)()) F652_3199;
	R2527[12] = (char *(*)()) F653_3199;
}

char *(*R2528[13])();
void R2528_init () {
	R2528[0] = (char *(*)()) F641_3200;
	R2528[1] = (char *(*)()) F642_3200;
	R2528[2] = (char *(*)()) F643_3200;
	R2528[3] = (char *(*)()) F644_3200;
	R2528[4] = (char *(*)()) F645_3200;
	R2528[5] = (char *(*)()) F646_3200;
	R2528[6] = (char *(*)()) F647_3200;
	R2528[7] = (char *(*)()) F648_3200;
	R2528[8] = (char *(*)()) F649_3200;
	R2528[9] = (char *(*)()) F650_3200;
	R2528[10] = (char *(*)()) F651_3200;
	R2528[11] = (char *(*)()) F652_3200;
	R2528[12] = (char *(*)()) F653_3200;
}

char *(*R2535[13])();
void R2535_init () {
	R2535[0] = (char *(*)()) F641_3207;
	R2535[1] = (char *(*)()) F642_3207;
	R2535[2] = (char *(*)()) F643_3207;
	R2535[3] = (char *(*)()) F644_3207;
	R2535[4] = (char *(*)()) F645_3207;
	R2535[5] = (char *(*)()) F646_3207;
	R2535[6] = (char *(*)()) F647_3207;
	R2535[7] = (char *(*)()) F648_3207;
	R2535[8] = (char *(*)()) F649_3207;
	R2535[9] = (char *(*)()) F650_3207;
	R2535[10] = (char *(*)()) F651_3207;
	R2535[11] = (char *(*)()) F652_3207;
	R2535[12] = (char *(*)()) F653_3207;
}

char *(*R2538[13])();
void R2538_init () {
	R2538[0] = (char *(*)()) F641_3210;
	R2538[1] = (char *(*)()) F642_3210;
	R2538[2] = (char *(*)()) F643_3210;
	R2538[3] = (char *(*)()) F644_3210;
	R2538[4] = (char *(*)()) F645_3210;
	R2538[5] = (char *(*)()) F646_3210;
	R2538[6] = (char *(*)()) F647_3210;
	R2538[7] = (char *(*)()) F648_3210;
	R2538[8] = (char *(*)()) F649_3210;
	R2538[9] = (char *(*)()) F650_3210;
	R2538[10] = (char *(*)()) F651_3210;
	R2538[11] = (char *(*)()) F652_3210;
	R2538[12] = (char *(*)()) F653_3210;
}

char *(*R2547[13])();
void R2547_init () {
	R2547[0] = (char *(*)()) F641_3220;
	R2547[1] = (char *(*)()) F642_3220;
	R2547[2] = (char *(*)()) F643_3220;
	R2547[3] = (char *(*)()) F644_3220;
	R2547[4] = (char *(*)()) F645_3220;
	R2547[5] = (char *(*)()) F646_3220;
	R2547[6] = (char *(*)()) F647_3220;
	R2547[7] = (char *(*)()) F648_3220;
	R2547[8] = (char *(*)()) F649_3220;
	R2547[9] = (char *(*)()) F650_3220;
	R2547[10] = (char *(*)()) F651_3220;
	R2547[11] = (char *(*)()) F652_3220;
	R2547[12] = (char *(*)()) F653_3220;
}

char *(*R2595[118])();
void R2595_init () {
	R2595[0] = (char *(*)()) F703_3360;
	R2595[1] = (char *(*)()) F704_3360;
	R2595[2] = (char *(*)()) F705_3360;
	R2595[3] = (char *(*)()) F706_3360;
	R2595[4] = (char *(*)()) F707_3360;
	R2595[5] = (char *(*)()) F708_3360;
	R2595[6] = (char *(*)()) F709_3360;
	R2595[7] = (char *(*)()) F710_3360;
	R2595[8] = (char *(*)()) F711_3360;
	R2595[9] = (char *(*)()) F712_3360;
	R2595[10] = (char *(*)()) F713_3360;
	R2595[11] = (char *(*)()) F714_3360;
	R2595[12] = (char *(*)()) F715_3360;
	R2595[13] = (char *(*)()) F716_3360;
	R2595[14] = (char *(*)()) F717_3360;
	R2595[15] = (char *(*)()) F718_3360;
	R2595[16] = (char *(*)()) F719_3360;
	R2595[17] = (char *(*)()) F720_3360;
	R2595[18] = (char *(*)()) F721_3360;
	R2595[19] = (char *(*)()) F722_3360;
	R2595[20] = (char *(*)()) F723_3360;
	R2595[21] = (char *(*)()) F724_3360;
	R2595[22] = (char *(*)()) F725_3360;
	R2595[23] = (char *(*)()) F726_3360;
	R2595[24] = (char *(*)()) F727_3360;
	R2595[25] = (char *(*)()) F728_3360;
	R2595[26] = (char *(*)()) F729_3360;
	R2595[27] = (char *(*)()) F730_3360;
	R2595[28] = (char *(*)()) F731_3360;
	R2595[29] = (char *(*)()) F732_3360;
	R2595[30] = (char *(*)()) F733_3360;
	R2595[31] = (char *(*)()) F734_3412;
	{long i; for (i = 33; i < 35; i++) R2595[i] = (char *(*)()) F735_3519;}
	{long i; for (i = 36; i < 38; i++) R2595[i] = (char *(*)()) F738_3617;}
	{long i; for (i = 39; i < 41; i++) R2595[i] = (char *(*)()) F741_3716;}
	{long i; for (i = 42; i < 44; i++) R2595[i] = (char *(*)()) F744_3815;}
	{long i; for (i = 45; i < 47; i++) R2595[i] = (char *(*)()) F747_3914;}
	{long i; for (i = 48; i < 50; i++) R2595[i] = (char *(*)()) F750_4008;}
	{long i; for (i = 51; i < 53; i++) R2595[i] = (char *(*)()) F753_4102;}
	{long i; for (i = 54; i < 56; i++) R2595[i] = (char *(*)()) F756_4197;}
	{long i; for (i = 57; i < 59; i++) R2595[i] = (char *(*)()) F759_4292;}
	{long i; for (i = 60; i < 62; i++) R2595[i] = (char *(*)()) F762_4358;}
	{long i; for (i = 63; i < 65; i++) R2595[i] = (char *(*)()) F765_4425;}
	{long i; for (i = 66; i < 68; i++) R2595[i] = (char *(*)()) F768_4466;}
	{long i; for (i = 69; i < 71; i++) R2595[i] = (char *(*)()) F771_4514;}
	{long i; for (i = 72; i < 102; i++) R2595[i] = (char *(*)()) F774_4535;}
	R2595[102] = (char *(*)()) F805_4561;
	R2595[103] = (char *(*)()) F806_4561;
	{long i; for (i = 113; i < 115; i++) R2595[i] = (char *(*)()) F812_4628;}
	{long i; for (i = 116; i < 118; i++) R2595[i] = (char *(*)()) F812_4628;}
}

char *(*R2653[31])();
void R2653_init () {
	R2653[0] = (char *(*)()) F703_3356;
	R2653[1] = (char *(*)()) F704_3356;
	R2653[2] = (char *(*)()) F705_3356;
	R2653[3] = (char *(*)()) F706_3356;
	R2653[4] = (char *(*)()) F707_3356;
	R2653[5] = (char *(*)()) F708_3356;
	R2653[6] = (char *(*)()) F709_3356;
	R2653[7] = (char *(*)()) F710_3356;
	R2653[8] = (char *(*)()) F711_3356;
	R2653[9] = (char *(*)()) F712_3356;
	R2653[10] = (char *(*)()) F713_3356;
	R2653[11] = (char *(*)()) F714_3356;
	R2653[12] = (char *(*)()) F715_3356;
	R2653[13] = (char *(*)()) F716_3356;
	R2653[14] = (char *(*)()) F717_3356;
	R2653[15] = (char *(*)()) F718_3356;
	R2653[16] = (char *(*)()) F719_3356;
	R2653[17] = (char *(*)()) F720_3356;
	R2653[18] = (char *(*)()) F721_3356;
	R2653[19] = (char *(*)()) F722_3356;
	R2653[20] = (char *(*)()) F723_3356;
	R2653[21] = (char *(*)()) F724_3356;
	R2653[22] = (char *(*)()) F725_3356;
	R2653[23] = (char *(*)()) F726_3356;
	R2653[24] = (char *(*)()) F727_3356;
	R2653[25] = (char *(*)()) F728_3356;
	R2653[26] = (char *(*)()) F729_3356;
	R2653[27] = (char *(*)()) F730_3356;
	R2653[28] = (char *(*)()) F731_3356;
	R2653[29] = (char *(*)()) F732_3356;
	R2653[30] = (char *(*)()) F733_3356;
}

char *(*R2656[31])();
void R2656_init () {
	R2656[0] = (char *(*)()) F703_3359;
	R2656[1] = (char *(*)()) F704_3359;
	R2656[2] = (char *(*)()) F705_3359;
	R2656[3] = (char *(*)()) F706_3359;
	R2656[4] = (char *(*)()) F707_3359;
	R2656[5] = (char *(*)()) F708_3359;
	R2656[6] = (char *(*)()) F709_3359;
	R2656[7] = (char *(*)()) F710_3359;
	R2656[8] = (char *(*)()) F711_3359;
	R2656[9] = (char *(*)()) F712_3359;
	R2656[10] = (char *(*)()) F713_3359;
	R2656[11] = (char *(*)()) F714_3359;
	R2656[12] = (char *(*)()) F715_3359;
	R2656[13] = (char *(*)()) F716_3359;
	R2656[14] = (char *(*)()) F717_3359;
	R2656[15] = (char *(*)()) F718_3359;
	R2656[16] = (char *(*)()) F719_3359;
	R2656[17] = (char *(*)()) F720_3359;
	R2656[18] = (char *(*)()) F721_3359;
	R2656[19] = (char *(*)()) F722_3359;
	R2656[20] = (char *(*)()) F723_3359;
	R2656[21] = (char *(*)()) F724_3359;
	R2656[22] = (char *(*)()) F725_3359;
	R2656[23] = (char *(*)()) F726_3359;
	R2656[24] = (char *(*)()) F727_3359;
	R2656[25] = (char *(*)()) F728_3359;
	R2656[26] = (char *(*)()) F729_3359;
	R2656[27] = (char *(*)()) F730_3359;
	R2656[28] = (char *(*)()) F731_3359;
	R2656[29] = (char *(*)()) F732_3359;
	R2656[30] = (char *(*)()) F733_3359;
}

char *(*R2661[31])();
void R2661_init () {
	R2661[0] = (char *(*)()) F703_3365;
	R2661[1] = (char *(*)()) F704_3365;
	R2661[2] = (char *(*)()) F705_3365;
	R2661[3] = (char *(*)()) F706_3365;
	R2661[4] = (char *(*)()) F707_3365;
	R2661[5] = (char *(*)()) F708_3365;
	R2661[6] = (char *(*)()) F709_3365;
	R2661[7] = (char *(*)()) F710_3365;
	R2661[8] = (char *(*)()) F711_3365;
	R2661[9] = (char *(*)()) F712_3365;
	R2661[10] = (char *(*)()) F713_3365;
	R2661[11] = (char *(*)()) F714_3365;
	R2661[12] = (char *(*)()) F715_3365;
	R2661[13] = (char *(*)()) F716_3365;
	R2661[14] = (char *(*)()) F717_3365;
	R2661[15] = (char *(*)()) F718_3365;
	R2661[16] = (char *(*)()) F719_3365;
	R2661[17] = (char *(*)()) F720_3365;
	R2661[18] = (char *(*)()) F721_3365;
	R2661[19] = (char *(*)()) F722_3365;
	R2661[20] = (char *(*)()) F723_3365;
	R2661[21] = (char *(*)()) F724_3365;
	R2661[22] = (char *(*)()) F725_3365;
	R2661[23] = (char *(*)()) F726_3365;
	R2661[24] = (char *(*)()) F727_3365;
	R2661[25] = (char *(*)()) F728_3365;
	R2661[26] = (char *(*)()) F729_3365;
	R2661[27] = (char *(*)()) F730_3365;
	R2661[28] = (char *(*)()) F731_3365;
	R2661[29] = (char *(*)()) F732_3365;
	R2661[30] = (char *(*)()) F733_3365;
}

char *(*R2668[31])();
void R2668_init () {
	R2668[0] = (char *(*)()) F703_3373;
	R2668[1] = (char *(*)()) F704_3373_2668_1;
	R2668[2] = (char *(*)()) F705_3373_2668_1;
	R2668[3] = (char *(*)()) F706_3373_2668_1;
	R2668[4] = (char *(*)()) F707_3373_2668_1;
	R2668[5] = (char *(*)()) F708_3373_2668_1;
	R2668[6] = (char *(*)()) F709_3373_2668_1;
	R2668[7] = (char *(*)()) F710_3373_2668_1;
	R2668[8] = (char *(*)()) F711_3373_2668_1;
	R2668[9] = (char *(*)()) F712_3373_2668_1;
	R2668[10] = (char *(*)()) F713_3373_2668_1;
	R2668[11] = (char *(*)()) F714_3373_2668_1;
	R2668[12] = (char *(*)()) F715_3373_2668_1;
	R2668[13] = (char *(*)()) F716_3373_2668_1;
	R2668[14] = (char *(*)()) F717_3373_2668_1;
	R2668[15] = (char *(*)()) F718_3373_2668_1;
	R2668[16] = (char *(*)()) F719_3373_2668_1;
	R2668[17] = (char *(*)()) F720_3373_2668_1;
	R2668[18] = (char *(*)()) F721_3373;
	R2668[19] = (char *(*)()) F722_3373_2668_1;
	R2668[20] = (char *(*)()) F723_3373_2668_1;
	R2668[21] = (char *(*)()) F724_3373_2668_1;
	R2668[22] = (char *(*)()) F725_3373_2668_1;
	R2668[23] = (char *(*)()) F726_3373_2668_1;
	R2668[24] = (char *(*)()) F727_3373_2668_1;
	R2668[25] = (char *(*)()) F728_3373_2668_1;
	R2668[26] = (char *(*)()) F729_3373_2668_1;
	R2668[27] = (char *(*)()) F730_3373_2668_1;
	R2668[28] = (char *(*)()) F731_3373_2668_1;
	R2668[29] = (char *(*)()) F732_3373_2668_1;
	R2668[30] = (char *(*)()) F733_3373_2668_1;
}
static EIF_REFERENCE F704_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8* r = F704_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {776,769,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 776, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F705_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F705_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(805, 0x00).id, 805, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F706_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F706_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(736, 0x00).id, 736, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F707_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F707_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(751, 0x00).id, 751, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F708_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REFERENCE* r = F708_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {777,0,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 777, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REFERENCE* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F709_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F709_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r8;
	} else {
		Result = RTLNS(eif_new_type(763, 0x00).id, 763, _OBJSIZ_0_0_0_0_0_0_0_1_);
		*(EIF_REAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F710_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F710_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(760, 0x00).id, 760, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F711_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F711_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(757, 0x00).id, 757, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F712_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F712_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(754, 0x00).id, 754, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F713_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F713_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(748, 0x00).id, 748, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F714_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8 r = F714_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i1;
	} else {
		Result = RTLNS(eif_new_type(745, 0x00).id, 745, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_INTEGER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F715_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16 r = F715_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i2;
	} else {
		Result = RTLNS(eif_new_type(742, 0x00).id, 742, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_INTEGER_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F716_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F716_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(739, 0x00).id, 739, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F717_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F717_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F718_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F718_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(766, 0x00).id, 766, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F719_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F719_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(772, 0x00).id, 772, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F720_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64* r = F720_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {779,763,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 779, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F722_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32* r = F722_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {781,760,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 781, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F723_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8* r = F723_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {783,757,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 783, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F724_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN* r = F724_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {785,772,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 785, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_BOOLEAN* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F725_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8* r = F725_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {787,745,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 787, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F726_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32* r = F726_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {789,751,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 789, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F727_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64* r = F727_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {791,736,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 791, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F728_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32* r = F728_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {793,739,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 793, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F729_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16* r = F729_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {795,742,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 795, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F730_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64* r = F730_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {797,748,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 797, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F731_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16* r = F731_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {799,754,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 799, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F732_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER* r = F732_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {801,805,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 801, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_POINTER* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F733_3373_2668_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32* r = F733_3373(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {803,766,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 803, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_32* *)Result = r;
		return Result;
	}
}

char *(*R2678[31])();
void R2678_init () {
	R2678[0] = (char *(*)()) F703_3385;
	R2678[1] = (char *(*)()) F704_3385;
	R2678[2] = (char *(*)()) F705_3385;
	R2678[3] = (char *(*)()) F706_3385;
	R2678[4] = (char *(*)()) F707_3385;
	R2678[5] = (char *(*)()) F708_3385;
	R2678[6] = (char *(*)()) F709_3385;
	R2678[7] = (char *(*)()) F710_3385;
	R2678[8] = (char *(*)()) F711_3385;
	R2678[9] = (char *(*)()) F712_3385;
	R2678[10] = (char *(*)()) F713_3385;
	R2678[11] = (char *(*)()) F714_3385;
	R2678[12] = (char *(*)()) F715_3385;
	R2678[13] = (char *(*)()) F716_3385;
	R2678[14] = (char *(*)()) F717_3385;
	R2678[15] = (char *(*)()) F718_3385;
	R2678[16] = (char *(*)()) F719_3385;
	R2678[17] = (char *(*)()) F720_3385;
	R2678[18] = (char *(*)()) F721_3385;
	R2678[19] = (char *(*)()) F722_3385;
	R2678[20] = (char *(*)()) F723_3385;
	R2678[21] = (char *(*)()) F724_3385;
	R2678[22] = (char *(*)()) F725_3385;
	R2678[23] = (char *(*)()) F726_3385;
	R2678[24] = (char *(*)()) F727_3385;
	R2678[25] = (char *(*)()) F728_3385;
	R2678[26] = (char *(*)()) F729_3385;
	R2678[27] = (char *(*)()) F730_3385;
	R2678[28] = (char *(*)()) F731_3385;
	R2678[29] = (char *(*)()) F732_3385;
	R2678[30] = (char *(*)()) F733_3385;
}

char *(*R2824[2])();
void R2824_init () {
	R2824[0] = (char *(*)()) F736_3601;
	R2824[1] = (char *(*)()) F737_3601;
}

char *(*R2827[2])();
void R2827_init () {
	R2827[0] = (char *(*)()) F736_3604;
	R2827[1] = (char *(*)()) F737_3604;
}

char *(*R2879[2])();
void R2879_init () {
	R2879[0] = (char *(*)()) F739_3699;
	R2879[1] = (char *(*)()) F740_3699;
}

char *(*R2880[2])();
void R2880_init () {
	R2880[0] = (char *(*)()) F739_3700;
	R2880[1] = (char *(*)()) F740_3700;
}

char *(*R2884[2])();
void R2884_init () {
	R2884[0] = (char *(*)()) F739_3704;
	R2884[1] = (char *(*)()) F740_3704;
}

char *(*R2936[2])();
void R2936_init () {
	R2936[0] = (char *(*)()) F742_3799;
	R2936[1] = (char *(*)()) F743_3799;
}

char *(*R2939[2])();
void R2939_init () {
	R2939[0] = (char *(*)()) F742_3802;
	R2939[1] = (char *(*)()) F743_3802;
}

char *(*R2989[2])();
void R2989_init () {
	R2989[0] = (char *(*)()) F745_3895;
	R2989[1] = (char *(*)()) F746_3895;
}

char *(*R2992[2])();
void R2992_init () {
	R2992[0] = (char *(*)()) F745_3898;
	R2992[1] = (char *(*)()) F746_3898;
}

char *(*R2995[2])();
void R2995_init () {
	R2995[0] = (char *(*)()) F745_3901;
	R2995[1] = (char *(*)()) F746_3901;
}

char *(*R3049[2])();
void R3049_init () {
	R3049[0] = (char *(*)()) F748_3995;
	R3049[1] = (char *(*)()) F749_3995;
}

char *(*R3095[2])();
void R3095_init () {
	R3095[0] = (char *(*)()) F751_4083;
	R3095[1] = (char *(*)()) F752_4083;
}

char *(*R3096[2])();
void R3096_init () {
	R3096[0] = (char *(*)()) F751_4084;
	R3096[1] = (char *(*)()) F752_4084;
}

char *(*R3098[2])();
void R3098_init () {
	R3098[0] = (char *(*)()) F751_4086;
	R3098[1] = (char *(*)()) F752_4086;
}

char *(*R3101[2])();
void R3101_init () {
	R3101[0] = (char *(*)()) F751_4089;
	R3101[1] = (char *(*)()) F752_4089;
}

char *(*R3102[2])();
void R3102_init () {
	R3102[0] = (char *(*)()) F751_4090;
	R3102[1] = (char *(*)()) F752_4090;
}

char *(*R3150[2])();
void R3150_init () {
	R3150[0] = (char *(*)()) F754_4180;
	R3150[1] = (char *(*)()) F755_4180;
}

char *(*R3151[2])();
void R3151_init () {
	R3151[0] = (char *(*)()) F754_4181;
	R3151[1] = (char *(*)()) F755_4181;
}

char *(*R3154[2])();
void R3154_init () {
	R3154[0] = (char *(*)()) F754_4184;
	R3154[1] = (char *(*)()) F755_4184;
}

char *(*R3203[2])();
void R3203_init () {
	R3203[0] = (char *(*)()) F757_4275;
	R3203[1] = (char *(*)()) F758_4275;
}

char *(*R3204[2])();
void R3204_init () {
	R3204[0] = (char *(*)()) F757_4276;
	R3204[1] = (char *(*)()) F758_4276;
}

char *(*R3205[2])();
void R3205_init () {
	R3205[0] = (char *(*)()) F757_4277;
	R3205[1] = (char *(*)()) F758_4277;
}

char *(*R3207[2])();
void R3207_init () {
	R3207[0] = (char *(*)()) F757_4279;
	R3207[1] = (char *(*)()) F758_4279;
}

char *(*R3253[2])();
void R3253_init () {
	R3253[0] = (char *(*)()) F760_4337;
	R3253[1] = (char *(*)()) F761_4337;
}

char *(*R3287[2])();
void R3287_init () {
	R3287[0] = (char *(*)()) F763_4403;
	R3287[1] = (char *(*)()) F764_4403;
}

char *(*R3308[2])();
void R3308_init () {
	R3308[0] = (char *(*)()) F766_4461;
	R3308[1] = (char *(*)()) F767_4461;
}

char *(*R3463[5])();
void R3463_init () {
	{long i; for (i = 0; i < 2; i++) R3463[i] = (char *(*)()) F815_4749;}
	{long i; for (i = 3; i < 5; i++) R3463[i] = (char *(*)()) F818_4915;}
}

char *(*R3465[5])();
void R3465_init () {
	R3465[0] = (char *(*)()) F816_4809;
	R3465[1] = (char *(*)()) F817_4831;
	R3465[3] = (char *(*)()) F819_4976;
	R3465[4] = (char *(*)()) F820_4999;
}

char *(*R3466[5])();
void R3466_init () {
	R3466[0] = (char *(*)()) F816_4808;
	R3466[1] = (char *(*)()) F817_4830;
	R3466[3] = (char *(*)()) F819_4974;
	R3466[4] = (char *(*)()) F820_4997;
}

char *(*R3477[5])();
void R3477_init () {
	{long i; for (i = 0; i < 2; i++) R3477[i] = (char *(*)()) F815_4780;}
	{long i; for (i = 3; i < 5; i++) R3477[i] = (char *(*)()) F818_4945;}
}

char *(*R3478[5])();
void R3478_init () {
	{long i; for (i = 0; i < 2; i++) R3478[i] = (char *(*)()) F815_4781;}
	{long i; for (i = 3; i < 5; i++) R3478[i] = (char *(*)()) F818_4946;}
}

char *(*R3479[5])();
void R3479_init () {
	{long i; for (i = 0; i < 2; i++) R3479[i] = (char *(*)()) F815_4782;}
	{long i; for (i = 3; i < 5; i++) R3479[i] = (char *(*)()) F818_4947;}
}

char *(*R3480[5])();
void R3480_init () {
	R3480[0] = (char *(*)()) F816_4818;
	R3480[1] = (char *(*)()) F453_2254;
	R3480[3] = (char *(*)()) F819_4986;
	R3480[4] = (char *(*)()) F452_2254;
}

char *(*R3502[5])();
void R3502_init () {
	{long i; for (i = 0; i < 2; i++) R3502[i] = (char *(*)()) F815_4771;}
	{long i; for (i = 3; i < 5; i++) R3502[i] = (char *(*)()) F818_4936;}
}

char *(*R3503[5])();
void R3503_init () {
	{long i; for (i = 0; i < 2; i++) R3503[i] = (char *(*)()) F815_4770;}
	{long i; for (i = 3; i < 5; i++) R3503[i] = (char *(*)()) F818_4935;}
}

char *(*R3543[5])();
void R3543_init () {
	R3543[0] = (char *(*)()) F816_4816;
	R3543[1] = (char *(*)()) F817_4909;
	R3543[3] = (char *(*)()) F819_4983;
	R3543[4] = (char *(*)()) F820_5077;
}

char *(*R3558[4])();
void R3558_init () {
	R3558[0] = (char *(*)()) F817_4911;
	R3558[3] = (char *(*)()) F820_5079;
}

char *(*R3561[4])();
void R3561_init () {
	R3561[0] = (char *(*)()) F817_4850;
	R3561[3] = (char *(*)()) F820_5018;
}

char *(*R3591[4])();
void R3591_init () {
	R3591[0] = (char *(*)()) F817_4894;
	R3591[3] = (char *(*)()) F820_5062;
}

char *(*R3623[2])();
void R3623_init () {
	R3623[0] = (char *(*)()) F816_4822;
	R3623[1] = (char *(*)()) F815_4801;
}

char *(*R3698[2])();
void R3698_init () {
	R3698[0] = (char *(*)()) F819_4989;
	R3698[1] = (char *(*)()) F818_4966;
}

char *(*R3766[2])();
void R3766_init () {
	R3766[0] = (char *(*)()) F823_5160;
	R3766[1] = (char *(*)()) F824_5168;
}

char *(*R3771[2])();
void R3771_init () {
	R3771[0] = (char *(*)()) F823_5155;
	R3771[1] = (char *(*)()) F824_5171;
}

char *(*R3773[2])();
void R3773_init () {
	R3773[0] = (char *(*)()) F823_5156;
	R3773[1] = (char *(*)()) F824_5172;
}
char *(*R2[834])();
void R2_init () {}
char *(*R6[834])();
void R6_init () {}

char *(*R3[834])();
void R3_init () {
	R3[117] = (char *(*)()) F118_1310;
	R3[820] = (char *(*)()) F821_5090;
}

char *(*R4[834])();
void R4_init () {
	{long i; for (i = 1; i < 4; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 5; i < 7; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 9; i < 12; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 26; i < 29; i++) R4[i] = (char *(*)()) F1_15;}
	R4[36] = (char *(*)()) F1_15;
	R4[40] = (char *(*)()) F1_15;
	{long i; for (i = 44; i < 50; i++) R4[i] = (char *(*)()) F1_15;}
	R4[52] = (char *(*)()) F1_15;
	{long i; for (i = 69; i < 71; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 73; i < 75; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 76; i < 79; i++) R4[i] = (char *(*)()) F1_15;}
	R4[81] = (char *(*)()) F1_15;
	{long i; for (i = 83; i < 86; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 87; i < 89; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 91; i < 93; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 94; i < 97; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 98; i < 102; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 103; i < 105; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 106; i < 109; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 110; i < 116; i++) R4[i] = (char *(*)()) F1_15;}
	R4[117] = (char *(*)()) F118_1229;
	R4[127] = (char *(*)()) F1_15;
	R4[139] = (char *(*)()) F1_15;
	R4[157] = (char *(*)()) F158_1953;
	{long i; for (i = 239; i < 243; i++) R4[i] = (char *(*)()) F1_15;}
	R4[448] = (char *(*)()) F1_15;
	R4[546] = (char *(*)()) F547_2724;
	R4[547] = (char *(*)()) F548_2724;
	R4[548] = (char *(*)()) F549_2724;
	R4[549] = (char *(*)()) F550_2724;
	R4[550] = (char *(*)()) F551_2724;
	R4[551] = (char *(*)()) F552_2724;
	R4[552] = (char *(*)()) F553_2724;
	R4[553] = (char *(*)()) F554_2724;
	R4[554] = (char *(*)()) F555_2724;
	R4[555] = (char *(*)()) F556_2724;
	R4[556] = (char *(*)()) F557_2724;
	R4[557] = (char *(*)()) F558_2724;
	R4[558] = (char *(*)()) F559_2724;
	R4[629] = (char *(*)()) F630_3000;
	R4[630] = (char *(*)()) F631_3000;
	R4[631] = (char *(*)()) F632_3000;
	R4[632] = (char *(*)()) F633_3000;
	R4[633] = (char *(*)()) F630_3000;
	R4[634] = (char *(*)()) F632_3000;
	R4[635] = (char *(*)()) F630_3000;
	{long i; for (i = 640; i < 653; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 702; i < 734; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 735; i < 737; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 738; i < 740; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 741; i < 743; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 744; i < 746; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 747; i < 749; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 750; i < 752; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 753; i < 755; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 756; i < 758; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 759; i < 761; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 762; i < 764; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 765; i < 767; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 768; i < 770; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 771; i < 773; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 774; i < 806; i++) R4[i] = (char *(*)()) F1_15;}
	R4[815] = (char *(*)()) F816_4805;
	R4[816] = (char *(*)()) F815_4789;
	R4[818] = (char *(*)()) F819_4973;
	R4[819] = (char *(*)()) F818_4954;
	R4[820] = (char *(*)()) F1_15;
	{long i; for (i = 822; i < 824; i++) R4[i] = (char *(*)()) F1_15;}
	R4[830] = (char *(*)()) F1_15;
}

char *(*R5[834])();
void R5_init () {
	{long i; for (i = 1; i < 4; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 5; i < 7; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 9; i < 12; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 26; i < 29; i++) R5[i] = (char *(*)()) F1_8;}
	R5[36] = (char *(*)()) F1_8;
	R5[40] = (char *(*)()) F1_8;
	{long i; for (i = 44; i < 50; i++) R5[i] = (char *(*)()) F1_8;}
	R5[52] = (char *(*)()) F1_8;
	{long i; for (i = 69; i < 71; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 73; i < 75; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 76; i < 79; i++) R5[i] = (char *(*)()) F1_8;}
	R5[81] = (char *(*)()) F1_8;
	{long i; for (i = 83; i < 86; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 87; i < 89; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 91; i < 93; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 94; i < 97; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 98; i < 102; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 103; i < 105; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 106; i < 109; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 110; i < 116; i++) R5[i] = (char *(*)()) F1_8;}
	R5[117] = (char *(*)()) F118_1228;
	R5[127] = (char *(*)()) F1_8;
	R5[139] = (char *(*)()) F1_8;
	R5[157] = (char *(*)()) F158_1952;
	{long i; for (i = 239; i < 243; i++) R5[i] = (char *(*)()) F1_8;}
	R5[448] = (char *(*)()) F1_8;
	R5[546] = (char *(*)()) F547_2686;
	R5[547] = (char *(*)()) F548_2686;
	R5[548] = (char *(*)()) F549_2686;
	R5[549] = (char *(*)()) F550_2686;
	R5[550] = (char *(*)()) F551_2686;
	R5[551] = (char *(*)()) F552_2686;
	R5[552] = (char *(*)()) F553_2686;
	R5[553] = (char *(*)()) F554_2686;
	R5[554] = (char *(*)()) F555_2686;
	R5[555] = (char *(*)()) F556_2686;
	R5[556] = (char *(*)()) F557_2686;
	R5[557] = (char *(*)()) F558_2686;
	R5[558] = (char *(*)()) F559_2686;
	R5[629] = (char *(*)()) F630_2966;
	R5[630] = (char *(*)()) F631_2966;
	R5[631] = (char *(*)()) F632_2966;
	R5[632] = (char *(*)()) F633_2966;
	R5[633] = (char *(*)()) F634_3060;
	R5[634] = (char *(*)()) F635_3060;
	R5[635] = (char *(*)()) F630_2966;
	{long i; for (i = 640; i < 653; i++) R5[i] = (char *(*)()) F1_8;}
	R5[702] = (char *(*)()) F703_3366;
	R5[703] = (char *(*)()) F704_3366;
	R5[704] = (char *(*)()) F705_3366;
	R5[705] = (char *(*)()) F706_3366;
	R5[706] = (char *(*)()) F707_3366;
	R5[707] = (char *(*)()) F708_3366;
	R5[708] = (char *(*)()) F709_3366;
	R5[709] = (char *(*)()) F710_3366;
	R5[710] = (char *(*)()) F711_3366;
	R5[711] = (char *(*)()) F712_3366;
	R5[712] = (char *(*)()) F713_3366;
	R5[713] = (char *(*)()) F714_3366;
	R5[714] = (char *(*)()) F715_3366;
	R5[715] = (char *(*)()) F716_3366;
	R5[716] = (char *(*)()) F717_3366;
	R5[717] = (char *(*)()) F718_3366;
	R5[718] = (char *(*)()) F719_3366;
	R5[719] = (char *(*)()) F720_3366;
	R5[720] = (char *(*)()) F721_3366;
	R5[721] = (char *(*)()) F722_3366;
	R5[722] = (char *(*)()) F723_3366;
	R5[723] = (char *(*)()) F724_3366;
	R5[724] = (char *(*)()) F725_3366;
	R5[725] = (char *(*)()) F726_3366;
	R5[726] = (char *(*)()) F727_3366;
	R5[727] = (char *(*)()) F728_3366;
	R5[728] = (char *(*)()) F729_3366;
	R5[729] = (char *(*)()) F730_3366;
	R5[730] = (char *(*)()) F731_3366;
	R5[731] = (char *(*)()) F732_3366;
	R5[732] = (char *(*)()) F733_3366;
	R5[733] = (char *(*)()) F734_3409;
	{long i; for (i = 735; i < 737; i++) R5[i] = (char *(*)()) F735_3527;}
	{long i; for (i = 738; i < 740; i++) R5[i] = (char *(*)()) F738_3625;}
	{long i; for (i = 741; i < 743; i++) R5[i] = (char *(*)()) F741_3724;}
	{long i; for (i = 744; i < 746; i++) R5[i] = (char *(*)()) F744_3823;}
	{long i; for (i = 747; i < 749; i++) R5[i] = (char *(*)()) F747_3922;}
	{long i; for (i = 750; i < 752; i++) R5[i] = (char *(*)()) F750_4016;}
	{long i; for (i = 753; i < 755; i++) R5[i] = (char *(*)()) F753_4110;}
	{long i; for (i = 756; i < 758; i++) R5[i] = (char *(*)()) F756_4205;}
	{long i; for (i = 759; i < 761; i++) R5[i] = (char *(*)()) F759_4304;}
	{long i; for (i = 762; i < 764; i++) R5[i] = (char *(*)()) F762_4370;}
	{long i; for (i = 765; i < 767; i++) R5[i] = (char *(*)()) F765_4431;}
	{long i; for (i = 768; i < 770; i++) R5[i] = (char *(*)()) F768_4471;}
	{long i; for (i = 771; i < 773; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 774; i < 806; i++) R5[i] = (char *(*)()) F774_4537;}
	{long i; for (i = 815; i < 817; i++) R5[i] = (char *(*)()) F815_4774;}
	{long i; for (i = 818; i < 820; i++) R5[i] = (char *(*)()) F818_4939;}
	R5[820] = (char *(*)()) F1_8;
	{long i; for (i = 822; i < 824; i++) R5[i] = (char *(*)()) F1_8;}
	R5[830] = (char *(*)()) F125_1448;
}


#ifdef __cplusplus
}
#endif
