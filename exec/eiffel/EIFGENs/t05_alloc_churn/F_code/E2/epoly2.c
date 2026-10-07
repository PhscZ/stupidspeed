#include "epoly2.h"
#include "../E1/eoffsets.h"


#ifdef __cplusplus
extern "C" {
#endif

char *(*R696[4])();
void R696_init () {
	R696[0] = (char *(*)()) F45_716;
	R696[1] = (char *(*)()) F46_716_696_1;
	R696[2] = (char *(*)()) F47_716_696_1;
	R696[3] = (char *(*)()) F48_716_696_1;
}
static EIF_REFERENCE F46_716_696_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F46_716(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F47_716_696_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F47_716(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F48_716_696_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F48_716(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(720, 0x00).id, 720, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}

char *(*R1026[39])();
void R1026_init () {
	R1026[0] = (char *(*)()) F76_1086;
	R1026[1] = (char *(*)()) F77_1110;
	R1026[4] = (char *(*)()) F80_1112;
	R1026[6] = (char *(*)()) F82_1114;
	R1026[7] = (char *(*)()) F83_1118;
	R1026[8] = (char *(*)()) F84_1124;
	R1026[10] = (char *(*)()) F86_1141;
	R1026[11] = (char *(*)()) F87_1143;
	R1026[12] = (char *(*)()) F88_1145;
	R1026[14] = (char *(*)()) F90_1147;
	R1026[15] = (char *(*)()) F91_1151;
	R1026[18] = (char *(*)()) F94_1153;
	R1026[19] = (char *(*)()) F95_1155;
	R1026[21] = (char *(*)()) F97_1159;
	R1026[22] = (char *(*)()) F98_1165;
	R1026[23] = (char *(*)()) F99_1167;
	R1026[25] = (char *(*)()) F101_1169;
	R1026[26] = (char *(*)()) F102_1171;
	R1026[27] = (char *(*)()) F103_1175;
	R1026[28] = (char *(*)()) F104_1179;
	R1026[30] = (char *(*)()) F106_1181;
	R1026[31] = (char *(*)()) F107_1183;
	R1026[33] = (char *(*)()) F109_1185;
	R1026[34] = (char *(*)()) F110_1187;
	R1026[35] = (char *(*)()) F111_1189;
	R1026[36] = (char *(*)()) F112_1193;
	R1026[37] = (char *(*)()) F113_1195;
	R1026[38] = (char *(*)()) F114_1197;
}

char *(*R1178[96])();
void R1178_init () {
	{long i; for (i = 0; i < 2; i++) R1178[i] = (char *(*)()) F698_3507;}
	{long i; for (i = 6; i < 8; i++) R1178[i] = (char *(*)()) F704_3578;}
	R1178[9] = (char *(*)()) F708_3681_1178_2;
	R1178[10] = (char *(*)()) F709_3681_1178_2;
	R1178[12] = (char *(*)()) F711_3780_1178_2;
	R1178[13] = (char *(*)()) F712_3780_1178_2;
	R1178[15] = (char *(*)()) F714_3879_1178_2;
	R1178[16] = (char *(*)()) F715_3879_1178_2;
	R1178[18] = (char *(*)()) F717_3978_1178_2;
	R1178[19] = (char *(*)()) F718_3978_1178_2;
	R1178[21] = (char *(*)()) F720_4073_1178_2;
	R1178[22] = (char *(*)()) F721_4073_1178_2;
	R1178[24] = (char *(*)()) F723_4167_1178_2;
	R1178[25] = (char *(*)()) F724_4167_1178_2;
	R1178[27] = (char *(*)()) F726_4262_1178_2;
	R1178[28] = (char *(*)()) F727_4262_1178_2;
	R1178[30] = (char *(*)()) F729_4357_1178_2;
	R1178[31] = (char *(*)()) F730_4357_1178_2;
	R1178[33] = (char *(*)()) F732_4426_1178_2;
	R1178[34] = (char *(*)()) F733_4426_1178_2;
	R1178[36] = (char *(*)()) F735_4492_1178_2;
	R1178[37] = (char *(*)()) F736_4492_1178_2;
	{long i; for (i = 80; i < 82; i++) R1178[i] = (char *(*)()) F778_4761;}
	{long i; for (i = 83; i < 85; i++) R1178[i] = (char *(*)()) F781_4926;}
	R1178[95] = (char *(*)()) F794_5304;
}
static EIF_BOOLEAN F708_3681_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F708_3681(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F709_3681_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F709_3681(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F711_3780_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F711_3780(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F712_3780_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F712_3780(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F714_3879_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F714_3879(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F715_3879_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F715_3879(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F717_3978_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F717_3978(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F718_3978_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F718_3978(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F720_4073_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F720_4073(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F721_4073_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F721_4073(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F723_4167_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F723_4167(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F724_4167_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F724_4167(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F726_4262_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F726_4262(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F727_4262_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F727_4262(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F729_4357_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F729_4357(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F730_4357_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F730_4357(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F732_4426_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F732_4426(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F733_4426_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F733_4426(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F735_4492_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F735_4492(Current, *(EIF_REAL_64 *)arg1);
}
static EIF_BOOLEAN F736_4492_1178_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F736_4492(Current, *(EIF_REAL_64 *)arg1);
}

char *(*R1708[629])();
void R1708_init () {
	R1708[0] = (char *(*)()) F146_1884;
	R1708[362] = (char *(*)()) F143_1884;
	R1708[363] = (char *(*)()) F144_1884;
	R1708[364] = (char *(*)()) F145_1884;
	R1708[365] = (char *(*)()) F146_1884;
	R1708[366] = (char *(*)()) F147_1884;
	R1708[367] = (char *(*)()) F148_1884;
	R1708[368] = (char *(*)()) F149_1884;
	R1708[369] = (char *(*)()) F150_1884;
	R1708[370] = (char *(*)()) F151_1884;
	R1708[371] = (char *(*)()) F152_1884;
	R1708[372] = (char *(*)()) F153_1884;
	R1708[373] = (char *(*)()) F154_1884;
	R1708[625] = (char *(*)()) F145_1884;
	R1708[628] = (char *(*)()) F144_1884;
}

char *(*R1709[629])();
void R1709_init () {
	R1709[0] = (char *(*)()) F146_1885_1709_112;
	R1709[362] = (char *(*)()) F143_1885;
	R1709[363] = (char *(*)()) F144_1885_1709_112;
	R1709[364] = (char *(*)()) F145_1885_1709_112;
	R1709[365] = (char *(*)()) F146_1885_1709_112;
	R1709[366] = (char *(*)()) F147_1885_1709_112;
	R1709[367] = (char *(*)()) F148_1885_1709_112;
	R1709[368] = (char *(*)()) F149_1885_1709_112;
	R1709[369] = (char *(*)()) F150_1885_1709_112;
	R1709[370] = (char *(*)()) F151_1885_1709_112;
	R1709[371] = (char *(*)()) F152_1885_1709_112;
	R1709[372] = (char *(*)()) F153_1885_1709_112;
	R1709[373] = (char *(*)()) F154_1885_1709_112;
	R1709[625] = (char *(*)()) F145_1885_1709_112;
	R1709[628] = (char *(*)()) F144_1885_1709_112;
}
static void F146_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F146_1885(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F144_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F144_1885(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F145_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F145_1885(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F147_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F147_1885(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F148_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F148_1885(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F149_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F149_1885(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F150_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F150_1885(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F151_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F151_1885(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F152_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F152_1885(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F153_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F153_1885(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F154_1885_1709_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F154_1885(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R1715[629])();
void R1715_init () {
	R1715[0] = (char *(*)()) F146_1891;
	R1715[362] = (char *(*)()) F143_1891;
	R1715[363] = (char *(*)()) F144_1891;
	R1715[364] = (char *(*)()) F145_1891;
	R1715[365] = (char *(*)()) F146_1891;
	R1715[366] = (char *(*)()) F147_1891;
	R1715[367] = (char *(*)()) F148_1891;
	R1715[368] = (char *(*)()) F149_1891;
	R1715[369] = (char *(*)()) F150_1891;
	R1715[370] = (char *(*)()) F151_1891;
	R1715[371] = (char *(*)()) F152_1891;
	R1715[372] = (char *(*)()) F153_1891;
	R1715[373] = (char *(*)()) F154_1891;
	R1715[625] = (char *(*)()) F145_1891;
	R1715[628] = (char *(*)()) F144_1891;
}

char *(*R1775[4])();
void R1775_init () {
	R1775[0] = (char *(*)()) F232_2079;
	R1775[1] = (char *(*)()) F233_2079;
	R1775[2] = (char *(*)()) F234_2079_1775_1;
	R1775[3] = (char *(*)()) F235_2079_1775_1;
}
static EIF_REFERENCE F234_2079_1775_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F234_2079(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F235_2079_1775_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F235_2079(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1776[195])();
void R1776_init () {
	R1776[0] = (char *(*)()) F232_2082;
	R1776[1] = (char *(*)()) F233_2082;
	R1776[2] = (char *(*)()) F234_2082;
	R1776[3] = (char *(*)()) F235_2082;
	R1776[194] = (char *(*)()) F425_2208;
}

char *(*R1777[195])();
void R1777_init () {
	R1777[0] = (char *(*)()) F232_2083;
	R1777[1] = (char *(*)()) F233_2083;
	R1777[2] = (char *(*)()) F234_2083;
	R1777[3] = (char *(*)()) F235_2083;
	R1777[194] = (char *(*)()) F425_2214;
}

char *(*R1788[4])();
void R1788_init () {
	R1788[0] = (char *(*)()) F232_2080;
	R1788[1] = (char *(*)()) F233_2080_1788_1;
	R1788[2] = (char *(*)()) F234_2080;
	R1788[3] = (char *(*)()) F235_2080_1788_1;
}
static EIF_REFERENCE F233_2080_1788_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F233_2080(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F235_2080_1788_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F235_2080(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R1790[7])();
void R1790_init () {
	R1790[0] = (char *(*)()) F594_2940;
	R1790[1] = (char *(*)()) F595_2940;
	R1790[2] = (char *(*)()) F596_2940;
	R1790[3] = (char *(*)()) F597_2940;
	R1790[4] = (char *(*)()) F594_2940;
	R1790[5] = (char *(*)()) F596_2940;
	R1790[6] = (char *(*)()) F594_2940;
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
static EIF_TYPE_INDEX Y1791_pgtype12[] = {0xFF01,779,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype13[] = {0xFF01,781,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype14[] = {705,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype15[] = {0xFFF8,1,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype85[] = {699,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype86[] = {705,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype87[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype88[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype89[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype90[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype91[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype92[] = {0xFFF8,1,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype251[] = {711,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype270[] = {0xFFF8,1,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype314[] = {699,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype315[] = {699,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype316[] = {699,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype338[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype339[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype340[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype341[] = {711,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype367[] = {0xFFF8,1,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype423[] = {0,0xFFFF};
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
static EIF_TYPE_INDEX Y1791_pgtype436[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype437[] = {699,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype438[] = {699,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype439[] = {699,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype440[] = {705,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype441[] = {705,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype442[] = {705,0xFFFF};
static EIF_TYPE_INDEX Y1791_pgtype443[] = {699,0xFFFF};
EIF_TYPE_INDEX *Y1791_gen_type [610];
EIF_TYPE_INDEX Y1791 [610];
void Y1791_init (void)
{
	egc_routines_types [1791] = Y1791;
	egc_routines_gen_types [1791] = Y1791_gen_type;
	egc_routines_offset [1791] = 174;
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
	Y1791_gen_type [405] = Y1791_pgtype404;
	Y1791_gen_type [406] = Y1791_pgtype405;
	Y1791_gen_type [407] = Y1791_pgtype406;
	Y1791_gen_type [408] = Y1791_pgtype407;
	Y1791_gen_type [409] = Y1791_pgtype408;
	Y1791_gen_type [410] = Y1791_pgtype409;
	Y1791_gen_type [411] = Y1791_pgtype410;
	Y1791_gen_type [412] = Y1791_pgtype411;
	Y1791_gen_type [413] = Y1791_pgtype412;
	Y1791_gen_type [414] = Y1791_pgtype413;
	Y1791_gen_type [415] = Y1791_pgtype414;
	Y1791_gen_type [416] = Y1791_pgtype415;
	Y1791_gen_type [417] = Y1791_pgtype416;
	Y1791_gen_type [419] = Y1791_pgtype417;
	Y1791_gen_type [420] = Y1791_pgtype418;
	Y1791_gen_type [421] = Y1791_pgtype419;
	Y1791_gen_type [422] = Y1791_pgtype420;
	Y1791_gen_type [423] = Y1791_pgtype421;
	Y1791_gen_type [424] = Y1791_pgtype422;
	Y1791_gen_type [425] = Y1791_pgtype423;
	Y1791_gen_type [430] = Y1791_pgtype424;
	Y1791_gen_type [431] = Y1791_pgtype425;
	Y1791_gen_type [432] = Y1791_pgtype426;
	Y1791_gen_type [433] = Y1791_pgtype427;
	Y1791_gen_type [434] = Y1791_pgtype428;
	Y1791_gen_type [435] = Y1791_pgtype429;
	Y1791_gen_type [436] = Y1791_pgtype430;
	Y1791_gen_type [437] = Y1791_pgtype431;
	Y1791_gen_type [438] = Y1791_pgtype432;
	Y1791_gen_type [439] = Y1791_pgtype433;
	Y1791_gen_type [440] = Y1791_pgtype434;
	Y1791_gen_type [441] = Y1791_pgtype435;
	Y1791_gen_type [522] = Y1791_pgtype436;
	Y1791_gen_type [603] = Y1791_pgtype437;
	Y1791_gen_type [604] = Y1791_pgtype438;
	Y1791_gen_type [605] = Y1791_pgtype439;
	Y1791_gen_type [606] = Y1791_pgtype440;
	Y1791_gen_type [607] = Y1791_pgtype441;
	Y1791_gen_type [608] = Y1791_pgtype442;
	Y1791_gen_type [609] = Y1791_pgtype443;
	Y1791[12] = 779;
	Y1791[13] = 781;
	Y1791[14] = 705;
	Y1791[85] = 699;
	Y1791[86] = 705;
	Y1791[251] = 711;
	{long i; for (i = 314; i < 317; i++) Y1791[i] = 699;};
	Y1791[341] = 711;
	Y1791[425] = 0;
	Y1791[522] = 0;
	{long i; for (i = 603; i < 606; i++) Y1791[i] = 699;};
	{long i; for (i = 606; i < 609; i++) Y1791[i] = 705;};
	Y1791[609] = 699;
}

char *(*R1853[4])();
void R1853_init () {
	{long i; for (i = 0; i < 2; i++) R1853[i] = (char *(*)()) F218_2065;}
	{long i; for (i = 2; i < 4; i++) R1853[i] = (char *(*)()) F226_2065;}
}

char *(*R1856[4])();
void R1856_init () {
	{long i; for (i = 0; i < 2; i++) R1856[i] = (char *(*)()) F218_2070;}
	{long i; for (i = 2; i < 4; i++) R1856[i] = (char *(*)()) F226_2070;}
}

char *(*R1859[4])();
void R1859_init () {
	{long i; for (i = 0; i < 2; i++) R1859[i] = (char *(*)()) F218_2052;}
	{long i; for (i = 2; i < 4; i++) R1859[i] = (char *(*)()) F226_2052;}
}

char *(*R1890[359])();
void R1890_init () {
	R1890[0] = (char *(*)()) F294_2138;
	R1890[91] = (char *(*)()) F286_2138;
	R1890[92] = (char *(*)()) F287_2138;
	R1890[93] = (char *(*)()) F288_2138;
	R1890[94] = (char *(*)()) F289_2138;
	R1890[95] = (char *(*)()) F290_2138;
	R1890[96] = (char *(*)()) F291_2138;
	R1890[97] = (char *(*)()) F292_2138;
	R1890[98] = (char *(*)()) F293_2138;
	R1890[99] = (char *(*)()) F294_2138;
	R1890[100] = (char *(*)()) F295_2138;
	R1890[101] = (char *(*)()) F296_2138;
	R1890[102] = (char *(*)()) F297_2138;
	{long i; for (i = 168; i < 170; i++) R1890[i] = (char *(*)()) F286_2138;}
	{long i; for (i = 170; i < 172; i++) R1890[i] = (char *(*)()) F294_2138;}
	R1890[172] = (char *(*)()) F286_2138;
	R1890[173] = (char *(*)()) F294_2138;
	R1890[174] = (char *(*)()) F286_2138;
	R1890[354] = (char *(*)()) F288_2138;
	R1890[357] = (char *(*)()) F287_2138;
	R1890[358] = (char *(*)()) F288_2138;
}

char *(*R1923[267])();
void R1923_init () {
	R1923[0] = (char *(*)()) F517_2658_1923_5;
	R1923[1] = (char *(*)()) F518_2658_1923_5;
	R1923[2] = (char *(*)()) F519_2658_1923_5;
	R1923[3] = (char *(*)()) F520_2658_1923_5;
	R1923[4] = (char *(*)()) F521_2658_1923_5;
	R1923[5] = (char *(*)()) F522_2658_1923_5;
	R1923[6] = (char *(*)()) F523_2658_1923_5;
	R1923[7] = (char *(*)()) F524_2658_1923_5;
	R1923[8] = (char *(*)()) F525_2658_1923_5;
	R1923[9] = (char *(*)()) F526_2658_1923_5;
	R1923[10] = (char *(*)()) F527_2658_1923_5;
	R1923[11] = (char *(*)()) F528_2658_1923_5;
	R1923[266] = (char *(*)()) F783_4979_1923_5;
}
static EIF_REFERENCE F517_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F517_2658(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_REFERENCE F518_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F518_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F519_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F519_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F520_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F520_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(729, 0x00).id, 729, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F521_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F521_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(726, 0x00).id, 726, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F522_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F522_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F523_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F523_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F524_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F524_2658(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F525_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F525_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F526_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F526_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(702, 0x00).id, 702, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F527_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F527_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(720, 0x00).id, 720, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F528_2658_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F528_2658(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(723, 0x00).id, 723, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F783_4979_1923_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F783_4979(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R1926[264])();
void R1926_init () {
	R1926[0] = (char *(*)()) F517_2677_1926_8;
	R1926[1] = (char *(*)()) F518_2677_1926_8;
	R1926[2] = (char *(*)()) F519_2677_1926_8;
	R1926[3] = (char *(*)()) F520_2677_1926_8;
	R1926[4] = (char *(*)()) F521_2677_1926_8;
	R1926[5] = (char *(*)()) F522_2677_1926_8;
	R1926[6] = (char *(*)()) F523_2677_1926_8;
	R1926[7] = (char *(*)()) F524_2677_1926_8;
	R1926[8] = (char *(*)()) F525_2677_1926_8;
	R1926[9] = (char *(*)()) F526_2677_1926_8;
	R1926[10] = (char *(*)()) F527_2677_1926_8;
	R1926[11] = (char *(*)()) F528_2677_1926_8;
	R1926[77] = (char *(*)()) F594_2971;
	R1926[78] = (char *(*)()) F595_2971_1926_8;
	R1926[79] = (char *(*)()) F596_2971_1926_8;
	R1926[80] = (char *(*)()) F597_2971_1926_8;
	R1926[81] = (char *(*)()) F594_2971;
	R1926[82] = (char *(*)()) F596_2971_1926_8;
	R1926[83] = (char *(*)()) F594_2971;
	R1926[263] = (char *(*)()) F780_4831_1926_8;
}
static void F517_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F517_2677(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F518_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F518_2677(Current, *(EIF_CHARACTER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F519_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F519_2677(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F520_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F520_2677(Current, *(EIF_NATURAL_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F521_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F521_2677(Current, *(EIF_NATURAL_16 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F522_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F522_2677(Current, *(EIF_POINTER *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F523_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F523_2677(Current, *(EIF_REAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F524_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F524_2677(Current, *(EIF_REAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F525_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F525_2677(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F526_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F526_2677(Current, *(EIF_BOOLEAN *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F527_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F527_2677(Current, *(EIF_NATURAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F528_2677_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F528_2677(Current, *(EIF_NATURAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F595_2971_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F595_2971(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F596_2971_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F596_2971(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F597_2971_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F597_2971(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F780_4831_1926_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F780_4831(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
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
static EIF_TYPE_INDEX Y1928_pgtype28[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype29[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype30[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype31[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype32[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype33[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype34[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype35[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype36[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype37[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype38[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype39[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype40[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype41[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype42[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype43[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype44[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype45[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype46[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype47[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype48[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype49[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype50[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype51[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype52[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype53[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype54[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype55[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype56[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype57[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype58[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype59[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype60[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype61[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype62[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype63[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype64[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype65[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype66[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype67[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype68[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype69[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype70[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype71[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype72[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype73[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype74[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype75[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype76[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype77[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype78[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype79[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype80[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype81[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype82[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype83[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype84[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype85[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype86[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype87[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype88[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype89[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype90[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype91[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype92[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype93[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype94[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype95[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype96[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype97[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype98[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype99[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype100[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype101[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype102[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype103[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype104[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype105[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype106[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype107[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype108[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype109[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype110[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype111[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype112[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype113[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype114[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype115[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype116[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype117[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype118[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype119[] = {0xFF01,774,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype120[] = {0xFF01,774,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype121[] = {0xFF01,779,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype122[] = {711,0xFFFF};
static EIF_TYPE_INDEX Y1928_pgtype123[] = {711,0xFFFF};
EIF_TYPE_INDEX *Y1928_gen_type [425];
EIF_TYPE_INDEX Y1928 [425];
void Y1928_init (void)
{
	egc_routines_types [1928] = Y1928;
	egc_routines_gen_types [1928] = Y1928_gen_type;
	egc_routines_offset [1928] = 358;
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
	Y1928_gen_type [145] = Y1928_pgtype28;
	Y1928_gen_type [146] = Y1928_pgtype29;
	Y1928_gen_type [147] = Y1928_pgtype30;
	Y1928_gen_type [148] = Y1928_pgtype31;
	Y1928_gen_type [149] = Y1928_pgtype32;
	Y1928_gen_type [150] = Y1928_pgtype33;
	Y1928_gen_type [151] = Y1928_pgtype34;
	Y1928_gen_type [152] = Y1928_pgtype35;
	Y1928_gen_type [153] = Y1928_pgtype36;
	Y1928_gen_type [154] = Y1928_pgtype37;
	Y1928_gen_type [155] = Y1928_pgtype38;
	Y1928_gen_type [156] = Y1928_pgtype39;
	Y1928_gen_type [157] = Y1928_pgtype40;
	Y1928_gen_type [158] = Y1928_pgtype41;
	Y1928_gen_type [159] = Y1928_pgtype42;
	Y1928_gen_type [160] = Y1928_pgtype43;
	Y1928_gen_type [161] = Y1928_pgtype44;
	Y1928_gen_type [162] = Y1928_pgtype45;
	Y1928_gen_type [163] = Y1928_pgtype46;
	Y1928_gen_type [164] = Y1928_pgtype47;
	Y1928_gen_type [165] = Y1928_pgtype48;
	Y1928_gen_type [166] = Y1928_pgtype49;
	Y1928_gen_type [167] = Y1928_pgtype50;
	Y1928_gen_type [168] = Y1928_pgtype51;
	Y1928_gen_type [169] = Y1928_pgtype52;
	Y1928_gen_type [170] = Y1928_pgtype53;
	Y1928_gen_type [171] = Y1928_pgtype54;
	Y1928_gen_type [172] = Y1928_pgtype55;
	Y1928_gen_type [173] = Y1928_pgtype56;
	Y1928_gen_type [174] = Y1928_pgtype57;
	Y1928_gen_type [175] = Y1928_pgtype58;
	Y1928_gen_type [176] = Y1928_pgtype59;
	Y1928_gen_type [177] = Y1928_pgtype60;
	Y1928_gen_type [178] = Y1928_pgtype61;
	Y1928_gen_type [179] = Y1928_pgtype62;
	Y1928_gen_type [180] = Y1928_pgtype63;
	Y1928_gen_type [181] = Y1928_pgtype64;
	Y1928_gen_type [182] = Y1928_pgtype65;
	Y1928_gen_type [183] = Y1928_pgtype66;
	Y1928_gen_type [184] = Y1928_pgtype67;
	Y1928_gen_type [185] = Y1928_pgtype68;
	Y1928_gen_type [186] = Y1928_pgtype69;
	Y1928_gen_type [187] = Y1928_pgtype70;
	Y1928_gen_type [188] = Y1928_pgtype71;
	Y1928_gen_type [189] = Y1928_pgtype72;
	Y1928_gen_type [190] = Y1928_pgtype73;
	Y1928_gen_type [191] = Y1928_pgtype74;
	Y1928_gen_type [192] = Y1928_pgtype75;
	Y1928_gen_type [193] = Y1928_pgtype76;
	Y1928_gen_type [194] = Y1928_pgtype77;
	Y1928_gen_type [195] = Y1928_pgtype78;
	Y1928_gen_type [196] = Y1928_pgtype79;
	Y1928_gen_type [197] = Y1928_pgtype80;
	Y1928_gen_type [198] = Y1928_pgtype81;
	Y1928_gen_type [199] = Y1928_pgtype82;
	Y1928_gen_type [200] = Y1928_pgtype83;
	Y1928_gen_type [201] = Y1928_pgtype84;
	Y1928_gen_type [202] = Y1928_pgtype85;
	Y1928_gen_type [203] = Y1928_pgtype86;
	Y1928_gen_type [204] = Y1928_pgtype87;
	Y1928_gen_type [205] = Y1928_pgtype88;
	Y1928_gen_type [206] = Y1928_pgtype89;
	Y1928_gen_type [207] = Y1928_pgtype90;
	Y1928_gen_type [208] = Y1928_pgtype91;
	Y1928_gen_type [209] = Y1928_pgtype92;
	Y1928_gen_type [210] = Y1928_pgtype93;
	Y1928_gen_type [211] = Y1928_pgtype94;
	Y1928_gen_type [212] = Y1928_pgtype95;
	Y1928_gen_type [213] = Y1928_pgtype96;
	Y1928_gen_type [214] = Y1928_pgtype97;
	Y1928_gen_type [215] = Y1928_pgtype98;
	Y1928_gen_type [216] = Y1928_pgtype99;
	Y1928_gen_type [217] = Y1928_pgtype100;
	Y1928_gen_type [218] = Y1928_pgtype101;
	Y1928_gen_type [219] = Y1928_pgtype102;
	Y1928_gen_type [222] = Y1928_pgtype103;
	Y1928_gen_type [223] = Y1928_pgtype104;
	Y1928_gen_type [224] = Y1928_pgtype105;
	Y1928_gen_type [225] = Y1928_pgtype106;
	Y1928_gen_type [226] = Y1928_pgtype107;
	Y1928_gen_type [227] = Y1928_pgtype108;
	Y1928_gen_type [228] = Y1928_pgtype109;
	Y1928_gen_type [229] = Y1928_pgtype110;
	Y1928_gen_type [230] = Y1928_pgtype111;
	Y1928_gen_type [231] = Y1928_pgtype112;
	Y1928_gen_type [232] = Y1928_pgtype113;
	Y1928_gen_type [233] = Y1928_pgtype114;
	Y1928_gen_type [235] = Y1928_pgtype115;
	Y1928_gen_type [236] = Y1928_pgtype116;
	Y1928_gen_type [237] = Y1928_pgtype117;
	Y1928_gen_type [238] = Y1928_pgtype118;
	Y1928_gen_type [239] = Y1928_pgtype119;
	Y1928_gen_type [240] = Y1928_pgtype120;
	Y1928_gen_type [241] = Y1928_pgtype121;
	Y1928_gen_type [421] = Y1928_pgtype122;
	Y1928_gen_type [424] = Y1928_pgtype123;
	{long i; for (i = 145; i < 220; i++) Y1928[i] = 711;};
	{long i; for (i = 222; i < 234; i++) Y1928[i] = 711;};
	{long i; for (i = 239; i < 241; i++) Y1928[i] = 774;};
	Y1928[241] = 779;
	Y1928[421] = 711;
	Y1928[424] = 711;
}

char *(*R1950[268])();
void R1950_init () {
	R1950[0] = (char *(*)()) F517_2665;
	R1950[1] = (char *(*)()) F518_2665;
	R1950[2] = (char *(*)()) F519_2665;
	R1950[3] = (char *(*)()) F520_2665;
	R1950[4] = (char *(*)()) F521_2665;
	R1950[5] = (char *(*)()) F522_2665;
	R1950[6] = (char *(*)()) F523_2665;
	R1950[7] = (char *(*)()) F524_2665;
	R1950[8] = (char *(*)()) F525_2665;
	R1950[9] = (char *(*)()) F526_2665;
	R1950[10] = (char *(*)()) F527_2665;
	R1950[11] = (char *(*)()) F528_2665;
	R1950[77] = (char *(*)()) F594_2943;
	R1950[78] = (char *(*)()) F595_2943;
	R1950[79] = (char *(*)()) F596_2943;
	R1950[80] = (char *(*)()) F597_2943;
	R1950[81] = (char *(*)()) F594_2943;
	R1950[82] = (char *(*)()) F596_2943;
	R1950[83] = (char *(*)()) F594_2943;
	R1950[263] = (char *(*)()) F778_4753;
	R1950[266] = (char *(*)()) F781_4918;
	R1950[267] = (char *(*)()) F784_5071;
}

char *(*R1953[267])();
void R1953_init () {
	R1953[0] = (char *(*)()) F517_2666;
	R1953[1] = (char *(*)()) F518_2666;
	R1953[2] = (char *(*)()) F519_2666;
	R1953[3] = (char *(*)()) F520_2666;
	R1953[4] = (char *(*)()) F521_2666;
	R1953[5] = (char *(*)()) F522_2666;
	R1953[6] = (char *(*)()) F523_2666;
	R1953[7] = (char *(*)()) F524_2666;
	R1953[8] = (char *(*)()) F525_2666;
	R1953[9] = (char *(*)()) F526_2666;
	R1953[10] = (char *(*)()) F527_2666;
	R1953[11] = (char *(*)()) F528_2666;
	R1953[263] = (char *(*)()) F778_4752;
	R1953[266] = (char *(*)()) F781_4917;
}

char *(*R2160[267])();
void R2160_init () {
	R2160[0] = (char *(*)()) F517_2658;
	R2160[1] = (char *(*)()) F518_2658_2160_33;
	R2160[2] = (char *(*)()) F519_2658_2160_33;
	R2160[3] = (char *(*)()) F520_2658_2160_33;
	R2160[4] = (char *(*)()) F521_2658_2160_33;
	R2160[5] = (char *(*)()) F522_2658_2160_33;
	R2160[6] = (char *(*)()) F523_2658_2160_33;
	R2160[7] = (char *(*)()) F524_2658_2160_33;
	R2160[8] = (char *(*)()) F525_2658_2160_33;
	R2160[9] = (char *(*)()) F526_2658_2160_33;
	R2160[10] = (char *(*)()) F527_2658_2160_33;
	R2160[11] = (char *(*)()) F528_2658_2160_33;
	R2160[88] = (char *(*)()) F605_3157;
	R2160[89] = (char *(*)()) F606_3157_2160_33;
	R2160[90] = (char *(*)()) F607_3157_2160_33;
	R2160[91] = (char *(*)()) F608_3157_2160_33;
	R2160[92] = (char *(*)()) F609_3157_2160_33;
	R2160[93] = (char *(*)()) F610_3157_2160_33;
	R2160[94] = (char *(*)()) F611_3157_2160_33;
	R2160[95] = (char *(*)()) F612_3157_2160_33;
	R2160[96] = (char *(*)()) F613_3157_2160_33;
	R2160[97] = (char *(*)()) F614_3157_2160_33;
	R2160[98] = (char *(*)()) F615_3157_2160_33;
	R2160[99] = (char *(*)()) F616_3157_2160_33;
	R2160[180] = (char *(*)()) F697_3368;
	R2160[265] = (char *(*)()) F782_4956_2160_33;
	R2160[266] = (char *(*)()) F783_4979_2160_33;
}
static EIF_REFERENCE F518_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F518_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F519_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F519_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F520_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F520_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(729, 0x00).id, 729, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F521_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F521_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(726, 0x00).id, 726, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F522_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F522_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F523_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F523_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F524_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F524_2658(Current, arg1);
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
static EIF_REFERENCE F525_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F525_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F526_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F526_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(702, 0x00).id, 702, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F527_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F527_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(720, 0x00).id, 720, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F528_2658_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F528_2658(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(723, 0x00).id, 723, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F606_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F606_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F607_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F607_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F608_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F608_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(729, 0x00).id, 729, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F609_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F609_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(726, 0x00).id, 726, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F610_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F610_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F611_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F611_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F612_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F612_3157(Current, arg1);
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
static EIF_REFERENCE F613_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F613_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F614_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F614_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(702, 0x00).id, 702, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F615_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F615_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(720, 0x00).id, 720, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F616_3157_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F616_3157(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(723, 0x00).id, 723, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F782_4956_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F782_4956(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F783_4979_2160_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F783_4979(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}

char *(*R2161[267])();
void R2161_init () {
	R2161[0] = (char *(*)()) F517_2663;
	R2161[1] = (char *(*)()) F518_2663;
	R2161[2] = (char *(*)()) F519_2663;
	R2161[3] = (char *(*)()) F520_2663;
	R2161[4] = (char *(*)()) F521_2663;
	R2161[5] = (char *(*)()) F522_2663;
	R2161[6] = (char *(*)()) F523_2663;
	R2161[7] = (char *(*)()) F524_2663;
	R2161[8] = (char *(*)()) F525_2663;
	R2161[9] = (char *(*)()) F526_2663;
	R2161[10] = (char *(*)()) F527_2663;
	R2161[11] = (char *(*)()) F528_2663;
	R2161[77] = (char *(*)()) F594_2946;
	R2161[78] = (char *(*)()) F595_2946;
	R2161[79] = (char *(*)()) F596_2946;
	R2161[80] = (char *(*)()) F597_2946;
	R2161[81] = (char *(*)()) F594_2946;
	R2161[82] = (char *(*)()) F596_2946;
	R2161[83] = (char *(*)()) F594_2946;
	R2161[88] = (char *(*)()) F605_3165;
	R2161[89] = (char *(*)()) F606_3165;
	R2161[90] = (char *(*)()) F607_3165;
	R2161[91] = (char *(*)()) F608_3165;
	R2161[92] = (char *(*)()) F609_3165;
	R2161[93] = (char *(*)()) F610_3165;
	R2161[94] = (char *(*)()) F611_3165;
	R2161[95] = (char *(*)()) F612_3165;
	R2161[96] = (char *(*)()) F613_3165;
	R2161[97] = (char *(*)()) F614_3165;
	R2161[98] = (char *(*)()) F615_3165;
	R2161[99] = (char *(*)()) F616_3165;
	R2161[180] = (char *(*)()) F697_3398;
	{long i; for (i = 262; i < 264; i++) R2161[i] = (char *(*)()) F778_4755;}
	{long i; for (i = 265; i < 267; i++) R2161[i] = (char *(*)()) F781_4920;}
}

EIF_TYPE_INDEX *Y2161_gen_type [292];
EIF_TYPE_INDEX Y2161 [292];
void Y2161_init (void)
{
	egc_routines_types [2161] = Y2161;
	egc_routines_gen_types [2161] = Y2161_gen_type;
	egc_routines_offset [2161] = 491;
	{long i; for (i = 0; i < 87; i++) Y2161[i] = 711;};
	{long i; for (i = 89; i < 101; i++) Y2161[i] = 711;};
	{long i; for (i = 102; i < 109; i++) Y2161[i] = 711;};
	{long i; for (i = 113; i < 125; i++) Y2161[i] = 711;};
	Y2161[205] = 711;
	{long i; for (i = 286; i < 292; i++) Y2161[i] = 711;};
}

char *(*R2162[267])();
void R2162_init () {
	R2162[0] = (char *(*)()) F517_2664;
	R2162[1] = (char *(*)()) F518_2664;
	R2162[2] = (char *(*)()) F519_2664;
	R2162[3] = (char *(*)()) F520_2664;
	R2162[4] = (char *(*)()) F521_2664;
	R2162[5] = (char *(*)()) F522_2664;
	R2162[6] = (char *(*)()) F523_2664;
	R2162[7] = (char *(*)()) F524_2664;
	R2162[8] = (char *(*)()) F525_2664;
	R2162[9] = (char *(*)()) F526_2664;
	R2162[10] = (char *(*)()) F527_2664;
	R2162[11] = (char *(*)()) F528_2664;
	R2162[77] = (char *(*)()) F594_2947;
	R2162[78] = (char *(*)()) F595_2947;
	R2162[79] = (char *(*)()) F596_2947;
	R2162[80] = (char *(*)()) F597_2947;
	R2162[81] = (char *(*)()) F594_2947;
	R2162[82] = (char *(*)()) F596_2947;
	R2162[83] = (char *(*)()) F594_2947;
	R2162[88] = (char *(*)()) F605_3166;
	R2162[89] = (char *(*)()) F606_3166;
	R2162[90] = (char *(*)()) F607_3166;
	R2162[91] = (char *(*)()) F608_3166;
	R2162[92] = (char *(*)()) F609_3166;
	R2162[93] = (char *(*)()) F610_3166;
	R2162[94] = (char *(*)()) F611_3166;
	R2162[95] = (char *(*)()) F612_3166;
	R2162[96] = (char *(*)()) F613_3166;
	R2162[97] = (char *(*)()) F614_3166;
	R2162[98] = (char *(*)()) F615_3166;
	R2162[99] = (char *(*)()) F616_3166;
	R2162[180] = (char *(*)()) F697_3397;
	{long i; for (i = 262; i < 264; i++) R2162[i] = (char *(*)()) F778_4753;}
	{long i; for (i = 265; i < 267; i++) R2162[i] = (char *(*)()) F781_4918;}
}

char *(*R2188[12])();
void R2188_init () {
	R2188[0] = (char *(*)()) F517_2656;
	R2188[1] = (char *(*)()) F518_2656;
	R2188[2] = (char *(*)()) F519_2656;
	R2188[3] = (char *(*)()) F520_2656;
	R2188[4] = (char *(*)()) F521_2656;
	R2188[5] = (char *(*)()) F522_2656;
	R2188[6] = (char *(*)()) F523_2656;
	R2188[7] = (char *(*)()) F524_2656;
	R2188[8] = (char *(*)()) F525_2656;
	R2188[9] = (char *(*)()) F526_2656;
	R2188[10] = (char *(*)()) F527_2656;
	R2188[11] = (char *(*)()) F528_2656;
}

char *(*R2253[190])();
void R2253_init () {
	R2253[0] = (char *(*)()) F594_2984;
	R2253[1] = (char *(*)()) F595_2984;
	R2253[2] = (char *(*)()) F596_2984;
	R2253[3] = (char *(*)()) F597_2984;
	R2253[4] = (char *(*)()) F594_2984;
	R2253[5] = (char *(*)()) F596_2984;
	R2253[6] = (char *(*)()) F594_2984;
	R2253[103] = (char *(*)()) F697_3476;
	R2253[186] = (char *(*)()) F780_4894;
	R2253[188] = (char *(*)()) F782_4972;
	R2253[189] = (char *(*)()) F783_5063;
}

char *(*R2290[7])();
void R2290_init () {
	R2290[0] = (char *(*)()) F594_2925;
	R2290[1] = (char *(*)()) F595_2925;
	R2290[2] = (char *(*)()) F596_2925;
	R2290[3] = (char *(*)()) F597_2925;
	R2290[4] = (char *(*)()) F594_2925;
	R2290[5] = (char *(*)()) F596_2925;
	R2290[6] = (char *(*)()) F594_2925;
}

char *(*R2293[7])();
void R2293_init () {
	R2293[0] = (char *(*)()) F594_2928;
	R2293[1] = (char *(*)()) F595_2928;
	R2293[2] = (char *(*)()) F596_2928;
	R2293[3] = (char *(*)()) F597_2928;
	R2293[4] = (char *(*)()) F594_2928;
	R2293[5] = (char *(*)()) F596_2928;
	R2293[6] = (char *(*)()) F594_2928;
}

char *(*R2294[7])();
void R2294_init () {
	R2294[0] = (char *(*)()) F594_2929;
	R2294[1] = (char *(*)()) F595_2929;
	R2294[2] = (char *(*)()) F596_2929_2294_1;
	R2294[3] = (char *(*)()) F597_2929_2294_1;
	R2294[4] = (char *(*)()) F594_2929;
	R2294[5] = (char *(*)()) F596_2929_2294_1;
	R2294[6] = (char *(*)()) F594_2929;
}
static EIF_REFERENCE F596_2929_2294_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F596_2929(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F597_2929_2294_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F597_2929(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2302[7])();
void R2302_init () {
	R2302[0] = (char *(*)()) F594_2942;
	R2302[1] = (char *(*)()) F595_2942_2302_10;
	R2302[2] = (char *(*)()) F596_2942;
	R2302[3] = (char *(*)()) F597_2942_2302_10;
	R2302[4] = (char *(*)()) F598_3039;
	R2302[5] = (char *(*)()) F599_3039;
	R2302[6] = (char *(*)()) F594_2942;
}
static EIF_INTEGER_32 F595_2942_2302_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F595_2942(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_INTEGER_32 F597_2942_2302_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F597_2942(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2304[7])();
void R2304_init () {
	R2304[0] = (char *(*)()) F594_2949;
	R2304[1] = (char *(*)()) F595_2949_2304_3;
	R2304[2] = (char *(*)()) F596_2949;
	R2304[3] = (char *(*)()) F597_2949_2304_3;
	R2304[4] = (char *(*)()) F598_3041;
	R2304[5] = (char *(*)()) F599_3041;
	R2304[6] = (char *(*)()) F594_2949;
}
static EIF_BOOLEAN F595_2949_2304_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F595_2949(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static EIF_BOOLEAN F597_2949_2304_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F597_2949(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

char *(*R2310[7])();
void R2310_init () {
	R2310[0] = (char *(*)()) F594_2957;
	R2310[1] = (char *(*)()) F595_2957;
	R2310[2] = (char *(*)()) F596_2957;
	R2310[3] = (char *(*)()) F597_2957;
	R2310[4] = (char *(*)()) F594_2957;
	R2310[5] = (char *(*)()) F596_2957;
	R2310[6] = (char *(*)()) F594_2957;
}

char *(*R2311[7])();
void R2311_init () {
	R2311[0] = (char *(*)()) F594_2958;
	R2311[1] = (char *(*)()) F595_2958;
	R2311[2] = (char *(*)()) F596_2958;
	R2311[3] = (char *(*)()) F597_2958;
	R2311[4] = (char *(*)()) F594_2958;
	R2311[5] = (char *(*)()) F596_2958;
	R2311[6] = (char *(*)()) F594_2958;
}

char *(*R2319[7])();
void R2319_init () {
	R2319[0] = (char *(*)()) F594_2967;
	R2319[1] = (char *(*)()) F595_2967_2319_4;
	R2319[2] = (char *(*)()) F596_2967;
	R2319[3] = (char *(*)()) F597_2967_2319_4;
	R2319[4] = (char *(*)()) F594_2967;
	R2319[5] = (char *(*)()) F596_2967;
	R2319[6] = (char *(*)()) F594_2967;
}
static void F595_2967_2319_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F595_2967(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F597_2967_2319_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F597_2967(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2321[7])();
void R2321_init () {
	R2321[0] = (char *(*)()) F594_2969;
	R2321[1] = (char *(*)()) F595_2969;
	R2321[2] = (char *(*)()) F596_2969;
	R2321[3] = (char *(*)()) F597_2969;
	R2321[4] = (char *(*)()) F594_2969;
	R2321[5] = (char *(*)()) F596_2969;
	R2321[6] = (char *(*)()) F594_2969;
}

char *(*R2322[7])();
void R2322_init () {
	R2322[0] = (char *(*)()) F594_2970;
	R2322[1] = (char *(*)()) F595_2970;
	R2322[2] = (char *(*)()) F596_2970;
	R2322[3] = (char *(*)()) F597_2970;
	R2322[4] = (char *(*)()) F594_2970;
	R2322[5] = (char *(*)()) F596_2970;
	R2322[6] = (char *(*)()) F594_2970;
}

char *(*R2328[7])();
void R2328_init () {
	R2328[0] = (char *(*)()) F594_2983;
	R2328[1] = (char *(*)()) F595_2983;
	R2328[2] = (char *(*)()) F596_2983;
	R2328[3] = (char *(*)()) F597_2983;
	R2328[4] = (char *(*)()) F598_3043;
	R2328[5] = (char *(*)()) F599_3043;
	R2328[6] = (char *(*)()) F594_2983;
}

char *(*R2337[7])();
void R2337_init () {
	R2337[0] = (char *(*)()) F594_2993;
	R2337[1] = (char *(*)()) F595_2993;
	R2337[2] = (char *(*)()) F596_2993;
	R2337[3] = (char *(*)()) F597_2993;
	R2337[4] = (char *(*)()) F594_2993;
	R2337[5] = (char *(*)()) F596_2993;
	R2337[6] = (char *(*)()) F594_2993;
}

char *(*R2338[7])();
void R2338_init () {
	R2338[0] = (char *(*)()) F594_2994;
	R2338[1] = (char *(*)()) F595_2994;
	R2338[2] = (char *(*)()) F596_2994;
	R2338[3] = (char *(*)()) F597_2994;
	R2338[4] = (char *(*)()) F594_2994;
	R2338[5] = (char *(*)()) F596_2994;
	R2338[6] = (char *(*)()) F594_2994;
}

char *(*R2345[7])();
void R2345_init () {
	R2345[0] = (char *(*)()) F594_3001;
	R2345[1] = (char *(*)()) F595_3001;
	R2345[2] = (char *(*)()) F596_3001_2345_1;
	R2345[3] = (char *(*)()) F597_3001_2345_1;
	R2345[4] = (char *(*)()) F594_3001;
	R2345[5] = (char *(*)()) F596_3001_2345_1;
	R2345[6] = (char *(*)()) F594_3001;
}
static EIF_REFERENCE F596_3001_2345_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F596_3001(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F597_3001_2345_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F597_3001(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2346[7])();
void R2346_init () {
	R2346[0] = (char *(*)()) F594_3002;
	R2346[1] = (char *(*)()) F595_3002_2346_1;
	R2346[2] = (char *(*)()) F596_3002;
	R2346[3] = (char *(*)()) F597_3002_2346_1;
	R2346[4] = (char *(*)()) F594_3002;
	R2346[5] = (char *(*)()) F596_3002;
	R2346[6] = (char *(*)()) F594_3002;
}
static EIF_REFERENCE F595_3002_2346_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F595_3002(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F597_3002_2346_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F597_3002(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}

char *(*R2347[7])();
void R2347_init () {
	R2347[0] = (char *(*)()) F594_3003;
	R2347[1] = (char *(*)()) F595_3003;
	R2347[2] = (char *(*)()) F596_3003;
	R2347[3] = (char *(*)()) F597_3003;
	R2347[4] = (char *(*)()) F594_3003;
	R2347[5] = (char *(*)()) F596_3003;
	R2347[6] = (char *(*)()) F594_3003;
}

char *(*R2348[7])();
void R2348_init () {
	R2348[0] = (char *(*)()) F594_3004;
	R2348[1] = (char *(*)()) F595_3004;
	R2348[2] = (char *(*)()) F596_3004;
	R2348[3] = (char *(*)()) F597_3004;
	R2348[4] = (char *(*)()) F594_3004;
	R2348[5] = (char *(*)()) F596_3004;
	R2348[6] = (char *(*)()) F594_3004;
}

char *(*R2351[7])();
void R2351_init () {
	R2351[0] = (char *(*)()) F594_3007;
	R2351[1] = (char *(*)()) F595_3007;
	R2351[2] = (char *(*)()) F596_3007;
	R2351[3] = (char *(*)()) F597_3007;
	R2351[4] = (char *(*)()) F594_3007;
	R2351[5] = (char *(*)()) F596_3007;
	R2351[6] = (char *(*)()) F594_3007;
}

char *(*R2353[7])();
void R2353_init () {
	R2353[0] = (char *(*)()) F594_3009;
	R2353[1] = (char *(*)()) F595_3009;
	R2353[2] = (char *(*)()) F596_3009;
	R2353[3] = (char *(*)()) F597_3009;
	R2353[4] = (char *(*)()) F594_3009;
	R2353[5] = (char *(*)()) F596_3009;
	R2353[6] = (char *(*)()) F594_3009;
}

char *(*R2354[7])();
void R2354_init () {
	R2354[0] = (char *(*)()) F594_3010;
	R2354[1] = (char *(*)()) F595_3010;
	R2354[2] = (char *(*)()) F596_3010;
	R2354[3] = (char *(*)()) F597_3010;
	R2354[4] = (char *(*)()) F594_3010;
	R2354[5] = (char *(*)()) F596_3010;
	R2354[6] = (char *(*)()) F594_3010;
}

char *(*R2355[7])();
void R2355_init () {
	R2355[0] = (char *(*)()) F594_3011;
	R2355[1] = (char *(*)()) F595_3011;
	R2355[2] = (char *(*)()) F596_3011;
	R2355[3] = (char *(*)()) F597_3011;
	R2355[4] = (char *(*)()) F594_3011;
	R2355[5] = (char *(*)()) F596_3011;
	R2355[6] = (char *(*)()) F594_3011;
}

char *(*R2359[7])();
void R2359_init () {
	R2359[0] = (char *(*)()) F594_3015;
	R2359[1] = (char *(*)()) F595_3015_2359_4;
	R2359[2] = (char *(*)()) F596_3015;
	R2359[3] = (char *(*)()) F597_3015_2359_4;
	R2359[4] = (char *(*)()) F594_3015;
	R2359[5] = (char *(*)()) F596_3015;
	R2359[6] = (char *(*)()) F594_3015;
}
static void F595_3015_2359_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F595_3015(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F597_3015_2359_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F597_3015(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2365[7])();
void R2365_init () {
	R2365[0] = (char *(*)()) F594_3021;
	R2365[1] = (char *(*)()) F595_3021;
	R2365[2] = (char *(*)()) F596_3021;
	R2365[3] = (char *(*)()) F597_3021;
	R2365[4] = (char *(*)()) F594_3021;
	R2365[5] = (char *(*)()) F596_3021;
	R2365[6] = (char *(*)()) F594_3021;
}

char *(*R2378[7])();
void R2378_init () {
	R2378[0] = (char *(*)()) F594_3034;
	R2378[1] = (char *(*)()) F595_3034;
	R2378[2] = (char *(*)()) F596_3034;
	R2378[3] = (char *(*)()) F597_3034;
	R2378[4] = (char *(*)()) F594_3034;
	R2378[5] = (char *(*)()) F596_3034;
	R2378[6] = (char *(*)()) F594_3034;
}

char *(*R2381[2])();
void R2381_init () {
	R2381[0] = (char *(*)()) F598_3037;
	R2381[1] = (char *(*)()) F599_3037;
}

char *(*R2486[12])();
void R2486_init () {
	R2486[0] = (char *(*)()) F605_3167;
	R2486[1] = (char *(*)()) F606_3167;
	R2486[2] = (char *(*)()) F607_3167;
	R2486[3] = (char *(*)()) F608_3167;
	R2486[4] = (char *(*)()) F609_3167;
	R2486[5] = (char *(*)()) F610_3167;
	R2486[6] = (char *(*)()) F611_3167;
	R2486[7] = (char *(*)()) F612_3167;
	R2486[8] = (char *(*)()) F613_3167;
	R2486[9] = (char *(*)()) F614_3167;
	R2486[10] = (char *(*)()) F615_3167;
	R2486[11] = (char *(*)()) F616_3167;
}

char *(*R2487[12])();
void R2487_init () {
	R2487[0] = (char *(*)()) F605_3168;
	R2487[1] = (char *(*)()) F606_3168;
	R2487[2] = (char *(*)()) F607_3168;
	R2487[3] = (char *(*)()) F608_3168;
	R2487[4] = (char *(*)()) F609_3168;
	R2487[5] = (char *(*)()) F610_3168;
	R2487[6] = (char *(*)()) F611_3168;
	R2487[7] = (char *(*)()) F612_3168;
	R2487[8] = (char *(*)()) F613_3168;
	R2487[9] = (char *(*)()) F614_3168;
	R2487[10] = (char *(*)()) F615_3168;
	R2487[11] = (char *(*)()) F616_3168;
}

char *(*R2489[12])();
void R2489_init () {
	R2489[0] = (char *(*)()) F605_3154;
	R2489[1] = (char *(*)()) F606_3154;
	R2489[2] = (char *(*)()) F607_3154;
	R2489[3] = (char *(*)()) F608_3154;
	R2489[4] = (char *(*)()) F609_3154;
	R2489[5] = (char *(*)()) F610_3154;
	R2489[6] = (char *(*)()) F611_3154;
	R2489[7] = (char *(*)()) F612_3154;
	R2489[8] = (char *(*)()) F613_3154;
	R2489[9] = (char *(*)()) F614_3154;
	R2489[10] = (char *(*)()) F615_3154;
	R2489[11] = (char *(*)()) F616_3154;
}

char *(*R2490[12])();
void R2490_init () {
	R2490[0] = (char *(*)()) F605_3155;
	R2490[1] = (char *(*)()) F606_3155_2490_112;
	R2490[2] = (char *(*)()) F607_3155_2490_112;
	R2490[3] = (char *(*)()) F608_3155_2490_112;
	R2490[4] = (char *(*)()) F609_3155_2490_112;
	R2490[5] = (char *(*)()) F610_3155_2490_112;
	R2490[6] = (char *(*)()) F611_3155_2490_112;
	R2490[7] = (char *(*)()) F612_3155_2490_112;
	R2490[8] = (char *(*)()) F613_3155_2490_112;
	R2490[9] = (char *(*)()) F614_3155_2490_112;
	R2490[10] = (char *(*)()) F615_3155_2490_112;
	R2490[11] = (char *(*)()) F616_3155_2490_112;
}
static void F606_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F606_3155(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F607_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F607_3155(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F608_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F608_3155(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F609_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F609_3155(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F610_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F610_3155(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F611_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F611_3155(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F612_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F612_3155(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F613_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3155(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F614_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3155(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F615_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3155(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F616_3155_2490_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3155(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2499[12])();
void R2499_init () {
	R2499[0] = (char *(*)()) F605_3170;
	R2499[1] = (char *(*)()) F606_3170;
	R2499[2] = (char *(*)()) F607_3170;
	R2499[3] = (char *(*)()) F608_3170;
	R2499[4] = (char *(*)()) F609_3170;
	R2499[5] = (char *(*)()) F610_3170;
	R2499[6] = (char *(*)()) F611_3170;
	R2499[7] = (char *(*)()) F612_3170;
	R2499[8] = (char *(*)()) F613_3170;
	R2499[9] = (char *(*)()) F614_3170;
	R2499[10] = (char *(*)()) F615_3170;
	R2499[11] = (char *(*)()) F616_3170;
}

char *(*R2500[12])();
void R2500_init () {
	R2500[0] = (char *(*)()) F605_3172;
	R2500[1] = (char *(*)()) F606_3172_2500_112;
	R2500[2] = (char *(*)()) F607_3172_2500_112;
	R2500[3] = (char *(*)()) F608_3172_2500_112;
	R2500[4] = (char *(*)()) F609_3172_2500_112;
	R2500[5] = (char *(*)()) F610_3172_2500_112;
	R2500[6] = (char *(*)()) F611_3172_2500_112;
	R2500[7] = (char *(*)()) F612_3172_2500_112;
	R2500[8] = (char *(*)()) F613_3172_2500_112;
	R2500[9] = (char *(*)()) F614_3172_2500_112;
	R2500[10] = (char *(*)()) F615_3172_2500_112;
	R2500[11] = (char *(*)()) F616_3172_2500_112;
}
static void F606_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F606_3172(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F607_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F607_3172(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F608_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F608_3172(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F609_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F609_3172(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F610_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F610_3172(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F611_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F611_3172(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F612_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F612_3172(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F613_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3172(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F614_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3172(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F615_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3172(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F616_3172_2500_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3172(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2501[12])();
void R2501_init () {
	R2501[0] = (char *(*)()) F605_3173;
	R2501[1] = (char *(*)()) F606_3173_2501_112;
	R2501[2] = (char *(*)()) F607_3173_2501_112;
	R2501[3] = (char *(*)()) F608_3173_2501_112;
	R2501[4] = (char *(*)()) F609_3173_2501_112;
	R2501[5] = (char *(*)()) F610_3173_2501_112;
	R2501[6] = (char *(*)()) F611_3173_2501_112;
	R2501[7] = (char *(*)()) F612_3173_2501_112;
	R2501[8] = (char *(*)()) F613_3173_2501_112;
	R2501[9] = (char *(*)()) F614_3173_2501_112;
	R2501[10] = (char *(*)()) F615_3173_2501_112;
	R2501[11] = (char *(*)()) F616_3173_2501_112;
}
static void F606_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F606_3173(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F607_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F607_3173(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F608_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F608_3173(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F609_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F609_3173(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F610_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F610_3173(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F611_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F611_3173(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F612_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F612_3173(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F613_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3173(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F614_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3173(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F615_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3173(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F616_3173_2501_112 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3173(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2504[12])();
void R2504_init () {
	R2504[0] = (char *(*)()) F605_3176;
	R2504[1] = (char *(*)()) F606_3176_2504_145;
	R2504[2] = (char *(*)()) F607_3176_2504_145;
	R2504[3] = (char *(*)()) F608_3176_2504_145;
	R2504[4] = (char *(*)()) F609_3176_2504_145;
	R2504[5] = (char *(*)()) F610_3176_2504_145;
	R2504[6] = (char *(*)()) F611_3176_2504_145;
	R2504[7] = (char *(*)()) F612_3176_2504_145;
	R2504[8] = (char *(*)()) F613_3176_2504_145;
	R2504[9] = (char *(*)()) F614_3176_2504_145;
	R2504[10] = (char *(*)()) F615_3176_2504_145;
	R2504[11] = (char *(*)()) F616_3176_2504_145;
}
static void F606_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F606_3176(Current, *(EIF_CHARACTER_32 *)arg1, arg2, arg3);
}
static void F607_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F607_3176(Current, *(EIF_CHARACTER_8 *)arg1, arg2, arg3);
}
static void F608_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F608_3176(Current, *(EIF_NATURAL_8 *)arg1, arg2, arg3);
}
static void F609_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F609_3176(Current, *(EIF_NATURAL_16 *)arg1, arg2, arg3);
}
static void F610_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F610_3176(Current, *(EIF_POINTER *)arg1, arg2, arg3);
}
static void F611_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F611_3176(Current, *(EIF_REAL_32 *)arg1, arg2, arg3);
}
static void F612_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F612_3176(Current, *(EIF_REAL_64 *)arg1, arg2, arg3);
}
static void F613_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F613_3176(Current, *(EIF_INTEGER_32 *)arg1, arg2, arg3);
}
static void F614_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F614_3176(Current, *(EIF_BOOLEAN *)arg1, arg2, arg3);
}
static void F615_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F615_3176(Current, *(EIF_NATURAL_64 *)arg1, arg2, arg3);
}
static void F616_3176_2504_145 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F616_3176(Current, *(EIF_NATURAL_32 *)arg1, arg2, arg3);
}

char *(*R2507[12])();
void R2507_init () {
	R2507[0] = (char *(*)()) F605_3179;
	R2507[1] = (char *(*)()) F606_3179;
	R2507[2] = (char *(*)()) F607_3179;
	R2507[3] = (char *(*)()) F608_3179;
	R2507[4] = (char *(*)()) F609_3179;
	R2507[5] = (char *(*)()) F610_3179;
	R2507[6] = (char *(*)()) F611_3179;
	R2507[7] = (char *(*)()) F612_3179;
	R2507[8] = (char *(*)()) F613_3179;
	R2507[9] = (char *(*)()) F614_3179;
	R2507[10] = (char *(*)()) F615_3179;
	R2507[11] = (char *(*)()) F616_3179;
}

char *(*R2508[12])();
void R2508_init () {
	R2508[0] = (char *(*)()) F605_3180;
	R2508[1] = (char *(*)()) F606_3180;
	R2508[2] = (char *(*)()) F607_3180;
	R2508[3] = (char *(*)()) F608_3180;
	R2508[4] = (char *(*)()) F609_3180;
	R2508[5] = (char *(*)()) F610_3180;
	R2508[6] = (char *(*)()) F611_3180;
	R2508[7] = (char *(*)()) F612_3180;
	R2508[8] = (char *(*)()) F613_3180;
	R2508[9] = (char *(*)()) F614_3180;
	R2508[10] = (char *(*)()) F615_3180;
	R2508[11] = (char *(*)()) F616_3180;
}

char *(*R2509[12])();
void R2509_init () {
	R2509[0] = (char *(*)()) F605_3181;
	R2509[1] = (char *(*)()) F606_3181;
	R2509[2] = (char *(*)()) F607_3181;
	R2509[3] = (char *(*)()) F608_3181;
	R2509[4] = (char *(*)()) F609_3181;
	R2509[5] = (char *(*)()) F610_3181;
	R2509[6] = (char *(*)()) F611_3181;
	R2509[7] = (char *(*)()) F612_3181;
	R2509[8] = (char *(*)()) F613_3181;
	R2509[9] = (char *(*)()) F614_3181;
	R2509[10] = (char *(*)()) F615_3181;
	R2509[11] = (char *(*)()) F616_3181;
}

char *(*R2510[12])();
void R2510_init () {
	R2510[0] = (char *(*)()) F605_3182;
	R2510[1] = (char *(*)()) F606_3182;
	R2510[2] = (char *(*)()) F607_3182;
	R2510[3] = (char *(*)()) F608_3182;
	R2510[4] = (char *(*)()) F609_3182;
	R2510[5] = (char *(*)()) F610_3182;
	R2510[6] = (char *(*)()) F611_3182;
	R2510[7] = (char *(*)()) F612_3182;
	R2510[8] = (char *(*)()) F613_3182;
	R2510[9] = (char *(*)()) F614_3182;
	R2510[10] = (char *(*)()) F615_3182;
	R2510[11] = (char *(*)()) F616_3182;
}

char *(*R2517[12])();
void R2517_init () {
	R2517[0] = (char *(*)()) F605_3189;
	R2517[1] = (char *(*)()) F606_3189;
	R2517[2] = (char *(*)()) F607_3189;
	R2517[3] = (char *(*)()) F608_3189;
	R2517[4] = (char *(*)()) F609_3189;
	R2517[5] = (char *(*)()) F610_3189;
	R2517[6] = (char *(*)()) F611_3189;
	R2517[7] = (char *(*)()) F612_3189;
	R2517[8] = (char *(*)()) F613_3189;
	R2517[9] = (char *(*)()) F614_3189;
	R2517[10] = (char *(*)()) F615_3189;
	R2517[11] = (char *(*)()) F616_3189;
}

char *(*R2520[12])();
void R2520_init () {
	R2520[0] = (char *(*)()) F605_3192;
	R2520[1] = (char *(*)()) F606_3192;
	R2520[2] = (char *(*)()) F607_3192;
	R2520[3] = (char *(*)()) F608_3192;
	R2520[4] = (char *(*)()) F609_3192;
	R2520[5] = (char *(*)()) F610_3192;
	R2520[6] = (char *(*)()) F611_3192;
	R2520[7] = (char *(*)()) F612_3192;
	R2520[8] = (char *(*)()) F613_3192;
	R2520[9] = (char *(*)()) F614_3192;
	R2520[10] = (char *(*)()) F615_3192;
	R2520[11] = (char *(*)()) F616_3192;
}

char *(*R2529[12])();
void R2529_init () {
	R2529[0] = (char *(*)()) F605_3202;
	R2529[1] = (char *(*)()) F606_3202;
	R2529[2] = (char *(*)()) F607_3202;
	R2529[3] = (char *(*)()) F608_3202;
	R2529[4] = (char *(*)()) F609_3202;
	R2529[5] = (char *(*)()) F610_3202;
	R2529[6] = (char *(*)()) F611_3202;
	R2529[7] = (char *(*)()) F612_3202;
	R2529[8] = (char *(*)()) F613_3202;
	R2529[9] = (char *(*)()) F614_3202;
	R2529[10] = (char *(*)()) F615_3202;
	R2529[11] = (char *(*)()) F616_3202;
}

char *(*R2577[118])();
void R2577_init () {
	R2577[0] = (char *(*)()) F666_3342;
	R2577[1] = (char *(*)()) F667_3342;
	R2577[2] = (char *(*)()) F668_3342;
	R2577[3] = (char *(*)()) F669_3342;
	R2577[4] = (char *(*)()) F670_3342;
	R2577[5] = (char *(*)()) F671_3342;
	R2577[6] = (char *(*)()) F672_3342;
	R2577[7] = (char *(*)()) F673_3342;
	R2577[8] = (char *(*)()) F674_3342;
	R2577[9] = (char *(*)()) F675_3342;
	R2577[10] = (char *(*)()) F676_3342;
	R2577[11] = (char *(*)()) F677_3342;
	R2577[12] = (char *(*)()) F678_3342;
	R2577[13] = (char *(*)()) F679_3342;
	R2577[14] = (char *(*)()) F680_3342;
	R2577[15] = (char *(*)()) F681_3342;
	R2577[16] = (char *(*)()) F682_3342;
	R2577[17] = (char *(*)()) F683_3342;
	R2577[18] = (char *(*)()) F684_3342;
	R2577[19] = (char *(*)()) F685_3342;
	R2577[20] = (char *(*)()) F686_3342;
	R2577[21] = (char *(*)()) F687_3342;
	R2577[22] = (char *(*)()) F688_3342;
	R2577[23] = (char *(*)()) F689_3342;
	R2577[24] = (char *(*)()) F690_3342;
	R2577[25] = (char *(*)()) F691_3342;
	R2577[26] = (char *(*)()) F692_3342;
	R2577[27] = (char *(*)()) F693_3342;
	R2577[28] = (char *(*)()) F694_3342;
	R2577[29] = (char *(*)()) F695_3342;
	R2577[30] = (char *(*)()) F696_3342;
	R2577[31] = (char *(*)()) F697_3394;
	{long i; for (i = 33; i < 35; i++) R2577[i] = (char *(*)()) F698_3503;}
	{long i; for (i = 36; i < 38; i++) R2577[i] = (char *(*)()) F701_3551;}
	{long i; for (i = 39; i < 41; i++) R2577[i] = (char *(*)()) F704_3573;}
	{long i; for (i = 42; i < 44; i++) R2577[i] = (char *(*)()) F707_3612;}
	{long i; for (i = 45; i < 47; i++) R2577[i] = (char *(*)()) F710_3710;}
	{long i; for (i = 48; i < 50; i++) R2577[i] = (char *(*)()) F713_3809;}
	{long i; for (i = 51; i < 53; i++) R2577[i] = (char *(*)()) F716_3908;}
	{long i; for (i = 54; i < 56; i++) R2577[i] = (char *(*)()) F719_4007;}
	{long i; for (i = 57; i < 59; i++) R2577[i] = (char *(*)()) F722_4101;}
	{long i; for (i = 60; i < 62; i++) R2577[i] = (char *(*)()) F725_4195;}
	{long i; for (i = 63; i < 65; i++) R2577[i] = (char *(*)()) F728_4290;}
	{long i; for (i = 66; i < 68; i++) R2577[i] = (char *(*)()) F731_4385;}
	{long i; for (i = 69; i < 71; i++) R2577[i] = (char *(*)()) F734_4451;}
	{long i; for (i = 72; i < 102; i++) R2577[i] = (char *(*)()) F737_4517;}
	R2577[102] = (char *(*)()) F768_4543;
	R2577[103] = (char *(*)()) F769_4543;
	{long i; for (i = 113; i < 115; i++) R2577[i] = (char *(*)()) F775_4610;}
	{long i; for (i = 116; i < 118; i++) R2577[i] = (char *(*)()) F775_4610;}
}

char *(*R2635[31])();
void R2635_init () {
	R2635[0] = (char *(*)()) F666_3338;
	R2635[1] = (char *(*)()) F667_3338;
	R2635[2] = (char *(*)()) F668_3338;
	R2635[3] = (char *(*)()) F669_3338;
	R2635[4] = (char *(*)()) F670_3338;
	R2635[5] = (char *(*)()) F671_3338;
	R2635[6] = (char *(*)()) F672_3338;
	R2635[7] = (char *(*)()) F673_3338;
	R2635[8] = (char *(*)()) F674_3338;
	R2635[9] = (char *(*)()) F675_3338;
	R2635[10] = (char *(*)()) F676_3338;
	R2635[11] = (char *(*)()) F677_3338;
	R2635[12] = (char *(*)()) F678_3338;
	R2635[13] = (char *(*)()) F679_3338;
	R2635[14] = (char *(*)()) F680_3338;
	R2635[15] = (char *(*)()) F681_3338;
	R2635[16] = (char *(*)()) F682_3338;
	R2635[17] = (char *(*)()) F683_3338;
	R2635[18] = (char *(*)()) F684_3338;
	R2635[19] = (char *(*)()) F685_3338;
	R2635[20] = (char *(*)()) F686_3338;
	R2635[21] = (char *(*)()) F687_3338;
	R2635[22] = (char *(*)()) F688_3338;
	R2635[23] = (char *(*)()) F689_3338;
	R2635[24] = (char *(*)()) F690_3338;
	R2635[25] = (char *(*)()) F691_3338;
	R2635[26] = (char *(*)()) F692_3338;
	R2635[27] = (char *(*)()) F693_3338;
	R2635[28] = (char *(*)()) F694_3338;
	R2635[29] = (char *(*)()) F695_3338;
	R2635[30] = (char *(*)()) F696_3338;
}

char *(*R2638[31])();
void R2638_init () {
	R2638[0] = (char *(*)()) F666_3341;
	R2638[1] = (char *(*)()) F667_3341;
	R2638[2] = (char *(*)()) F668_3341;
	R2638[3] = (char *(*)()) F669_3341;
	R2638[4] = (char *(*)()) F670_3341;
	R2638[5] = (char *(*)()) F671_3341;
	R2638[6] = (char *(*)()) F672_3341;
	R2638[7] = (char *(*)()) F673_3341;
	R2638[8] = (char *(*)()) F674_3341;
	R2638[9] = (char *(*)()) F675_3341;
	R2638[10] = (char *(*)()) F676_3341;
	R2638[11] = (char *(*)()) F677_3341;
	R2638[12] = (char *(*)()) F678_3341;
	R2638[13] = (char *(*)()) F679_3341;
	R2638[14] = (char *(*)()) F680_3341;
	R2638[15] = (char *(*)()) F681_3341;
	R2638[16] = (char *(*)()) F682_3341;
	R2638[17] = (char *(*)()) F683_3341;
	R2638[18] = (char *(*)()) F684_3341;
	R2638[19] = (char *(*)()) F685_3341;
	R2638[20] = (char *(*)()) F686_3341;
	R2638[21] = (char *(*)()) F687_3341;
	R2638[22] = (char *(*)()) F688_3341;
	R2638[23] = (char *(*)()) F689_3341;
	R2638[24] = (char *(*)()) F690_3341;
	R2638[25] = (char *(*)()) F691_3341;
	R2638[26] = (char *(*)()) F692_3341;
	R2638[27] = (char *(*)()) F693_3341;
	R2638[28] = (char *(*)()) F694_3341;
	R2638[29] = (char *(*)()) F695_3341;
	R2638[30] = (char *(*)()) F696_3341;
}

char *(*R2643[31])();
void R2643_init () {
	R2643[0] = (char *(*)()) F666_3347;
	R2643[1] = (char *(*)()) F667_3347;
	R2643[2] = (char *(*)()) F668_3347;
	R2643[3] = (char *(*)()) F669_3347;
	R2643[4] = (char *(*)()) F670_3347;
	R2643[5] = (char *(*)()) F671_3347;
	R2643[6] = (char *(*)()) F672_3347;
	R2643[7] = (char *(*)()) F673_3347;
	R2643[8] = (char *(*)()) F674_3347;
	R2643[9] = (char *(*)()) F675_3347;
	R2643[10] = (char *(*)()) F676_3347;
	R2643[11] = (char *(*)()) F677_3347;
	R2643[12] = (char *(*)()) F678_3347;
	R2643[13] = (char *(*)()) F679_3347;
	R2643[14] = (char *(*)()) F680_3347;
	R2643[15] = (char *(*)()) F681_3347;
	R2643[16] = (char *(*)()) F682_3347;
	R2643[17] = (char *(*)()) F683_3347;
	R2643[18] = (char *(*)()) F684_3347;
	R2643[19] = (char *(*)()) F685_3347;
	R2643[20] = (char *(*)()) F686_3347;
	R2643[21] = (char *(*)()) F687_3347;
	R2643[22] = (char *(*)()) F688_3347;
	R2643[23] = (char *(*)()) F689_3347;
	R2643[24] = (char *(*)()) F690_3347;
	R2643[25] = (char *(*)()) F691_3347;
	R2643[26] = (char *(*)()) F692_3347;
	R2643[27] = (char *(*)()) F693_3347;
	R2643[28] = (char *(*)()) F694_3347;
	R2643[29] = (char *(*)()) F695_3347;
	R2643[30] = (char *(*)()) F696_3347;
}

char *(*R2650[31])();
void R2650_init () {
	R2650[0] = (char *(*)()) F666_3355;
	R2650[1] = (char *(*)()) F667_3355_2650_1;
	R2650[2] = (char *(*)()) F668_3355_2650_1;
	R2650[3] = (char *(*)()) F669_3355_2650_1;
	R2650[4] = (char *(*)()) F670_3355_2650_1;
	R2650[5] = (char *(*)()) F671_3355_2650_1;
	R2650[6] = (char *(*)()) F672_3355_2650_1;
	R2650[7] = (char *(*)()) F673_3355_2650_1;
	R2650[8] = (char *(*)()) F674_3355_2650_1;
	R2650[9] = (char *(*)()) F675_3355_2650_1;
	R2650[10] = (char *(*)()) F676_3355_2650_1;
	R2650[11] = (char *(*)()) F677_3355_2650_1;
	R2650[12] = (char *(*)()) F678_3355_2650_1;
	R2650[13] = (char *(*)()) F679_3355_2650_1;
	R2650[14] = (char *(*)()) F680_3355_2650_1;
	R2650[15] = (char *(*)()) F681_3355_2650_1;
	R2650[16] = (char *(*)()) F682_3355_2650_1;
	R2650[17] = (char *(*)()) F683_3355;
	R2650[18] = (char *(*)()) F684_3355_2650_1;
	R2650[19] = (char *(*)()) F685_3355_2650_1;
	R2650[20] = (char *(*)()) F686_3355_2650_1;
	R2650[21] = (char *(*)()) F687_3355_2650_1;
	R2650[22] = (char *(*)()) F688_3355_2650_1;
	R2650[23] = (char *(*)()) F689_3355_2650_1;
	R2650[24] = (char *(*)()) F690_3355_2650_1;
	R2650[25] = (char *(*)()) F691_3355_2650_1;
	R2650[26] = (char *(*)()) F692_3355_2650_1;
	R2650[27] = (char *(*)()) F693_3355_2650_1;
	R2650[28] = (char *(*)()) F694_3355_2650_1;
	R2650[29] = (char *(*)()) F695_3355_2650_1;
	R2650[30] = (char *(*)()) F696_3355_2650_1;
}
static EIF_REFERENCE F667_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8* r = F667_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {739,699,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 739, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F668_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F668_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(768, 0x00).id, 768, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F669_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F669_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i8;
	} else {
		Result = RTLNS(eif_new_type(708, 0x00).id, 708, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_INTEGER_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F670_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F670_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n4;
	} else {
		Result = RTLNS(eif_new_type(723, 0x00).id, 723, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_NATURAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F671_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REFERENCE* r = F671_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {740,0,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 740, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REFERENCE* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F672_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F672_3355(Current);
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
static EIF_REFERENCE F673_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F673_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_r4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_r4;
	} else {
		Result = RTLNS(eif_new_type(732, 0x00).id, 732, _OBJSIZ_0_0_0_0_1_0_0_0_);
		*(EIF_REAL_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F674_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F674_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n1;
	} else {
		Result = RTLNS(eif_new_type(729, 0x00).id, 729, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_NATURAL_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F675_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F675_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n2;
	} else {
		Result = RTLNS(eif_new_type(726, 0x00).id, 726, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_NATURAL_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F676_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F676_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_n8 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_n8;
	} else {
		Result = RTLNS(eif_new_type(720, 0x00).id, 720, _OBJSIZ_0_0_0_0_0_0_1_0_);
		*(EIF_NATURAL_64 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F677_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8 r = F677_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i1;
	} else {
		Result = RTLNS(eif_new_type(717, 0x00).id, 717, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_INTEGER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F678_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16 r = F678_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i2 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i2;
	} else {
		Result = RTLNS(eif_new_type(714, 0x00).id, 714, _OBJSIZ_0_0_1_0_0_0_0_0_);
		*(EIF_INTEGER_16 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F679_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F679_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_i4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_i4;
	} else {
		Result = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_INTEGER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F680_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F680_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(699, 0x00).id, 699, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F681_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F681_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c4 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c4;
	} else {
		Result = RTLNS(eif_new_type(705, 0x00).id, 705, _OBJSIZ_0_0_0_1_0_0_0_0_);
		*(EIF_CHARACTER_32 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F682_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F682_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(702, 0x00).id, 702, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F684_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32* r = F684_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {742,723,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 742, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F685_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16* r = F685_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {744,726,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 744, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F686_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32* r = F686_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {746,711,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 746, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F687_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16* r = F687_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {748,714,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 748, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F688_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN* r = F688_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {750,702,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 750, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_BOOLEAN* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F689_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8* r = F689_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {752,717,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 752, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F690_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64* r = F690_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {754,708,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 754, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F691_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8* r = F691_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {756,729,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 756, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F692_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32* r = F692_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {758,732,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 758, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F693_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64* r = F693_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {760,735,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 760, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F694_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64* r = F694_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {762,720,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 762, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F695_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER* r = F695_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {764,768,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 764, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_POINTER* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F696_3355_2650_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32* r = F696_3355(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {766,705,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 766, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_32* *)Result = r;
		return Result;
	}
}

char *(*R2660[31])();
void R2660_init () {
	R2660[0] = (char *(*)()) F666_3367;
	R2660[1] = (char *(*)()) F667_3367;
	R2660[2] = (char *(*)()) F668_3367;
	R2660[3] = (char *(*)()) F669_3367;
	R2660[4] = (char *(*)()) F670_3367;
	R2660[5] = (char *(*)()) F671_3367;
	R2660[6] = (char *(*)()) F672_3367;
	R2660[7] = (char *(*)()) F673_3367;
	R2660[8] = (char *(*)()) F674_3367;
	R2660[9] = (char *(*)()) F675_3367;
	R2660[10] = (char *(*)()) F676_3367;
	R2660[11] = (char *(*)()) F677_3367;
	R2660[12] = (char *(*)()) F678_3367;
	R2660[13] = (char *(*)()) F679_3367;
	R2660[14] = (char *(*)()) F680_3367;
	R2660[15] = (char *(*)()) F681_3367;
	R2660[16] = (char *(*)()) F682_3367;
	R2660[17] = (char *(*)()) F683_3367;
	R2660[18] = (char *(*)()) F684_3367;
	R2660[19] = (char *(*)()) F685_3367;
	R2660[20] = (char *(*)()) F686_3367;
	R2660[21] = (char *(*)()) F687_3367;
	R2660[22] = (char *(*)()) F688_3367;
	R2660[23] = (char *(*)()) F689_3367;
	R2660[24] = (char *(*)()) F690_3367;
	R2660[25] = (char *(*)()) F691_3367;
	R2660[26] = (char *(*)()) F692_3367;
	R2660[27] = (char *(*)()) F693_3367;
	R2660[28] = (char *(*)()) F694_3367;
	R2660[29] = (char *(*)()) F695_3367;
	R2660[30] = (char *(*)()) F696_3367;
}

char *(*R2845[2])();
void R2845_init () {
	R2845[0] = (char *(*)()) F705_3609;
	R2845[1] = (char *(*)()) F706_3609;
}

char *(*R2892[2])();
void R2892_init () {
	R2892[0] = (char *(*)()) F708_3691;
	R2892[1] = (char *(*)()) F709_3691;
}

char *(*R2895[2])();
void R2895_init () {
	R2895[0] = (char *(*)()) F708_3694;
	R2895[1] = (char *(*)()) F709_3694;
}

char *(*R2898[2])();
void R2898_init () {
	R2898[0] = (char *(*)()) F708_3697;
	R2898[1] = (char *(*)()) F709_3697;
}

char *(*R2950[2])();
void R2950_init () {
	R2950[0] = (char *(*)()) F711_3792;
	R2950[1] = (char *(*)()) F712_3792;
}

char *(*R2951[2])();
void R2951_init () {
	R2951[0] = (char *(*)()) F711_3793;
	R2951[1] = (char *(*)()) F712_3793;
}

char *(*R2955[2])();
void R2955_init () {
	R2955[0] = (char *(*)()) F711_3797;
	R2955[1] = (char *(*)()) F712_3797;
}

char *(*R3007[2])();
void R3007_init () {
	R3007[0] = (char *(*)()) F714_3892;
	R3007[1] = (char *(*)()) F715_3892;
}

char *(*R3010[2])();
void R3010_init () {
	R3010[0] = (char *(*)()) F714_3895;
	R3010[1] = (char *(*)()) F715_3895;
}

char *(*R3060[2])();
void R3060_init () {
	R3060[0] = (char *(*)()) F717_3988;
	R3060[1] = (char *(*)()) F718_3988;
}

char *(*R3063[2])();
void R3063_init () {
	R3063[0] = (char *(*)()) F717_3991;
	R3063[1] = (char *(*)()) F718_3991;
}

char *(*R3066[2])();
void R3066_init () {
	R3066[0] = (char *(*)()) F717_3994;
	R3066[1] = (char *(*)()) F718_3994;
}

char *(*R3120[2])();
void R3120_init () {
	R3120[0] = (char *(*)()) F720_4088;
	R3120[1] = (char *(*)()) F721_4088;
}

char *(*R3166[2])();
void R3166_init () {
	R3166[0] = (char *(*)()) F723_4176;
	R3166[1] = (char *(*)()) F724_4176;
}

char *(*R3167[2])();
void R3167_init () {
	R3167[0] = (char *(*)()) F723_4177;
	R3167[1] = (char *(*)()) F724_4177;
}

char *(*R3169[2])();
void R3169_init () {
	R3169[0] = (char *(*)()) F723_4179;
	R3169[1] = (char *(*)()) F724_4179;
}

char *(*R3172[2])();
void R3172_init () {
	R3172[0] = (char *(*)()) F723_4182;
	R3172[1] = (char *(*)()) F724_4182;
}

char *(*R3173[2])();
void R3173_init () {
	R3173[0] = (char *(*)()) F723_4183;
	R3173[1] = (char *(*)()) F724_4183;
}

char *(*R3221[2])();
void R3221_init () {
	R3221[0] = (char *(*)()) F726_4273;
	R3221[1] = (char *(*)()) F727_4273;
}

char *(*R3222[2])();
void R3222_init () {
	R3222[0] = (char *(*)()) F726_4274;
	R3222[1] = (char *(*)()) F727_4274;
}

char *(*R3225[2])();
void R3225_init () {
	R3225[0] = (char *(*)()) F726_4277;
	R3225[1] = (char *(*)()) F727_4277;
}

char *(*R3274[2])();
void R3274_init () {
	R3274[0] = (char *(*)()) F729_4368;
	R3274[1] = (char *(*)()) F730_4368;
}

char *(*R3275[2])();
void R3275_init () {
	R3275[0] = (char *(*)()) F729_4369;
	R3275[1] = (char *(*)()) F730_4369;
}

char *(*R3276[2])();
void R3276_init () {
	R3276[0] = (char *(*)()) F729_4370;
	R3276[1] = (char *(*)()) F730_4370;
}

char *(*R3278[2])();
void R3278_init () {
	R3278[0] = (char *(*)()) F729_4372;
	R3278[1] = (char *(*)()) F730_4372;
}

char *(*R3279[2])();
void R3279_init () {
	R3279[0] = (char *(*)()) F729_4373;
	R3279[1] = (char *(*)()) F730_4373;
}

char *(*R3324[2])();
void R3324_init () {
	R3324[0] = (char *(*)()) F732_4430;
	R3324[1] = (char *(*)()) F733_4430;
}

char *(*R3358[2])();
void R3358_init () {
	R3358[0] = (char *(*)()) F735_4496;
	R3358[1] = (char *(*)()) F736_4496;
}

char *(*R3445[5])();
void R3445_init () {
	{long i; for (i = 0; i < 2; i++) R3445[i] = (char *(*)()) F778_4731;}
	{long i; for (i = 3; i < 5; i++) R3445[i] = (char *(*)()) F781_4897;}
}

char *(*R3447[5])();
void R3447_init () {
	R3447[0] = (char *(*)()) F779_4791;
	R3447[1] = (char *(*)()) F780_4813;
	R3447[3] = (char *(*)()) F782_4958;
	R3447[4] = (char *(*)()) F783_4981;
}

char *(*R3448[5])();
void R3448_init () {
	R3448[0] = (char *(*)()) F779_4790;
	R3448[1] = (char *(*)()) F780_4812;
	R3448[3] = (char *(*)()) F782_4956;
	R3448[4] = (char *(*)()) F783_4979;
}

char *(*R3459[5])();
void R3459_init () {
	{long i; for (i = 0; i < 2; i++) R3459[i] = (char *(*)()) F778_4762;}
	{long i; for (i = 3; i < 5; i++) R3459[i] = (char *(*)()) F781_4927;}
}

char *(*R3460[5])();
void R3460_init () {
	{long i; for (i = 0; i < 2; i++) R3460[i] = (char *(*)()) F778_4763;}
	{long i; for (i = 3; i < 5; i++) R3460[i] = (char *(*)()) F781_4928;}
}

char *(*R3461[5])();
void R3461_init () {
	{long i; for (i = 0; i < 2; i++) R3461[i] = (char *(*)()) F778_4764;}
	{long i; for (i = 3; i < 5; i++) R3461[i] = (char *(*)()) F781_4929;}
}

char *(*R3462[5])();
void R3462_init () {
	R3462[0] = (char *(*)()) F779_4800;
	R3462[1] = (char *(*)()) F429_2236;
	R3462[3] = (char *(*)()) F782_4968;
	R3462[4] = (char *(*)()) F428_2236;
}

char *(*R3484[5])();
void R3484_init () {
	{long i; for (i = 0; i < 2; i++) R3484[i] = (char *(*)()) F778_4753;}
	{long i; for (i = 3; i < 5; i++) R3484[i] = (char *(*)()) F781_4918;}
}

char *(*R3485[5])();
void R3485_init () {
	{long i; for (i = 0; i < 2; i++) R3485[i] = (char *(*)()) F778_4752;}
	{long i; for (i = 3; i < 5; i++) R3485[i] = (char *(*)()) F781_4917;}
}

char *(*R3525[5])();
void R3525_init () {
	R3525[0] = (char *(*)()) F779_4798;
	R3525[1] = (char *(*)()) F780_4891;
	R3525[3] = (char *(*)()) F782_4965;
	R3525[4] = (char *(*)()) F783_5059;
}

char *(*R3540[4])();
void R3540_init () {
	R3540[0] = (char *(*)()) F780_4893;
	R3540[3] = (char *(*)()) F783_5061;
}

char *(*R3543[4])();
void R3543_init () {
	R3543[0] = (char *(*)()) F780_4832;
	R3543[3] = (char *(*)()) F783_5000;
}

char *(*R3573[4])();
void R3573_init () {
	R3573[0] = (char *(*)()) F780_4876;
	R3573[3] = (char *(*)()) F783_5044;
}

char *(*R3605[2])();
void R3605_init () {
	R3605[0] = (char *(*)()) F779_4804;
	R3605[1] = (char *(*)()) F778_4783;
}

char *(*R3680[2])();
void R3680_init () {
	R3680[0] = (char *(*)()) F782_4971;
	R3680[1] = (char *(*)()) F781_4948;
}

char *(*R3748[2])();
void R3748_init () {
	R3748[0] = (char *(*)()) F786_5137;
	R3748[1] = (char *(*)()) F787_5158;
}

char *(*R3753[2])();
void R3753_init () {
	R3753[0] = (char *(*)()) F786_5140;
	R3753[1] = (char *(*)()) F787_5153;
}

char *(*R3755[2])();
void R3755_init () {
	R3755[0] = (char *(*)()) F786_5141;
	R3755[1] = (char *(*)()) F787_5154;
}
char *(*R2[797])();
void R2_init () {}
char *(*R6[797])();
void R6_init () {}

char *(*R3[797])();
void R3_init () {
	R3[115] = (char *(*)()) F116_1292;
	R3[783] = (char *(*)()) F784_5072;
}

char *(*R4[797])();
void R4_init () {
	{long i; for (i = 1; i < 4; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 5; i < 7; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 9; i < 12; i++) R4[i] = (char *(*)()) F1_15;}
	R4[24] = (char *(*)()) F1_15;
	R4[26] = (char *(*)()) F1_15;
	R4[34] = (char *(*)()) F1_15;
	R4[38] = (char *(*)()) F1_15;
	{long i; for (i = 42; i < 48; i++) R4[i] = (char *(*)()) F1_15;}
	R4[50] = (char *(*)()) F1_15;
	{long i; for (i = 64; i < 66; i++) R4[i] = (char *(*)()) F1_15;}
	R4[67] = (char *(*)()) F1_15;
	R4[69] = (char *(*)()) F1_15;
	{long i; for (i = 74; i < 77; i++) R4[i] = (char *(*)()) F1_15;}
	R4[79] = (char *(*)()) F1_15;
	{long i; for (i = 81; i < 84; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 85; i < 88; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 89; i < 91; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 93; i < 95; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 96; i < 99; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 100; i < 104; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 105; i < 107; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 108; i < 114; i++) R4[i] = (char *(*)()) F1_15;}
	R4[115] = (char *(*)()) F116_1211;
	R4[125] = (char *(*)()) F1_15;
	R4[137] = (char *(*)()) F1_15;
	R4[154] = (char *(*)()) F155_1935;
	{long i; for (i = 231; i < 235; i++) R4[i] = (char *(*)()) F1_15;}
	R4[425] = (char *(*)()) F1_15;
	R4[516] = (char *(*)()) F517_2706;
	R4[517] = (char *(*)()) F518_2706;
	R4[518] = (char *(*)()) F519_2706;
	R4[519] = (char *(*)()) F520_2706;
	R4[520] = (char *(*)()) F521_2706;
	R4[521] = (char *(*)()) F522_2706;
	R4[522] = (char *(*)()) F523_2706;
	R4[523] = (char *(*)()) F524_2706;
	R4[524] = (char *(*)()) F525_2706;
	R4[525] = (char *(*)()) F526_2706;
	R4[526] = (char *(*)()) F527_2706;
	R4[527] = (char *(*)()) F528_2706;
	R4[593] = (char *(*)()) F594_2982;
	R4[594] = (char *(*)()) F595_2982;
	R4[595] = (char *(*)()) F596_2982;
	R4[596] = (char *(*)()) F597_2982;
	R4[597] = (char *(*)()) F594_2982;
	R4[598] = (char *(*)()) F596_2982;
	R4[599] = (char *(*)()) F594_2982;
	{long i; for (i = 604; i < 616; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 665; i < 697; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 698; i < 700; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 701; i < 703; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 704; i < 706; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 707; i < 709; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 710; i < 712; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 713; i < 715; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 716; i < 718; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 719; i < 721; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 722; i < 724; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 725; i < 727; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 728; i < 730; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 731; i < 733; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 734; i < 736; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 737; i < 769; i++) R4[i] = (char *(*)()) F1_15;}
	R4[778] = (char *(*)()) F779_4787;
	R4[779] = (char *(*)()) F778_4771;
	R4[781] = (char *(*)()) F782_4955;
	R4[782] = (char *(*)()) F781_4936;
	R4[783] = (char *(*)()) F1_15;
	{long i; for (i = 785; i < 787; i++) R4[i] = (char *(*)()) F1_15;}
	R4[793] = (char *(*)()) F1_15;
}

char *(*R5[797])();
void R5_init () {
	{long i; for (i = 1; i < 4; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 5; i < 7; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 9; i < 12; i++) R5[i] = (char *(*)()) F1_8;}
	R5[24] = (char *(*)()) F1_8;
	R5[26] = (char *(*)()) F1_8;
	R5[34] = (char *(*)()) F1_8;
	R5[38] = (char *(*)()) F1_8;
	{long i; for (i = 42; i < 48; i++) R5[i] = (char *(*)()) F1_8;}
	R5[50] = (char *(*)()) F1_8;
	{long i; for (i = 64; i < 66; i++) R5[i] = (char *(*)()) F1_8;}
	R5[67] = (char *(*)()) F1_8;
	R5[69] = (char *(*)()) F1_8;
	{long i; for (i = 74; i < 77; i++) R5[i] = (char *(*)()) F1_8;}
	R5[79] = (char *(*)()) F1_8;
	{long i; for (i = 81; i < 84; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 85; i < 88; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 89; i < 91; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 93; i < 95; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 96; i < 99; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 100; i < 104; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 105; i < 107; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 108; i < 114; i++) R5[i] = (char *(*)()) F1_8;}
	R5[115] = (char *(*)()) F116_1210;
	R5[125] = (char *(*)()) F1_8;
	R5[137] = (char *(*)()) F1_8;
	R5[154] = (char *(*)()) F155_1934;
	{long i; for (i = 231; i < 235; i++) R5[i] = (char *(*)()) F1_8;}
	R5[425] = (char *(*)()) F1_8;
	R5[516] = (char *(*)()) F517_2668;
	R5[517] = (char *(*)()) F518_2668;
	R5[518] = (char *(*)()) F519_2668;
	R5[519] = (char *(*)()) F520_2668;
	R5[520] = (char *(*)()) F521_2668;
	R5[521] = (char *(*)()) F522_2668;
	R5[522] = (char *(*)()) F523_2668;
	R5[523] = (char *(*)()) F524_2668;
	R5[524] = (char *(*)()) F525_2668;
	R5[525] = (char *(*)()) F526_2668;
	R5[526] = (char *(*)()) F527_2668;
	R5[527] = (char *(*)()) F528_2668;
	R5[593] = (char *(*)()) F594_2948;
	R5[594] = (char *(*)()) F595_2948;
	R5[595] = (char *(*)()) F596_2948;
	R5[596] = (char *(*)()) F597_2948;
	R5[597] = (char *(*)()) F598_3042;
	R5[598] = (char *(*)()) F599_3042;
	R5[599] = (char *(*)()) F594_2948;
	{long i; for (i = 604; i < 616; i++) R5[i] = (char *(*)()) F1_8;}
	R5[665] = (char *(*)()) F666_3348;
	R5[666] = (char *(*)()) F667_3348;
	R5[667] = (char *(*)()) F668_3348;
	R5[668] = (char *(*)()) F669_3348;
	R5[669] = (char *(*)()) F670_3348;
	R5[670] = (char *(*)()) F671_3348;
	R5[671] = (char *(*)()) F672_3348;
	R5[672] = (char *(*)()) F673_3348;
	R5[673] = (char *(*)()) F674_3348;
	R5[674] = (char *(*)()) F675_3348;
	R5[675] = (char *(*)()) F676_3348;
	R5[676] = (char *(*)()) F677_3348;
	R5[677] = (char *(*)()) F678_3348;
	R5[678] = (char *(*)()) F679_3348;
	R5[679] = (char *(*)()) F680_3348;
	R5[680] = (char *(*)()) F681_3348;
	R5[681] = (char *(*)()) F682_3348;
	R5[682] = (char *(*)()) F683_3348;
	R5[683] = (char *(*)()) F684_3348;
	R5[684] = (char *(*)()) F685_3348;
	R5[685] = (char *(*)()) F686_3348;
	R5[686] = (char *(*)()) F687_3348;
	R5[687] = (char *(*)()) F688_3348;
	R5[688] = (char *(*)()) F689_3348;
	R5[689] = (char *(*)()) F690_3348;
	R5[690] = (char *(*)()) F691_3348;
	R5[691] = (char *(*)()) F692_3348;
	R5[692] = (char *(*)()) F693_3348;
	R5[693] = (char *(*)()) F694_3348;
	R5[694] = (char *(*)()) F695_3348;
	R5[695] = (char *(*)()) F696_3348;
	R5[696] = (char *(*)()) F697_3391;
	{long i; for (i = 698; i < 700; i++) R5[i] = (char *(*)()) F698_3508;}
	{long i; for (i = 701; i < 703; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 704; i < 706; i++) R5[i] = (char *(*)()) F704_3579;}
	{long i; for (i = 707; i < 709; i++) R5[i] = (char *(*)()) F707_3620;}
	{long i; for (i = 710; i < 712; i++) R5[i] = (char *(*)()) F710_3718;}
	{long i; for (i = 713; i < 715; i++) R5[i] = (char *(*)()) F713_3817;}
	{long i; for (i = 716; i < 718; i++) R5[i] = (char *(*)()) F716_3916;}
	{long i; for (i = 719; i < 721; i++) R5[i] = (char *(*)()) F719_4015;}
	{long i; for (i = 722; i < 724; i++) R5[i] = (char *(*)()) F722_4109;}
	{long i; for (i = 725; i < 727; i++) R5[i] = (char *(*)()) F725_4203;}
	{long i; for (i = 728; i < 730; i++) R5[i] = (char *(*)()) F728_4298;}
	{long i; for (i = 731; i < 733; i++) R5[i] = (char *(*)()) F731_4397;}
	{long i; for (i = 734; i < 736; i++) R5[i] = (char *(*)()) F734_4463;}
	{long i; for (i = 737; i < 769; i++) R5[i] = (char *(*)()) F737_4519;}
	{long i; for (i = 778; i < 780; i++) R5[i] = (char *(*)()) F778_4756;}
	{long i; for (i = 781; i < 783; i++) R5[i] = (char *(*)()) F781_4921;}
	R5[783] = (char *(*)()) F1_8;
	{long i; for (i = 785; i < 787; i++) R5[i] = (char *(*)()) F1_8;}
	R5[793] = (char *(*)()) F123_1430;
}


#ifdef __cplusplus
}
#endif
