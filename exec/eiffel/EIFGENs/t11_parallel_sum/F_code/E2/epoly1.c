#include "eif_eiffel.h"
#include "../E1/eoffsets.h"


#ifdef __cplusplus
extern "C" {
#endif

long O704[7];
void O704_init () {
	O704[0] = 0;
	{long i; for (i = 1; i < 3; i++) O704[i] = + _LNGOFF_0_0_0_0_;}
	O704[3] = + _CHROFF_0_0_;
	O704[4] = + _I64OFF_0_0_0_0_0_0_0_;
	O704[5] = 0;
	O704[6] = + _LNGOFF_1_0_0_0_;
}

long O949[4];
void O949_init () {
	O949[0] = + _CHROFF_2_0_;
	O949[1] = + _CHROFF_2_1_;
	{long i; for (i = 2; i < 4; i++) O949[i] = + _CHROFF_2_0_;}
}

long O950[4];
void O950_init () {
	O950[0] = + _CHROFF_2_1_;
	O950[1] = + _CHROFF_2_2_;
	{long i; for (i = 2; i < 4; i++) O950[i] = + _CHROFF_2_1_;}
}

static EIF_TYPE_INDEX Y1763_pgtype0[] = {0xFF01,611,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype1[] = {0xFF01,612,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype2[] = {0xFF01,613,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype3[] = {0xFF01,614,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype4[] = {0xFF01,615,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype5[] = {0xFF01,616,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype6[] = {0xFF01,617,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype7[] = {0xFF01,618,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype8[] = {0xFF01,619,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype9[] = {0xFF01,620,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype10[] = {0xFF01,621,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype11[] = {0xFF01,622,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype12[] = {0xFF01,616,727,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype13[] = {0xFF01,616,727,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype14[] = {0xFF01,611,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype15[] = {0xFF01,612,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype16[] = {0xFF01,613,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype17[] = {0xFF01,614,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype18[] = {0xFF01,615,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype19[] = {0xFF01,616,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype20[] = {0xFF01,617,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype21[] = {0xFF01,618,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype22[] = {0xFF01,619,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype23[] = {0xFF01,620,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype24[] = {0xFF01,621,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype25[] = {0xFF01,622,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype26[] = {0xFF01,611,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype27[] = {0xFF01,612,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype28[] = {0xFF01,613,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype29[] = {0xFF01,614,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype30[] = {0xFF01,615,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype31[] = {0xFF01,616,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype32[] = {0xFF01,617,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype33[] = {0xFF01,618,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype34[] = {0xFF01,619,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype35[] = {0xFF01,620,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype36[] = {0xFF01,621,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype37[] = {0xFF01,622,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype38[] = {0xFF01,617,739,0xFFFF};
static EIF_TYPE_INDEX Y1763_pgtype39[] = {0xFF01,619,736,0xFFFF};
EIF_TYPE_INDEX *Y1763_gen_type [641];
EIF_TYPE_INDEX Y1763 [641];
void Y1763_init (void)
{
	egc_routines_types [1763] = Y1763;
	egc_routines_gen_types [1763] = Y1763_gen_type;
	egc_routines_offset [1763] = 149;
	Y1763_gen_type [0] = Y1763_pgtype0;
	Y1763_gen_type [1] = Y1763_pgtype1;
	Y1763_gen_type [2] = Y1763_pgtype2;
	Y1763_gen_type [3] = Y1763_pgtype3;
	Y1763_gen_type [4] = Y1763_pgtype4;
	Y1763_gen_type [5] = Y1763_pgtype5;
	Y1763_gen_type [6] = Y1763_pgtype6;
	Y1763_gen_type [7] = Y1763_pgtype7;
	Y1763_gen_type [8] = Y1763_pgtype8;
	Y1763_gen_type [9] = Y1763_pgtype9;
	Y1763_gen_type [10] = Y1763_pgtype10;
	Y1763_gen_type [11] = Y1763_pgtype11;
	Y1763_gen_type [12] = Y1763_pgtype12;
	Y1763_gen_type [13] = Y1763_pgtype13;
	Y1763_gen_type [374] = Y1763_pgtype14;
	Y1763_gen_type [375] = Y1763_pgtype15;
	Y1763_gen_type [376] = Y1763_pgtype16;
	Y1763_gen_type [377] = Y1763_pgtype17;
	Y1763_gen_type [378] = Y1763_pgtype18;
	Y1763_gen_type [379] = Y1763_pgtype19;
	Y1763_gen_type [380] = Y1763_pgtype20;
	Y1763_gen_type [381] = Y1763_pgtype21;
	Y1763_gen_type [382] = Y1763_pgtype22;
	Y1763_gen_type [383] = Y1763_pgtype23;
	Y1763_gen_type [384] = Y1763_pgtype24;
	Y1763_gen_type [385] = Y1763_pgtype25;
	Y1763_gen_type [438] = Y1763_pgtype26;
	Y1763_gen_type [439] = Y1763_pgtype27;
	Y1763_gen_type [440] = Y1763_pgtype28;
	Y1763_gen_type [441] = Y1763_pgtype29;
	Y1763_gen_type [442] = Y1763_pgtype30;
	Y1763_gen_type [443] = Y1763_pgtype31;
	Y1763_gen_type [444] = Y1763_pgtype32;
	Y1763_gen_type [445] = Y1763_pgtype33;
	Y1763_gen_type [446] = Y1763_pgtype34;
	Y1763_gen_type [447] = Y1763_pgtype35;
	Y1763_gen_type [448] = Y1763_pgtype36;
	Y1763_gen_type [449] = Y1763_pgtype37;
	Y1763_gen_type [637] = Y1763_pgtype38;
	Y1763_gen_type [640] = Y1763_pgtype39;
	Y1763[0] = 611;
	Y1763[1] = 612;
	Y1763[2] = 613;
	Y1763[3] = 614;
	Y1763[4] = 615;
	Y1763[5] = 616;
	Y1763[6] = 617;
	Y1763[7] = 618;
	Y1763[8] = 619;
	Y1763[9] = 620;
	Y1763[10] = 621;
	Y1763[11] = 622;
	{long i; for (i = 12; i < 14; i++) Y1763[i] = 616;};
	Y1763[374] = 611;
	Y1763[375] = 612;
	Y1763[376] = 613;
	Y1763[377] = 614;
	Y1763[378] = 615;
	Y1763[379] = 616;
	Y1763[380] = 617;
	Y1763[381] = 618;
	Y1763[382] = 619;
	Y1763[383] = 620;
	Y1763[384] = 621;
	Y1763[385] = 622;
	Y1763[438] = 611;
	Y1763[439] = 612;
	Y1763[440] = 613;
	Y1763[441] = 614;
	Y1763[442] = 615;
	Y1763[443] = 616;
	Y1763[444] = 617;
	Y1763[445] = 618;
	Y1763[446] = 619;
	Y1763[447] = 620;
	Y1763[448] = 621;
	Y1763[449] = 622;
	Y1763[637] = 617;
	Y1763[640] = 619;
}

long O1941[500];
void O1941_init () {
	{long i; for (i = 0; i < 203; i++) O1941[i] = + _CHROFF_0_0_;}
	O1941[203] = + _CHROFF_3_2_;
	O1941[204] = + _CHROFF_4_2_;
	O1941[205] = + _CHROFF_5_2_;
	{long i; for (i = 218; i < 231; i++) O1941[i] = + _CHROFF_0_0_;}
	{long i; for (i = 231; i < 243; i++) O1941[i] = + _CHROFF_1_0_;}
	{long i; for (i = 243; i < 291; i++) O1941[i] = + _CHROFF_0_0_;}
	{long i; for (i = 291; i < 293; i++) O1941[i] = + _CHROFF_2_0_;}
	{long i; for (i = 294; i < 307; i++) O1941[i] = + _CHROFF_1_0_;}
	O1941[308] = + _CHROFF_7_0_;
	O1941[309] = + _CHROFF_6_0_;
	O1941[310] = + _CHROFF_5_0_;
	O1941[311] = + _CHROFF_4_0_;
	O1941[312] = + _CHROFF_7_0_;
	O1941[313] = + _CHROFF_5_0_;
	O1941[314] = + _CHROFF_9_0_;
	O1941[494] = + _CHROFF_1_0_;
	O1941[497] = + _CHROFF_1_0_;
	O1941[499] = + _CHROFF_5_2_;
}

EIF_TYPE_INDEX *Y2317_gen_type [1];
EIF_TYPE_INDEX Y2317 [1];
void Y2317_init (void)
{
	egc_routines_types [2317] = Y2317;
	egc_routines_gen_types [2317] = Y2317_gen_type;
	egc_routines_offset [2317] = 586;
	Y2317[0] = 709;
}

long O2347[7];
void O2347_init () {
	{long i; for (i = 0; i < 2; i++) O2347[i] = 0;}
	O2347[2] = + _LNGOFF_5_3_0_0_;
	O2347[3] = + _LNGOFF_4_3_0_0_;
	O2347[4] = 0;
	O2347[5] = + _LNGOFF_5_4_0_0_;
	O2347[6] = 0;
}

long O2356[7];
void O2356_init () {
	O2356[0] = + _LNGOFF_7_3_0_0_;
	O2356[1] = + _LNGOFF_6_3_0_0_;
	O2356[2] = + _LNGOFF_5_3_0_1_;
	O2356[3] = + _LNGOFF_4_3_0_1_;
	O2356[4] = + _LNGOFF_7_4_0_0_;
	O2356[5] = + _LNGOFF_5_4_0_1_;
	O2356[6] = + _LNGOFF_9_3_0_0_;
}

long O2383[7];
void O2383_init () {
	{long i; for (i = 0; i < 2; i++) O2383[i] =  + _REFACS_1_;}
	{long i; for (i = 2; i < 4; i++) O2383[i] = 0;}
	O2383[4] =  + _REFACS_1_;
	O2383[5] = 0;
	O2383[6] =  + _REFACS_1_;
}

static EIF_TYPE_INDEX Y2383_pgtype0[] = {0xFF01,611,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2383_pgtype1[] = {0xFF01,611,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2383_pgtype2[] = {0xFF01,618,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2383_pgtype3[] = {0xFF01,618,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2383_pgtype4[] = {0xFF01,611,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2383_pgtype5[] = {0xFF01,618,0xFFF8,1,0xFFFF};
static EIF_TYPE_INDEX Y2383_pgtype6[] = {0xFF01,611,0,0xFFFF};
EIF_TYPE_INDEX *Y2383_gen_type [7];
EIF_TYPE_INDEX Y2383 [7];
void Y2383_init (void)
{
	egc_routines_types [2383] = Y2383;
	egc_routines_gen_types [2383] = Y2383_gen_type;
	egc_routines_offset [2383] = 600;
	Y2383_gen_type [0] = Y2383_pgtype0;
	Y2383_gen_type [1] = Y2383_pgtype1;
	Y2383_gen_type [2] = Y2383_pgtype2;
	Y2383_gen_type [3] = Y2383_pgtype3;
	Y2383_gen_type [4] = Y2383_pgtype4;
	Y2383_gen_type [5] = Y2383_pgtype5;
	Y2383_gen_type [6] = Y2383_pgtype6;
	{long i; for (i = 0; i < 2; i++) Y2383[i] = 611;};
	{long i; for (i = 2; i < 4; i++) Y2383[i] = 618;};
	Y2383[4] = 611;
	Y2383[5] = 618;
	Y2383[6] = 611;
}

long O2384[7];
void O2384_init () {
	{long i; for (i = 0; i < 2; i++) O2384[i] =  + _REFACS_2_;}
	{long i; for (i = 2; i < 4; i++) O2384[i] =  + _REFACS_1_;}
	O2384[4] =  + _REFACS_2_;
	O2384[5] =  + _REFACS_1_;
	O2384[6] =  + _REFACS_2_;
}

static EIF_TYPE_INDEX Y2384_pgtype0[] = {0xFF01,611,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2384_pgtype1[] = {0xFF01,618,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2384_pgtype2[] = {0xFF01,611,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2384_pgtype3[] = {0xFF01,618,0xFFF8,2,0xFFFF};
static EIF_TYPE_INDEX Y2384_pgtype4[] = {0xFF01,611,0xFF01,781,0xFFFF};
static EIF_TYPE_INDEX Y2384_pgtype5[] = {0xFF01,611,0xFF01,781,0xFFFF};
static EIF_TYPE_INDEX Y2384_pgtype6[] = {0xFF01,611,0xFF01,786,0xFFFF};
EIF_TYPE_INDEX *Y2384_gen_type [7];
EIF_TYPE_INDEX Y2384 [7];
void Y2384_init (void)
{
	egc_routines_types [2384] = Y2384;
	egc_routines_gen_types [2384] = Y2384_gen_type;
	egc_routines_offset [2384] = 600;
	Y2384_gen_type [0] = Y2384_pgtype0;
	Y2384_gen_type [1] = Y2384_pgtype1;
	Y2384_gen_type [2] = Y2384_pgtype2;
	Y2384_gen_type [3] = Y2384_pgtype3;
	Y2384_gen_type [4] = Y2384_pgtype4;
	Y2384_gen_type [5] = Y2384_pgtype5;
	Y2384_gen_type [6] = Y2384_pgtype6;
	Y2384[0] = 611;
	Y2384[1] = 618;
	Y2384[2] = 611;
	Y2384[3] = 618;
	{long i; for (i = 4; i < 7; i++) Y2384[i] = 611;};
}

long O2385[7];
void O2385_init () {
	{long i; for (i = 0; i < 2; i++) O2385[i] =  + _REFACS_3_;}
	{long i; for (i = 2; i < 4; i++) O2385[i] =  + _REFACS_2_;}
	O2385[4] =  + _REFACS_3_;
	O2385[5] =  + _REFACS_2_;
	O2385[6] =  + _REFACS_3_;
}

long O2386[7];
void O2386_init () {
	{long i; for (i = 0; i < 2; i++) O2386[i] =  + _REFACS_4_;}
	{long i; for (i = 2; i < 4; i++) O2386[i] =  + _REFACS_3_;}
	O2386[4] =  + _REFACS_4_;
	O2386[5] =  + _REFACS_3_;
	O2386[6] =  + _REFACS_4_;
}

long O2387[7];
void O2387_init () {
	O2387[0] = + _LNGOFF_7_3_0_1_;
	O2387[1] = + _LNGOFF_6_3_0_1_;
	O2387[2] = + _LNGOFF_5_3_0_2_;
	O2387[3] = + _LNGOFF_4_3_0_2_;
	O2387[4] = + _LNGOFF_7_4_0_1_;
	O2387[5] = + _LNGOFF_5_4_0_2_;
	O2387[6] = + _LNGOFF_9_3_0_1_;
}

long O2388[7];
void O2388_init () {
	O2388[0] = + _CHROFF_7_2_;
	O2388[1] = + _CHROFF_6_2_;
	O2388[2] = + _CHROFF_5_2_;
	O2388[3] = + _CHROFF_4_2_;
	O2388[4] = + _CHROFF_7_2_;
	O2388[5] = + _CHROFF_5_2_;
	O2388[6] = + _CHROFF_9_2_;
}

long O2389[7];
void O2389_init () {
	O2389[0] = + _LNGOFF_7_3_0_2_;
	O2389[1] = + _LNGOFF_6_3_0_2_;
	O2389[2] = + _LNGOFF_5_3_0_3_;
	O2389[3] = + _LNGOFF_4_3_0_3_;
	O2389[4] = + _LNGOFF_7_4_0_2_;
	O2389[5] = + _LNGOFF_5_4_0_3_;
	O2389[6] = + _LNGOFF_9_3_0_2_;
}

long O2392[7];
void O2392_init () {
	O2392[0] = + _LNGOFF_7_3_0_3_;
	O2392[1] = + _LNGOFF_6_3_0_3_;
	O2392[2] = + _LNGOFF_5_3_0_4_;
	O2392[3] = + _LNGOFF_4_3_0_4_;
	O2392[4] = + _LNGOFF_7_4_0_3_;
	O2392[5] = + _LNGOFF_5_4_0_4_;
	O2392[6] = + _LNGOFF_9_3_0_3_;
}

long O2393[7];
void O2393_init () {
	O2393[0] = + _LNGOFF_7_3_0_4_;
	O2393[1] = + _LNGOFF_6_3_0_4_;
	O2393[2] = + _LNGOFF_5_3_0_5_;
	O2393[3] = + _LNGOFF_4_3_0_5_;
	O2393[4] = + _LNGOFF_7_4_0_4_;
	O2393[5] = + _LNGOFF_5_4_0_5_;
	O2393[6] = + _LNGOFF_9_3_0_4_;
}

long O2397[7];
void O2397_init () {
	O2397[0] = + _LNGOFF_7_3_0_5_;
	O2397[1] = + _LNGOFF_6_3_0_5_;
	O2397[2] = + _LNGOFF_5_3_0_6_;
	O2397[3] = + _LNGOFF_4_3_0_6_;
	O2397[4] = + _LNGOFF_7_4_0_5_;
	O2397[5] = + _LNGOFF_5_4_0_6_;
	O2397[6] = + _LNGOFF_9_3_0_5_;
}

long O2398[7];
void O2398_init () {
	{long i; for (i = 0; i < 2; i++) O2398[i] =  + _REFACS_5_;}
	O2398[2] = + _LNGOFF_5_3_0_7_;
	O2398[3] = + _LNGOFF_4_3_0_7_;
	O2398[4] =  + _REFACS_5_;
	O2398[5] = + _LNGOFF_5_4_0_7_;
	O2398[6] =  + _REFACS_5_;
}

long O2399[7];
void O2399_init () {
	O2399[0] =  + _REFACS_6_;
	O2399[1] = + _LNGOFF_6_3_0_6_;
	O2399[2] =  + _REFACS_4_;
	O2399[3] = + _LNGOFF_4_3_0_8_;
	O2399[4] =  + _REFACS_6_;
	O2399[5] =  + _REFACS_4_;
	O2399[6] =  + _REFACS_6_;
}

long O2433[7];
void O2433_init () {
	O2433[0] = + _LNGOFF_7_3_0_6_;
	O2433[1] = + _LNGOFF_6_3_0_7_;
	O2433[2] = + _LNGOFF_5_3_0_8_;
	O2433[3] = + _LNGOFF_4_3_0_9_;
	O2433[4] = + _LNGOFF_7_4_0_6_;
	O2433[5] = + _LNGOFF_5_4_0_8_;
	O2433[6] = + _LNGOFF_9_3_0_6_;
}

long O2436[2];
void O2436_init () {
	O2436[0] = + _CHROFF_7_3_;
	O2436[1] = + _CHROFF_5_3_;
}

long O3590[9];
void O3590_init () {
	{long i; for (i = 0; i < 3; i++) O3590[i] = + _LNGOFF_0_0_0_0_;}
	{long i; for (i = 3; i < 5; i++) O3590[i] = + _LNGOFF_1_0_0_0_;}
	O3590[5] = + _LNGOFF_1_1_0_0_;
	{long i; for (i = 6; i < 8; i++) O3590[i] = + _LNGOFF_1_0_0_0_;}
	O3590[8] = + _LNGOFF_1_1_0_0_;
}

long O3591[9];
void O3591_init () {
	{long i; for (i = 0; i < 3; i++) O3591[i] = + _LNGOFF_0_0_0_1_;}
	{long i; for (i = 3; i < 5; i++) O3591[i] = + _LNGOFF_1_0_0_1_;}
	O3591[5] = + _LNGOFF_1_1_0_1_;
	{long i; for (i = 6; i < 8; i++) O3591[i] = + _LNGOFF_1_0_0_1_;}
	O3591[8] = + _LNGOFF_1_1_0_1_;
}

long O3660[3];
void O3660_init () {
	{long i; for (i = 0; i < 2; i++) O3660[i] = + _LNGOFF_1_0_0_2_;}
	O3660[2] = + _LNGOFF_1_1_0_2_;
}

long O3735[3];
void O3735_init () {
	{long i; for (i = 0; i < 2; i++) O3735[i] = + _LNGOFF_1_0_0_2_;}
	O3735[2] = + _LNGOFF_1_1_0_2_;
}


#ifdef __cplusplus
}
#endif
