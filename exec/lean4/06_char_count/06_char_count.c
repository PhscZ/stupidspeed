// Lean compiler output
// Module: «06_char_count»
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
lean_object* lean_string_utf8_byte_size(lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
uint32_t lean_string_utf8_get_fast(lean_object*, lean_object*);
lean_object* lean_string_utf8_next_fast(lean_object*, lean_object*);
uint8_t lean_uint32_dec_eq(uint32_t, uint32_t);
uint64_t lean_uint64_add(uint64_t, uint64_t);
lean_object* lean_string_to_utf8(lean_object*);
extern lean_object* l_ByteArray_empty;
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_nat_shiftr(lean_object*, lean_object*);
lean_object* lean_byte_array_size(lean_object*);
lean_object* lean_byte_array_copy_slice(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, uint8_t);
lean_object* lean_nat_mod(lean_object*, lean_object*);
uint8_t lean_string_validate_utf8(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_mono_nanos_now();
lean_object* lean_string_from_utf8_unchecked(lean_object*);
double lean_float_of_nat(lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
lean_object* lean_uint64_to_nat(uint64_t);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
LEAN_EXPORT lean_object* l_repeatBytes_go(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_repeatBytes(lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___redArg(lean_object*, lean_object*, lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_charCount(lean_object*);
LEAN_EXPORT lean_object* l_charCount___boxed(lean_object*);
LEAN_EXPORT uint64_t l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, uint64_t, lean_object*);
LEAN_EXPORT lean_object* l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_main___lam__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static const lean_string_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "abcdefghij"};
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static lean_once_cell_t l_main___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__1;
static lean_once_cell_t l_main___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__2;
static lean_once_cell_t l_main___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static uint8_t l_main___closed__3;
static const lean_string_object l_main___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 24, .m_capacity = 24, .m_length = 23, .m_data = "text is not valid UTF-8"};
static const lean_object* l_main___closed__4 = (const lean_object*)&l_main___closed__4_value;
static const lean_ctor_object l_main___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 18}, .m_objs = {((lean_object*)&l_main___closed__4_value)}};
static const lean_object* l_main___closed__5 = (const lean_object*)&l_main___closed__5_value;
static lean_once_cell_t l_main___closed__6_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__6;
static lean_once_cell_t l_main___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__7;
static lean_once_cell_t l_main___closed__8_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__8;
static const lean_string_object l_main___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__9 = (const lean_object*)&l_main___closed__9_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT lean_object* l_repeatBytes_go(lean_object* v_a_1_, lean_object* v_a_2_, lean_object* v_a_3_){
_start:
{
lean_object* v_zero_4_; uint8_t v_isZero_5_; 
v_zero_4_ = lean_unsigned_to_nat(0u);
v_isZero_5_ = lean_nat_dec_eq(v_a_1_, v_zero_4_);
if (v_isZero_5_ == 1)
{
lean_dec_ref(v_a_3_);
lean_dec(v_a_1_);
return v_a_2_;
}
else
{
lean_object* v_one_6_; lean_object* v_n_7_; lean_object* v___x_8_; lean_object* v___x_9_; lean_object* v___x_10_; lean_object* v___y_12_; lean_object* v___x_16_; uint8_t v___x_17_; 
v_one_6_ = lean_unsigned_to_nat(1u);
v_n_7_ = lean_nat_sub(v_a_1_, v_one_6_);
lean_dec(v_a_1_);
v___x_8_ = lean_nat_add(v_n_7_, v_one_6_);
lean_dec(v_n_7_);
v___x_9_ = lean_unsigned_to_nat(2u);
v___x_10_ = lean_nat_shiftr(v___x_8_, v_one_6_);
v___x_16_ = lean_nat_mod(v___x_8_, v___x_9_);
lean_dec(v___x_8_);
v___x_17_ = lean_nat_dec_eq(v___x_16_, v_one_6_);
lean_dec(v___x_16_);
if (v___x_17_ == 0)
{
v___y_12_ = v_a_2_;
goto v___jp_11_;
}
else
{
lean_object* v___x_18_; lean_object* v___x_19_; lean_object* v___x_20_; 
v___x_18_ = lean_byte_array_size(v_a_2_);
v___x_19_ = lean_byte_array_size(v_a_3_);
v___x_20_ = lean_byte_array_copy_slice(v_a_3_, v_zero_4_, v_a_2_, v___x_18_, v___x_19_, v_isZero_5_);
v___y_12_ = v___x_20_;
goto v___jp_11_;
}
v___jp_11_:
{
lean_object* v___x_13_; lean_object* v___x_14_; 
v___x_13_ = lean_byte_array_size(v_a_3_);
lean_inc_ref(v_a_3_);
v___x_14_ = lean_byte_array_copy_slice(v_a_3_, v_zero_4_, v_a_3_, v___x_13_, v___x_13_, v_isZero_5_);
lean_dec_ref(v_a_3_);
v_a_1_ = v___x_10_;
v_a_2_ = v___y_12_;
v_a_3_ = v___x_14_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter___redArg(lean_object* v_x_21_, lean_object* v_x_22_, lean_object* v_x_23_, lean_object* v_h__1_24_, lean_object* v_h__2_25_){
_start:
{
lean_object* v_zero_26_; uint8_t v_isZero_27_; 
v_zero_26_ = lean_unsigned_to_nat(0u);
v_isZero_27_ = lean_nat_dec_eq(v_x_21_, v_zero_26_);
if (v_isZero_27_ == 1)
{
lean_object* v___x_28_; 
lean_dec(v_h__2_25_);
v___x_28_ = lean_apply_2(v_h__1_24_, v_x_22_, v_x_23_);
return v___x_28_;
}
else
{
lean_object* v_one_29_; lean_object* v_n_30_; lean_object* v___x_31_; 
lean_dec(v_h__1_24_);
v_one_29_ = lean_unsigned_to_nat(1u);
v_n_30_ = lean_nat_sub(v_x_21_, v_one_29_);
v___x_31_ = lean_apply_3(v_h__2_25_, v_n_30_, v_x_22_, v_x_23_);
return v___x_31_;
}
}
}
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter___redArg___boxed(lean_object* v_x_32_, lean_object* v_x_33_, lean_object* v_x_34_, lean_object* v_h__1_35_, lean_object* v_h__2_36_){
_start:
{
lean_object* v_res_37_; 
v_res_37_ = l___private_0006__char__count_0__repeatBytes_go_match__1_splitter___redArg(v_x_32_, v_x_33_, v_x_34_, v_h__1_35_, v_h__2_36_);
lean_dec(v_x_32_);
return v_res_37_;
}
}
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter(lean_object* v_motive_38_, lean_object* v_x_39_, lean_object* v_x_40_, lean_object* v_x_41_, lean_object* v_h__1_42_, lean_object* v_h__2_43_){
_start:
{
lean_object* v_zero_44_; uint8_t v_isZero_45_; 
v_zero_44_ = lean_unsigned_to_nat(0u);
v_isZero_45_ = lean_nat_dec_eq(v_x_39_, v_zero_44_);
if (v_isZero_45_ == 1)
{
lean_object* v___x_46_; 
lean_dec(v_h__2_43_);
v___x_46_ = lean_apply_2(v_h__1_42_, v_x_40_, v_x_41_);
return v___x_46_;
}
else
{
lean_object* v_one_47_; lean_object* v_n_48_; lean_object* v___x_49_; 
lean_dec(v_h__1_42_);
v_one_47_ = lean_unsigned_to_nat(1u);
v_n_48_ = lean_nat_sub(v_x_39_, v_one_47_);
v___x_49_ = lean_apply_3(v_h__2_43_, v_n_48_, v_x_40_, v_x_41_);
return v___x_49_;
}
}
}
LEAN_EXPORT lean_object* l___private_0006__char__count_0__repeatBytes_go_match__1_splitter___boxed(lean_object* v_motive_50_, lean_object* v_x_51_, lean_object* v_x_52_, lean_object* v_x_53_, lean_object* v_h__1_54_, lean_object* v_h__2_55_){
_start:
{
lean_object* v_res_56_; 
v_res_56_ = l___private_0006__char__count_0__repeatBytes_go_match__1_splitter(v_motive_50_, v_x_51_, v_x_52_, v_x_53_, v_h__1_54_, v_h__2_55_);
lean_dec(v_x_51_);
return v_res_56_;
}
}
LEAN_EXPORT lean_object* l_repeatBytes(lean_object* v_block_57_, lean_object* v_times_58_){
_start:
{
lean_object* v___x_59_; lean_object* v___x_60_; 
v___x_59_ = l_ByteArray_empty;
v___x_60_ = l_repeatBytes_go(v_times_58_, v___x_59_, v_block_57_);
return v___x_60_;
}
}
LEAN_EXPORT uint64_t l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___redArg(lean_object* v___x_61_, lean_object* v_text_62_, lean_object* v_a_63_, uint64_t v_b_64_){
_start:
{
lean_object* v_startInclusive_65_; lean_object* v_endExclusive_66_; lean_object* v___x_67_; uint8_t v___x_68_; 
v_startInclusive_65_ = lean_ctor_get(v___x_61_, 1);
v_endExclusive_66_ = lean_ctor_get(v___x_61_, 2);
v___x_67_ = lean_nat_sub(v_endExclusive_66_, v_startInclusive_65_);
v___x_68_ = lean_nat_dec_eq(v_a_63_, v___x_67_);
lean_dec(v___x_67_);
if (v___x_68_ == 0)
{
uint32_t v___x_69_; lean_object* v___x_70_; uint32_t v___x_71_; uint8_t v___x_72_; 
v___x_69_ = lean_string_utf8_get_fast(v_text_62_, v_a_63_);
v___x_70_ = lean_string_utf8_next_fast(v_text_62_, v_a_63_);
lean_dec(v_a_63_);
v___x_71_ = 104;
v___x_72_ = lean_uint32_dec_eq(v___x_69_, v___x_71_);
if (v___x_72_ == 0)
{
v_a_63_ = v___x_70_;
goto _start;
}
else
{
uint64_t v___x_74_; uint64_t v___x_75_; 
v___x_74_ = 1ULL;
v___x_75_ = lean_uint64_add(v_b_64_, v___x_74_);
v_a_63_ = v___x_70_;
v_b_64_ = v___x_75_;
goto _start;
}
}
else
{
lean_dec(v_a_63_);
return v_b_64_;
}
}
}
LEAN_EXPORT lean_object* l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___redArg___boxed(lean_object* v___x_77_, lean_object* v_text_78_, lean_object* v_a_79_, lean_object* v_b_80_){
_start:
{
uint64_t v_b_boxed_81_; uint64_t v_res_82_; lean_object* v_r_83_; 
v_b_boxed_81_ = lean_unbox_uint64(v_b_80_);
lean_dec_ref(v_b_80_);
v_res_82_ = l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___redArg(v___x_77_, v_text_78_, v_a_79_, v_b_boxed_81_);
lean_dec_ref(v_text_78_);
lean_dec_ref(v___x_77_);
v_r_83_ = lean_box_uint64(v_res_82_);
return v_r_83_;
}
}
LEAN_EXPORT uint64_t l_charCount(lean_object* v_text_84_){
_start:
{
uint64_t v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; lean_object* v___x_88_; uint64_t v___x_89_; 
v___x_85_ = 0ULL;
v___x_86_ = lean_unsigned_to_nat(0u);
v___x_87_ = lean_string_utf8_byte_size(v_text_84_);
lean_inc_ref(v_text_84_);
v___x_88_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v___x_88_, 0, v_text_84_);
lean_ctor_set(v___x_88_, 1, v___x_86_);
lean_ctor_set(v___x_88_, 2, v___x_87_);
v___x_89_ = l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___redArg(v___x_88_, v_text_84_, v___x_86_, v___x_85_);
lean_dec_ref(v_text_84_);
lean_dec_ref_known(v___x_88_, 3);
return v___x_89_;
}
}
LEAN_EXPORT lean_object* l_charCount___boxed(lean_object* v_text_90_){
_start:
{
uint64_t v_res_91_; lean_object* v_r_92_; 
v_res_91_ = l_charCount(v_text_90_);
v_r_92_ = lean_box_uint64(v_res_91_);
return v_r_92_;
}
}
LEAN_EXPORT uint64_t l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0(lean_object* v___x_93_, lean_object* v_text_94_, lean_object* v_inst_95_, lean_object* v_R_96_, lean_object* v_a_97_, uint64_t v_b_98_, lean_object* v_c_99_){
_start:
{
uint64_t v___x_100_; 
v___x_100_ = l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___redArg(v___x_93_, v_text_94_, v_a_97_, v_b_98_);
return v___x_100_;
}
}
LEAN_EXPORT lean_object* l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0___boxed(lean_object* v___x_101_, lean_object* v_text_102_, lean_object* v_inst_103_, lean_object* v_R_104_, lean_object* v_a_105_, lean_object* v_b_106_, lean_object* v_c_107_){
_start:
{
uint64_t v_b_boxed_108_; uint64_t v_res_109_; lean_object* v_r_110_; 
v_b_boxed_108_ = lean_unbox_uint64(v_b_106_);
lean_dec_ref(v_b_106_);
v_res_109_ = l_WellFounded_opaqueFix_u2083___at___00charCount_spec__0(v___x_101_, v_text_102_, v_inst_103_, v_R_104_, v_a_105_, v_b_boxed_108_, v_c_107_);
lean_dec_ref(v_text_102_);
lean_dec_ref(v___x_101_);
v_r_110_ = lean_box_uint64(v_res_109_);
return v_r_110_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_111_){
_start:
{
lean_object* v___x_113_; 
v___x_113_ = l_IO_lazyPure___redArg(v_x_111_);
return v___x_113_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_114_, lean_object* v_a_115_){
_start:
{
lean_object* v_res_116_; 
v_res_116_ = l_forceIO___redArg(v_x_114_);
return v_res_116_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_117_, lean_object* v_x_118_){
_start:
{
lean_object* v___x_120_; 
v___x_120_ = l_forceIO___redArg(v_x_118_);
return v___x_120_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_121_, lean_object* v_x_122_, lean_object* v_a_123_){
_start:
{
lean_object* v_res_124_; 
v_res_124_ = l_forceIO(v_00_u03b1_121_, v_x_122_);
return v_res_124_;
}
}
LEAN_EXPORT uint64_t l_main___lam__0(lean_object* v___x_125_, lean_object* v_x_126_){
_start:
{
uint64_t v___x_127_; 
v___x_127_ = l_charCount(v___x_125_);
return v___x_127_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object* v___x_128_, lean_object* v_x_129_){
_start:
{
uint64_t v_res_130_; lean_object* v_r_131_; 
v_res_130_ = l_main___lam__0(v___x_128_, v_x_129_);
v_r_131_ = lean_box_uint64(v_res_130_);
return v_r_131_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_132_){
_start:
{
lean_object* v___x_134_; lean_object* v_putStr_135_; lean_object* v___x_136_; 
v___x_134_ = lean_get_stdout();
v_putStr_135_ = lean_ctor_get(v___x_134_, 4);
lean_inc_ref(v_putStr_135_);
lean_dec_ref(v___x_134_);
v___x_136_ = lean_apply_2(v_putStr_135_, v_s_132_, lean_box(0));
return v___x_136_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_137_, lean_object* v_a_138_){
_start:
{
lean_object* v_res_139_; 
v_res_139_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_137_);
return v_res_139_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_140_){
_start:
{
lean_object* v___x_142_; lean_object* v___x_143_; uint32_t v___x_144_; lean_object* v___x_145_; lean_object* v___x_146_; 
v___x_142_ = lean_uint64_to_nat(v_s_140_);
v___x_143_ = l_Nat_reprFast(v___x_142_);
v___x_144_ = 10;
v___x_145_ = lean_string_push(v___x_143_, v___x_144_);
v___x_146_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_145_);
return v___x_146_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_147_, lean_object* v_a_148_){
_start:
{
uint64_t v_s_boxed_149_; lean_object* v_res_150_; 
v_s_boxed_149_ = lean_unbox_uint64(v_s_147_);
lean_dec_ref(v_s_147_);
v_res_150_ = l_IO_println___at___00main_spec__0(v_s_boxed_149_);
return v_res_150_;
}
}
static lean_object* _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_152_; lean_object* v___x_153_; 
v___x_152_ = ((lean_object*)(l_main___closed__0));
v___x_153_ = lean_string_to_utf8(v___x_152_);
return v___x_153_;
}
}
static lean_object* _init_l_main___closed__2(void){
_start:
{
lean_object* v___x_154_; lean_object* v___x_155_; lean_object* v___x_156_; 
v___x_154_ = lean_unsigned_to_nat(10000000u);
v___x_155_ = lean_obj_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_156_ = l_repeatBytes(v___x_155_, v___x_154_);
return v___x_156_;
}
}
static uint8_t _init_l_main___closed__3(void){
_start:
{
lean_object* v___x_157_; uint8_t v___x_158_; 
v___x_157_ = lean_obj_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_158_ = lean_string_validate_utf8(v___x_157_);
return v___x_158_;
}
}
static lean_object* _init_l_main___closed__6(void){
_start:
{
lean_object* v___x_162_; lean_object* v___x_163_; 
v___x_162_ = lean_obj_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_163_ = lean_string_from_utf8_unchecked(v___x_162_);
return v___x_163_;
}
}
static lean_object* _init_l_main___closed__7(void){
_start:
{
lean_object* v___x_164_; lean_object* v___f_165_; 
v___x_164_ = lean_obj_once(&l_main___closed__6, &l_main___closed__6_once, _init_l_main___closed__6);
v___f_165_ = lean_alloc_closure((void*)(l_main___lam__0___boxed), 2, 1);
lean_closure_set(v___f_165_, 0, v___x_164_);
return v___f_165_;
}
}
static double _init_l_main___closed__8(void){
_start:
{
lean_object* v___x_166_; uint8_t v___x_167_; lean_object* v___x_168_; double v___x_169_; 
v___x_166_ = lean_unsigned_to_nat(1u);
v___x_167_ = lean_uint8_once(&l_main___closed__3, &l_main___closed__3_once, _init_l_main___closed__3);
v___x_168_ = lean_unsigned_to_nat(10000000u);
v___x_169_ = l_Float_ofScientific(v___x_168_, v___x_167_, v___x_166_);
return v___x_169_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_172_; uint8_t v___x_173_; 
v___x_172_ = lean_io_mono_nanos_now();
v___x_173_ = lean_uint8_once(&l_main___closed__3, &l_main___closed__3_once, _init_l_main___closed__3);
if (v___x_173_ == 0)
{
lean_object* v___x_174_; lean_object* v___x_175_; 
lean_dec(v___x_172_);
v___x_174_ = ((lean_object*)(l_main___closed__5));
v___x_175_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_175_, 0, v___x_174_);
return v___x_175_;
}
else
{
lean_object* v___f_176_; lean_object* v___x_177_; lean_object* v_a_178_; lean_object* v___x_179_; lean_object* v___x_180_; double v___x_181_; double v___x_182_; double v___x_183_; lean_object* v___x_184_; lean_object* v___x_185_; lean_object* v___x_186_; lean_object* v___x_187_; 
v___f_176_ = lean_obj_once(&l_main___closed__7, &l_main___closed__7_once, _init_l_main___closed__7);
v___x_177_ = l_forceIO___redArg(v___f_176_);
v_a_178_ = lean_ctor_get(v___x_177_, 0);
lean_inc(v_a_178_);
lean_dec_ref(v___x_177_);
v___x_179_ = lean_io_mono_nanos_now();
v___x_180_ = lean_nat_sub(v___x_179_, v___x_172_);
lean_dec(v___x_172_);
lean_dec(v___x_179_);
v___x_181_ = lean_float_of_nat(v___x_180_);
v___x_182_ = lean_float_once(&l_main___closed__8, &l_main___closed__8_once, _init_l_main___closed__8);
v___x_183_ = lean_float_div(v___x_181_, v___x_182_);
v___x_184_ = ((lean_object*)(l_main___closed__9));
v___x_185_ = lean_float_to_string(v___x_183_);
v___x_186_ = lean_string_append(v___x_184_, v___x_185_);
lean_dec_ref(v___x_185_);
v___x_187_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_186_);
if (lean_obj_tag(v___x_187_) == 0)
{
uint64_t v___x_188_; lean_object* v___x_189_; 
lean_dec_ref_known(v___x_187_, 1);
v___x_188_ = lean_unbox_uint64(v_a_178_);
lean_dec(v_a_178_);
v___x_189_ = l_IO_println___at___00main_spec__0(v___x_188_);
return v___x_189_;
}
else
{
lean_dec(v_a_178_);
return v___x_187_;
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_190_){
_start:
{
lean_object* v_res_191_; 
v_res_191_ = _lean_main();
return v_res_191_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0006__char__count(uint8_t builtin) {
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
  res = initialize_0006__char__count(1 /* builtin */);
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
