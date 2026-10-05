#include "eif_eiffel.h"
#include "../E1/eoffsets.h"


#ifdef __cplusplus
extern "C" {
#endif

long O696[6];
void O696_init () {
	O696[0] = 0;
	{long i; for (i = 1; i < 3; i++) O696[i] = + _LNGOFF_0_0_0_0_;}
	O696[3] = + _I64OFF_0_0_0_0_0_0_0_;
	O696[4] = 0;
	O696[5] = + _LNGOFF_1_0_0_0_;
}

long O923[4];
void O923_init () {
	O923[0] = + _CHROFF_2_0_;
	O923[1] = + _CHROFF_2_1_;
	{long i; for (i = 2; i < 4; i++) O923[i] = + _CHROFF_2_0_;}
}

long O924[4];
void O924_init () {
	O924[0] = + _CHROFF_2_1_;
	O924[1] = + _CHROFF_2_2_;
	{long i; for (i = 2; i < 4; i++) O924[i] = + _CHROFF_2_1_;}
}

static EIF_TYPE_INDEX Y1710_pgtype0[] = {0xFF01,639,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype1[] = {0xFF01,640,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype2[] = {0xFF01,641,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype3[] = {0xFF01,642,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype4[] = {0xFF01,643,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype5[] = {0xFF01,644,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype6[] = {0xFF01,645,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype7[] = {0xFF01,646,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype8[] = {0xFF01,647,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype9[] = {0xFF01,648,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype10[] = {0xFF01,649,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype11[] = {0xFF01,650,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype12[] = {0xFF01,651,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype13[] = {0xFF01,641,771,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype14[] = {0xFF01,641,771,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype15[] = {0xFF01,639,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype16[] = {0xFF01,640,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype17[] = {0xFF01,641,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype18[] = {0xFF01,642,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype19[] = {0xFF01,643,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype20[] = {0xFF01,644,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype21[] = {0xFF01,645,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype22[] = {0xFF01,646,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype23[] = {0xFF01,647,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype24[] = {0xFF01,648,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype25[] = {0xFF01,649,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype26[] = {0xFF01,650,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype27[] = {0xFF01,651,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype28[] = {0xFF01,639,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype29[] = {0xFF01,640,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype30[] = {0xFF01,641,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype31[] = {0xFF01,642,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype32[] = {0xFF01,643,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype33[] = {0xFF01,644,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype34[] = {0xFF01,645,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype35[] = {0xFF01,646,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype36[] = {0xFF01,647,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype37[] = {0xFF01,648,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype38[] = {0xFF01,649,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype39[] = {0xFF01,650,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype40[] = {0xFF01,651,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype41[] = {0xFF01,649,741,0xFFFF};
static EIF_TYPE_INDEX Y1710_pgtype42[] = {0xFF01,640,744,0xFFFF};
EIF_TYPE_INDEX *Y1710_gen_type [676];
EIF_TYPE_INDEX Y1710 [676];
void Y1710_init (void)
{
	egc_routines_types [1710] = Y1710;
	egc_routines_gen_types [1710] = Y1710_gen_type;
	egc_routines_offset [1710] = 143;
	Y1710_gen_type [0] = Y1710_pgtype0;
	Y1710_gen_type [1] = Y1710_pgtype1;
	Y1710_gen_type [2] = Y1710_pgtype2;
	Y1710_gen_type [3] = Y1710_pgtype3;
	Y1710_gen_type [4] = Y1710_pgtype4;
	Y1710_gen_type [5] = Y1710_pgtype5;
	Y1710_gen_type [6] = Y1710_pgtype6;
	Y1710_gen_type [7] = Y1710_pgtype7;
	Y1710_gen_type [8] = Y1710_pgtype8;
	Y1710_gen_type [9] = Y1710_pgtype9;
	Y1710_gen_type [10] = Y1710_pgtype10;
	Y1710_gen_type [11] = Y1710_pgtype11;
	Y1710_gen_type [12] = Y1710_pgtype12;
	Y1710_gen_type [13] = Y1710_pgtype13;
	Y1710_gen_type [14] = Y1710_pgtype14;
	Y1710_gen_type [402] = Y1710_pgtype15;
	Y1710_gen_type [403] = Y1710_pgtype16;
	Y1710_gen_type [404] = Y1710_pgtype17;
	Y1710_gen_type [405] = Y1710_pgtype18;
	Y1710_gen_type [406] = Y1710_pgtype19;
	Y1710_gen_type [407] = Y1710_pgtype20;
	Y1710_gen_type [408] = Y1710_pgtype21;
	Y1710_gen_type [409] = Y1710_pgtype22;
	Y1710_gen_type [410] = Y1710_pgtype23;
	Y1710_gen_type [411] = Y1710_pgtype24;
	Y1710_gen_type [412] = Y1710_pgtype25;
	Y1710_gen_type [413] = Y1710_pgtype26;
	Y1710_gen_type [414] = Y1710_pgtype27;
	Y1710_gen_type [471] = Y1710_pgtype28;
	Y1710_gen_type [472] = Y1710_pgtype29;
	Y1710_gen_type [473] = Y1710_pgtype30;
	Y1710_gen_type [474] = Y1710_pgtype31;
	Y1710_gen_type [475] = Y1710_pgtype32;
	Y1710_gen_type [476] = Y1710_pgtype33;
	Y1710_gen_type [477] = Y1710_pgtype34;
	Y1710_gen_type [478] = Y1710_pgtype35;
	Y1710_gen_type [479] = Y1710_pgtype36;
	Y1710_gen_type [480] = Y1710_pgtype37;
	Y1710_gen_type [481] = Y1710_pgtype38;
	Y1710_gen_type [482] = Y1710_pgtype39;
	Y1710_gen_type [483] = Y1710_pgtype40;
	Y1710_gen_type [672] = Y1710_pgtype41;
	Y1710_gen_type [675] = Y1710_pgtype42;
	Y1710[0] = 639;
	Y1710[1] = 640;
	Y1710[2] = 641;
	Y1710[3] = 642;
	Y1710[4] = 643;
	Y1710[5] = 644;
	Y1710[6] = 645;
	Y1710[7] = 646;
	Y1710[8] = 647;
	Y1710[9] = 648;
	Y1710[10] = 649;
	Y1710[11] = 650;
	Y1710[12] = 651;
	{long i; for (i = 13; i < 15; i++) Y1710[i] = 641;};
	Y1710[402] = 639;
	Y1710[403] = 640;
	Y1710[404] = 641;
	Y1710[405] = 642;
	Y1710[406] = 643;
	Y1710[407] = 644;
	Y1710[408] = 645;
	Y1710[409] = 646;
	Y1710[410] = 647;
	Y1710[411] = 648;
	Y1710[412] = 649;
	Y1710[413] = 650;
	Y1710[414] = 651;
	Y1710[471] = 639;
	Y1710[472] = 640;
	Y1710[473] = 641;
	Y1710[474] = 642;
	Y1710[475] = 643;
	Y1710[476] = 644;
	Y1710[477] = 645;
	Y1710[478] = 646;
	Y1710[479] = 647;
	Y1710[480] = 648;
	Y1710[481] = 649;
	Y1710[482] = 650;
	Y1710[483] = 651;
	Y1710[672] = 649;
	Y1710[675] = 640;
}

long O1888[524];
void O1888_init () {
	{long i; for (i = 0; i < 219; i++) O1888[i] = + _CHROFF_0_0_;}
	O1888[219] = + _CHROFF_3_2_;
	O1888[220] = + _CHROFF_4_2_;
	O1888[221] = + _CHROFF_5_2_;
	{long i; for (i = 235; i < 249; i++) O1888[i] = + _CHROFF_0_0_;}
	{long i; for (i = 249; i < 262; i++) O1888[i] = + _CHROFF_1_0_;}
	{long i; for (i = 262; i < 314; i++) O1888[i] = + _CHROFF_0_0_;}
	{long i; for (i = 314; i < 316; i++) O1888[i] = + _CHROFF_2_0_;}
	{long i; for (i = 317; i < 331; i++) O1888[i] = + _CHROFF_1_0_;}
	O1888[332] = + _CHROFF_7_0_;
	O1888[333] = + _CHROFF_6_0_;
	O1888[334] = + _CHROFF_5_0_;
	O1888[335] = + _CHROFF_4_0_;
	O1888[336] = + _CHROFF_7_0_;
	O1888[337] = + _CHROFF_5_0_;
	O1888[338] = + _CHROFF_9_0_;
	O1888[519] = + _CHROFF_1_0_;
	O1888[522] = + _CHROFF_1_0_;
	O1888[523] = + _CHROFF_5_2_;
}

EIF_TYPE_INDEX *Y2264_gen_type [1];
EIF_TYPE_INDEX Y2264 [1];
void Y2264_init (void)
{
	egc_routines_types [2264] = Y2264;
	egc_routines_gen_types [2264] = Y2264_gen_type;
	egc_routines_offset [2264] = 613;
	Y2264[0] = 753;
}

long O2294[7];
void O2294_init () {
	{long i; for (i = 0; i < 2; i++) O2294[i] = 0;}
	O2294[2] = + _LNGOFF_5_3_0_0_;
	O2294[3] = + _LNGOFF_4_3_0_0_;
	O2294[4] = 0;
	O2294[5] = + _LNGOFF_5_4_0_0_;
	O2294[6] = 0;
}

long O2303[7];
void O2303_init () {
	O2303[0] = + _LNGOFF_7_3_0_0_;
	O2303[1] = + _LNGOFF_6_3_0_0_;
	O2303[2] = + _LNGOFF_5_3_0_1_;
	O2303[3] = + _LNGOFF_4_3_0_1_;
	O2303[4] = + _LNGOFF_7_4_0_0_;
	O2303[5] = + _LNGOFF_5_4_0_1_;
	O2303[6] = + _LNGOFF_9_3_0_0_;
}

long O2330[7];
void O2330_init () {
	{long i; for (i = 0; i < 2; i++) O2330[i] =  + _REFACS_1_;}
	{long i; for (i = 2; i < 4; i++) O2330[i] = 0;}
	O2330[4] =  + _REFACS_1_;
	O2330[5] = 0;
	O2330[6] =  + _REFACS_1_;
}

static EIF_TYPE_INDEX Y2330_pgtype0[] = {0xFF01,639,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2330_pgtype1[] = {0xFF01,639,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2330_pgtype2[] = {0xFF01,648,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2330_pgtype3[] = {0xFF01,648,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2330_pgtype4[] = {0xFF01,639,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2330_pgtype5[] = {0xFF01,648,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2330_pgtype6[] = {0xFF01,639,0,0xFFFF};
EIF_TYPE_INDEX *Y2330_gen_type [7];
EIF_TYPE_INDEX Y2330 [7];
void Y2330_init (void)
{
	egc_routines_types [2330] = Y2330;
	egc_routines_gen_types [2330] = Y2330_gen_type;
	egc_routines_offset [2330] = 628;
	Y2330_gen_type [0] = Y2330_pgtype0;
	Y2330_gen_type [1] = Y2330_pgtype1;
	Y2330_gen_type [2] = Y2330_pgtype2;
	Y2330_gen_type [3] = Y2330_pgtype3;
	Y2330_gen_type [4] = Y2330_pgtype4;
	Y2330_gen_type [5] = Y2330_pgtype5;
	Y2330_gen_type [6] = Y2330_pgtype6;
	{long i; for (i = 0; i < 2; i++) Y2330[i] = 639;};
	{long i; for (i = 2; i < 4; i++) Y2330[i] = 648;};
	Y2330[4] = 639;
	Y2330[5] = 648;
	Y2330[6] = 639;
}

long O2331[7];
void O2331_init () {
	{long i; for (i = 0; i < 2; i++) O2331[i] =  + _REFACS_2_;}
	{long i; for (i = 2; i < 4; i++) O2331[i] =  + _REFACS_1_;}
	O2331[4] =  + _REFACS_2_;
	O2331[5] =  + _REFACS_1_;
	O2331[6] =  + _REFACS_2_;
}

static EIF_TYPE_INDEX Y2331_pgtype0[] = {0xFF01,639,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2331_pgtype1[] = {0xFF01,648,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2331_pgtype2[] = {0xFF01,639,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2331_pgtype3[] = {0xFF01,648,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2331_pgtype4[] = {0xFF01,639,0xFF01,810,0xFFFF};
static EIF_TYPE_INDEX Y2331_pgtype5[] = {0xFF01,639,0xFF01,810,0xFFFF};
static EIF_TYPE_INDEX Y2331_pgtype6[] = {0xFF01,639,0xFF01,818,0xFFFF};
EIF_TYPE_INDEX *Y2331_gen_type [7];
EIF_TYPE_INDEX Y2331 [7];
void Y2331_init (void)
{
	egc_routines_types [2331] = Y2331;
	egc_routines_gen_types [2331] = Y2331_gen_type;
	egc_routines_offset [2331] = 628;
	Y2331_gen_type [0] = Y2331_pgtype0;
	Y2331_gen_type [1] = Y2331_pgtype1;
	Y2331_gen_type [2] = Y2331_pgtype2;
	Y2331_gen_type [3] = Y2331_pgtype3;
	Y2331_gen_type [4] = Y2331_pgtype4;
	Y2331_gen_type [5] = Y2331_pgtype5;
	Y2331_gen_type [6] = Y2331_pgtype6;
	Y2331[0] = 639;
	Y2331[1] = 648;
	Y2331[2] = 639;
	Y2331[3] = 648;
	{long i; for (i = 4; i < 7; i++) Y2331[i] = 639;};
}

long O2332[7];
void O2332_init () {
	{long i; for (i = 0; i < 2; i++) O2332[i] =  + _REFACS_3_;}
	{long i; for (i = 2; i < 4; i++) O2332[i] =  + _REFACS_2_;}
	O2332[4] =  + _REFACS_3_;
	O2332[5] =  + _REFACS_2_;
	O2332[6] =  + _REFACS_3_;
}

long O2333[7];
void O2333_init () {
	{long i; for (i = 0; i < 2; i++) O2333[i] =  + _REFACS_4_;}
	{long i; for (i = 2; i < 4; i++) O2333[i] =  + _REFACS_3_;}
	O2333[4] =  + _REFACS_4_;
	O2333[5] =  + _REFACS_3_;
	O2333[6] =  + _REFACS_4_;
}

long O2334[7];
void O2334_init () {
	O2334[0] = + _LNGOFF_7_3_0_1_;
	O2334[1] = + _LNGOFF_6_3_0_1_;
	O2334[2] = + _LNGOFF_5_3_0_2_;
	O2334[3] = + _LNGOFF_4_3_0_2_;
	O2334[4] = + _LNGOFF_7_4_0_1_;
	O2334[5] = + _LNGOFF_5_4_0_2_;
	O2334[6] = + _LNGOFF_9_3_0_1_;
}

long O2335[7];
void O2335_init () {
	O2335[0] = + _CHROFF_7_2_;
	O2335[1] = + _CHROFF_6_2_;
	O2335[2] = + _CHROFF_5_2_;
	O2335[3] = + _CHROFF_4_2_;
	O2335[4] = + _CHROFF_7_2_;
	O2335[5] = + _CHROFF_5_2_;
	O2335[6] = + _CHROFF_9_2_;
}

long O2336[7];
void O2336_init () {
	O2336[0] = + _LNGOFF_7_3_0_2_;
	O2336[1] = + _LNGOFF_6_3_0_2_;
	O2336[2] = + _LNGOFF_5_3_0_3_;
	O2336[3] = + _LNGOFF_4_3_0_3_;
	O2336[4] = + _LNGOFF_7_4_0_2_;
	O2336[5] = + _LNGOFF_5_4_0_3_;
	O2336[6] = + _LNGOFF_9_3_0_2_;
}

long O2339[7];
void O2339_init () {
	O2339[0] = + _LNGOFF_7_3_0_3_;
	O2339[1] = + _LNGOFF_6_3_0_3_;
	O2339[2] = + _LNGOFF_5_3_0_4_;
	O2339[3] = + _LNGOFF_4_3_0_4_;
	O2339[4] = + _LNGOFF_7_4_0_3_;
	O2339[5] = + _LNGOFF_5_4_0_4_;
	O2339[6] = + _LNGOFF_9_3_0_3_;
}

long O2340[7];
void O2340_init () {
	O2340[0] = + _LNGOFF_7_3_0_4_;
	O2340[1] = + _LNGOFF_6_3_0_4_;
	O2340[2] = + _LNGOFF_5_3_0_5_;
	O2340[3] = + _LNGOFF_4_3_0_5_;
	O2340[4] = + _LNGOFF_7_4_0_4_;
	O2340[5] = + _LNGOFF_5_4_0_5_;
	O2340[6] = + _LNGOFF_9_3_0_4_;
}

long O2344[7];
void O2344_init () {
	O2344[0] = + _LNGOFF_7_3_0_5_;
	O2344[1] = + _LNGOFF_6_3_0_5_;
	O2344[2] = + _LNGOFF_5_3_0_6_;
	O2344[3] = + _LNGOFF_4_3_0_6_;
	O2344[4] = + _LNGOFF_7_4_0_5_;
	O2344[5] = + _LNGOFF_5_4_0_6_;
	O2344[6] = + _LNGOFF_9_3_0_5_;
}

long O2345[7];
void O2345_init () {
	{long i; for (i = 0; i < 2; i++) O2345[i] =  + _REFACS_5_;}
	O2345[2] = + _LNGOFF_5_3_0_7_;
	O2345[3] = + _LNGOFF_4_3_0_7_;
	O2345[4] =  + _REFACS_5_;
	O2345[5] = + _LNGOFF_5_4_0_7_;
	O2345[6] =  + _REFACS_5_;
}

long O2346[7];
void O2346_init () {
	O2346[0] =  + _REFACS_6_;
	O2346[1] = + _LNGOFF_6_3_0_6_;
	O2346[2] =  + _REFACS_4_;
	O2346[3] = + _LNGOFF_4_3_0_8_;
	O2346[4] =  + _REFACS_6_;
	O2346[5] =  + _REFACS_4_;
	O2346[6] =  + _REFACS_6_;
}

long O2380[7];
void O2380_init () {
	O2380[0] = + _LNGOFF_7_3_0_6_;
	O2380[1] = + _LNGOFF_6_3_0_7_;
	O2380[2] = + _LNGOFF_5_3_0_8_;
	O2380[3] = + _LNGOFF_4_3_0_9_;
	O2380[4] = + _LNGOFF_7_4_0_6_;
	O2380[5] = + _LNGOFF_5_4_0_8_;
	O2380[6] = + _LNGOFF_9_3_0_6_;
}

long O2383[2];
void O2383_init () {
	O2383[0] = + _CHROFF_7_3_;
	O2383[1] = + _CHROFF_5_3_;
}

long O3537[9];
void O3537_init () {
	{long i; for (i = 0; i < 3; i++) O3537[i] = + _LNGOFF_0_0_0_0_;}
	{long i; for (i = 3; i < 5; i++) O3537[i] = + _LNGOFF_1_0_0_0_;}
	O3537[5] = + _LNGOFF_1_1_0_0_;
	{long i; for (i = 6; i < 8; i++) O3537[i] = + _LNGOFF_1_0_0_0_;}
	O3537[8] = + _LNGOFF_1_1_0_0_;
}

long O3538[9];
void O3538_init () {
	{long i; for (i = 0; i < 3; i++) O3538[i] = + _LNGOFF_0_0_0_1_;}
	{long i; for (i = 3; i < 5; i++) O3538[i] = + _LNGOFF_1_0_0_1_;}
	O3538[5] = + _LNGOFF_1_1_0_1_;
	{long i; for (i = 6; i < 8; i++) O3538[i] = + _LNGOFF_1_0_0_1_;}
	O3538[8] = + _LNGOFF_1_1_0_1_;
}

long O3603[3];
void O3603_init () {
	{long i; for (i = 0; i < 2; i++) O3603[i] = + _LNGOFF_1_0_0_2_;}
	O3603[2] = + _LNGOFF_1_1_0_2_;
}

long O3683[3];
void O3683_init () {
	{long i; for (i = 0; i < 2; i++) O3683[i] = + _LNGOFF_1_0_0_2_;}
	O3683[2] = + _LNGOFF_1_1_0_2_;
}


#ifdef __cplusplus
}
#endif
