#include "epoly2.h"
#include "../E1/eoffsets.h"


#ifdef __cplusplus
extern "C" {
#endif

char *(*R698[4])();
void R698_init () {
	R698[0] = (char *(*)()) F46_718;
	R698[1] = (char *(*)()) F47_718_698_1;
	R698[2] = (char *(*)()) F48_718_698_1;
	R698[3] = (char *(*)()) F49_718_698_1;
}
static EIF_REFERENCE F47_718_698_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F47_718(Current);
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
static EIF_REFERENCE F48_718_698_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F48_718(Current);
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
static EIF_REFERENCE F49_718_698_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F49_718(Current);
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

char *(*R1028[39])();
void R1028_init () {
	R1028[0] = (char *(*)()) F77_1088;
	R1028[1] = (char *(*)()) F78_1112;
	R1028[4] = (char *(*)()) F81_1114;
	R1028[6] = (char *(*)()) F83_1116;
	R1028[7] = (char *(*)()) F84_1120;
	R1028[8] = (char *(*)()) F85_1126;
	R1028[10] = (char *(*)()) F87_1143;
	R1028[11] = (char *(*)()) F88_1145;
	R1028[12] = (char *(*)()) F89_1147;
	R1028[14] = (char *(*)()) F91_1149;
	R1028[15] = (char *(*)()) F92_1153;
	R1028[18] = (char *(*)()) F95_1155;
	R1028[19] = (char *(*)()) F96_1157;
	R1028[21] = (char *(*)()) F98_1161;
	R1028[22] = (char *(*)()) F99_1167;
	R1028[23] = (char *(*)()) F100_1169;
	R1028[25] = (char *(*)()) F102_1171;
	R1028[26] = (char *(*)()) F103_1173;
	R1028[27] = (char *(*)()) F104_1177;
	R1028[28] = (char *(*)()) F105_1181;
	R1028[30] = (char *(*)()) F107_1183;
	R1028[31] = (char *(*)()) F108_1185;
	R1028[33] = (char *(*)()) F110_1187;
	R1028[34] = (char *(*)()) F111_1189;
	R1028[35] = (char *(*)()) F112_1191;
	R1028[36] = (char *(*)()) F113_1193;
	R1028[37] = (char *(*)()) F114_1197;
	R1028[38] = (char *(*)()) F115_1199;
}

char *(*R1180[96])();
void R1180_init () {
	{long i; for (i = 0; i < 2; i++) R1180[i] = (char *(*)()) F699_3509;}
	R1180[6] = (char *(*)()) F706_3643_1180_2;
	R1180[7] = (char *(*)()) F707_3643_1180_2;
	R1180[9] = (char *(*)()) F709_3742_1180_2;
	R1180[10] = (char *(*)()) F710_3742_1180_2;
	R1180[12] = (char *(*)()) F712_3841_1180_2;
	R1180[13] = (char *(*)()) F713_3841_1180_2;
	R1180[15] = (char *(*)()) F715_3940_1180_2;
	R1180[16] = (char *(*)()) F716_3940_1180_2;
	R1180[18] = (char *(*)()) F718_4035_1180_2;
	R1180[19] = (char *(*)()) F719_4035_1180_2;
	R1180[21] = (char *(*)()) F721_4129_1180_2;
	R1180[22] = (char *(*)()) F722_4129_1180_2;
	R1180[24] = (char *(*)()) F724_4224_1180_2;
	R1180[25] = (char *(*)()) F725_4224_1180_2;
	R1180[27] = (char *(*)()) F727_4319_1180_2;
	R1180[28] = (char *(*)()) F728_4319_1180_2;
	R1180[30] = (char *(*)()) F730_4388_1180_2;
	R1180[31] = (char *(*)()) F731_4388_1180_2;
	R1180[33] = (char *(*)()) F733_4454_1180_2;
	R1180[34] = (char *(*)()) F734_4454_1180_2;
	{long i; for (i = 36; i < 38; i++) R1180[i] = (char *(*)()) F735_4485;}
	{long i; for (i = 80; i < 82; i++) R1180[i] = (char *(*)()) F779_4762;}
	{long i; for (i = 83; i < 85; i++) R1180[i] = (char *(*)()) F782_4930;}
	R1180[95] = (char *(*)()) F795_5306;
}
static EIF_BOOLEAN F706_3643_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F706_3643(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F707_3643_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F707_3643(Current, *(EIF_INTEGER_64 *)arg1);
}
static EIF_BOOLEAN F709_3742_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F709_3742(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F710_3742_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F710_3742(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_BOOLEAN F712_3841_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F712_3841(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F713_3841_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F713_3841(Current, *(EIF_INTEGER_16 *)arg1);
}
static EIF_BOOLEAN F715_3940_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F715_3940(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F716_3940_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F716_3940(Current, *(EIF_INTEGER_8 *)arg1);
}
static EIF_BOOLEAN F718_4035_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F718_4035(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F719_4035_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F719_4035(Current, *(EIF_NATURAL_64 *)arg1);
}
static EIF_BOOLEAN F721_4129_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F721_4129(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F722_4129_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F722_4129(Current, *(EIF_NATURAL_32 *)arg1);
}
static EIF_BOOLEAN F724_4224_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F724_4224(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F725_4224_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F725_4224(Current, *(EIF_NATURAL_16 *)arg1);
}
static EIF_BOOLEAN F727_4319_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F727_4319(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F728_4319_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F728_4319(Current, *(EIF_NATURAL_8 *)arg1);
}
static EIF_BOOLEAN F730_4388_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F730_4388(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F731_4388_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F731_4388(Current, *(EIF_REAL_32 *)arg1);
}
static EIF_BOOLEAN F733_4454_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F733_4454(Current, *(EIF_REAL_64 *)arg1);
}
static EIF_BOOLEAN F734_4454_1180_2 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F734_4454(Current, *(EIF_REAL_64 *)arg1);
}

char *(*R1710[629])();
void R1710_init () {
	R1710[0] = (char *(*)()) F149_1886;
	R1710[362] = (char *(*)()) F144_1886;
	R1710[363] = (char *(*)()) F145_1886;
	R1710[364] = (char *(*)()) F146_1886;
	R1710[365] = (char *(*)()) F147_1886;
	R1710[366] = (char *(*)()) F148_1886;
	R1710[367] = (char *(*)()) F149_1886;
	R1710[368] = (char *(*)()) F150_1886;
	R1710[369] = (char *(*)()) F151_1886;
	R1710[370] = (char *(*)()) F152_1886;
	R1710[371] = (char *(*)()) F153_1886;
	R1710[372] = (char *(*)()) F154_1886;
	R1710[373] = (char *(*)()) F155_1886;
	R1710[625] = (char *(*)()) F154_1886;
	R1710[628] = (char *(*)()) F150_1886;
}

char *(*R1711[629])();
void R1711_init () {
	R1711[0] = (char *(*)()) F149_1887_1711_116;
	R1711[362] = (char *(*)()) F144_1887;
	R1711[363] = (char *(*)()) F145_1887_1711_116;
	R1711[364] = (char *(*)()) F146_1887_1711_116;
	R1711[365] = (char *(*)()) F147_1887_1711_116;
	R1711[366] = (char *(*)()) F148_1887_1711_116;
	R1711[367] = (char *(*)()) F149_1887_1711_116;
	R1711[368] = (char *(*)()) F150_1887_1711_116;
	R1711[369] = (char *(*)()) F151_1887_1711_116;
	R1711[370] = (char *(*)()) F152_1887_1711_116;
	R1711[371] = (char *(*)()) F153_1887_1711_116;
	R1711[372] = (char *(*)()) F154_1887_1711_116;
	R1711[373] = (char *(*)()) F155_1887_1711_116;
	R1711[625] = (char *(*)()) F154_1887_1711_116;
	R1711[628] = (char *(*)()) F150_1887_1711_116;
}
static void F149_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F149_1887(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F145_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F145_1887(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F146_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F146_1887(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F147_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F147_1887(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F148_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F148_1887(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F150_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F150_1887(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F151_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F151_1887(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F152_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F152_1887(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F153_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F153_1887(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F154_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F154_1887(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F155_1887_1711_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F155_1887(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R1717[629])();
void R1717_init () {
	R1717[0] = (char *(*)()) F149_1893;
	R1717[362] = (char *(*)()) F144_1893;
	R1717[363] = (char *(*)()) F145_1893;
	R1717[364] = (char *(*)()) F146_1893;
	R1717[365] = (char *(*)()) F147_1893;
	R1717[366] = (char *(*)()) F148_1893;
	R1717[367] = (char *(*)()) F149_1893;
	R1717[368] = (char *(*)()) F150_1893;
	R1717[369] = (char *(*)()) F151_1893;
	R1717[370] = (char *(*)()) F152_1893;
	R1717[371] = (char *(*)()) F153_1893;
	R1717[372] = (char *(*)()) F154_1893;
	R1717[373] = (char *(*)()) F155_1893;
	R1717[625] = (char *(*)()) F154_1893;
	R1717[628] = (char *(*)()) F150_1893;
}

char *(*R1777[4])();
void R1777_init () {
	R1777[0] = (char *(*)()) F233_2081;
	R1777[1] = (char *(*)()) F234_2081_1777_1;
	R1777[2] = (char *(*)()) F235_2081;
	R1777[3] = (char *(*)()) F236_2081_1777_1;
}
static EIF_REFERENCE F234_2081_1777_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F234_2081(Current);
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
static EIF_REFERENCE F236_2081_1777_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F236_2081(Current);
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

char *(*R1778[195])();
void R1778_init () {
	R1778[0] = (char *(*)()) F233_2084;
	R1778[1] = (char *(*)()) F234_2084;
	R1778[2] = (char *(*)()) F235_2084;
	R1778[3] = (char *(*)()) F236_2084;
	R1778[194] = (char *(*)()) F426_2210;
}

char *(*R1779[195])();
void R1779_init () {
	R1779[0] = (char *(*)()) F233_2085;
	R1779[1] = (char *(*)()) F234_2085;
	R1779[2] = (char *(*)()) F235_2085;
	R1779[3] = (char *(*)()) F236_2085;
	R1779[194] = (char *(*)()) F426_2216;
}

char *(*R1790[4])();
void R1790_init () {
	R1790[0] = (char *(*)()) F233_2082;
	R1790[1] = (char *(*)()) F234_2082;
	R1790[2] = (char *(*)()) F235_2082_1790_1;
	R1790[3] = (char *(*)()) F236_2082_1790_1;
}
static EIF_REFERENCE F235_2082_1790_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F235_2082(Current);
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
static EIF_REFERENCE F236_2082_1790_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F236_2082(Current);
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

char *(*R1792[7])();
void R1792_init () {
	R1792[0] = (char *(*)()) F595_2942;
	R1792[1] = (char *(*)()) F596_2942;
	R1792[2] = (char *(*)()) F597_2942;
	R1792[3] = (char *(*)()) F598_2942;
	R1792[4] = (char *(*)()) F595_2942;
	R1792[5] = (char *(*)()) F596_2942;
	R1792[6] = (char *(*)()) F595_2942;
}

static EIF_TYPE_INDEX Y1793_pgtype0[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype1[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype2[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype3[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype4[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype5[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype6[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype7[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype8[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype9[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype10[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype11[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype12[] = {0xFF01,783,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype13[] = {0xFF01,779,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype14[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype15[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype16[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype17[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype18[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype19[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype20[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype21[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype22[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype23[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype24[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype25[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype26[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype27[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype28[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype29[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype30[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype31[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype32[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype33[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype34[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype35[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype36[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype37[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype38[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype39[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype40[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype41[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype42[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype43[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype44[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype45[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype46[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype47[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype48[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype49[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype50[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype51[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype52[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype53[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype54[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype55[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype56[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype57[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype58[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype59[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype60[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype61[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype62[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype63[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype64[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype65[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype66[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype67[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype68[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype69[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype70[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype71[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype72[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype73[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype74[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype75[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype76[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype77[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype78[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype79[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype80[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype81[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype82[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype83[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype84[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype85[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype86[] = {700,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype87[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype88[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype89[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype90[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype91[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype92[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype93[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype94[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype95[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype96[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype97[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype98[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype99[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype100[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype101[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype102[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype103[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype104[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype105[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype106[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype107[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype108[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype109[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype110[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype111[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype112[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype113[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype114[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype115[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype116[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype117[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype118[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype119[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype120[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype121[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype122[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype123[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype124[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype125[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype126[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype127[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype128[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype129[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype130[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype131[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype132[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype133[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype134[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype135[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype136[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype137[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype138[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype139[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype140[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype141[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype142[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype143[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype144[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype145[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype146[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype147[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype148[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype149[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype150[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype151[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype152[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype153[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype154[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype155[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype156[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype157[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype158[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype159[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype160[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype161[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype162[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype163[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype164[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype165[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype166[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype167[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype168[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype169[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype170[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype171[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype172[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype173[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype174[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype175[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype176[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype177[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype178[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype179[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype180[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype181[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype182[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype183[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype184[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype185[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype186[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype187[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype188[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype189[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype190[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype191[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype192[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype193[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype194[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype195[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype196[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype197[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype198[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype199[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype200[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype201[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype202[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype203[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype204[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype205[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype206[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype207[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype208[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype209[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype210[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype211[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype212[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype213[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype214[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype215[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype216[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype217[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype218[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype219[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype220[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype221[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype222[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype223[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype224[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype225[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype226[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype227[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype228[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype229[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype230[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype231[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype232[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype233[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype234[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype235[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype236[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype237[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype238[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype239[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype240[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype241[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype242[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype243[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype244[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype245[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype246[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype247[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype248[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype249[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype250[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype251[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype252[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype253[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype254[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype255[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype256[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype257[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype258[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype259[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype260[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype261[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype262[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype263[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype264[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype265[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype266[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype267[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype268[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype269[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype270[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype271[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype272[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype273[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype274[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype275[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype276[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype277[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype278[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype279[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype280[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype281[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype282[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype283[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype284[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype285[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype286[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype287[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype288[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype289[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype290[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype291[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype292[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype293[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype294[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype295[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype296[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype297[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype298[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype299[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype300[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype301[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype302[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype303[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype304[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype305[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype306[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype307[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype308[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype309[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype310[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype311[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype312[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype313[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype314[] = {700,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype315[] = {700,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype316[] = {700,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype317[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype318[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype319[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype320[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype321[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype322[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype323[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype324[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype325[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype326[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype327[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype328[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype329[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype330[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype331[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype332[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype333[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype334[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype335[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype336[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype337[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype338[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype339[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype340[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype341[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype342[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype343[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype344[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype345[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype346[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype347[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype348[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype349[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype350[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype351[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype352[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype353[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype354[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype355[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype356[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype357[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype358[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype359[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype360[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype361[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype362[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype363[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype364[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype365[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype366[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype367[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype368[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype369[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype370[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype371[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype372[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype373[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype374[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype375[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype376[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype377[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype378[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype379[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype380[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype381[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype382[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype383[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype384[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype385[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype386[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype387[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype388[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype389[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype390[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype391[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype392[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype393[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype394[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype395[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype396[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype397[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype398[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype399[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype400[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype401[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype402[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype403[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype404[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype405[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype406[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype407[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype408[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype409[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype410[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype411[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype412[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype413[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype414[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype415[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype416[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype417[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype418[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype419[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype420[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype421[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype422[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype423[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype424[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype425[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype426[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype427[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype428[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype429[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype430[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype431[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype432[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype433[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype434[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype435[] = {0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype436[] = {0,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype437[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype438[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype439[] = {736,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype440[] = {700,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype441[] = {700,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype442[] = {700,0xFFFF};
static EIF_TYPE_INDEX Y1793_pgtype443[] = {700,0xFFFF};
EIF_TYPE_INDEX *Y1793_gen_type [610];
EIF_TYPE_INDEX Y1793 [610];
void Y1793_init (void)
{
	egc_routines_types [1793] = Y1793;
	egc_routines_gen_types [1793] = Y1793_gen_type;
	egc_routines_offset [1793] = 175;
	Y1793_gen_type [0] = Y1793_pgtype0;
	Y1793_gen_type [1] = Y1793_pgtype1;
	Y1793_gen_type [2] = Y1793_pgtype2;
	Y1793_gen_type [3] = Y1793_pgtype3;
	Y1793_gen_type [4] = Y1793_pgtype4;
	Y1793_gen_type [5] = Y1793_pgtype5;
	Y1793_gen_type [6] = Y1793_pgtype6;
	Y1793_gen_type [7] = Y1793_pgtype7;
	Y1793_gen_type [8] = Y1793_pgtype8;
	Y1793_gen_type [9] = Y1793_pgtype9;
	Y1793_gen_type [10] = Y1793_pgtype10;
	Y1793_gen_type [11] = Y1793_pgtype11;
	Y1793_gen_type [12] = Y1793_pgtype12;
	Y1793_gen_type [13] = Y1793_pgtype13;
	Y1793_gen_type [14] = Y1793_pgtype14;
	Y1793_gen_type [15] = Y1793_pgtype15;
	Y1793_gen_type [16] = Y1793_pgtype16;
	Y1793_gen_type [17] = Y1793_pgtype17;
	Y1793_gen_type [18] = Y1793_pgtype18;
	Y1793_gen_type [19] = Y1793_pgtype19;
	Y1793_gen_type [20] = Y1793_pgtype20;
	Y1793_gen_type [21] = Y1793_pgtype21;
	Y1793_gen_type [22] = Y1793_pgtype22;
	Y1793_gen_type [23] = Y1793_pgtype23;
	Y1793_gen_type [24] = Y1793_pgtype24;
	Y1793_gen_type [25] = Y1793_pgtype25;
	Y1793_gen_type [26] = Y1793_pgtype26;
	Y1793_gen_type [27] = Y1793_pgtype27;
	Y1793_gen_type [28] = Y1793_pgtype28;
	Y1793_gen_type [29] = Y1793_pgtype29;
	Y1793_gen_type [30] = Y1793_pgtype30;
	Y1793_gen_type [31] = Y1793_pgtype31;
	Y1793_gen_type [32] = Y1793_pgtype32;
	Y1793_gen_type [33] = Y1793_pgtype33;
	Y1793_gen_type [34] = Y1793_pgtype34;
	Y1793_gen_type [35] = Y1793_pgtype35;
	Y1793_gen_type [36] = Y1793_pgtype36;
	Y1793_gen_type [37] = Y1793_pgtype37;
	Y1793_gen_type [38] = Y1793_pgtype38;
	Y1793_gen_type [39] = Y1793_pgtype39;
	Y1793_gen_type [40] = Y1793_pgtype40;
	Y1793_gen_type [41] = Y1793_pgtype41;
	Y1793_gen_type [42] = Y1793_pgtype42;
	Y1793_gen_type [43] = Y1793_pgtype43;
	Y1793_gen_type [44] = Y1793_pgtype44;
	Y1793_gen_type [45] = Y1793_pgtype45;
	Y1793_gen_type [46] = Y1793_pgtype46;
	Y1793_gen_type [47] = Y1793_pgtype47;
	Y1793_gen_type [48] = Y1793_pgtype48;
	Y1793_gen_type [49] = Y1793_pgtype49;
	Y1793_gen_type [50] = Y1793_pgtype50;
	Y1793_gen_type [51] = Y1793_pgtype51;
	Y1793_gen_type [52] = Y1793_pgtype52;
	Y1793_gen_type [53] = Y1793_pgtype53;
	Y1793_gen_type [54] = Y1793_pgtype54;
	Y1793_gen_type [55] = Y1793_pgtype55;
	Y1793_gen_type [56] = Y1793_pgtype56;
	Y1793_gen_type [57] = Y1793_pgtype57;
	Y1793_gen_type [58] = Y1793_pgtype58;
	Y1793_gen_type [59] = Y1793_pgtype59;
	Y1793_gen_type [60] = Y1793_pgtype60;
	Y1793_gen_type [61] = Y1793_pgtype61;
	Y1793_gen_type [62] = Y1793_pgtype62;
	Y1793_gen_type [63] = Y1793_pgtype63;
	Y1793_gen_type [64] = Y1793_pgtype64;
	Y1793_gen_type [65] = Y1793_pgtype65;
	Y1793_gen_type [66] = Y1793_pgtype66;
	Y1793_gen_type [67] = Y1793_pgtype67;
	Y1793_gen_type [68] = Y1793_pgtype68;
	Y1793_gen_type [69] = Y1793_pgtype69;
	Y1793_gen_type [70] = Y1793_pgtype70;
	Y1793_gen_type [71] = Y1793_pgtype71;
	Y1793_gen_type [72] = Y1793_pgtype72;
	Y1793_gen_type [73] = Y1793_pgtype73;
	Y1793_gen_type [74] = Y1793_pgtype74;
	Y1793_gen_type [75] = Y1793_pgtype75;
	Y1793_gen_type [76] = Y1793_pgtype76;
	Y1793_gen_type [77] = Y1793_pgtype77;
	Y1793_gen_type [78] = Y1793_pgtype78;
	Y1793_gen_type [79] = Y1793_pgtype79;
	Y1793_gen_type [80] = Y1793_pgtype80;
	Y1793_gen_type [81] = Y1793_pgtype81;
	Y1793_gen_type [82] = Y1793_pgtype82;
	Y1793_gen_type [83] = Y1793_pgtype83;
	Y1793_gen_type [84] = Y1793_pgtype84;
	Y1793_gen_type [85] = Y1793_pgtype85;
	Y1793_gen_type [86] = Y1793_pgtype86;
	Y1793_gen_type [87] = Y1793_pgtype87;
	Y1793_gen_type [88] = Y1793_pgtype88;
	Y1793_gen_type [89] = Y1793_pgtype89;
	Y1793_gen_type [90] = Y1793_pgtype90;
	Y1793_gen_type [91] = Y1793_pgtype91;
	Y1793_gen_type [92] = Y1793_pgtype92;
	Y1793_gen_type [93] = Y1793_pgtype93;
	Y1793_gen_type [94] = Y1793_pgtype94;
	Y1793_gen_type [95] = Y1793_pgtype95;
	Y1793_gen_type [96] = Y1793_pgtype96;
	Y1793_gen_type [97] = Y1793_pgtype97;
	Y1793_gen_type [98] = Y1793_pgtype98;
	Y1793_gen_type [99] = Y1793_pgtype99;
	Y1793_gen_type [100] = Y1793_pgtype100;
	Y1793_gen_type [101] = Y1793_pgtype101;
	Y1793_gen_type [102] = Y1793_pgtype102;
	Y1793_gen_type [103] = Y1793_pgtype103;
	Y1793_gen_type [104] = Y1793_pgtype104;
	Y1793_gen_type [105] = Y1793_pgtype105;
	Y1793_gen_type [106] = Y1793_pgtype106;
	Y1793_gen_type [107] = Y1793_pgtype107;
	Y1793_gen_type [108] = Y1793_pgtype108;
	Y1793_gen_type [109] = Y1793_pgtype109;
	Y1793_gen_type [110] = Y1793_pgtype110;
	Y1793_gen_type [111] = Y1793_pgtype111;
	Y1793_gen_type [112] = Y1793_pgtype112;
	Y1793_gen_type [113] = Y1793_pgtype113;
	Y1793_gen_type [114] = Y1793_pgtype114;
	Y1793_gen_type [115] = Y1793_pgtype115;
	Y1793_gen_type [116] = Y1793_pgtype116;
	Y1793_gen_type [117] = Y1793_pgtype117;
	Y1793_gen_type [118] = Y1793_pgtype118;
	Y1793_gen_type [119] = Y1793_pgtype119;
	Y1793_gen_type [120] = Y1793_pgtype120;
	Y1793_gen_type [121] = Y1793_pgtype121;
	Y1793_gen_type [122] = Y1793_pgtype122;
	Y1793_gen_type [123] = Y1793_pgtype123;
	Y1793_gen_type [124] = Y1793_pgtype124;
	Y1793_gen_type [125] = Y1793_pgtype125;
	Y1793_gen_type [126] = Y1793_pgtype126;
	Y1793_gen_type [127] = Y1793_pgtype127;
	Y1793_gen_type [128] = Y1793_pgtype128;
	Y1793_gen_type [129] = Y1793_pgtype129;
	Y1793_gen_type [130] = Y1793_pgtype130;
	Y1793_gen_type [131] = Y1793_pgtype131;
	Y1793_gen_type [132] = Y1793_pgtype132;
	Y1793_gen_type [133] = Y1793_pgtype133;
	Y1793_gen_type [134] = Y1793_pgtype134;
	Y1793_gen_type [135] = Y1793_pgtype135;
	Y1793_gen_type [136] = Y1793_pgtype136;
	Y1793_gen_type [137] = Y1793_pgtype137;
	Y1793_gen_type [138] = Y1793_pgtype138;
	Y1793_gen_type [139] = Y1793_pgtype139;
	Y1793_gen_type [140] = Y1793_pgtype140;
	Y1793_gen_type [141] = Y1793_pgtype141;
	Y1793_gen_type [142] = Y1793_pgtype142;
	Y1793_gen_type [143] = Y1793_pgtype143;
	Y1793_gen_type [144] = Y1793_pgtype144;
	Y1793_gen_type [145] = Y1793_pgtype145;
	Y1793_gen_type [146] = Y1793_pgtype146;
	Y1793_gen_type [147] = Y1793_pgtype147;
	Y1793_gen_type [148] = Y1793_pgtype148;
	Y1793_gen_type [149] = Y1793_pgtype149;
	Y1793_gen_type [150] = Y1793_pgtype150;
	Y1793_gen_type [151] = Y1793_pgtype151;
	Y1793_gen_type [152] = Y1793_pgtype152;
	Y1793_gen_type [153] = Y1793_pgtype153;
	Y1793_gen_type [154] = Y1793_pgtype154;
	Y1793_gen_type [155] = Y1793_pgtype155;
	Y1793_gen_type [156] = Y1793_pgtype156;
	Y1793_gen_type [157] = Y1793_pgtype157;
	Y1793_gen_type [158] = Y1793_pgtype158;
	Y1793_gen_type [159] = Y1793_pgtype159;
	Y1793_gen_type [160] = Y1793_pgtype160;
	Y1793_gen_type [161] = Y1793_pgtype161;
	Y1793_gen_type [162] = Y1793_pgtype162;
	Y1793_gen_type [163] = Y1793_pgtype163;
	Y1793_gen_type [164] = Y1793_pgtype164;
	Y1793_gen_type [165] = Y1793_pgtype165;
	Y1793_gen_type [166] = Y1793_pgtype166;
	Y1793_gen_type [167] = Y1793_pgtype167;
	Y1793_gen_type [168] = Y1793_pgtype168;
	Y1793_gen_type [169] = Y1793_pgtype169;
	Y1793_gen_type [170] = Y1793_pgtype170;
	Y1793_gen_type [171] = Y1793_pgtype171;
	Y1793_gen_type [172] = Y1793_pgtype172;
	Y1793_gen_type [173] = Y1793_pgtype173;
	Y1793_gen_type [174] = Y1793_pgtype174;
	Y1793_gen_type [175] = Y1793_pgtype175;
	Y1793_gen_type [176] = Y1793_pgtype176;
	Y1793_gen_type [177] = Y1793_pgtype177;
	Y1793_gen_type [178] = Y1793_pgtype178;
	Y1793_gen_type [179] = Y1793_pgtype179;
	Y1793_gen_type [180] = Y1793_pgtype180;
	Y1793_gen_type [181] = Y1793_pgtype181;
	Y1793_gen_type [182] = Y1793_pgtype182;
	Y1793_gen_type [183] = Y1793_pgtype183;
	Y1793_gen_type [184] = Y1793_pgtype184;
	Y1793_gen_type [185] = Y1793_pgtype185;
	Y1793_gen_type [186] = Y1793_pgtype186;
	Y1793_gen_type [187] = Y1793_pgtype187;
	Y1793_gen_type [188] = Y1793_pgtype188;
	Y1793_gen_type [189] = Y1793_pgtype189;
	Y1793_gen_type [190] = Y1793_pgtype190;
	Y1793_gen_type [191] = Y1793_pgtype191;
	Y1793_gen_type [192] = Y1793_pgtype192;
	Y1793_gen_type [193] = Y1793_pgtype193;
	Y1793_gen_type [194] = Y1793_pgtype194;
	Y1793_gen_type [195] = Y1793_pgtype195;
	Y1793_gen_type [196] = Y1793_pgtype196;
	Y1793_gen_type [197] = Y1793_pgtype197;
	Y1793_gen_type [198] = Y1793_pgtype198;
	Y1793_gen_type [199] = Y1793_pgtype199;
	Y1793_gen_type [200] = Y1793_pgtype200;
	Y1793_gen_type [201] = Y1793_pgtype201;
	Y1793_gen_type [202] = Y1793_pgtype202;
	Y1793_gen_type [203] = Y1793_pgtype203;
	Y1793_gen_type [204] = Y1793_pgtype204;
	Y1793_gen_type [205] = Y1793_pgtype205;
	Y1793_gen_type [206] = Y1793_pgtype206;
	Y1793_gen_type [207] = Y1793_pgtype207;
	Y1793_gen_type [208] = Y1793_pgtype208;
	Y1793_gen_type [209] = Y1793_pgtype209;
	Y1793_gen_type [210] = Y1793_pgtype210;
	Y1793_gen_type [211] = Y1793_pgtype211;
	Y1793_gen_type [212] = Y1793_pgtype212;
	Y1793_gen_type [213] = Y1793_pgtype213;
	Y1793_gen_type [214] = Y1793_pgtype214;
	Y1793_gen_type [215] = Y1793_pgtype215;
	Y1793_gen_type [216] = Y1793_pgtype216;
	Y1793_gen_type [217] = Y1793_pgtype217;
	Y1793_gen_type [218] = Y1793_pgtype218;
	Y1793_gen_type [219] = Y1793_pgtype219;
	Y1793_gen_type [220] = Y1793_pgtype220;
	Y1793_gen_type [221] = Y1793_pgtype221;
	Y1793_gen_type [222] = Y1793_pgtype222;
	Y1793_gen_type [223] = Y1793_pgtype223;
	Y1793_gen_type [224] = Y1793_pgtype224;
	Y1793_gen_type [225] = Y1793_pgtype225;
	Y1793_gen_type [226] = Y1793_pgtype226;
	Y1793_gen_type [227] = Y1793_pgtype227;
	Y1793_gen_type [228] = Y1793_pgtype228;
	Y1793_gen_type [229] = Y1793_pgtype229;
	Y1793_gen_type [230] = Y1793_pgtype230;
	Y1793_gen_type [231] = Y1793_pgtype231;
	Y1793_gen_type [232] = Y1793_pgtype232;
	Y1793_gen_type [233] = Y1793_pgtype233;
	Y1793_gen_type [234] = Y1793_pgtype234;
	Y1793_gen_type [235] = Y1793_pgtype235;
	Y1793_gen_type [236] = Y1793_pgtype236;
	Y1793_gen_type [237] = Y1793_pgtype237;
	Y1793_gen_type [238] = Y1793_pgtype238;
	Y1793_gen_type [239] = Y1793_pgtype239;
	Y1793_gen_type [240] = Y1793_pgtype240;
	Y1793_gen_type [241] = Y1793_pgtype241;
	Y1793_gen_type [242] = Y1793_pgtype242;
	Y1793_gen_type [243] = Y1793_pgtype243;
	Y1793_gen_type [244] = Y1793_pgtype244;
	Y1793_gen_type [245] = Y1793_pgtype245;
	Y1793_gen_type [246] = Y1793_pgtype246;
	Y1793_gen_type [247] = Y1793_pgtype247;
	Y1793_gen_type [248] = Y1793_pgtype248;
	Y1793_gen_type [249] = Y1793_pgtype249;
	Y1793_gen_type [250] = Y1793_pgtype250;
	Y1793_gen_type [251] = Y1793_pgtype251;
	Y1793_gen_type [252] = Y1793_pgtype252;
	Y1793_gen_type [253] = Y1793_pgtype253;
	Y1793_gen_type [254] = Y1793_pgtype254;
	Y1793_gen_type [255] = Y1793_pgtype255;
	Y1793_gen_type [256] = Y1793_pgtype256;
	Y1793_gen_type [257] = Y1793_pgtype257;
	Y1793_gen_type [258] = Y1793_pgtype258;
	Y1793_gen_type [259] = Y1793_pgtype259;
	Y1793_gen_type [260] = Y1793_pgtype260;
	Y1793_gen_type [261] = Y1793_pgtype261;
	Y1793_gen_type [262] = Y1793_pgtype262;
	Y1793_gen_type [263] = Y1793_pgtype263;
	Y1793_gen_type [264] = Y1793_pgtype264;
	Y1793_gen_type [265] = Y1793_pgtype265;
	Y1793_gen_type [266] = Y1793_pgtype266;
	Y1793_gen_type [267] = Y1793_pgtype267;
	Y1793_gen_type [268] = Y1793_pgtype268;
	Y1793_gen_type [269] = Y1793_pgtype269;
	Y1793_gen_type [270] = Y1793_pgtype270;
	Y1793_gen_type [271] = Y1793_pgtype271;
	Y1793_gen_type [272] = Y1793_pgtype272;
	Y1793_gen_type [273] = Y1793_pgtype273;
	Y1793_gen_type [274] = Y1793_pgtype274;
	Y1793_gen_type [275] = Y1793_pgtype275;
	Y1793_gen_type [276] = Y1793_pgtype276;
	Y1793_gen_type [277] = Y1793_pgtype277;
	Y1793_gen_type [278] = Y1793_pgtype278;
	Y1793_gen_type [279] = Y1793_pgtype279;
	Y1793_gen_type [280] = Y1793_pgtype280;
	Y1793_gen_type [281] = Y1793_pgtype281;
	Y1793_gen_type [282] = Y1793_pgtype282;
	Y1793_gen_type [283] = Y1793_pgtype283;
	Y1793_gen_type [284] = Y1793_pgtype284;
	Y1793_gen_type [285] = Y1793_pgtype285;
	Y1793_gen_type [286] = Y1793_pgtype286;
	Y1793_gen_type [287] = Y1793_pgtype287;
	Y1793_gen_type [288] = Y1793_pgtype288;
	Y1793_gen_type [289] = Y1793_pgtype289;
	Y1793_gen_type [290] = Y1793_pgtype290;
	Y1793_gen_type [291] = Y1793_pgtype291;
	Y1793_gen_type [292] = Y1793_pgtype292;
	Y1793_gen_type [293] = Y1793_pgtype293;
	Y1793_gen_type [294] = Y1793_pgtype294;
	Y1793_gen_type [295] = Y1793_pgtype295;
	Y1793_gen_type [296] = Y1793_pgtype296;
	Y1793_gen_type [297] = Y1793_pgtype297;
	Y1793_gen_type [298] = Y1793_pgtype298;
	Y1793_gen_type [299] = Y1793_pgtype299;
	Y1793_gen_type [300] = Y1793_pgtype300;
	Y1793_gen_type [301] = Y1793_pgtype301;
	Y1793_gen_type [302] = Y1793_pgtype302;
	Y1793_gen_type [303] = Y1793_pgtype303;
	Y1793_gen_type [304] = Y1793_pgtype304;
	Y1793_gen_type [305] = Y1793_pgtype305;
	Y1793_gen_type [306] = Y1793_pgtype306;
	Y1793_gen_type [307] = Y1793_pgtype307;
	Y1793_gen_type [308] = Y1793_pgtype308;
	Y1793_gen_type [309] = Y1793_pgtype309;
	Y1793_gen_type [310] = Y1793_pgtype310;
	Y1793_gen_type [311] = Y1793_pgtype311;
	Y1793_gen_type [312] = Y1793_pgtype312;
	Y1793_gen_type [313] = Y1793_pgtype313;
	Y1793_gen_type [314] = Y1793_pgtype314;
	Y1793_gen_type [315] = Y1793_pgtype315;
	Y1793_gen_type [316] = Y1793_pgtype316;
	Y1793_gen_type [317] = Y1793_pgtype317;
	Y1793_gen_type [318] = Y1793_pgtype318;
	Y1793_gen_type [319] = Y1793_pgtype319;
	Y1793_gen_type [320] = Y1793_pgtype320;
	Y1793_gen_type [321] = Y1793_pgtype321;
	Y1793_gen_type [322] = Y1793_pgtype322;
	Y1793_gen_type [323] = Y1793_pgtype323;
	Y1793_gen_type [324] = Y1793_pgtype324;
	Y1793_gen_type [325] = Y1793_pgtype325;
	Y1793_gen_type [326] = Y1793_pgtype326;
	Y1793_gen_type [327] = Y1793_pgtype327;
	Y1793_gen_type [328] = Y1793_pgtype328;
	Y1793_gen_type [329] = Y1793_pgtype329;
	Y1793_gen_type [330] = Y1793_pgtype330;
	Y1793_gen_type [331] = Y1793_pgtype331;
	Y1793_gen_type [332] = Y1793_pgtype332;
	Y1793_gen_type [333] = Y1793_pgtype333;
	Y1793_gen_type [334] = Y1793_pgtype334;
	Y1793_gen_type [335] = Y1793_pgtype335;
	Y1793_gen_type [336] = Y1793_pgtype336;
	Y1793_gen_type [337] = Y1793_pgtype337;
	Y1793_gen_type [338] = Y1793_pgtype338;
	Y1793_gen_type [339] = Y1793_pgtype339;
	Y1793_gen_type [340] = Y1793_pgtype340;
	Y1793_gen_type [341] = Y1793_pgtype341;
	Y1793_gen_type [342] = Y1793_pgtype342;
	Y1793_gen_type [343] = Y1793_pgtype343;
	Y1793_gen_type [344] = Y1793_pgtype344;
	Y1793_gen_type [345] = Y1793_pgtype345;
	Y1793_gen_type [346] = Y1793_pgtype346;
	Y1793_gen_type [347] = Y1793_pgtype347;
	Y1793_gen_type [348] = Y1793_pgtype348;
	Y1793_gen_type [349] = Y1793_pgtype349;
	Y1793_gen_type [350] = Y1793_pgtype350;
	Y1793_gen_type [351] = Y1793_pgtype351;
	Y1793_gen_type [352] = Y1793_pgtype352;
	Y1793_gen_type [353] = Y1793_pgtype353;
	Y1793_gen_type [354] = Y1793_pgtype354;
	Y1793_gen_type [355] = Y1793_pgtype355;
	Y1793_gen_type [356] = Y1793_pgtype356;
	Y1793_gen_type [357] = Y1793_pgtype357;
	Y1793_gen_type [358] = Y1793_pgtype358;
	Y1793_gen_type [359] = Y1793_pgtype359;
	Y1793_gen_type [360] = Y1793_pgtype360;
	Y1793_gen_type [361] = Y1793_pgtype361;
	Y1793_gen_type [362] = Y1793_pgtype362;
	Y1793_gen_type [363] = Y1793_pgtype363;
	Y1793_gen_type [364] = Y1793_pgtype364;
	Y1793_gen_type [365] = Y1793_pgtype365;
	Y1793_gen_type [366] = Y1793_pgtype366;
	Y1793_gen_type [367] = Y1793_pgtype367;
	Y1793_gen_type [368] = Y1793_pgtype368;
	Y1793_gen_type [369] = Y1793_pgtype369;
	Y1793_gen_type [370] = Y1793_pgtype370;
	Y1793_gen_type [371] = Y1793_pgtype371;
	Y1793_gen_type [372] = Y1793_pgtype372;
	Y1793_gen_type [373] = Y1793_pgtype373;
	Y1793_gen_type [374] = Y1793_pgtype374;
	Y1793_gen_type [375] = Y1793_pgtype375;
	Y1793_gen_type [376] = Y1793_pgtype376;
	Y1793_gen_type [377] = Y1793_pgtype377;
	Y1793_gen_type [378] = Y1793_pgtype378;
	Y1793_gen_type [379] = Y1793_pgtype379;
	Y1793_gen_type [380] = Y1793_pgtype380;
	Y1793_gen_type [381] = Y1793_pgtype381;
	Y1793_gen_type [382] = Y1793_pgtype382;
	Y1793_gen_type [383] = Y1793_pgtype383;
	Y1793_gen_type [384] = Y1793_pgtype384;
	Y1793_gen_type [385] = Y1793_pgtype385;
	Y1793_gen_type [386] = Y1793_pgtype386;
	Y1793_gen_type [387] = Y1793_pgtype387;
	Y1793_gen_type [388] = Y1793_pgtype388;
	Y1793_gen_type [389] = Y1793_pgtype389;
	Y1793_gen_type [390] = Y1793_pgtype390;
	Y1793_gen_type [391] = Y1793_pgtype391;
	Y1793_gen_type [392] = Y1793_pgtype392;
	Y1793_gen_type [393] = Y1793_pgtype393;
	Y1793_gen_type [394] = Y1793_pgtype394;
	Y1793_gen_type [395] = Y1793_pgtype395;
	Y1793_gen_type [396] = Y1793_pgtype396;
	Y1793_gen_type [397] = Y1793_pgtype397;
	Y1793_gen_type [398] = Y1793_pgtype398;
	Y1793_gen_type [399] = Y1793_pgtype399;
	Y1793_gen_type [400] = Y1793_pgtype400;
	Y1793_gen_type [401] = Y1793_pgtype401;
	Y1793_gen_type [402] = Y1793_pgtype402;
	Y1793_gen_type [403] = Y1793_pgtype403;
	Y1793_gen_type [405] = Y1793_pgtype404;
	Y1793_gen_type [406] = Y1793_pgtype405;
	Y1793_gen_type [407] = Y1793_pgtype406;
	Y1793_gen_type [408] = Y1793_pgtype407;
	Y1793_gen_type [409] = Y1793_pgtype408;
	Y1793_gen_type [410] = Y1793_pgtype409;
	Y1793_gen_type [411] = Y1793_pgtype410;
	Y1793_gen_type [412] = Y1793_pgtype411;
	Y1793_gen_type [413] = Y1793_pgtype412;
	Y1793_gen_type [414] = Y1793_pgtype413;
	Y1793_gen_type [415] = Y1793_pgtype414;
	Y1793_gen_type [416] = Y1793_pgtype415;
	Y1793_gen_type [417] = Y1793_pgtype416;
	Y1793_gen_type [419] = Y1793_pgtype417;
	Y1793_gen_type [420] = Y1793_pgtype418;
	Y1793_gen_type [421] = Y1793_pgtype419;
	Y1793_gen_type [422] = Y1793_pgtype420;
	Y1793_gen_type [423] = Y1793_pgtype421;
	Y1793_gen_type [424] = Y1793_pgtype422;
	Y1793_gen_type [425] = Y1793_pgtype423;
	Y1793_gen_type [430] = Y1793_pgtype424;
	Y1793_gen_type [431] = Y1793_pgtype425;
	Y1793_gen_type [432] = Y1793_pgtype426;
	Y1793_gen_type [433] = Y1793_pgtype427;
	Y1793_gen_type [434] = Y1793_pgtype428;
	Y1793_gen_type [435] = Y1793_pgtype429;
	Y1793_gen_type [436] = Y1793_pgtype430;
	Y1793_gen_type [437] = Y1793_pgtype431;
	Y1793_gen_type [438] = Y1793_pgtype432;
	Y1793_gen_type [439] = Y1793_pgtype433;
	Y1793_gen_type [440] = Y1793_pgtype434;
	Y1793_gen_type [441] = Y1793_pgtype435;
	Y1793_gen_type [522] = Y1793_pgtype436;
	Y1793_gen_type [603] = Y1793_pgtype437;
	Y1793_gen_type [604] = Y1793_pgtype438;
	Y1793_gen_type [605] = Y1793_pgtype439;
	Y1793_gen_type [606] = Y1793_pgtype440;
	Y1793_gen_type [607] = Y1793_pgtype441;
	Y1793_gen_type [608] = Y1793_pgtype442;
	Y1793_gen_type [609] = Y1793_pgtype443;
	Y1793[12] = 783;
	Y1793[13] = 779;
	Y1793[14] = 736;
	Y1793[85] = 736;
	Y1793[86] = 700;
	Y1793[251] = 709;
	{long i; for (i = 314; i < 317; i++) Y1793[i] = 700;};
	Y1793[341] = 709;
	Y1793[425] = 0;
	Y1793[522] = 0;
	{long i; for (i = 603; i < 606; i++) Y1793[i] = 736;};
	{long i; for (i = 606; i < 610; i++) Y1793[i] = 700;};
}

char *(*R1855[4])();
void R1855_init () {
	R1855[0] = (char *(*)()) F219_2067;
	R1855[1] = (char *(*)()) F220_2067;
	R1855[2] = (char *(*)()) F219_2067;
	R1855[3] = (char *(*)()) F220_2067;
}

char *(*R1858[4])();
void R1858_init () {
	R1858[0] = (char *(*)()) F219_2072;
	R1858[1] = (char *(*)()) F220_2072;
	R1858[2] = (char *(*)()) F219_2072;
	R1858[3] = (char *(*)()) F220_2072;
}

char *(*R1861[4])();
void R1861_init () {
	R1861[0] = (char *(*)()) F219_2054;
	R1861[1] = (char *(*)()) F220_2054;
	R1861[2] = (char *(*)()) F219_2054;
	R1861[3] = (char *(*)()) F220_2054;
}

char *(*R1892[359])();
void R1892_init () {
	R1892[0] = (char *(*)()) F288_2140;
	R1892[91] = (char *(*)()) F287_2140;
	R1892[92] = (char *(*)()) F291_2140;
	R1892[93] = (char *(*)()) F292_2140;
	R1892[94] = (char *(*)()) F293_2140;
	R1892[95] = (char *(*)()) F294_2140;
	R1892[96] = (char *(*)()) F295_2140;
	R1892[97] = (char *(*)()) F290_2140;
	R1892[98] = (char *(*)()) F296_2140;
	R1892[99] = (char *(*)()) F297_2140;
	R1892[100] = (char *(*)()) F288_2140;
	R1892[101] = (char *(*)()) F289_2140;
	R1892[102] = (char *(*)()) F298_2140;
	R1892[168] = (char *(*)()) F287_2140;
	R1892[169] = (char *(*)()) F288_2140;
	R1892[170] = (char *(*)()) F287_2140;
	R1892[171] = (char *(*)()) F288_2140;
	R1892[172] = (char *(*)()) F287_2140;
	R1892[173] = (char *(*)()) F288_2140;
	R1892[174] = (char *(*)()) F287_2140;
	R1892[354] = (char *(*)()) F289_2140;
	{long i; for (i = 357; i < 359; i++) R1892[i] = (char *(*)()) F290_2140;}
}

char *(*R1925[264])();
void R1925_init () {
	R1925[0] = (char *(*)()) F518_2660_1925_5;
	R1925[1] = (char *(*)()) F519_2660_1925_5;
	R1925[2] = (char *(*)()) F520_2660_1925_5;
	R1925[3] = (char *(*)()) F521_2660_1925_5;
	R1925[4] = (char *(*)()) F522_2660_1925_5;
	R1925[5] = (char *(*)()) F523_2660_1925_5;
	R1925[6] = (char *(*)()) F524_2660_1925_5;
	R1925[7] = (char *(*)()) F525_2660_1925_5;
	R1925[8] = (char *(*)()) F526_2660_1925_5;
	R1925[9] = (char *(*)()) F527_2660_1925_5;
	R1925[10] = (char *(*)()) F528_2660_1925_5;
	R1925[11] = (char *(*)()) F529_2660_1925_5;
	R1925[263] = (char *(*)()) F781_4815_1925_5;
}
static EIF_REFERENCE F518_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F518_2660(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_REFERENCE F519_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F519_2660(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F520_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F520_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F521_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F521_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F522_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F522_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F523_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F523_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F524_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F524_2660(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(700, 0x00).id, 700, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F525_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F525_2660(Current, *(EIF_INTEGER_32 *)arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(703, 0x00).id, 703, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F526_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F526_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F527_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F527_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F528_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F528_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F529_2660_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F529_2660(Current, *(EIF_INTEGER_32 *)arg1);
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
static EIF_REFERENCE F781_4815_1925_5 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F781_4815(Current, *(EIF_INTEGER_32 *)arg1);
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

char *(*R1928[267])();
void R1928_init () {
	R1928[0] = (char *(*)()) F518_2679_1928_8;
	R1928[1] = (char *(*)()) F519_2679_1928_8;
	R1928[2] = (char *(*)()) F520_2679_1928_8;
	R1928[3] = (char *(*)()) F521_2679_1928_8;
	R1928[4] = (char *(*)()) F522_2679_1928_8;
	R1928[5] = (char *(*)()) F523_2679_1928_8;
	R1928[6] = (char *(*)()) F524_2679_1928_8;
	R1928[7] = (char *(*)()) F525_2679_1928_8;
	R1928[8] = (char *(*)()) F526_2679_1928_8;
	R1928[9] = (char *(*)()) F527_2679_1928_8;
	R1928[10] = (char *(*)()) F528_2679_1928_8;
	R1928[11] = (char *(*)()) F529_2679_1928_8;
	R1928[77] = (char *(*)()) F595_2973;
	R1928[78] = (char *(*)()) F596_2973_1928_8;
	R1928[79] = (char *(*)()) F597_2973_1928_8;
	R1928[80] = (char *(*)()) F598_2973_1928_8;
	R1928[81] = (char *(*)()) F595_2973;
	R1928[82] = (char *(*)()) F596_2973_1928_8;
	R1928[83] = (char *(*)()) F595_2973;
	R1928[266] = (char *(*)()) F784_5000_1928_8;
}
static void F518_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F518_2679(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F519_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F519_2679(Current, *(EIF_POINTER *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F520_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F520_2679(Current, *(EIF_REAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F521_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F521_2679(Current, *(EIF_REAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F522_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F522_2679(Current, *(EIF_NATURAL_16 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F523_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F523_2679(Current, *(EIF_NATURAL_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F524_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F524_2679(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F525_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F525_2679(Current, *(EIF_BOOLEAN *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F526_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F526_2679(Current, *(EIF_NATURAL_64 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F527_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F527_2679(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F528_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F528_2679(Current, *(EIF_CHARACTER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F529_2679_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F529_2679(Current, *(EIF_NATURAL_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F596_2973_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F596_2973(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F597_2973_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F597_2973(Current, arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F598_2973_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F598_2973(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static void F784_5000_1928_8 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	F784_5000(Current, *(EIF_CHARACTER_8 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

static EIF_TYPE_INDEX Y1930_pgtype0[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype1[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype2[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype3[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype4[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype5[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype6[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype7[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype8[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype9[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype10[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype11[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype12[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype13[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype14[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype15[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype16[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype17[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype18[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype19[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype20[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype21[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype22[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype23[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype24[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype25[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype26[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype27[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype28[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype29[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype30[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype31[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype32[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype33[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype34[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype35[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype36[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype37[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype38[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype39[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype40[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype41[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype42[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype43[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype44[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype45[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype46[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype47[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype48[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype49[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype50[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype51[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype52[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype53[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype54[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype55[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype56[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype57[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype58[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype59[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype60[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype61[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype62[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype63[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype64[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype65[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype66[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype67[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype68[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype69[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype70[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype71[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype72[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype73[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype74[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype75[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype76[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype77[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype78[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype79[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype80[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype81[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype82[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype83[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype84[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype85[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype86[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype87[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype88[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype89[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype90[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype91[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype92[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype93[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype94[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype95[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype96[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype97[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype98[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype99[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype100[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype101[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype102[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype103[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype104[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype105[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype106[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype107[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype108[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype109[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype110[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype111[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype112[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype113[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype114[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype115[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype116[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype117[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype118[] = {0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype119[] = {0xFF01,775,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype120[] = {0xFF01,775,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype121[] = {0xFF01,783,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype122[] = {709,0xFFFF};
static EIF_TYPE_INDEX Y1930_pgtype123[] = {709,0xFFFF};
EIF_TYPE_INDEX *Y1930_gen_type [425];
EIF_TYPE_INDEX Y1930 [425];
void Y1930_init (void)
{
	egc_routines_types [1930] = Y1930;
	egc_routines_gen_types [1930] = Y1930_gen_type;
	egc_routines_offset [1930] = 359;
	Y1930_gen_type [0] = Y1930_pgtype0;
	Y1930_gen_type [1] = Y1930_pgtype1;
	Y1930_gen_type [2] = Y1930_pgtype2;
	Y1930_gen_type [3] = Y1930_pgtype3;
	Y1930_gen_type [4] = Y1930_pgtype4;
	Y1930_gen_type [5] = Y1930_pgtype5;
	Y1930_gen_type [6] = Y1930_pgtype6;
	Y1930_gen_type [7] = Y1930_pgtype7;
	Y1930_gen_type [8] = Y1930_pgtype8;
	Y1930_gen_type [9] = Y1930_pgtype9;
	Y1930_gen_type [10] = Y1930_pgtype10;
	Y1930_gen_type [11] = Y1930_pgtype11;
	Y1930_gen_type [12] = Y1930_pgtype12;
	Y1930_gen_type [13] = Y1930_pgtype13;
	Y1930_gen_type [14] = Y1930_pgtype14;
	Y1930_gen_type [15] = Y1930_pgtype15;
	Y1930_gen_type [16] = Y1930_pgtype16;
	Y1930_gen_type [17] = Y1930_pgtype17;
	Y1930_gen_type [18] = Y1930_pgtype18;
	Y1930_gen_type [19] = Y1930_pgtype19;
	Y1930_gen_type [20] = Y1930_pgtype20;
	Y1930_gen_type [21] = Y1930_pgtype21;
	Y1930_gen_type [22] = Y1930_pgtype22;
	Y1930_gen_type [23] = Y1930_pgtype23;
	Y1930_gen_type [24] = Y1930_pgtype24;
	Y1930_gen_type [25] = Y1930_pgtype25;
	Y1930_gen_type [26] = Y1930_pgtype26;
	Y1930_gen_type [27] = Y1930_pgtype27;
	Y1930_gen_type [145] = Y1930_pgtype28;
	Y1930_gen_type [146] = Y1930_pgtype29;
	Y1930_gen_type [147] = Y1930_pgtype30;
	Y1930_gen_type [148] = Y1930_pgtype31;
	Y1930_gen_type [149] = Y1930_pgtype32;
	Y1930_gen_type [150] = Y1930_pgtype33;
	Y1930_gen_type [151] = Y1930_pgtype34;
	Y1930_gen_type [152] = Y1930_pgtype35;
	Y1930_gen_type [153] = Y1930_pgtype36;
	Y1930_gen_type [154] = Y1930_pgtype37;
	Y1930_gen_type [155] = Y1930_pgtype38;
	Y1930_gen_type [156] = Y1930_pgtype39;
	Y1930_gen_type [157] = Y1930_pgtype40;
	Y1930_gen_type [158] = Y1930_pgtype41;
	Y1930_gen_type [159] = Y1930_pgtype42;
	Y1930_gen_type [160] = Y1930_pgtype43;
	Y1930_gen_type [161] = Y1930_pgtype44;
	Y1930_gen_type [162] = Y1930_pgtype45;
	Y1930_gen_type [163] = Y1930_pgtype46;
	Y1930_gen_type [164] = Y1930_pgtype47;
	Y1930_gen_type [165] = Y1930_pgtype48;
	Y1930_gen_type [166] = Y1930_pgtype49;
	Y1930_gen_type [167] = Y1930_pgtype50;
	Y1930_gen_type [168] = Y1930_pgtype51;
	Y1930_gen_type [169] = Y1930_pgtype52;
	Y1930_gen_type [170] = Y1930_pgtype53;
	Y1930_gen_type [171] = Y1930_pgtype54;
	Y1930_gen_type [172] = Y1930_pgtype55;
	Y1930_gen_type [173] = Y1930_pgtype56;
	Y1930_gen_type [174] = Y1930_pgtype57;
	Y1930_gen_type [175] = Y1930_pgtype58;
	Y1930_gen_type [176] = Y1930_pgtype59;
	Y1930_gen_type [177] = Y1930_pgtype60;
	Y1930_gen_type [178] = Y1930_pgtype61;
	Y1930_gen_type [179] = Y1930_pgtype62;
	Y1930_gen_type [180] = Y1930_pgtype63;
	Y1930_gen_type [181] = Y1930_pgtype64;
	Y1930_gen_type [182] = Y1930_pgtype65;
	Y1930_gen_type [183] = Y1930_pgtype66;
	Y1930_gen_type [184] = Y1930_pgtype67;
	Y1930_gen_type [185] = Y1930_pgtype68;
	Y1930_gen_type [186] = Y1930_pgtype69;
	Y1930_gen_type [187] = Y1930_pgtype70;
	Y1930_gen_type [188] = Y1930_pgtype71;
	Y1930_gen_type [189] = Y1930_pgtype72;
	Y1930_gen_type [190] = Y1930_pgtype73;
	Y1930_gen_type [191] = Y1930_pgtype74;
	Y1930_gen_type [192] = Y1930_pgtype75;
	Y1930_gen_type [193] = Y1930_pgtype76;
	Y1930_gen_type [194] = Y1930_pgtype77;
	Y1930_gen_type [195] = Y1930_pgtype78;
	Y1930_gen_type [196] = Y1930_pgtype79;
	Y1930_gen_type [197] = Y1930_pgtype80;
	Y1930_gen_type [198] = Y1930_pgtype81;
	Y1930_gen_type [199] = Y1930_pgtype82;
	Y1930_gen_type [200] = Y1930_pgtype83;
	Y1930_gen_type [201] = Y1930_pgtype84;
	Y1930_gen_type [202] = Y1930_pgtype85;
	Y1930_gen_type [203] = Y1930_pgtype86;
	Y1930_gen_type [204] = Y1930_pgtype87;
	Y1930_gen_type [205] = Y1930_pgtype88;
	Y1930_gen_type [206] = Y1930_pgtype89;
	Y1930_gen_type [207] = Y1930_pgtype90;
	Y1930_gen_type [208] = Y1930_pgtype91;
	Y1930_gen_type [209] = Y1930_pgtype92;
	Y1930_gen_type [210] = Y1930_pgtype93;
	Y1930_gen_type [211] = Y1930_pgtype94;
	Y1930_gen_type [212] = Y1930_pgtype95;
	Y1930_gen_type [213] = Y1930_pgtype96;
	Y1930_gen_type [214] = Y1930_pgtype97;
	Y1930_gen_type [215] = Y1930_pgtype98;
	Y1930_gen_type [216] = Y1930_pgtype99;
	Y1930_gen_type [217] = Y1930_pgtype100;
	Y1930_gen_type [218] = Y1930_pgtype101;
	Y1930_gen_type [219] = Y1930_pgtype102;
	Y1930_gen_type [222] = Y1930_pgtype103;
	Y1930_gen_type [223] = Y1930_pgtype104;
	Y1930_gen_type [224] = Y1930_pgtype105;
	Y1930_gen_type [225] = Y1930_pgtype106;
	Y1930_gen_type [226] = Y1930_pgtype107;
	Y1930_gen_type [227] = Y1930_pgtype108;
	Y1930_gen_type [228] = Y1930_pgtype109;
	Y1930_gen_type [229] = Y1930_pgtype110;
	Y1930_gen_type [230] = Y1930_pgtype111;
	Y1930_gen_type [231] = Y1930_pgtype112;
	Y1930_gen_type [232] = Y1930_pgtype113;
	Y1930_gen_type [233] = Y1930_pgtype114;
	Y1930_gen_type [235] = Y1930_pgtype115;
	Y1930_gen_type [236] = Y1930_pgtype116;
	Y1930_gen_type [237] = Y1930_pgtype117;
	Y1930_gen_type [238] = Y1930_pgtype118;
	Y1930_gen_type [239] = Y1930_pgtype119;
	Y1930_gen_type [240] = Y1930_pgtype120;
	Y1930_gen_type [241] = Y1930_pgtype121;
	Y1930_gen_type [421] = Y1930_pgtype122;
	Y1930_gen_type [424] = Y1930_pgtype123;
	{long i; for (i = 145; i < 220; i++) Y1930[i] = 709;};
	{long i; for (i = 222; i < 234; i++) Y1930[i] = 709;};
	{long i; for (i = 239; i < 241; i++) Y1930[i] = 775;};
	Y1930[241] = 783;
	Y1930[421] = 709;
	Y1930[424] = 709;
}

char *(*R1952[268])();
void R1952_init () {
	R1952[0] = (char *(*)()) F518_2667;
	R1952[1] = (char *(*)()) F519_2667;
	R1952[2] = (char *(*)()) F520_2667;
	R1952[3] = (char *(*)()) F521_2667;
	R1952[4] = (char *(*)()) F522_2667;
	R1952[5] = (char *(*)()) F523_2667;
	R1952[6] = (char *(*)()) F524_2667;
	R1952[7] = (char *(*)()) F525_2667;
	R1952[8] = (char *(*)()) F526_2667;
	R1952[9] = (char *(*)()) F527_2667;
	R1952[10] = (char *(*)()) F528_2667;
	R1952[11] = (char *(*)()) F529_2667;
	R1952[77] = (char *(*)()) F595_2945;
	R1952[78] = (char *(*)()) F596_2945;
	R1952[79] = (char *(*)()) F597_2945;
	R1952[80] = (char *(*)()) F598_2945;
	R1952[81] = (char *(*)()) F595_2945;
	R1952[82] = (char *(*)()) F596_2945;
	R1952[83] = (char *(*)()) F595_2945;
	R1952[263] = (char *(*)()) F779_4754;
	R1952[266] = (char *(*)()) F782_4922;
	R1952[267] = (char *(*)()) F785_5073;
}

char *(*R1955[267])();
void R1955_init () {
	R1955[0] = (char *(*)()) F518_2668;
	R1955[1] = (char *(*)()) F519_2668;
	R1955[2] = (char *(*)()) F520_2668;
	R1955[3] = (char *(*)()) F521_2668;
	R1955[4] = (char *(*)()) F522_2668;
	R1955[5] = (char *(*)()) F523_2668;
	R1955[6] = (char *(*)()) F524_2668;
	R1955[7] = (char *(*)()) F525_2668;
	R1955[8] = (char *(*)()) F526_2668;
	R1955[9] = (char *(*)()) F527_2668;
	R1955[10] = (char *(*)()) F528_2668;
	R1955[11] = (char *(*)()) F529_2668;
	R1955[263] = (char *(*)()) F779_4753;
	R1955[266] = (char *(*)()) F782_4921;
}

char *(*R2162[264])();
void R2162_init () {
	R2162[0] = (char *(*)()) F518_2660;
	R2162[1] = (char *(*)()) F519_2660_2162_33;
	R2162[2] = (char *(*)()) F520_2660_2162_33;
	R2162[3] = (char *(*)()) F521_2660_2162_33;
	R2162[4] = (char *(*)()) F522_2660_2162_33;
	R2162[5] = (char *(*)()) F523_2660_2162_33;
	R2162[6] = (char *(*)()) F524_2660_2162_33;
	R2162[7] = (char *(*)()) F525_2660_2162_33;
	R2162[8] = (char *(*)()) F526_2660_2162_33;
	R2162[9] = (char *(*)()) F527_2660_2162_33;
	R2162[10] = (char *(*)()) F528_2660_2162_33;
	R2162[11] = (char *(*)()) F529_2660_2162_33;
	R2162[88] = (char *(*)()) F606_3159;
	R2162[89] = (char *(*)()) F607_3159_2162_33;
	R2162[90] = (char *(*)()) F608_3159_2162_33;
	R2162[91] = (char *(*)()) F609_3159_2162_33;
	R2162[92] = (char *(*)()) F610_3159_2162_33;
	R2162[93] = (char *(*)()) F611_3159_2162_33;
	R2162[94] = (char *(*)()) F612_3159_2162_33;
	R2162[95] = (char *(*)()) F613_3159_2162_33;
	R2162[96] = (char *(*)()) F614_3159_2162_33;
	R2162[97] = (char *(*)()) F615_3159_2162_33;
	R2162[98] = (char *(*)()) F616_3159_2162_33;
	R2162[99] = (char *(*)()) F617_3159_2162_33;
	R2162[180] = (char *(*)()) F698_3370;
	R2162[262] = (char *(*)()) F780_4792_2162_33;
	R2162[263] = (char *(*)()) F781_4815_2162_33;
}
static EIF_REFERENCE F519_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F519_2660(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F520_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F520_2660(Current, arg1);
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
static EIF_REFERENCE F521_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F521_2660(Current, arg1);
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
static EIF_REFERENCE F522_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F522_2660(Current, arg1);
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
static EIF_REFERENCE F523_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F523_2660(Current, arg1);
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
static EIF_REFERENCE F524_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F524_2660(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(700, 0x00).id, 700, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F525_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F525_2660(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(703, 0x00).id, 703, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F526_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F526_2660(Current, arg1);
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
static EIF_REFERENCE F527_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F527_2660(Current, arg1);
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
static EIF_REFERENCE F528_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F528_2660(Current, arg1);
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
static EIF_REFERENCE F529_2660_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F529_2660(Current, arg1);
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
static EIF_REFERENCE F607_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F607_3159(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F608_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F608_3159(Current, arg1);
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
static EIF_REFERENCE F609_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F609_3159(Current, arg1);
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
static EIF_REFERENCE F610_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F610_3159(Current, arg1);
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
static EIF_REFERENCE F611_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F611_3159(Current, arg1);
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
static EIF_REFERENCE F612_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F612_3159(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(700, 0x00).id, 700, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F613_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F613_3159(Current, arg1);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(703, 0x00).id, 703, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F614_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F614_3159(Current, arg1);
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
static EIF_REFERENCE F615_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F615_3159(Current, arg1);
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
static EIF_REFERENCE F616_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F616_3159(Current, arg1);
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
static EIF_REFERENCE F617_3159_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F617_3159(Current, arg1);
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
static EIF_REFERENCE F780_4792_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F780_4792(Current, arg1);
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
static EIF_REFERENCE F781_4815_2162_33 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F781_4815(Current, arg1);
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

char *(*R2163[267])();
void R2163_init () {
	R2163[0] = (char *(*)()) F518_2665;
	R2163[1] = (char *(*)()) F519_2665;
	R2163[2] = (char *(*)()) F520_2665;
	R2163[3] = (char *(*)()) F521_2665;
	R2163[4] = (char *(*)()) F522_2665;
	R2163[5] = (char *(*)()) F523_2665;
	R2163[6] = (char *(*)()) F524_2665;
	R2163[7] = (char *(*)()) F525_2665;
	R2163[8] = (char *(*)()) F526_2665;
	R2163[9] = (char *(*)()) F527_2665;
	R2163[10] = (char *(*)()) F528_2665;
	R2163[11] = (char *(*)()) F529_2665;
	R2163[77] = (char *(*)()) F595_2948;
	R2163[78] = (char *(*)()) F596_2948;
	R2163[79] = (char *(*)()) F597_2948;
	R2163[80] = (char *(*)()) F598_2948;
	R2163[81] = (char *(*)()) F595_2948;
	R2163[82] = (char *(*)()) F596_2948;
	R2163[83] = (char *(*)()) F595_2948;
	R2163[88] = (char *(*)()) F606_3167;
	R2163[89] = (char *(*)()) F607_3167;
	R2163[90] = (char *(*)()) F608_3167;
	R2163[91] = (char *(*)()) F609_3167;
	R2163[92] = (char *(*)()) F610_3167;
	R2163[93] = (char *(*)()) F611_3167;
	R2163[94] = (char *(*)()) F612_3167;
	R2163[95] = (char *(*)()) F613_3167;
	R2163[96] = (char *(*)()) F614_3167;
	R2163[97] = (char *(*)()) F615_3167;
	R2163[98] = (char *(*)()) F616_3167;
	R2163[99] = (char *(*)()) F617_3167;
	R2163[180] = (char *(*)()) F698_3400;
	{long i; for (i = 262; i < 264; i++) R2163[i] = (char *(*)()) F779_4756;}
	{long i; for (i = 265; i < 267; i++) R2163[i] = (char *(*)()) F782_4924;}
}

EIF_TYPE_INDEX *Y2163_gen_type [292];
EIF_TYPE_INDEX Y2163 [292];
void Y2163_init (void)
{
	egc_routines_types [2163] = Y2163;
	egc_routines_gen_types [2163] = Y2163_gen_type;
	egc_routines_offset [2163] = 492;
	{long i; for (i = 0; i < 87; i++) Y2163[i] = 709;};
	{long i; for (i = 89; i < 101; i++) Y2163[i] = 709;};
	{long i; for (i = 102; i < 109; i++) Y2163[i] = 709;};
	{long i; for (i = 113; i < 125; i++) Y2163[i] = 709;};
	Y2163[205] = 709;
	{long i; for (i = 286; i < 292; i++) Y2163[i] = 709;};
}

char *(*R2164[267])();
void R2164_init () {
	R2164[0] = (char *(*)()) F518_2666;
	R2164[1] = (char *(*)()) F519_2666;
	R2164[2] = (char *(*)()) F520_2666;
	R2164[3] = (char *(*)()) F521_2666;
	R2164[4] = (char *(*)()) F522_2666;
	R2164[5] = (char *(*)()) F523_2666;
	R2164[6] = (char *(*)()) F524_2666;
	R2164[7] = (char *(*)()) F525_2666;
	R2164[8] = (char *(*)()) F526_2666;
	R2164[9] = (char *(*)()) F527_2666;
	R2164[10] = (char *(*)()) F528_2666;
	R2164[11] = (char *(*)()) F529_2666;
	R2164[77] = (char *(*)()) F595_2949;
	R2164[78] = (char *(*)()) F596_2949;
	R2164[79] = (char *(*)()) F597_2949;
	R2164[80] = (char *(*)()) F598_2949;
	R2164[81] = (char *(*)()) F595_2949;
	R2164[82] = (char *(*)()) F596_2949;
	R2164[83] = (char *(*)()) F595_2949;
	R2164[88] = (char *(*)()) F606_3168;
	R2164[89] = (char *(*)()) F607_3168;
	R2164[90] = (char *(*)()) F608_3168;
	R2164[91] = (char *(*)()) F609_3168;
	R2164[92] = (char *(*)()) F610_3168;
	R2164[93] = (char *(*)()) F611_3168;
	R2164[94] = (char *(*)()) F612_3168;
	R2164[95] = (char *(*)()) F613_3168;
	R2164[96] = (char *(*)()) F614_3168;
	R2164[97] = (char *(*)()) F615_3168;
	R2164[98] = (char *(*)()) F616_3168;
	R2164[99] = (char *(*)()) F617_3168;
	R2164[180] = (char *(*)()) F698_3399;
	{long i; for (i = 262; i < 264; i++) R2164[i] = (char *(*)()) F779_4754;}
	{long i; for (i = 265; i < 267; i++) R2164[i] = (char *(*)()) F782_4922;}
}

char *(*R2190[12])();
void R2190_init () {
	R2190[0] = (char *(*)()) F518_2658;
	R2190[1] = (char *(*)()) F519_2658;
	R2190[2] = (char *(*)()) F520_2658;
	R2190[3] = (char *(*)()) F521_2658;
	R2190[4] = (char *(*)()) F522_2658;
	R2190[5] = (char *(*)()) F523_2658;
	R2190[6] = (char *(*)()) F524_2658;
	R2190[7] = (char *(*)()) F525_2658;
	R2190[8] = (char *(*)()) F526_2658;
	R2190[9] = (char *(*)()) F527_2658;
	R2190[10] = (char *(*)()) F528_2658;
	R2190[11] = (char *(*)()) F529_2658;
}

char *(*R2255[190])();
void R2255_init () {
	R2255[0] = (char *(*)()) F595_2986;
	R2255[1] = (char *(*)()) F596_2986;
	R2255[2] = (char *(*)()) F597_2986;
	R2255[3] = (char *(*)()) F598_2986;
	R2255[4] = (char *(*)()) F595_2986;
	R2255[5] = (char *(*)()) F596_2986;
	R2255[6] = (char *(*)()) F595_2986;
	R2255[103] = (char *(*)()) F698_3478;
	R2255[185] = (char *(*)()) F780_4808;
	R2255[186] = (char *(*)()) F781_4899;
	R2255[189] = (char *(*)()) F784_5063;
}

char *(*R2292[7])();
void R2292_init () {
	R2292[0] = (char *(*)()) F595_2927;
	R2292[1] = (char *(*)()) F596_2927;
	R2292[2] = (char *(*)()) F597_2927;
	R2292[3] = (char *(*)()) F598_2927;
	R2292[4] = (char *(*)()) F595_2927;
	R2292[5] = (char *(*)()) F596_2927;
	R2292[6] = (char *(*)()) F595_2927;
}

char *(*R2295[7])();
void R2295_init () {
	R2295[0] = (char *(*)()) F595_2930;
	R2295[1] = (char *(*)()) F596_2930;
	R2295[2] = (char *(*)()) F597_2930;
	R2295[3] = (char *(*)()) F598_2930;
	R2295[4] = (char *(*)()) F595_2930;
	R2295[5] = (char *(*)()) F596_2930;
	R2295[6] = (char *(*)()) F595_2930;
}

char *(*R2296[7])();
void R2296_init () {
	R2296[0] = (char *(*)()) F595_2931;
	R2296[1] = (char *(*)()) F596_2931_2296_1;
	R2296[2] = (char *(*)()) F597_2931;
	R2296[3] = (char *(*)()) F598_2931_2296_1;
	R2296[4] = (char *(*)()) F595_2931;
	R2296[5] = (char *(*)()) F596_2931_2296_1;
	R2296[6] = (char *(*)()) F595_2931;
}
static EIF_REFERENCE F596_2931_2296_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F596_2931(Current);
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
static EIF_REFERENCE F598_2931_2296_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F598_2931(Current);
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

char *(*R2304[7])();
void R2304_init () {
	R2304[0] = (char *(*)()) F595_2944;
	R2304[1] = (char *(*)()) F596_2944;
	R2304[2] = (char *(*)()) F597_2944_2304_10;
	R2304[3] = (char *(*)()) F598_2944_2304_10;
	R2304[4] = (char *(*)()) F599_3041;
	R2304[5] = (char *(*)()) F600_3041;
	R2304[6] = (char *(*)()) F595_2944;
}
static EIF_INTEGER_32 F597_2944_2304_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F597_2944(Current, *(EIF_INTEGER_32 *)arg1);
}
static EIF_INTEGER_32 F598_2944_2304_10 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	return F598_2944(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2306[7])();
void R2306_init () {
	R2306[0] = (char *(*)()) F595_2951;
	R2306[1] = (char *(*)()) F596_2951;
	R2306[2] = (char *(*)()) F597_2951_2306_3;
	R2306[3] = (char *(*)()) F598_2951_2306_3;
	R2306[4] = (char *(*)()) F599_3043;
	R2306[5] = (char *(*)()) F600_3043;
	R2306[6] = (char *(*)()) F595_2951;
}
static EIF_BOOLEAN F597_2951_2306_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F597_2951(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}
static EIF_BOOLEAN F598_2951_2306_3 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	return F598_2951(Current, *(EIF_INTEGER_32 *)arg1, *(EIF_INTEGER_32 *)arg2);
}

char *(*R2312[7])();
void R2312_init () {
	R2312[0] = (char *(*)()) F595_2959;
	R2312[1] = (char *(*)()) F596_2959;
	R2312[2] = (char *(*)()) F597_2959;
	R2312[3] = (char *(*)()) F598_2959;
	R2312[4] = (char *(*)()) F595_2959;
	R2312[5] = (char *(*)()) F596_2959;
	R2312[6] = (char *(*)()) F595_2959;
}

char *(*R2313[7])();
void R2313_init () {
	R2313[0] = (char *(*)()) F595_2960;
	R2313[1] = (char *(*)()) F596_2960;
	R2313[2] = (char *(*)()) F597_2960;
	R2313[3] = (char *(*)()) F598_2960;
	R2313[4] = (char *(*)()) F595_2960;
	R2313[5] = (char *(*)()) F596_2960;
	R2313[6] = (char *(*)()) F595_2960;
}

char *(*R2321[7])();
void R2321_init () {
	R2321[0] = (char *(*)()) F595_2969;
	R2321[1] = (char *(*)()) F596_2969;
	R2321[2] = (char *(*)()) F597_2969_2321_4;
	R2321[3] = (char *(*)()) F598_2969_2321_4;
	R2321[4] = (char *(*)()) F595_2969;
	R2321[5] = (char *(*)()) F596_2969;
	R2321[6] = (char *(*)()) F595_2969;
}
static void F597_2969_2321_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F597_2969(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F598_2969_2321_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F598_2969(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2323[7])();
void R2323_init () {
	R2323[0] = (char *(*)()) F595_2971;
	R2323[1] = (char *(*)()) F596_2971;
	R2323[2] = (char *(*)()) F597_2971;
	R2323[3] = (char *(*)()) F598_2971;
	R2323[4] = (char *(*)()) F595_2971;
	R2323[5] = (char *(*)()) F596_2971;
	R2323[6] = (char *(*)()) F595_2971;
}

char *(*R2324[7])();
void R2324_init () {
	R2324[0] = (char *(*)()) F595_2972;
	R2324[1] = (char *(*)()) F596_2972;
	R2324[2] = (char *(*)()) F597_2972;
	R2324[3] = (char *(*)()) F598_2972;
	R2324[4] = (char *(*)()) F595_2972;
	R2324[5] = (char *(*)()) F596_2972;
	R2324[6] = (char *(*)()) F595_2972;
}

char *(*R2330[7])();
void R2330_init () {
	R2330[0] = (char *(*)()) F595_2985;
	R2330[1] = (char *(*)()) F596_2985;
	R2330[2] = (char *(*)()) F597_2985;
	R2330[3] = (char *(*)()) F598_2985;
	R2330[4] = (char *(*)()) F599_3045;
	R2330[5] = (char *(*)()) F600_3045;
	R2330[6] = (char *(*)()) F595_2985;
}

char *(*R2339[7])();
void R2339_init () {
	R2339[0] = (char *(*)()) F595_2995;
	R2339[1] = (char *(*)()) F596_2995;
	R2339[2] = (char *(*)()) F597_2995;
	R2339[3] = (char *(*)()) F598_2995;
	R2339[4] = (char *(*)()) F595_2995;
	R2339[5] = (char *(*)()) F596_2995;
	R2339[6] = (char *(*)()) F595_2995;
}

char *(*R2340[7])();
void R2340_init () {
	R2340[0] = (char *(*)()) F595_2996;
	R2340[1] = (char *(*)()) F596_2996;
	R2340[2] = (char *(*)()) F597_2996;
	R2340[3] = (char *(*)()) F598_2996;
	R2340[4] = (char *(*)()) F595_2996;
	R2340[5] = (char *(*)()) F596_2996;
	R2340[6] = (char *(*)()) F595_2996;
}

char *(*R2347[7])();
void R2347_init () {
	R2347[0] = (char *(*)()) F595_3003;
	R2347[1] = (char *(*)()) F596_3003_2347_1;
	R2347[2] = (char *(*)()) F597_3003;
	R2347[3] = (char *(*)()) F598_3003_2347_1;
	R2347[4] = (char *(*)()) F595_3003;
	R2347[5] = (char *(*)()) F596_3003_2347_1;
	R2347[6] = (char *(*)()) F595_3003;
}
static EIF_REFERENCE F596_3003_2347_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F596_3003(Current);
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
static EIF_REFERENCE F598_3003_2347_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F598_3003(Current);
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

char *(*R2348[7])();
void R2348_init () {
	R2348[0] = (char *(*)()) F595_3004;
	R2348[1] = (char *(*)()) F596_3004;
	R2348[2] = (char *(*)()) F597_3004_2348_1;
	R2348[3] = (char *(*)()) F598_3004_2348_1;
	R2348[4] = (char *(*)()) F595_3004;
	R2348[5] = (char *(*)()) F596_3004;
	R2348[6] = (char *(*)()) F595_3004;
}
static EIF_REFERENCE F597_3004_2348_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F597_3004(Current);
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
static EIF_REFERENCE F598_3004_2348_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F598_3004(Current);
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

char *(*R2349[7])();
void R2349_init () {
	R2349[0] = (char *(*)()) F595_3005;
	R2349[1] = (char *(*)()) F596_3005;
	R2349[2] = (char *(*)()) F597_3005;
	R2349[3] = (char *(*)()) F598_3005;
	R2349[4] = (char *(*)()) F595_3005;
	R2349[5] = (char *(*)()) F596_3005;
	R2349[6] = (char *(*)()) F595_3005;
}

char *(*R2350[7])();
void R2350_init () {
	R2350[0] = (char *(*)()) F595_3006;
	R2350[1] = (char *(*)()) F596_3006;
	R2350[2] = (char *(*)()) F597_3006;
	R2350[3] = (char *(*)()) F598_3006;
	R2350[4] = (char *(*)()) F595_3006;
	R2350[5] = (char *(*)()) F596_3006;
	R2350[6] = (char *(*)()) F595_3006;
}

char *(*R2353[7])();
void R2353_init () {
	R2353[0] = (char *(*)()) F595_3009;
	R2353[1] = (char *(*)()) F596_3009;
	R2353[2] = (char *(*)()) F597_3009;
	R2353[3] = (char *(*)()) F598_3009;
	R2353[4] = (char *(*)()) F595_3009;
	R2353[5] = (char *(*)()) F596_3009;
	R2353[6] = (char *(*)()) F595_3009;
}

char *(*R2355[7])();
void R2355_init () {
	R2355[0] = (char *(*)()) F595_3011;
	R2355[1] = (char *(*)()) F596_3011;
	R2355[2] = (char *(*)()) F597_3011;
	R2355[3] = (char *(*)()) F598_3011;
	R2355[4] = (char *(*)()) F595_3011;
	R2355[5] = (char *(*)()) F596_3011;
	R2355[6] = (char *(*)()) F595_3011;
}

char *(*R2356[7])();
void R2356_init () {
	R2356[0] = (char *(*)()) F595_3012;
	R2356[1] = (char *(*)()) F596_3012;
	R2356[2] = (char *(*)()) F597_3012;
	R2356[3] = (char *(*)()) F598_3012;
	R2356[4] = (char *(*)()) F595_3012;
	R2356[5] = (char *(*)()) F596_3012;
	R2356[6] = (char *(*)()) F595_3012;
}

char *(*R2357[7])();
void R2357_init () {
	R2357[0] = (char *(*)()) F595_3013;
	R2357[1] = (char *(*)()) F596_3013;
	R2357[2] = (char *(*)()) F597_3013;
	R2357[3] = (char *(*)()) F598_3013;
	R2357[4] = (char *(*)()) F595_3013;
	R2357[5] = (char *(*)()) F596_3013;
	R2357[6] = (char *(*)()) F595_3013;
}

char *(*R2361[7])();
void R2361_init () {
	R2361[0] = (char *(*)()) F595_3017;
	R2361[1] = (char *(*)()) F596_3017;
	R2361[2] = (char *(*)()) F597_3017_2361_4;
	R2361[3] = (char *(*)()) F598_3017_2361_4;
	R2361[4] = (char *(*)()) F595_3017;
	R2361[5] = (char *(*)()) F596_3017;
	R2361[6] = (char *(*)()) F595_3017;
}
static void F597_3017_2361_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F597_3017(Current, *(EIF_INTEGER_32 *)arg1);
}
static void F598_3017_2361_4 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	F598_3017(Current, *(EIF_INTEGER_32 *)arg1);
}

char *(*R2367[7])();
void R2367_init () {
	R2367[0] = (char *(*)()) F595_3023;
	R2367[1] = (char *(*)()) F596_3023;
	R2367[2] = (char *(*)()) F597_3023;
	R2367[3] = (char *(*)()) F598_3023;
	R2367[4] = (char *(*)()) F595_3023;
	R2367[5] = (char *(*)()) F596_3023;
	R2367[6] = (char *(*)()) F595_3023;
}

char *(*R2380[7])();
void R2380_init () {
	R2380[0] = (char *(*)()) F595_3036;
	R2380[1] = (char *(*)()) F596_3036;
	R2380[2] = (char *(*)()) F597_3036;
	R2380[3] = (char *(*)()) F598_3036;
	R2380[4] = (char *(*)()) F595_3036;
	R2380[5] = (char *(*)()) F596_3036;
	R2380[6] = (char *(*)()) F595_3036;
}

char *(*R2383[2])();
void R2383_init () {
	R2383[0] = (char *(*)()) F599_3039;
	R2383[1] = (char *(*)()) F600_3039;
}

char *(*R2488[12])();
void R2488_init () {
	R2488[0] = (char *(*)()) F606_3169;
	R2488[1] = (char *(*)()) F607_3169;
	R2488[2] = (char *(*)()) F608_3169;
	R2488[3] = (char *(*)()) F609_3169;
	R2488[4] = (char *(*)()) F610_3169;
	R2488[5] = (char *(*)()) F611_3169;
	R2488[6] = (char *(*)()) F612_3169;
	R2488[7] = (char *(*)()) F613_3169;
	R2488[8] = (char *(*)()) F614_3169;
	R2488[9] = (char *(*)()) F615_3169;
	R2488[10] = (char *(*)()) F616_3169;
	R2488[11] = (char *(*)()) F617_3169;
}

char *(*R2489[12])();
void R2489_init () {
	R2489[0] = (char *(*)()) F606_3170;
	R2489[1] = (char *(*)()) F607_3170;
	R2489[2] = (char *(*)()) F608_3170;
	R2489[3] = (char *(*)()) F609_3170;
	R2489[4] = (char *(*)()) F610_3170;
	R2489[5] = (char *(*)()) F611_3170;
	R2489[6] = (char *(*)()) F612_3170;
	R2489[7] = (char *(*)()) F613_3170;
	R2489[8] = (char *(*)()) F614_3170;
	R2489[9] = (char *(*)()) F615_3170;
	R2489[10] = (char *(*)()) F616_3170;
	R2489[11] = (char *(*)()) F617_3170;
}

char *(*R2491[12])();
void R2491_init () {
	R2491[0] = (char *(*)()) F606_3156;
	R2491[1] = (char *(*)()) F607_3156;
	R2491[2] = (char *(*)()) F608_3156;
	R2491[3] = (char *(*)()) F609_3156;
	R2491[4] = (char *(*)()) F610_3156;
	R2491[5] = (char *(*)()) F611_3156;
	R2491[6] = (char *(*)()) F612_3156;
	R2491[7] = (char *(*)()) F613_3156;
	R2491[8] = (char *(*)()) F614_3156;
	R2491[9] = (char *(*)()) F615_3156;
	R2491[10] = (char *(*)()) F616_3156;
	R2491[11] = (char *(*)()) F617_3156;
}

char *(*R2492[12])();
void R2492_init () {
	R2492[0] = (char *(*)()) F606_3157;
	R2492[1] = (char *(*)()) F607_3157_2492_116;
	R2492[2] = (char *(*)()) F608_3157_2492_116;
	R2492[3] = (char *(*)()) F609_3157_2492_116;
	R2492[4] = (char *(*)()) F610_3157_2492_116;
	R2492[5] = (char *(*)()) F611_3157_2492_116;
	R2492[6] = (char *(*)()) F612_3157_2492_116;
	R2492[7] = (char *(*)()) F613_3157_2492_116;
	R2492[8] = (char *(*)()) F614_3157_2492_116;
	R2492[9] = (char *(*)()) F615_3157_2492_116;
	R2492[10] = (char *(*)()) F616_3157_2492_116;
	R2492[11] = (char *(*)()) F617_3157_2492_116;
}
static void F607_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F607_3157(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F608_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F608_3157(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F609_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F609_3157(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F610_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F610_3157(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F611_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F611_3157(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F612_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F612_3157(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F613_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3157(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F614_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3157(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F615_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3157(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F616_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3157(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F617_3157_2492_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F617_3157(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2501[12])();
void R2501_init () {
	R2501[0] = (char *(*)()) F606_3172;
	R2501[1] = (char *(*)()) F607_3172;
	R2501[2] = (char *(*)()) F608_3172;
	R2501[3] = (char *(*)()) F609_3172;
	R2501[4] = (char *(*)()) F610_3172;
	R2501[5] = (char *(*)()) F611_3172;
	R2501[6] = (char *(*)()) F612_3172;
	R2501[7] = (char *(*)()) F613_3172;
	R2501[8] = (char *(*)()) F614_3172;
	R2501[9] = (char *(*)()) F615_3172;
	R2501[10] = (char *(*)()) F616_3172;
	R2501[11] = (char *(*)()) F617_3172;
}

char *(*R2502[12])();
void R2502_init () {
	R2502[0] = (char *(*)()) F606_3174;
	R2502[1] = (char *(*)()) F607_3174_2502_116;
	R2502[2] = (char *(*)()) F608_3174_2502_116;
	R2502[3] = (char *(*)()) F609_3174_2502_116;
	R2502[4] = (char *(*)()) F610_3174_2502_116;
	R2502[5] = (char *(*)()) F611_3174_2502_116;
	R2502[6] = (char *(*)()) F612_3174_2502_116;
	R2502[7] = (char *(*)()) F613_3174_2502_116;
	R2502[8] = (char *(*)()) F614_3174_2502_116;
	R2502[9] = (char *(*)()) F615_3174_2502_116;
	R2502[10] = (char *(*)()) F616_3174_2502_116;
	R2502[11] = (char *(*)()) F617_3174_2502_116;
}
static void F607_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F607_3174(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F608_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F608_3174(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F609_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F609_3174(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F610_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F610_3174(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F611_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F611_3174(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F612_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F612_3174(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F613_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3174(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F614_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3174(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F615_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3174(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F616_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3174(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F617_3174_2502_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F617_3174(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2503[12])();
void R2503_init () {
	R2503[0] = (char *(*)()) F606_3175;
	R2503[1] = (char *(*)()) F607_3175_2503_116;
	R2503[2] = (char *(*)()) F608_3175_2503_116;
	R2503[3] = (char *(*)()) F609_3175_2503_116;
	R2503[4] = (char *(*)()) F610_3175_2503_116;
	R2503[5] = (char *(*)()) F611_3175_2503_116;
	R2503[6] = (char *(*)()) F612_3175_2503_116;
	R2503[7] = (char *(*)()) F613_3175_2503_116;
	R2503[8] = (char *(*)()) F614_3175_2503_116;
	R2503[9] = (char *(*)()) F615_3175_2503_116;
	R2503[10] = (char *(*)()) F616_3175_2503_116;
	R2503[11] = (char *(*)()) F617_3175_2503_116;
}
static void F607_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F607_3175(Current, *(EIF_POINTER *)arg1, arg2);
}
static void F608_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F608_3175(Current, *(EIF_REAL_32 *)arg1, arg2);
}
static void F609_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F609_3175(Current, *(EIF_REAL_64 *)arg1, arg2);
}
static void F610_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F610_3175(Current, *(EIF_NATURAL_16 *)arg1, arg2);
}
static void F611_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F611_3175(Current, *(EIF_NATURAL_8 *)arg1, arg2);
}
static void F612_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F612_3175(Current, *(EIF_CHARACTER_8 *)arg1, arg2);
}
static void F613_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F613_3175(Current, *(EIF_BOOLEAN *)arg1, arg2);
}
static void F614_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F614_3175(Current, *(EIF_NATURAL_64 *)arg1, arg2);
}
static void F615_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F615_3175(Current, *(EIF_INTEGER_32 *)arg1, arg2);
}
static void F616_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F616_3175(Current, *(EIF_CHARACTER_32 *)arg1, arg2);
}
static void F617_3175_2503_116 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2)
{
	F617_3175(Current, *(EIF_NATURAL_32 *)arg1, arg2);
}

char *(*R2506[12])();
void R2506_init () {
	R2506[0] = (char *(*)()) F606_3178;
	R2506[1] = (char *(*)()) F607_3178_2506_146;
	R2506[2] = (char *(*)()) F608_3178_2506_146;
	R2506[3] = (char *(*)()) F609_3178_2506_146;
	R2506[4] = (char *(*)()) F610_3178_2506_146;
	R2506[5] = (char *(*)()) F611_3178_2506_146;
	R2506[6] = (char *(*)()) F612_3178_2506_146;
	R2506[7] = (char *(*)()) F613_3178_2506_146;
	R2506[8] = (char *(*)()) F614_3178_2506_146;
	R2506[9] = (char *(*)()) F615_3178_2506_146;
	R2506[10] = (char *(*)()) F616_3178_2506_146;
	R2506[11] = (char *(*)()) F617_3178_2506_146;
}
static void F607_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F607_3178(Current, *(EIF_POINTER *)arg1, arg2, arg3);
}
static void F608_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F608_3178(Current, *(EIF_REAL_32 *)arg1, arg2, arg3);
}
static void F609_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F609_3178(Current, *(EIF_REAL_64 *)arg1, arg2, arg3);
}
static void F610_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F610_3178(Current, *(EIF_NATURAL_16 *)arg1, arg2, arg3);
}
static void F611_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F611_3178(Current, *(EIF_NATURAL_8 *)arg1, arg2, arg3);
}
static void F612_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F612_3178(Current, *(EIF_CHARACTER_8 *)arg1, arg2, arg3);
}
static void F613_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F613_3178(Current, *(EIF_BOOLEAN *)arg1, arg2, arg3);
}
static void F614_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F614_3178(Current, *(EIF_NATURAL_64 *)arg1, arg2, arg3);
}
static void F615_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F615_3178(Current, *(EIF_INTEGER_32 *)arg1, arg2, arg3);
}
static void F616_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F616_3178(Current, *(EIF_CHARACTER_32 *)arg1, arg2, arg3);
}
static void F617_3178_2506_146 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	F617_3178(Current, *(EIF_NATURAL_32 *)arg1, arg2, arg3);
}

char *(*R2509[12])();
void R2509_init () {
	R2509[0] = (char *(*)()) F606_3181;
	R2509[1] = (char *(*)()) F607_3181;
	R2509[2] = (char *(*)()) F608_3181;
	R2509[3] = (char *(*)()) F609_3181;
	R2509[4] = (char *(*)()) F610_3181;
	R2509[5] = (char *(*)()) F611_3181;
	R2509[6] = (char *(*)()) F612_3181;
	R2509[7] = (char *(*)()) F613_3181;
	R2509[8] = (char *(*)()) F614_3181;
	R2509[9] = (char *(*)()) F615_3181;
	R2509[10] = (char *(*)()) F616_3181;
	R2509[11] = (char *(*)()) F617_3181;
}

char *(*R2510[12])();
void R2510_init () {
	R2510[0] = (char *(*)()) F606_3182;
	R2510[1] = (char *(*)()) F607_3182;
	R2510[2] = (char *(*)()) F608_3182;
	R2510[3] = (char *(*)()) F609_3182;
	R2510[4] = (char *(*)()) F610_3182;
	R2510[5] = (char *(*)()) F611_3182;
	R2510[6] = (char *(*)()) F612_3182;
	R2510[7] = (char *(*)()) F613_3182;
	R2510[8] = (char *(*)()) F614_3182;
	R2510[9] = (char *(*)()) F615_3182;
	R2510[10] = (char *(*)()) F616_3182;
	R2510[11] = (char *(*)()) F617_3182;
}

char *(*R2511[12])();
void R2511_init () {
	R2511[0] = (char *(*)()) F606_3183;
	R2511[1] = (char *(*)()) F607_3183;
	R2511[2] = (char *(*)()) F608_3183;
	R2511[3] = (char *(*)()) F609_3183;
	R2511[4] = (char *(*)()) F610_3183;
	R2511[5] = (char *(*)()) F611_3183;
	R2511[6] = (char *(*)()) F612_3183;
	R2511[7] = (char *(*)()) F613_3183;
	R2511[8] = (char *(*)()) F614_3183;
	R2511[9] = (char *(*)()) F615_3183;
	R2511[10] = (char *(*)()) F616_3183;
	R2511[11] = (char *(*)()) F617_3183;
}

char *(*R2512[12])();
void R2512_init () {
	R2512[0] = (char *(*)()) F606_3184;
	R2512[1] = (char *(*)()) F607_3184;
	R2512[2] = (char *(*)()) F608_3184;
	R2512[3] = (char *(*)()) F609_3184;
	R2512[4] = (char *(*)()) F610_3184;
	R2512[5] = (char *(*)()) F611_3184;
	R2512[6] = (char *(*)()) F612_3184;
	R2512[7] = (char *(*)()) F613_3184;
	R2512[8] = (char *(*)()) F614_3184;
	R2512[9] = (char *(*)()) F615_3184;
	R2512[10] = (char *(*)()) F616_3184;
	R2512[11] = (char *(*)()) F617_3184;
}

char *(*R2519[12])();
void R2519_init () {
	R2519[0] = (char *(*)()) F606_3191;
	R2519[1] = (char *(*)()) F607_3191;
	R2519[2] = (char *(*)()) F608_3191;
	R2519[3] = (char *(*)()) F609_3191;
	R2519[4] = (char *(*)()) F610_3191;
	R2519[5] = (char *(*)()) F611_3191;
	R2519[6] = (char *(*)()) F612_3191;
	R2519[7] = (char *(*)()) F613_3191;
	R2519[8] = (char *(*)()) F614_3191;
	R2519[9] = (char *(*)()) F615_3191;
	R2519[10] = (char *(*)()) F616_3191;
	R2519[11] = (char *(*)()) F617_3191;
}

char *(*R2522[12])();
void R2522_init () {
	R2522[0] = (char *(*)()) F606_3194;
	R2522[1] = (char *(*)()) F607_3194;
	R2522[2] = (char *(*)()) F608_3194;
	R2522[3] = (char *(*)()) F609_3194;
	R2522[4] = (char *(*)()) F610_3194;
	R2522[5] = (char *(*)()) F611_3194;
	R2522[6] = (char *(*)()) F612_3194;
	R2522[7] = (char *(*)()) F613_3194;
	R2522[8] = (char *(*)()) F614_3194;
	R2522[9] = (char *(*)()) F615_3194;
	R2522[10] = (char *(*)()) F616_3194;
	R2522[11] = (char *(*)()) F617_3194;
}

char *(*R2531[12])();
void R2531_init () {
	R2531[0] = (char *(*)()) F606_3204;
	R2531[1] = (char *(*)()) F607_3204;
	R2531[2] = (char *(*)()) F608_3204;
	R2531[3] = (char *(*)()) F609_3204;
	R2531[4] = (char *(*)()) F610_3204;
	R2531[5] = (char *(*)()) F611_3204;
	R2531[6] = (char *(*)()) F612_3204;
	R2531[7] = (char *(*)()) F613_3204;
	R2531[8] = (char *(*)()) F614_3204;
	R2531[9] = (char *(*)()) F615_3204;
	R2531[10] = (char *(*)()) F616_3204;
	R2531[11] = (char *(*)()) F617_3204;
}

char *(*R2579[118])();
void R2579_init () {
	R2579[0] = (char *(*)()) F667_3344;
	R2579[1] = (char *(*)()) F668_3344;
	R2579[2] = (char *(*)()) F669_3344;
	R2579[3] = (char *(*)()) F670_3344;
	R2579[4] = (char *(*)()) F671_3344;
	R2579[5] = (char *(*)()) F672_3344;
	R2579[6] = (char *(*)()) F673_3344;
	R2579[7] = (char *(*)()) F674_3344;
	R2579[8] = (char *(*)()) F675_3344;
	R2579[9] = (char *(*)()) F676_3344;
	R2579[10] = (char *(*)()) F677_3344;
	R2579[11] = (char *(*)()) F678_3344;
	R2579[12] = (char *(*)()) F679_3344;
	R2579[13] = (char *(*)()) F680_3344;
	R2579[14] = (char *(*)()) F681_3344;
	R2579[15] = (char *(*)()) F682_3344;
	R2579[16] = (char *(*)()) F683_3344;
	R2579[17] = (char *(*)()) F684_3344;
	R2579[18] = (char *(*)()) F685_3344;
	R2579[19] = (char *(*)()) F686_3344;
	R2579[20] = (char *(*)()) F687_3344;
	R2579[21] = (char *(*)()) F688_3344;
	R2579[22] = (char *(*)()) F689_3344;
	R2579[23] = (char *(*)()) F690_3344;
	R2579[24] = (char *(*)()) F691_3344;
	R2579[25] = (char *(*)()) F692_3344;
	R2579[26] = (char *(*)()) F693_3344;
	R2579[27] = (char *(*)()) F694_3344;
	R2579[28] = (char *(*)()) F695_3344;
	R2579[29] = (char *(*)()) F696_3344;
	R2579[30] = (char *(*)()) F697_3344;
	R2579[31] = (char *(*)()) F698_3396;
	{long i; for (i = 33; i < 35; i++) R2579[i] = (char *(*)()) F699_3505;}
	{long i; for (i = 36; i < 38; i++) R2579[i] = (char *(*)()) F702_3553;}
	{long i; for (i = 39; i < 41; i++) R2579[i] = (char *(*)()) F705_3574;}
	{long i; for (i = 42; i < 44; i++) R2579[i] = (char *(*)()) F708_3672;}
	{long i; for (i = 45; i < 47; i++) R2579[i] = (char *(*)()) F711_3771;}
	{long i; for (i = 48; i < 50; i++) R2579[i] = (char *(*)()) F714_3870;}
	{long i; for (i = 51; i < 53; i++) R2579[i] = (char *(*)()) F717_3969;}
	{long i; for (i = 54; i < 56; i++) R2579[i] = (char *(*)()) F720_4063;}
	{long i; for (i = 57; i < 59; i++) R2579[i] = (char *(*)()) F723_4157;}
	{long i; for (i = 60; i < 62; i++) R2579[i] = (char *(*)()) F726_4252;}
	{long i; for (i = 63; i < 65; i++) R2579[i] = (char *(*)()) F729_4347;}
	{long i; for (i = 66; i < 68; i++) R2579[i] = (char *(*)()) F732_4413;}
	{long i; for (i = 69; i < 71; i++) R2579[i] = (char *(*)()) F735_4480;}
	{long i; for (i = 72; i < 102; i++) R2579[i] = (char *(*)()) F738_4519;}
	R2579[102] = (char *(*)()) F769_4545;
	R2579[103] = (char *(*)()) F770_4545;
	{long i; for (i = 113; i < 115; i++) R2579[i] = (char *(*)()) F776_4612;}
	{long i; for (i = 116; i < 118; i++) R2579[i] = (char *(*)()) F776_4612;}
}

char *(*R2637[31])();
void R2637_init () {
	R2637[0] = (char *(*)()) F667_3340;
	R2637[1] = (char *(*)()) F668_3340;
	R2637[2] = (char *(*)()) F669_3340;
	R2637[3] = (char *(*)()) F670_3340;
	R2637[4] = (char *(*)()) F671_3340;
	R2637[5] = (char *(*)()) F672_3340;
	R2637[6] = (char *(*)()) F673_3340;
	R2637[7] = (char *(*)()) F674_3340;
	R2637[8] = (char *(*)()) F675_3340;
	R2637[9] = (char *(*)()) F676_3340;
	R2637[10] = (char *(*)()) F677_3340;
	R2637[11] = (char *(*)()) F678_3340;
	R2637[12] = (char *(*)()) F679_3340;
	R2637[13] = (char *(*)()) F680_3340;
	R2637[14] = (char *(*)()) F681_3340;
	R2637[15] = (char *(*)()) F682_3340;
	R2637[16] = (char *(*)()) F683_3340;
	R2637[17] = (char *(*)()) F684_3340;
	R2637[18] = (char *(*)()) F685_3340;
	R2637[19] = (char *(*)()) F686_3340;
	R2637[20] = (char *(*)()) F687_3340;
	R2637[21] = (char *(*)()) F688_3340;
	R2637[22] = (char *(*)()) F689_3340;
	R2637[23] = (char *(*)()) F690_3340;
	R2637[24] = (char *(*)()) F691_3340;
	R2637[25] = (char *(*)()) F692_3340;
	R2637[26] = (char *(*)()) F693_3340;
	R2637[27] = (char *(*)()) F694_3340;
	R2637[28] = (char *(*)()) F695_3340;
	R2637[29] = (char *(*)()) F696_3340;
	R2637[30] = (char *(*)()) F697_3340;
}

char *(*R2640[31])();
void R2640_init () {
	R2640[0] = (char *(*)()) F667_3343;
	R2640[1] = (char *(*)()) F668_3343;
	R2640[2] = (char *(*)()) F669_3343;
	R2640[3] = (char *(*)()) F670_3343;
	R2640[4] = (char *(*)()) F671_3343;
	R2640[5] = (char *(*)()) F672_3343;
	R2640[6] = (char *(*)()) F673_3343;
	R2640[7] = (char *(*)()) F674_3343;
	R2640[8] = (char *(*)()) F675_3343;
	R2640[9] = (char *(*)()) F676_3343;
	R2640[10] = (char *(*)()) F677_3343;
	R2640[11] = (char *(*)()) F678_3343;
	R2640[12] = (char *(*)()) F679_3343;
	R2640[13] = (char *(*)()) F680_3343;
	R2640[14] = (char *(*)()) F681_3343;
	R2640[15] = (char *(*)()) F682_3343;
	R2640[16] = (char *(*)()) F683_3343;
	R2640[17] = (char *(*)()) F684_3343;
	R2640[18] = (char *(*)()) F685_3343;
	R2640[19] = (char *(*)()) F686_3343;
	R2640[20] = (char *(*)()) F687_3343;
	R2640[21] = (char *(*)()) F688_3343;
	R2640[22] = (char *(*)()) F689_3343;
	R2640[23] = (char *(*)()) F690_3343;
	R2640[24] = (char *(*)()) F691_3343;
	R2640[25] = (char *(*)()) F692_3343;
	R2640[26] = (char *(*)()) F693_3343;
	R2640[27] = (char *(*)()) F694_3343;
	R2640[28] = (char *(*)()) F695_3343;
	R2640[29] = (char *(*)()) F696_3343;
	R2640[30] = (char *(*)()) F697_3343;
}

char *(*R2645[31])();
void R2645_init () {
	R2645[0] = (char *(*)()) F667_3349;
	R2645[1] = (char *(*)()) F668_3349;
	R2645[2] = (char *(*)()) F669_3349;
	R2645[3] = (char *(*)()) F670_3349;
	R2645[4] = (char *(*)()) F671_3349;
	R2645[5] = (char *(*)()) F672_3349;
	R2645[6] = (char *(*)()) F673_3349;
	R2645[7] = (char *(*)()) F674_3349;
	R2645[8] = (char *(*)()) F675_3349;
	R2645[9] = (char *(*)()) F676_3349;
	R2645[10] = (char *(*)()) F677_3349;
	R2645[11] = (char *(*)()) F678_3349;
	R2645[12] = (char *(*)()) F679_3349;
	R2645[13] = (char *(*)()) F680_3349;
	R2645[14] = (char *(*)()) F681_3349;
	R2645[15] = (char *(*)()) F682_3349;
	R2645[16] = (char *(*)()) F683_3349;
	R2645[17] = (char *(*)()) F684_3349;
	R2645[18] = (char *(*)()) F685_3349;
	R2645[19] = (char *(*)()) F686_3349;
	R2645[20] = (char *(*)()) F687_3349;
	R2645[21] = (char *(*)()) F688_3349;
	R2645[22] = (char *(*)()) F689_3349;
	R2645[23] = (char *(*)()) F690_3349;
	R2645[24] = (char *(*)()) F691_3349;
	R2645[25] = (char *(*)()) F692_3349;
	R2645[26] = (char *(*)()) F693_3349;
	R2645[27] = (char *(*)()) F694_3349;
	R2645[28] = (char *(*)()) F695_3349;
	R2645[29] = (char *(*)()) F696_3349;
	R2645[30] = (char *(*)()) F697_3349;
}

char *(*R2652[31])();
void R2652_init () {
	R2652[0] = (char *(*)()) F667_3357;
	R2652[1] = (char *(*)()) F668_3357_2652_1;
	R2652[2] = (char *(*)()) F669_3357_2652_1;
	R2652[3] = (char *(*)()) F670_3357_2652_1;
	R2652[4] = (char *(*)()) F671_3357_2652_1;
	R2652[5] = (char *(*)()) F672_3357_2652_1;
	R2652[6] = (char *(*)()) F673_3357_2652_1;
	R2652[7] = (char *(*)()) F674_3357_2652_1;
	R2652[8] = (char *(*)()) F675_3357_2652_1;
	R2652[9] = (char *(*)()) F676_3357_2652_1;
	R2652[10] = (char *(*)()) F677_3357_2652_1;
	R2652[11] = (char *(*)()) F678_3357_2652_1;
	R2652[12] = (char *(*)()) F679_3357_2652_1;
	R2652[13] = (char *(*)()) F680_3357_2652_1;
	R2652[14] = (char *(*)()) F681_3357_2652_1;
	R2652[15] = (char *(*)()) F682_3357_2652_1;
	R2652[16] = (char *(*)()) F683_3357_2652_1;
	R2652[17] = (char *(*)()) F684_3357_2652_1;
	R2652[18] = (char *(*)()) F685_3357;
	R2652[19] = (char *(*)()) F686_3357_2652_1;
	R2652[20] = (char *(*)()) F687_3357_2652_1;
	R2652[21] = (char *(*)()) F688_3357_2652_1;
	R2652[22] = (char *(*)()) F689_3357_2652_1;
	R2652[23] = (char *(*)()) F690_3357_2652_1;
	R2652[24] = (char *(*)()) F691_3357_2652_1;
	R2652[25] = (char *(*)()) F692_3357_2652_1;
	R2652[26] = (char *(*)()) F693_3357_2652_1;
	R2652[27] = (char *(*)()) F694_3357_2652_1;
	R2652[28] = (char *(*)()) F695_3357_2652_1;
	R2652[29] = (char *(*)()) F696_3357_2652_1;
	R2652[30] = (char *(*)()) F697_3357_2652_1;
}
static EIF_REFERENCE F668_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8* r = F668_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {740,700,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 740, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F669_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER r = F669_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		Result = RTLNS(eif_new_type(769, 0x00).id, 769, _OBJSIZ_0_0_0_0_0_1_0_0_);
		*(EIF_POINTER *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F670_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64 r = F670_3357(Current);
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
static EIF_REFERENCE F671_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16 r = F671_3357(Current);
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
static EIF_REFERENCE F672_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32 r = F672_3357(Current);
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
static EIF_REFERENCE F673_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REFERENCE* r = F673_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {741,0,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 741, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REFERENCE* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F674_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64 r = F674_3357(Current);
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
static EIF_REFERENCE F675_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32 r = F675_3357(Current);
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
static EIF_REFERENCE F676_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8 r = F676_3357(Current);
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
static EIF_REFERENCE F677_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64 r = F677_3357(Current);
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
static EIF_REFERENCE F678_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8 r = F678_3357(Current);
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
static EIF_REFERENCE F679_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16 r = F679_3357(Current);
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
static EIF_REFERENCE F680_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32 r = F680_3357(Current);
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
static EIF_REFERENCE F681_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_8 r = F681_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_c1 = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_c1;
	} else {
		Result = RTLNS(eif_new_type(700, 0x00).id, 700, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_CHARACTER_8 *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F682_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32 r = F682_3357(Current);
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
static EIF_REFERENCE F683_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN r = F683_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_b = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_b;
	} else {
		Result = RTLNS(eif_new_type(703, 0x00).id, 703, _OBJSIZ_0_1_0_0_0_0_0_0_);
		*(EIF_BOOLEAN *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F684_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_8* r = F684_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {743,715,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 743, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F686_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_64* r = F686_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {745,706,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 745, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F687_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_32* r = F687_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {747,709,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 747, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F688_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_INTEGER_16* r = F688_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {749,712,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 749, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_INTEGER_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F689_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_8* r = F689_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {751,727,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 751, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_8* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F690_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_32* r = F690_3357(Current);
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
static EIF_REFERENCE F691_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_REAL_64* r = F691_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {755,733,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 755, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_REAL_64* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F692_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_64* r = F692_3357(Current);
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
static EIF_REFERENCE F693_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_32* r = F693_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {759,721,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 759, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_32* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F694_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_NATURAL_16* r = F694_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {761,724,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 761, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_NATURAL_16* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F695_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_POINTER* r = F695_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {763,769,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 763, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_POINTER* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F696_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_BOOLEAN* r = F696_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {765,703,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 765, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_BOOLEAN* *)Result = r;
		return Result;
	}
}
static EIF_REFERENCE F697_3357_2652_1 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result;
	int l_eif_optimize_return = eif_optimize_return;
	EIF_CHARACTER_32* r = F697_3357(Current);
	if (l_eif_optimize_return) {
		eif_optimize_return = 0;
		eif_optimized_return_value.it_p = r;
		return (EIF_REFERENCE) &eif_optimized_return_value.it_p;
	} else {
		{
			static EIF_TYPE_INDEX typarr0[] = {767,736,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
			Result = RTLNS(typres0.id, 767, _OBJSIZ_0_0_0_0_0_1_0_0_);
		}
		*(EIF_CHARACTER_32* *)Result = r;
		return Result;
	}
}

char *(*R2662[31])();
void R2662_init () {
	R2662[0] = (char *(*)()) F667_3369;
	R2662[1] = (char *(*)()) F668_3369;
	R2662[2] = (char *(*)()) F669_3369;
	R2662[3] = (char *(*)()) F670_3369;
	R2662[4] = (char *(*)()) F671_3369;
	R2662[5] = (char *(*)()) F672_3369;
	R2662[6] = (char *(*)()) F673_3369;
	R2662[7] = (char *(*)()) F674_3369;
	R2662[8] = (char *(*)()) F675_3369;
	R2662[9] = (char *(*)()) F676_3369;
	R2662[10] = (char *(*)()) F677_3369;
	R2662[11] = (char *(*)()) F678_3369;
	R2662[12] = (char *(*)()) F679_3369;
	R2662[13] = (char *(*)()) F680_3369;
	R2662[14] = (char *(*)()) F681_3369;
	R2662[15] = (char *(*)()) F682_3369;
	R2662[16] = (char *(*)()) F683_3369;
	R2662[17] = (char *(*)()) F684_3369;
	R2662[18] = (char *(*)()) F685_3369;
	R2662[19] = (char *(*)()) F686_3369;
	R2662[20] = (char *(*)()) F687_3369;
	R2662[21] = (char *(*)()) F688_3369;
	R2662[22] = (char *(*)()) F689_3369;
	R2662[23] = (char *(*)()) F690_3369;
	R2662[24] = (char *(*)()) F691_3369;
	R2662[25] = (char *(*)()) F692_3369;
	R2662[26] = (char *(*)()) F693_3369;
	R2662[27] = (char *(*)()) F694_3369;
	R2662[28] = (char *(*)()) F695_3369;
	R2662[29] = (char *(*)()) F696_3369;
	R2662[30] = (char *(*)()) F697_3369;
}

char *(*R2864[2])();
void R2864_init () {
	R2864[0] = (char *(*)()) F706_3656;
	R2864[1] = (char *(*)()) F707_3656;
}

char *(*R2867[2])();
void R2867_init () {
	R2867[0] = (char *(*)()) F706_3659;
	R2867[1] = (char *(*)()) F707_3659;
}

char *(*R2919[2])();
void R2919_init () {
	R2919[0] = (char *(*)()) F709_3754;
	R2919[1] = (char *(*)()) F710_3754;
}

char *(*R2920[2])();
void R2920_init () {
	R2920[0] = (char *(*)()) F709_3755;
	R2920[1] = (char *(*)()) F710_3755;
}

char *(*R2924[2])();
void R2924_init () {
	R2924[0] = (char *(*)()) F709_3759;
	R2924[1] = (char *(*)()) F710_3759;
}

char *(*R2976[2])();
void R2976_init () {
	R2976[0] = (char *(*)()) F712_3854;
	R2976[1] = (char *(*)()) F713_3854;
}

char *(*R2979[2])();
void R2979_init () {
	R2979[0] = (char *(*)()) F712_3857;
	R2979[1] = (char *(*)()) F713_3857;
}

char *(*R3029[2])();
void R3029_init () {
	R3029[0] = (char *(*)()) F715_3950;
	R3029[1] = (char *(*)()) F716_3950;
}

char *(*R3032[2])();
void R3032_init () {
	R3032[0] = (char *(*)()) F715_3953;
	R3032[1] = (char *(*)()) F716_3953;
}

char *(*R3035[2])();
void R3035_init () {
	R3035[0] = (char *(*)()) F715_3956;
	R3035[1] = (char *(*)()) F716_3956;
}

char *(*R3089[2])();
void R3089_init () {
	R3089[0] = (char *(*)()) F718_4050;
	R3089[1] = (char *(*)()) F719_4050;
}

char *(*R3135[2])();
void R3135_init () {
	R3135[0] = (char *(*)()) F721_4138;
	R3135[1] = (char *(*)()) F722_4138;
}

char *(*R3136[2])();
void R3136_init () {
	R3136[0] = (char *(*)()) F721_4139;
	R3136[1] = (char *(*)()) F722_4139;
}

char *(*R3138[2])();
void R3138_init () {
	R3138[0] = (char *(*)()) F721_4141;
	R3138[1] = (char *(*)()) F722_4141;
}

char *(*R3141[2])();
void R3141_init () {
	R3141[0] = (char *(*)()) F721_4144;
	R3141[1] = (char *(*)()) F722_4144;
}

char *(*R3142[2])();
void R3142_init () {
	R3142[0] = (char *(*)()) F721_4145;
	R3142[1] = (char *(*)()) F722_4145;
}

char *(*R3190[2])();
void R3190_init () {
	R3190[0] = (char *(*)()) F724_4235;
	R3190[1] = (char *(*)()) F725_4235;
}

char *(*R3191[2])();
void R3191_init () {
	R3191[0] = (char *(*)()) F724_4236;
	R3191[1] = (char *(*)()) F725_4236;
}

char *(*R3194[2])();
void R3194_init () {
	R3194[0] = (char *(*)()) F724_4239;
	R3194[1] = (char *(*)()) F725_4239;
}

char *(*R3243[2])();
void R3243_init () {
	R3243[0] = (char *(*)()) F727_4330;
	R3243[1] = (char *(*)()) F728_4330;
}

char *(*R3244[2])();
void R3244_init () {
	R3244[0] = (char *(*)()) F727_4331;
	R3244[1] = (char *(*)()) F728_4331;
}

char *(*R3245[2])();
void R3245_init () {
	R3245[0] = (char *(*)()) F727_4332;
	R3245[1] = (char *(*)()) F728_4332;
}

char *(*R3247[2])();
void R3247_init () {
	R3247[0] = (char *(*)()) F727_4334;
	R3247[1] = (char *(*)()) F728_4334;
}

char *(*R3293[2])();
void R3293_init () {
	R3293[0] = (char *(*)()) F730_4392;
	R3293[1] = (char *(*)()) F731_4392;
}

char *(*R3327[2])();
void R3327_init () {
	R3327[0] = (char *(*)()) F733_4458;
	R3327[1] = (char *(*)()) F734_4458;
}

char *(*R3348[2])();
void R3348_init () {
	R3348[0] = (char *(*)()) F736_4516;
	R3348[1] = (char *(*)()) F737_4516;
}

char *(*R3447[5])();
void R3447_init () {
	{long i; for (i = 0; i < 2; i++) R3447[i] = (char *(*)()) F779_4733;}
	{long i; for (i = 3; i < 5; i++) R3447[i] = (char *(*)()) F782_4900;}
}

char *(*R3449[5])();
void R3449_init () {
	R3449[0] = (char *(*)()) F780_4794;
	R3449[1] = (char *(*)()) F781_4817;
	R3449[3] = (char *(*)()) F783_4960;
	R3449[4] = (char *(*)()) F784_4982;
}

char *(*R3450[5])();
void R3450_init () {
	R3450[0] = (char *(*)()) F780_4792;
	R3450[1] = (char *(*)()) F781_4815;
	R3450[3] = (char *(*)()) F783_4959;
	R3450[4] = (char *(*)()) F784_4981;
}

char *(*R3461[5])();
void R3461_init () {
	{long i; for (i = 0; i < 2; i++) R3461[i] = (char *(*)()) F779_4763;}
	{long i; for (i = 3; i < 5; i++) R3461[i] = (char *(*)()) F782_4931;}
}

char *(*R3462[5])();
void R3462_init () {
	{long i; for (i = 0; i < 2; i++) R3462[i] = (char *(*)()) F779_4764;}
	{long i; for (i = 3; i < 5; i++) R3462[i] = (char *(*)()) F782_4932;}
}

char *(*R3463[5])();
void R3463_init () {
	{long i; for (i = 0; i < 2; i++) R3463[i] = (char *(*)()) F779_4765;}
	{long i; for (i = 3; i < 5; i++) R3463[i] = (char *(*)()) F782_4933;}
}

char *(*R3464[5])();
void R3464_init () {
	R3464[0] = (char *(*)()) F780_4804;
	R3464[1] = (char *(*)()) F430_2238;
	R3464[3] = (char *(*)()) F783_4969;
	R3464[4] = (char *(*)()) F431_2238;
}

char *(*R3486[5])();
void R3486_init () {
	{long i; for (i = 0; i < 2; i++) R3486[i] = (char *(*)()) F779_4754;}
	{long i; for (i = 3; i < 5; i++) R3486[i] = (char *(*)()) F782_4922;}
}

char *(*R3487[5])();
void R3487_init () {
	{long i; for (i = 0; i < 2; i++) R3487[i] = (char *(*)()) F779_4753;}
	{long i; for (i = 3; i < 5; i++) R3487[i] = (char *(*)()) F782_4921;}
}

char *(*R3527[5])();
void R3527_init () {
	R3527[0] = (char *(*)()) F780_4801;
	R3527[1] = (char *(*)()) F781_4895;
	R3527[3] = (char *(*)()) F783_4967;
	R3527[4] = (char *(*)()) F784_5060;
}

char *(*R3542[4])();
void R3542_init () {
	R3542[0] = (char *(*)()) F781_4897;
	R3542[3] = (char *(*)()) F784_5062;
}

char *(*R3545[4])();
void R3545_init () {
	R3545[0] = (char *(*)()) F781_4836;
	R3545[3] = (char *(*)()) F784_5001;
}

char *(*R3575[4])();
void R3575_init () {
	R3575[0] = (char *(*)()) F781_4880;
	R3575[3] = (char *(*)()) F784_5045;
}

char *(*R3603[2])();
void R3603_init () {
	R3603[0] = (char *(*)()) F780_4807;
	R3603[1] = (char *(*)()) F779_4784;
}

char *(*R3683[2])();
void R3683_init () {
	R3683[0] = (char *(*)()) F783_4973;
	R3683[1] = (char *(*)()) F782_4952;
}

char *(*R3750[2])();
void R3750_init () {
	R3750[0] = (char *(*)()) F787_5144;
	R3750[1] = (char *(*)()) F788_5152;
}

char *(*R3755[2])();
void R3755_init () {
	R3755[0] = (char *(*)()) F787_5139;
	R3755[1] = (char *(*)()) F788_5155;
}

char *(*R3757[2])();
void R3757_init () {
	R3757[0] = (char *(*)()) F787_5140;
	R3757[1] = (char *(*)()) F788_5156;
}
char *(*R2[798])();
void R2_init () {}
char *(*R6[798])();
void R6_init () {}

char *(*R3[798])();
void R3_init () {
	R3[116] = (char *(*)()) F117_1294;
	R3[784] = (char *(*)()) F785_5074;
}

char *(*R4[798])();
void R4_init () {
	{long i; for (i = 1; i < 4; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 5; i < 7; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 9; i < 12; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 25; i < 28; i++) R4[i] = (char *(*)()) F1_15;}
	R4[35] = (char *(*)()) F1_15;
	R4[39] = (char *(*)()) F1_15;
	{long i; for (i = 43; i < 49; i++) R4[i] = (char *(*)()) F1_15;}
	R4[51] = (char *(*)()) F1_15;
	{long i; for (i = 68; i < 70; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 71; i < 73; i++) R4[i] = (char *(*)()) F1_15;}
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
	R4[116] = (char *(*)()) F117_1213;
	R4[126] = (char *(*)()) F1_15;
	R4[138] = (char *(*)()) F1_15;
	R4[155] = (char *(*)()) F156_1937;
	{long i; for (i = 232; i < 236; i++) R4[i] = (char *(*)()) F1_15;}
	R4[426] = (char *(*)()) F1_15;
	R4[517] = (char *(*)()) F518_2708;
	R4[518] = (char *(*)()) F519_2708;
	R4[519] = (char *(*)()) F520_2708;
	R4[520] = (char *(*)()) F521_2708;
	R4[521] = (char *(*)()) F522_2708;
	R4[522] = (char *(*)()) F523_2708;
	R4[523] = (char *(*)()) F524_2708;
	R4[524] = (char *(*)()) F525_2708;
	R4[525] = (char *(*)()) F526_2708;
	R4[526] = (char *(*)()) F527_2708;
	R4[527] = (char *(*)()) F528_2708;
	R4[528] = (char *(*)()) F529_2708;
	R4[594] = (char *(*)()) F595_2984;
	R4[595] = (char *(*)()) F596_2984;
	R4[596] = (char *(*)()) F597_2984;
	R4[597] = (char *(*)()) F598_2984;
	R4[598] = (char *(*)()) F595_2984;
	R4[599] = (char *(*)()) F596_2984;
	R4[600] = (char *(*)()) F595_2984;
	{long i; for (i = 605; i < 617; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 666; i < 698; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 699; i < 701; i++) R4[i] = (char *(*)()) F1_15;}
	{long i; for (i = 702; i < 704; i++) R4[i] = (char *(*)()) F1_15;}
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
	{long i; for (i = 738; i < 770; i++) R4[i] = (char *(*)()) F1_15;}
	R4[779] = (char *(*)()) F780_4791;
	R4[780] = (char *(*)()) F779_4772;
	R4[782] = (char *(*)()) F783_4956;
	R4[783] = (char *(*)()) F782_4940;
	R4[784] = (char *(*)()) F1_15;
	{long i; for (i = 786; i < 788; i++) R4[i] = (char *(*)()) F1_15;}
	R4[794] = (char *(*)()) F1_15;
}

char *(*R5[798])();
void R5_init () {
	{long i; for (i = 1; i < 4; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 5; i < 7; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 9; i < 12; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 25; i < 28; i++) R5[i] = (char *(*)()) F1_8;}
	R5[35] = (char *(*)()) F1_8;
	R5[39] = (char *(*)()) F1_8;
	{long i; for (i = 43; i < 49; i++) R5[i] = (char *(*)()) F1_8;}
	R5[51] = (char *(*)()) F1_8;
	{long i; for (i = 68; i < 70; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 71; i < 73; i++) R5[i] = (char *(*)()) F1_8;}
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
	R5[116] = (char *(*)()) F117_1212;
	R5[126] = (char *(*)()) F1_8;
	R5[138] = (char *(*)()) F1_8;
	R5[155] = (char *(*)()) F156_1936;
	{long i; for (i = 232; i < 236; i++) R5[i] = (char *(*)()) F1_8;}
	R5[426] = (char *(*)()) F1_8;
	R5[517] = (char *(*)()) F518_2670;
	R5[518] = (char *(*)()) F519_2670;
	R5[519] = (char *(*)()) F520_2670;
	R5[520] = (char *(*)()) F521_2670;
	R5[521] = (char *(*)()) F522_2670;
	R5[522] = (char *(*)()) F523_2670;
	R5[523] = (char *(*)()) F524_2670;
	R5[524] = (char *(*)()) F525_2670;
	R5[525] = (char *(*)()) F526_2670;
	R5[526] = (char *(*)()) F527_2670;
	R5[527] = (char *(*)()) F528_2670;
	R5[528] = (char *(*)()) F529_2670;
	R5[594] = (char *(*)()) F595_2950;
	R5[595] = (char *(*)()) F596_2950;
	R5[596] = (char *(*)()) F597_2950;
	R5[597] = (char *(*)()) F598_2950;
	R5[598] = (char *(*)()) F599_3044;
	R5[599] = (char *(*)()) F600_3044;
	R5[600] = (char *(*)()) F595_2950;
	{long i; for (i = 605; i < 617; i++) R5[i] = (char *(*)()) F1_8;}
	R5[666] = (char *(*)()) F667_3350;
	R5[667] = (char *(*)()) F668_3350;
	R5[668] = (char *(*)()) F669_3350;
	R5[669] = (char *(*)()) F670_3350;
	R5[670] = (char *(*)()) F671_3350;
	R5[671] = (char *(*)()) F672_3350;
	R5[672] = (char *(*)()) F673_3350;
	R5[673] = (char *(*)()) F674_3350;
	R5[674] = (char *(*)()) F675_3350;
	R5[675] = (char *(*)()) F676_3350;
	R5[676] = (char *(*)()) F677_3350;
	R5[677] = (char *(*)()) F678_3350;
	R5[678] = (char *(*)()) F679_3350;
	R5[679] = (char *(*)()) F680_3350;
	R5[680] = (char *(*)()) F681_3350;
	R5[681] = (char *(*)()) F682_3350;
	R5[682] = (char *(*)()) F683_3350;
	R5[683] = (char *(*)()) F684_3350;
	R5[684] = (char *(*)()) F685_3350;
	R5[685] = (char *(*)()) F686_3350;
	R5[686] = (char *(*)()) F687_3350;
	R5[687] = (char *(*)()) F688_3350;
	R5[688] = (char *(*)()) F689_3350;
	R5[689] = (char *(*)()) F690_3350;
	R5[690] = (char *(*)()) F691_3350;
	R5[691] = (char *(*)()) F692_3350;
	R5[692] = (char *(*)()) F693_3350;
	R5[693] = (char *(*)()) F694_3350;
	R5[694] = (char *(*)()) F695_3350;
	R5[695] = (char *(*)()) F696_3350;
	R5[696] = (char *(*)()) F697_3350;
	R5[697] = (char *(*)()) F698_3393;
	{long i; for (i = 699; i < 701; i++) R5[i] = (char *(*)()) F699_3510;}
	{long i; for (i = 702; i < 704; i++) R5[i] = (char *(*)()) F1_8;}
	{long i; for (i = 705; i < 707; i++) R5[i] = (char *(*)()) F705_3582;}
	{long i; for (i = 708; i < 710; i++) R5[i] = (char *(*)()) F708_3680;}
	{long i; for (i = 711; i < 713; i++) R5[i] = (char *(*)()) F711_3779;}
	{long i; for (i = 714; i < 716; i++) R5[i] = (char *(*)()) F714_3878;}
	{long i; for (i = 717; i < 719; i++) R5[i] = (char *(*)()) F717_3977;}
	{long i; for (i = 720; i < 722; i++) R5[i] = (char *(*)()) F720_4071;}
	{long i; for (i = 723; i < 725; i++) R5[i] = (char *(*)()) F723_4165;}
	{long i; for (i = 726; i < 728; i++) R5[i] = (char *(*)()) F726_4260;}
	{long i; for (i = 729; i < 731; i++) R5[i] = (char *(*)()) F729_4359;}
	{long i; for (i = 732; i < 734; i++) R5[i] = (char *(*)()) F732_4425;}
	{long i; for (i = 735; i < 737; i++) R5[i] = (char *(*)()) F735_4486;}
	{long i; for (i = 738; i < 770; i++) R5[i] = (char *(*)()) F738_4521;}
	{long i; for (i = 779; i < 781; i++) R5[i] = (char *(*)()) F779_4757;}
	{long i; for (i = 782; i < 784; i++) R5[i] = (char *(*)()) F782_4925;}
	R5[784] = (char *(*)()) F1_8;
	{long i; for (i = 786; i < 788; i++) R5[i] = (char *(*)()) F1_8;}
	R5[794] = (char *(*)()) F124_1432;
}


#ifdef __cplusplus
}
#endif
