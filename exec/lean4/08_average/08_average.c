// Lean compiler output
// Module: «08_average»
// Imports: public import Init public meta import Init
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
uint64_t lean_uint64_add(uint64_t, uint64_t);
uint64_t lean_uint64_mod(uint64_t, uint64_t);
double lean_uint64_to_float(uint64_t);
double lean_float_div(double, double);
double lean_float_add(double, double);
lean_object* lean_nat_to_int(lean_object*);
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_mono_nanos_now();
uint8_t lean_int_dec_le(lean_object*, lean_object*);
lean_object* lean_int_neg(lean_object*);
lean_object* l_Int_toNat(lean_object*);
lean_object* lean_nat_pow(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_string_length(lean_object*);
lean_object* l_List_replicateTR___redArg(lean_object*, lean_object*);
lean_object* lean_string_mk(lean_object*);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* lean_string_utf8_byte_size(lean_object*);
lean_object* l_String_Slice_Pos_nextn(lean_object*, lean_object*, lean_object*);
lean_object* l_String_Slice_toString(lean_object*);
lean_object* l_String_Slice_posLE(lean_object*, lean_object*);
uint32_t lean_string_utf8_get_fast(lean_object*, lean_object*);
uint8_t lean_uint32_dec_eq(uint32_t, uint32_t);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* lean_string_utf8_extract_fast(lean_object*, lean_object*, lean_object*);
lean_object* lean_nat_shiftl(lean_object*, lean_object*);
uint8_t lean_float_beq(double, double);
uint64_t lean_float_to_bits(double);
uint64_t lean_uint64_shift_right(uint64_t, uint64_t);
uint8_t lean_uint64_dec_eq(uint64_t, uint64_t);
uint64_t lean_uint64_land(uint64_t, uint64_t);
lean_object* lean_uint64_to_nat(uint64_t);
lean_object* lean_int_sub(lean_object*, lean_object*);
double lean_float_of_nat(lean_object*);
lean_object* lean_float_to_string(double);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
static lean_once_cell_t l_avg_go___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_avg_go___closed__0;
LEAN_EXPORT double l_avg_go(lean_object*, uint64_t, double);
LEAN_EXPORT lean_object* l_avg_go___boxed(lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_avg___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_avg___closed__0;
LEAN_EXPORT double l_avg(lean_object*);
LEAN_EXPORT lean_object* l_avg___boxed(lean_object*);
LEAN_EXPORT lean_object* l_String_Slice_Pos_revSkipWhile___at___00exactFloat_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_String_Slice_Pos_revSkipWhile___at___00exactFloat_spec__0___boxed(lean_object*, lean_object*);
static lean_once_cell_t l_exactFloat___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_exactFloat___closed__0;
static const lean_string_object l_exactFloat___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "."};
static const lean_object* l_exactFloat___closed__1 = (const lean_object*)&l_exactFloat___closed__1_value;
static const lean_string_object l_exactFloat___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 1, .m_capacity = 1, .m_length = 0, .m_data = ""};
static const lean_object* l_exactFloat___closed__2 = (const lean_object*)&l_exactFloat___closed__2_value;
static const lean_string_object l_exactFloat___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "-"};
static const lean_object* l_exactFloat___closed__3 = (const lean_object*)&l_exactFloat___closed__3_value;
static lean_once_cell_t l_exactFloat___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_exactFloat___closed__4;
static lean_once_cell_t l_exactFloat___closed__5_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_exactFloat___closed__5;
static lean_once_cell_t l_exactFloat___closed__6_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_exactFloat___closed__6;
static const lean_string_object l_exactFloat___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "0"};
static const lean_object* l_exactFloat___closed__7 = (const lean_object*)&l_exactFloat___closed__7_value;
LEAN_EXPORT lean_object* l_exactFloat___boxed__const__1;
LEAN_EXPORT lean_object* l_exactFloat(double);
LEAN_EXPORT lean_object* l_exactFloat___boxed(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_main___lam__0___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___lam__0___closed__0;
static lean_once_cell_t l_main___lam__0___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___lam__0___closed__1;
static lean_once_cell_t l_main___lam__0___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___lam__0___closed__2;
static lean_once_cell_t l_main___lam__0___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___lam__0___closed__3;
LEAN_EXPORT lean_object* l_main___lam__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static const lean_closure_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)l_main___lam__0, .m_arity = 1, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static lean_once_cell_t l_main___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__1;
static const lean_string_object l_main___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__2 = (const lean_object*)&l_main___closed__2_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
static double _init_l_avg_go___closed__0(void){
_start:
{
lean_object* v_one_1_; uint8_t v___x_2_; lean_object* v___x_3_; double v___x_4_; 
v_one_1_ = lean_unsigned_to_nat(1u);
v___x_2_ = 1;
v___x_3_ = lean_unsigned_to_nat(2560u);
v___x_4_ = l_Float_ofScientific(v___x_3_, v___x_2_, v_one_1_);
return v___x_4_;
}
}
LEAN_EXPORT double l_avg_go(lean_object* v_a_5_, uint64_t v_a_6_, double v_a_7_){
_start:
{
lean_object* v_zero_8_; uint8_t v_isZero_9_; 
v_zero_8_ = lean_unsigned_to_nat(0u);
v_isZero_9_ = lean_nat_dec_eq(v_a_5_, v_zero_8_);
if (v_isZero_9_ == 1)
{
lean_dec(v_a_5_);
return v_a_7_;
}
else
{
lean_object* v_one_10_; lean_object* v_n_11_; uint64_t v___x_12_; uint64_t v___x_13_; uint64_t v___x_14_; uint64_t v___x_15_; double v___x_16_; double v___x_17_; double v___x_18_; double v___x_19_; 
v_one_10_ = lean_unsigned_to_nat(1u);
v_n_11_ = lean_nat_sub(v_a_5_, v_one_10_);
lean_dec(v_a_5_);
v___x_12_ = 1ULL;
v___x_13_ = lean_uint64_add(v_a_6_, v___x_12_);
v___x_14_ = 256ULL;
v___x_15_ = lean_uint64_mod(v_a_6_, v___x_14_);
v___x_16_ = lean_uint64_to_float(v___x_15_);
v___x_17_ = lean_float_once(&l_avg_go___closed__0, &l_avg_go___closed__0_once, _init_l_avg_go___closed__0);
v___x_18_ = lean_float_div(v___x_16_, v___x_17_);
v___x_19_ = lean_float_add(v_a_7_, v___x_18_);
v_a_5_ = v_n_11_;
v_a_6_ = v___x_13_;
v_a_7_ = v___x_19_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_avg_go___boxed(lean_object* v_a_21_, lean_object* v_a_22_, lean_object* v_a_23_){
_start:
{
uint64_t v_a_101__boxed_24_; double v_a_102__boxed_25_; double v_res_26_; lean_object* v_r_27_; 
v_a_101__boxed_24_ = lean_unbox_uint64(v_a_22_);
lean_dec_ref(v_a_22_);
v_a_102__boxed_25_ = lean_unbox_float(v_a_23_);
lean_dec_ref(v_a_23_);
v_res_26_ = l_avg_go(v_a_21_, v_a_101__boxed_24_, v_a_102__boxed_25_);
v_r_27_ = lean_box_float(v_res_26_);
return v_r_27_;
}
}
static double _init_l_avg___closed__0(void){
_start:
{
lean_object* v___x_28_; uint8_t v___x_29_; lean_object* v___x_30_; double v___x_31_; 
v___x_28_ = lean_unsigned_to_nat(1u);
v___x_29_ = 1;
v___x_30_ = lean_unsigned_to_nat(0u);
v___x_31_ = l_Float_ofScientific(v___x_30_, v___x_29_, v___x_28_);
return v___x_31_;
}
}
LEAN_EXPORT double l_avg(lean_object* v_n_32_){
_start:
{
uint64_t v___x_33_; double v___x_34_; double v___x_35_; 
v___x_33_ = 0ULL;
v___x_34_ = lean_float_once(&l_avg___closed__0, &l_avg___closed__0_once, _init_l_avg___closed__0);
v___x_35_ = l_avg_go(v_n_32_, v___x_33_, v___x_34_);
return v___x_35_;
}
}
LEAN_EXPORT lean_object* l_avg___boxed(lean_object* v_n_36_){
_start:
{
double v_res_37_; lean_object* v_r_38_; 
v_res_37_ = l_avg(v_n_36_);
v_r_38_ = lean_box_float(v_res_37_);
return v_r_38_;
}
}
LEAN_EXPORT lean_object* l_String_Slice_Pos_revSkipWhile___at___00exactFloat_spec__0(lean_object* v_s_39_, lean_object* v_pos_40_){
_start:
{
lean_object* v_str_41_; lean_object* v_startInclusive_42_; lean_object* v___x_43_; lean_object* v___x_44_; lean_object* v___x_45_; uint8_t v___x_46_; 
v_str_41_ = lean_ctor_get(v_s_39_, 0);
v_startInclusive_42_ = lean_ctor_get(v_s_39_, 1);
v___x_43_ = lean_nat_add(v_startInclusive_42_, v_pos_40_);
v___x_44_ = lean_nat_sub(v___x_43_, v_startInclusive_42_);
v___x_45_ = lean_unsigned_to_nat(0u);
v___x_46_ = lean_nat_dec_eq(v___x_44_, v___x_45_);
if (v___x_46_ == 0)
{
uint32_t v___x_47_; lean_object* v___x_48_; lean_object* v___x_49_; lean_object* v___x_50_; lean_object* v___x_51_; lean_object* v___x_52_; uint32_t v___x_53_; uint8_t v___x_54_; 
v___x_47_ = 48;
lean_inc(v_startInclusive_42_);
lean_inc_ref(v_str_41_);
v___x_48_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v___x_48_, 0, v_str_41_);
lean_ctor_set(v___x_48_, 1, v_startInclusive_42_);
lean_ctor_set(v___x_48_, 2, v___x_43_);
v___x_49_ = lean_unsigned_to_nat(1u);
v___x_50_ = lean_nat_sub(v___x_44_, v___x_49_);
lean_dec(v___x_44_);
v___x_51_ = l_String_Slice_posLE(v___x_48_, v___x_50_);
lean_dec_ref_known(v___x_48_, 3);
v___x_52_ = lean_nat_add(v_startInclusive_42_, v___x_51_);
v___x_53_ = lean_string_utf8_get_fast(v_str_41_, v___x_52_);
lean_dec(v___x_52_);
v___x_54_ = lean_uint32_dec_eq(v___x_53_, v___x_47_);
if (v___x_54_ == 0)
{
lean_dec(v___x_51_);
return v_pos_40_;
}
else
{
uint8_t v___x_55_; 
v___x_55_ = lean_nat_dec_lt(v___x_51_, v_pos_40_);
if (v___x_55_ == 0)
{
lean_dec(v___x_51_);
return v_pos_40_;
}
else
{
lean_dec(v_pos_40_);
v_pos_40_ = v___x_51_;
goto _start;
}
}
}
else
{
lean_dec(v___x_44_);
lean_dec(v___x_43_);
return v_pos_40_;
}
}
}
LEAN_EXPORT lean_object* l_String_Slice_Pos_revSkipWhile___at___00exactFloat_spec__0___boxed(lean_object* v_s_57_, lean_object* v_pos_58_){
_start:
{
lean_object* v_res_59_; 
v_res_59_ = l_String_Slice_Pos_revSkipWhile___at___00exactFloat_spec__0(v_s_57_, v_pos_58_);
lean_dec_ref(v_s_57_);
return v_res_59_;
}
}
static lean_object* _init_l_exactFloat___closed__0(void){
_start:
{
lean_object* v___x_60_; lean_object* v___x_61_; 
v___x_60_ = lean_unsigned_to_nat(0u);
v___x_61_ = lean_nat_to_int(v___x_60_);
return v___x_61_;
}
}
static lean_object* _init_l_exactFloat___closed__4(void){
_start:
{
lean_object* v___x_65_; lean_object* v___x_66_; 
v___x_65_ = lean_unsigned_to_nat(1075u);
v___x_66_ = lean_nat_to_int(v___x_65_);
return v___x_66_;
}
}
static lean_object* _init_l_exactFloat___closed__5(void){
_start:
{
lean_object* v___x_67_; lean_object* v___x_68_; 
v___x_67_ = lean_unsigned_to_nat(1074u);
v___x_68_ = lean_nat_to_int(v___x_67_);
return v___x_68_;
}
}
static lean_object* _init_l_exactFloat___closed__6(void){
_start:
{
lean_object* v___x_69_; lean_object* v___x_70_; 
v___x_69_ = lean_obj_once(&l_exactFloat___closed__5, &l_exactFloat___closed__5_once, _init_l_exactFloat___closed__5);
v___x_70_ = lean_int_neg(v___x_69_);
return v___x_70_;
}
}
static lean_object* _init_l_exactFloat___boxed__const__1(void){
_start:
{
uint32_t v___x_72_; lean_object* v___x_73_; 
v___x_72_ = 48;
v___x_73_ = lean_box_uint32(v___x_72_);
return v___x_73_;
}
}
LEAN_EXPORT lean_object* l_exactFloat(double v_x_74_){
_start:
{
lean_object* v___x_75_; lean_object* v___x_76_; lean_object* v___y_78_; lean_object* v___y_79_; lean_object* v___y_80_; double v___x_119_; uint8_t v___x_120_; 
v___x_75_ = lean_unsigned_to_nat(0u);
v___x_76_ = lean_unsigned_to_nat(1u);
v___x_119_ = lean_float_once(&l_avg___closed__0, &l_avg___closed__0_once, _init_l_avg___closed__0);
v___x_120_ = lean_float_beq(v_x_74_, v___x_119_);
if (v___x_120_ == 0)
{
uint64_t v_bits_121_; uint64_t v___x_122_; uint64_t v___x_123_; uint64_t v___x_124_; uint8_t v_neg_125_; lean_object* v_fst_127_; lean_object* v_snd_128_; uint64_t v___x_131_; uint64_t v___x_132_; uint64_t v___x_133_; uint64_t v_expField_134_; uint64_t v___x_135_; uint64_t v_frac_136_; uint64_t v___x_137_; uint8_t v___x_138_; 
v_bits_121_ = lean_float_to_bits(v_x_74_);
v___x_122_ = 63ULL;
v___x_123_ = lean_uint64_shift_right(v_bits_121_, v___x_122_);
v___x_124_ = 1ULL;
v_neg_125_ = lean_uint64_dec_eq(v___x_123_, v___x_124_);
v___x_131_ = 52ULL;
v___x_132_ = lean_uint64_shift_right(v_bits_121_, v___x_131_);
v___x_133_ = 2047ULL;
v_expField_134_ = lean_uint64_land(v___x_132_, v___x_133_);
v___x_135_ = 4503599627370495ULL;
v_frac_136_ = lean_uint64_land(v_bits_121_, v___x_135_);
v___x_137_ = 0ULL;
v___x_138_ = lean_uint64_dec_eq(v_expField_134_, v___x_137_);
if (v___x_138_ == 0)
{
uint64_t v___x_139_; uint64_t v___x_140_; lean_object* v___x_141_; lean_object* v___x_142_; lean_object* v___x_143_; lean_object* v___x_144_; lean_object* v___x_145_; 
v___x_139_ = 4503599627370496ULL;
v___x_140_ = lean_uint64_add(v_frac_136_, v___x_139_);
v___x_141_ = lean_uint64_to_nat(v___x_140_);
v___x_142_ = lean_uint64_to_nat(v_expField_134_);
v___x_143_ = lean_nat_to_int(v___x_142_);
v___x_144_ = lean_obj_once(&l_exactFloat___closed__4, &l_exactFloat___closed__4_once, _init_l_exactFloat___closed__4);
v___x_145_ = lean_int_sub(v___x_143_, v___x_144_);
lean_dec(v___x_143_);
v_fst_127_ = v___x_141_;
v_snd_128_ = v___x_145_;
goto v___jp_126_;
}
else
{
lean_object* v___x_146_; lean_object* v___x_147_; 
v___x_146_ = lean_uint64_to_nat(v_frac_136_);
v___x_147_ = lean_obj_once(&l_exactFloat___closed__6, &l_exactFloat___closed__6_once, _init_l_exactFloat___closed__6);
v_fst_127_ = v___x_146_;
v_snd_128_ = v___x_147_;
goto v___jp_126_;
}
v___jp_126_:
{
if (v_neg_125_ == 0)
{
lean_object* v___x_129_; 
v___x_129_ = ((lean_object*)(l_exactFloat___closed__2));
v___y_78_ = v_fst_127_;
v___y_79_ = v_snd_128_;
v___y_80_ = v___x_129_;
goto v___jp_77_;
}
else
{
lean_object* v___x_130_; 
v___x_130_ = ((lean_object*)(l_exactFloat___closed__3));
v___y_78_ = v_fst_127_;
v___y_79_ = v_snd_128_;
v___y_80_ = v___x_130_;
goto v___jp_77_;
}
}
}
else
{
lean_object* v___x_148_; 
v___x_148_ = ((lean_object*)(l_exactFloat___closed__7));
return v___x_148_;
}
v___jp_77_:
{
lean_object* v___x_81_; uint8_t v___x_82_; 
v___x_81_ = lean_obj_once(&l_exactFloat___closed__0, &l_exactFloat___closed__0_once, _init_l_exactFloat___closed__0);
v___x_82_ = lean_int_dec_le(v___x_81_, v___y_79_);
if (v___x_82_ == 0)
{
lean_object* v___x_83_; lean_object* v_places_84_; lean_object* v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; lean_object* v_digits_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; lean_object* v___x_92_; lean_object* v___x_93_; lean_object* v___x_94_; lean_object* v_padded_95_; lean_object* v___x_96_; lean_object* v___x_97_; lean_object* v___x_98_; lean_object* v___x_99_; lean_object* v___x_100_; lean_object* v___x_101_; lean_object* v_intPart_102_; lean_object* v___x_103_; lean_object* v___x_104_; lean_object* v___x_105_; lean_object* v___x_106_; lean_object* v___x_107_; uint8_t v___x_108_; 
v___x_83_ = lean_int_neg(v___y_79_);
lean_dec(v___y_79_);
v_places_84_ = l_Int_toNat(v___x_83_);
lean_dec(v___x_83_);
v___x_85_ = lean_unsigned_to_nat(5u);
v___x_86_ = lean_nat_pow(v___x_85_, v_places_84_);
v___x_87_ = lean_nat_mul(v___y_78_, v___x_86_);
lean_dec(v___x_86_);
lean_dec(v___y_78_);
v_digits_88_ = l_Nat_reprFast(v___x_87_);
v___x_89_ = lean_nat_add(v_places_84_, v___x_76_);
v___x_90_ = lean_string_length(v_digits_88_);
v___x_91_ = lean_nat_sub(v___x_89_, v___x_90_);
lean_dec(v___x_89_);
v___x_92_ = l_exactFloat___boxed__const__1;
v___x_93_ = l_List_replicateTR___redArg(v___x_91_, v___x_92_);
v___x_94_ = lean_string_mk(v___x_93_);
v_padded_95_ = lean_string_append(v___x_94_, v_digits_88_);
lean_dec_ref(v_digits_88_);
v___x_96_ = lean_string_length(v_padded_95_);
v___x_97_ = lean_nat_sub(v___x_96_, v_places_84_);
lean_dec(v_places_84_);
v___x_98_ = lean_string_utf8_byte_size(v_padded_95_);
lean_inc_ref_n(v_padded_95_, 2);
v___x_99_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v___x_99_, 0, v_padded_95_);
lean_ctor_set(v___x_99_, 1, v___x_75_);
lean_ctor_set(v___x_99_, 2, v___x_98_);
v___x_100_ = l_String_Slice_Pos_nextn(v___x_99_, v___x_75_, v___x_97_);
lean_dec_ref_known(v___x_99_, 3);
lean_inc(v___x_100_);
v___x_101_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v___x_101_, 0, v_padded_95_);
lean_ctor_set(v___x_101_, 1, v___x_75_);
lean_ctor_set(v___x_101_, 2, v___x_100_);
v_intPart_102_ = l_String_Slice_toString(v___x_101_);
lean_dec_ref_known(v___x_101_, 3);
v___x_103_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v___x_103_, 0, v_padded_95_);
lean_ctor_set(v___x_103_, 1, v___x_100_);
lean_ctor_set(v___x_103_, 2, v___x_98_);
v___x_104_ = l_String_Slice_toString(v___x_103_);
lean_dec_ref_known(v___x_103_, 3);
v___x_105_ = lean_string_utf8_byte_size(v___x_104_);
lean_inc_ref(v___x_104_);
v___x_106_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v___x_106_, 0, v___x_104_);
lean_ctor_set(v___x_106_, 1, v___x_75_);
lean_ctor_set(v___x_106_, 2, v___x_105_);
v___x_107_ = l_String_Slice_Pos_revSkipWhile___at___00exactFloat_spec__0(v___x_106_, v___x_105_);
lean_dec_ref_known(v___x_106_, 3);
v___x_108_ = lean_nat_dec_eq(v___x_107_, v___x_75_);
if (v___x_108_ == 0)
{
lean_object* v___x_109_; lean_object* v___x_110_; lean_object* v___x_111_; lean_object* v___x_112_; lean_object* v___x_113_; 
lean_inc_ref(v___y_80_);
v___x_109_ = lean_string_append(v___y_80_, v_intPart_102_);
lean_dec_ref(v_intPart_102_);
v___x_110_ = ((lean_object*)(l_exactFloat___closed__1));
v___x_111_ = lean_string_append(v___x_109_, v___x_110_);
v___x_112_ = lean_string_utf8_extract_fast(v___x_104_, v___x_75_, v___x_107_);
lean_dec(v___x_107_);
lean_dec_ref(v___x_104_);
v___x_113_ = lean_string_append(v___x_111_, v___x_112_);
lean_dec_ref(v___x_112_);
return v___x_113_;
}
else
{
lean_object* v___x_114_; 
lean_dec(v___x_107_);
lean_dec_ref(v___x_104_);
lean_inc_ref(v___y_80_);
v___x_114_ = lean_string_append(v___y_80_, v_intPart_102_);
lean_dec_ref(v_intPart_102_);
return v___x_114_;
}
}
else
{
lean_object* v___x_115_; lean_object* v___x_116_; lean_object* v___x_117_; lean_object* v___x_118_; 
v___x_115_ = l_Int_toNat(v___y_79_);
lean_dec(v___y_79_);
v___x_116_ = lean_nat_shiftl(v___y_78_, v___x_115_);
lean_dec(v___x_115_);
lean_dec(v___y_78_);
v___x_117_ = l_Nat_reprFast(v___x_116_);
lean_inc_ref(v___y_80_);
v___x_118_ = lean_string_append(v___y_80_, v___x_117_);
lean_dec_ref(v___x_117_);
return v___x_118_;
}
}
}
}
LEAN_EXPORT lean_object* l_exactFloat___boxed(lean_object* v_x_149_){
_start:
{
double v_x_boxed_150_; lean_object* v_res_151_; 
v_x_boxed_150_ = lean_unbox_float(v_x_149_);
lean_dec_ref(v_x_149_);
v_res_151_ = l_exactFloat(v_x_boxed_150_);
return v_res_151_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_152_){
_start:
{
lean_object* v___x_154_; 
v___x_154_ = l_IO_lazyPure___redArg(v_x_152_);
return v___x_154_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_155_, lean_object* v_a_156_){
_start:
{
lean_object* v_res_157_; 
v_res_157_ = l_forceIO___redArg(v_x_155_);
return v_res_157_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_158_, lean_object* v_x_159_){
_start:
{
lean_object* v___x_161_; 
v___x_161_ = l_forceIO___redArg(v_x_159_);
return v___x_161_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_162_, lean_object* v_x_163_, lean_object* v_a_164_){
_start:
{
lean_object* v_res_165_; 
v_res_165_ = l_forceIO(v_00_u03b1_162_, v_x_163_);
return v_res_165_;
}
}
static double _init_l_main___lam__0___closed__0(void){
_start:
{
lean_object* v___x_166_; double v___x_167_; 
v___x_166_ = lean_unsigned_to_nat(100000000u);
v___x_167_ = l_avg(v___x_166_);
return v___x_167_;
}
}
static double _init_l_main___lam__0___closed__1(void){
_start:
{
lean_object* v___x_168_; uint8_t v___x_169_; lean_object* v___x_170_; double v___x_171_; 
v___x_168_ = lean_unsigned_to_nat(1u);
v___x_169_ = 1;
v___x_170_ = lean_unsigned_to_nat(1000000000u);
v___x_171_ = l_Float_ofScientific(v___x_170_, v___x_169_, v___x_168_);
return v___x_171_;
}
}
static double _init_l_main___lam__0___closed__2(void){
_start:
{
double v___x_172_; double v___x_173_; double v___x_174_; 
v___x_172_ = lean_float_once(&l_main___lam__0___closed__1, &l_main___lam__0___closed__1_once, _init_l_main___lam__0___closed__1);
v___x_173_ = lean_float_once(&l_main___lam__0___closed__0, &l_main___lam__0___closed__0_once, _init_l_main___lam__0___closed__0);
v___x_174_ = lean_float_div(v___x_173_, v___x_172_);
return v___x_174_;
}
}
static lean_object* _init_l_main___lam__0___closed__3(void){
_start:
{
double v___x_175_; lean_object* v___x_176_; 
v___x_175_ = lean_float_once(&l_main___lam__0___closed__2, &l_main___lam__0___closed__2_once, _init_l_main___lam__0___closed__2);
v___x_176_ = l_exactFloat(v___x_175_);
return v___x_176_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0(lean_object* v_x_177_){
_start:
{
lean_object* v___x_178_; 
v___x_178_ = lean_obj_once(&l_main___lam__0___closed__3, &l_main___lam__0___closed__3_once, _init_l_main___lam__0___closed__3);
return v___x_178_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_179_){
_start:
{
lean_object* v___x_181_; lean_object* v_putStr_182_; lean_object* v___x_183_; 
v___x_181_ = lean_get_stdout();
v_putStr_182_ = lean_ctor_get(v___x_181_, 4);
lean_inc_ref(v_putStr_182_);
lean_dec_ref(v___x_181_);
v___x_183_ = lean_apply_2(v_putStr_182_, v_s_179_, lean_box(0));
return v___x_183_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_184_, lean_object* v_a_185_){
_start:
{
lean_object* v_res_186_; 
v_res_186_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_184_);
return v_res_186_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(lean_object* v_s_187_){
_start:
{
uint32_t v___x_189_; lean_object* v___x_190_; lean_object* v___x_191_; 
v___x_189_ = 10;
v___x_190_ = lean_string_push(v_s_187_, v___x_189_);
v___x_191_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_190_);
return v___x_191_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_192_, lean_object* v_a_193_){
_start:
{
lean_object* v_res_194_; 
v_res_194_ = l_IO_println___at___00main_spec__0(v_s_192_);
return v_res_194_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_196_; uint8_t v___x_197_; lean_object* v___x_198_; double v___x_199_; 
v___x_196_ = lean_unsigned_to_nat(1u);
v___x_197_ = 1;
v___x_198_ = lean_unsigned_to_nat(10000000u);
v___x_199_ = l_Float_ofScientific(v___x_198_, v___x_197_, v___x_196_);
return v___x_199_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_202_; lean_object* v___f_203_; lean_object* v___x_204_; lean_object* v_a_205_; lean_object* v___x_206_; lean_object* v___x_207_; double v___x_208_; double v___x_209_; double v___x_210_; lean_object* v___x_211_; lean_object* v___x_212_; lean_object* v___x_213_; lean_object* v___x_214_; 
v___x_202_ = lean_io_mono_nanos_now();
v___f_203_ = ((lean_object*)(l_main___closed__0));
v___x_204_ = l_forceIO___redArg(v___f_203_);
v_a_205_ = lean_ctor_get(v___x_204_, 0);
lean_inc(v_a_205_);
lean_dec_ref(v___x_204_);
v___x_206_ = lean_io_mono_nanos_now();
v___x_207_ = lean_nat_sub(v___x_206_, v___x_202_);
lean_dec(v___x_202_);
lean_dec(v___x_206_);
v___x_208_ = lean_float_of_nat(v___x_207_);
v___x_209_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_210_ = lean_float_div(v___x_208_, v___x_209_);
v___x_211_ = ((lean_object*)(l_main___closed__2));
v___x_212_ = lean_float_to_string(v___x_210_);
v___x_213_ = lean_string_append(v___x_211_, v___x_212_);
lean_dec_ref(v___x_212_);
v___x_214_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_213_);
if (lean_obj_tag(v___x_214_) == 0)
{
lean_object* v___x_215_; 
lean_dec_ref_known(v___x_214_, 1);
v___x_215_ = l_IO_println___at___00main_spec__0(v_a_205_);
return v___x_215_;
}
else
{
lean_dec(v_a_205_);
return v___x_214_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_216_){
_start:
{
lean_object* v_res_217_; 
v_res_217_ = _lean_main();
return v_res_217_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0008__average(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
lean_initialize_runtime_module();
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_exactFloat___boxed__const__1 = _init_l_exactFloat___boxed__const__1();
lean_mark_persistent(l_exactFloat___boxed__const__1);
return lean_io_result_mk_ok(lean_box(0));
}
char ** lean_setup_args(int argc, char ** argv);
#if defined(WIN32) || defined(_WIN32)
#include <windows.h>
#endif
lean_object* run_main(int argc, char ** argv) {
    return _lean_main();
}
int main(int argc, char ** argv) {
#if defined(WIN32) || defined(_WIN32)
  SetErrorMode(SEM_FAILCRITICALERRORS);
  SetConsoleOutputCP(CP_UTF8);
#endif
  lean_object* res;
  argv = lean_setup_args(argc, argv);
  res = initialize_0008__average(1 /* builtin */);
  lean_io_mark_end_initialization();
  if (lean_io_result_is_ok(res)) {
    lean_dec_ref(res);
    lean_init_task_manager();
    res = lean_run_main(&run_main, argc, argv);
  }
  lean_finalize_task_manager();
  if (lean_io_result_is_ok(res)) {
    int ret = 0;
    lean_dec_ref(res);
    return ret;
  } else {
    lean_io_result_show_error(res);
    lean_dec_ref(res);
    return 1;
  }
}
#ifdef __cplusplus
}
#endif
