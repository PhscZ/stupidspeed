// Lean compiler output
// Module: «12_matrix_add»
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
uint64_t lean_int64_of_nat(lean_object*);
uint64_t lean_int64_add(uint64_t, uint64_t);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
extern uint64_t l_instInhabitedInt64;
lean_object* lean_array_get_borrowed(lean_object*, lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_mk_empty_array_with_capacity(lean_object*);
lean_object* lean_nat_div(lean_object*, lean_object*);
lean_object* lean_nat_mod(lean_object*, lean_object*);
lean_object* lean_array_push(lean_object*, lean_object*);
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_mono_nanos_now();
uint64_t lean_int64_sub(uint64_t, uint64_t);
double lean_float_of_nat(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
lean_object* lean_int64_to_int_sint(uint64_t);
lean_object* l_Int_repr(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
LEAN_EXPORT lean_object* l_build_go(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_build_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_build(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_build___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_add_go___boxed__const__1;
LEAN_EXPORT lean_object* l_add_go(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_add_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_add(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_add___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_sum_go(lean_object*, lean_object*, lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_sum_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_sum___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static uint64_t l_sum___closed__0;
LEAN_EXPORT uint64_t l_sum(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_sum___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_main___lam__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_main___lam__1(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_main___lam__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_main___lam__2(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_main___lam__2___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static const lean_closure_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)l_main___lam__0___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static const lean_closure_object l_main___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)l_main___lam__1___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* l_main___closed__1 = (const lean_object*)&l_main___closed__1_value;
static lean_once_cell_t l_main___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__2;
static lean_once_cell_t l_main___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__3;
static lean_once_cell_t l_main___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__4;
static lean_once_cell_t l_main___closed__5_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__5;
static lean_once_cell_t l_main___closed__6_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__6;
static const lean_string_object l_main___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__7 = (const lean_object*)&l_main___closed__7_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT lean_object* l_build_go(lean_object* v_n_1_, lean_object* v_f_2_, lean_object* v_a_3_, lean_object* v_a_4_, lean_object* v_a_5_){
_start:
{
lean_object* v_zero_6_; uint8_t v_isZero_7_; 
v_zero_6_ = lean_unsigned_to_nat(0u);
v_isZero_7_ = lean_nat_dec_eq(v_a_3_, v_zero_6_);
if (v_isZero_7_ == 1)
{
lean_dec(v_a_4_);
lean_dec(v_a_3_);
lean_dec_ref(v_f_2_);
return v_a_5_;
}
else
{
lean_object* v_one_8_; lean_object* v_n_9_; lean_object* v___x_10_; lean_object* v___x_11_; lean_object* v___x_12_; lean_object* v___x_13_; lean_object* v___x_14_; 
v_one_8_ = lean_unsigned_to_nat(1u);
v_n_9_ = lean_nat_sub(v_a_3_, v_one_8_);
lean_dec(v_a_3_);
v___x_10_ = lean_nat_add(v_a_4_, v_one_8_);
v___x_11_ = lean_nat_div(v_a_4_, v_n_1_);
v___x_12_ = lean_nat_mod(v_a_4_, v_n_1_);
lean_dec(v_a_4_);
lean_inc_ref(v_f_2_);
v___x_13_ = lean_apply_2(v_f_2_, v___x_11_, v___x_12_);
v___x_14_ = lean_array_push(v_a_5_, v___x_13_);
v_a_3_ = v_n_9_;
v_a_4_ = v___x_10_;
v_a_5_ = v___x_14_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_build_go___boxed(lean_object* v_n_16_, lean_object* v_f_17_, lean_object* v_a_18_, lean_object* v_a_19_, lean_object* v_a_20_){
_start:
{
lean_object* v_res_21_; 
v_res_21_ = l_build_go(v_n_16_, v_f_17_, v_a_18_, v_a_19_, v_a_20_);
lean_dec(v_n_16_);
return v_res_21_;
}
}
LEAN_EXPORT lean_object* l_build(lean_object* v_n_22_, lean_object* v_f_23_){
_start:
{
lean_object* v___x_24_; lean_object* v___x_25_; lean_object* v___x_26_; lean_object* v___x_27_; 
v___x_24_ = lean_nat_mul(v_n_22_, v_n_22_);
v___x_25_ = lean_unsigned_to_nat(0u);
v___x_26_ = lean_mk_empty_array_with_capacity(v___x_24_);
v___x_27_ = l_build_go(v_n_22_, v_f_23_, v___x_24_, v___x_25_, v___x_26_);
return v___x_27_;
}
}
LEAN_EXPORT lean_object* l_build___boxed(lean_object* v_n_28_, lean_object* v_f_29_){
_start:
{
lean_object* v_res_30_; 
v_res_30_ = l_build(v_n_28_, v_f_29_);
lean_dec(v_n_28_);
return v_res_30_;
}
}
static lean_object* _init_l_add_go___boxed__const__1(void){
_start:
{
uint64_t v___x_31_; lean_object* v___x_32_; 
v___x_31_ = l_instInhabitedInt64;
v___x_32_ = lean_box_uint64(v___x_31_);
return v___x_32_;
}
}
LEAN_EXPORT lean_object* l_add_go(lean_object* v_a_33_, lean_object* v_b_34_, lean_object* v_a_35_, lean_object* v_a_36_, lean_object* v_a_37_){
_start:
{
lean_object* v_zero_38_; uint8_t v_isZero_39_; 
v_zero_38_ = lean_unsigned_to_nat(0u);
v_isZero_39_ = lean_nat_dec_eq(v_a_35_, v_zero_38_);
if (v_isZero_39_ == 1)
{
lean_dec(v_a_36_);
lean_dec(v_a_35_);
return v_a_37_;
}
else
{
lean_object* v_one_40_; lean_object* v_n_41_; lean_object* v___x_42_; lean_object* v___x_43_; lean_object* v___x_44_; lean_object* v___x_45_; lean_object* v___x_46_; uint64_t v___x_47_; uint64_t v___x_48_; uint64_t v___x_49_; lean_object* v___x_50_; lean_object* v___x_51_; 
v_one_40_ = lean_unsigned_to_nat(1u);
v_n_41_ = lean_nat_sub(v_a_35_, v_one_40_);
lean_dec(v_a_35_);
v___x_42_ = lean_nat_add(v_a_36_, v_one_40_);
v___x_43_ = l_add_go___boxed__const__1;
v___x_44_ = lean_array_get_borrowed(v___x_43_, v_a_33_, v_a_36_);
v___x_45_ = l_add_go___boxed__const__1;
v___x_46_ = lean_array_get_borrowed(v___x_45_, v_b_34_, v_a_36_);
lean_dec(v_a_36_);
v___x_47_ = lean_unbox_uint64(v___x_44_);
v___x_48_ = lean_unbox_uint64(v___x_46_);
v___x_49_ = lean_int64_add(v___x_47_, v___x_48_);
v___x_50_ = lean_box_uint64(v___x_49_);
v___x_51_ = lean_array_push(v_a_37_, v___x_50_);
v_a_35_ = v_n_41_;
v_a_36_ = v___x_42_;
v_a_37_ = v___x_51_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_add_go___boxed(lean_object* v_a_53_, lean_object* v_b_54_, lean_object* v_a_55_, lean_object* v_a_56_, lean_object* v_a_57_){
_start:
{
lean_object* v_res_58_; 
v_res_58_ = l_add_go(v_a_53_, v_b_54_, v_a_55_, v_a_56_, v_a_57_);
lean_dec_ref(v_b_54_);
lean_dec_ref(v_a_53_);
return v_res_58_;
}
}
LEAN_EXPORT lean_object* l_add(lean_object* v_a_59_, lean_object* v_b_60_, lean_object* v_elems_61_){
_start:
{
lean_object* v___x_62_; lean_object* v___x_63_; lean_object* v___x_64_; 
v___x_62_ = lean_unsigned_to_nat(0u);
v___x_63_ = lean_mk_empty_array_with_capacity(v_elems_61_);
v___x_64_ = l_add_go(v_a_59_, v_b_60_, v_elems_61_, v___x_62_, v___x_63_);
return v___x_64_;
}
}
LEAN_EXPORT lean_object* l_add___boxed(lean_object* v_a_65_, lean_object* v_b_66_, lean_object* v_elems_67_){
_start:
{
lean_object* v_res_68_; 
v_res_68_ = l_add(v_a_65_, v_b_66_, v_elems_67_);
lean_dec_ref(v_b_66_);
lean_dec_ref(v_a_65_);
return v_res_68_;
}
}
LEAN_EXPORT uint64_t l_sum_go(lean_object* v_a_69_, lean_object* v_a_70_, lean_object* v_a_71_, uint64_t v_a_72_){
_start:
{
lean_object* v_zero_73_; uint8_t v_isZero_74_; 
v_zero_73_ = lean_unsigned_to_nat(0u);
v_isZero_74_ = lean_nat_dec_eq(v_a_70_, v_zero_73_);
if (v_isZero_74_ == 1)
{
lean_dec(v_a_71_);
lean_dec(v_a_70_);
return v_a_72_;
}
else
{
lean_object* v_one_75_; lean_object* v_n_76_; lean_object* v___x_77_; lean_object* v___x_78_; lean_object* v___x_79_; uint64_t v___x_80_; uint64_t v___x_81_; 
v_one_75_ = lean_unsigned_to_nat(1u);
v_n_76_ = lean_nat_sub(v_a_70_, v_one_75_);
lean_dec(v_a_70_);
v___x_77_ = lean_nat_add(v_a_71_, v_one_75_);
v___x_78_ = l_add_go___boxed__const__1;
v___x_79_ = lean_array_get_borrowed(v___x_78_, v_a_69_, v_a_71_);
lean_dec(v_a_71_);
v___x_80_ = lean_unbox_uint64(v___x_79_);
v___x_81_ = lean_int64_add(v_a_72_, v___x_80_);
v_a_70_ = v_n_76_;
v_a_71_ = v___x_77_;
v_a_72_ = v___x_81_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_sum_go___boxed(lean_object* v_a_83_, lean_object* v_a_84_, lean_object* v_a_85_, lean_object* v_a_86_){
_start:
{
uint64_t v_a_66__boxed_87_; uint64_t v_res_88_; lean_object* v_r_89_; 
v_a_66__boxed_87_ = lean_unbox_uint64(v_a_86_);
lean_dec_ref(v_a_86_);
v_res_88_ = l_sum_go(v_a_83_, v_a_84_, v_a_85_, v_a_66__boxed_87_);
lean_dec_ref(v_a_83_);
v_r_89_ = lean_box_uint64(v_res_88_);
return v_r_89_;
}
}
static uint64_t _init_l_sum___closed__0(void){
_start:
{
lean_object* v___x_90_; uint64_t v___x_91_; 
v___x_90_ = lean_unsigned_to_nat(0u);
v___x_91_ = lean_int64_of_nat(v___x_90_);
return v___x_91_;
}
}
LEAN_EXPORT uint64_t l_sum(lean_object* v_a_92_, lean_object* v_elems_93_){
_start:
{
lean_object* v___x_94_; uint64_t v___x_95_; uint64_t v___x_96_; 
v___x_94_ = lean_unsigned_to_nat(0u);
v___x_95_ = lean_uint64_once(&l_sum___closed__0, &l_sum___closed__0_once, _init_l_sum___closed__0);
v___x_96_ = l_sum_go(v_a_92_, v_elems_93_, v___x_94_, v___x_95_);
return v___x_96_;
}
}
LEAN_EXPORT lean_object* l_sum___boxed(lean_object* v_a_97_, lean_object* v_elems_98_){
_start:
{
uint64_t v_res_99_; lean_object* v_r_100_; 
v_res_99_ = l_sum(v_a_97_, v_elems_98_);
lean_dec_ref(v_a_97_);
v_r_100_ = lean_box_uint64(v_res_99_);
return v_r_100_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_101_){
_start:
{
lean_object* v___x_103_; 
v___x_103_ = l_IO_lazyPure___redArg(v_x_101_);
return v___x_103_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_104_, lean_object* v_a_105_){
_start:
{
lean_object* v_res_106_; 
v_res_106_ = l_forceIO___redArg(v_x_104_);
return v_res_106_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_107_, lean_object* v_x_108_){
_start:
{
lean_object* v___x_110_; 
v___x_110_ = l_forceIO___redArg(v_x_108_);
return v___x_110_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_111_, lean_object* v_x_112_, lean_object* v_a_113_){
_start:
{
lean_object* v_res_114_; 
v_res_114_ = l_forceIO(v_00_u03b1_111_, v_x_112_);
return v_res_114_;
}
}
LEAN_EXPORT uint64_t l_main___lam__0(lean_object* v_i_115_, lean_object* v_j_116_){
_start:
{
uint64_t v___x_117_; uint64_t v___x_118_; uint64_t v___x_119_; 
v___x_117_ = lean_int64_of_nat(v_i_115_);
v___x_118_ = lean_int64_of_nat(v_j_116_);
v___x_119_ = lean_int64_add(v___x_117_, v___x_118_);
return v___x_119_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object* v_i_120_, lean_object* v_j_121_){
_start:
{
uint64_t v_res_122_; lean_object* v_r_123_; 
v_res_122_ = l_main___lam__0(v_i_120_, v_j_121_);
lean_dec(v_j_121_);
lean_dec(v_i_120_);
v_r_123_ = lean_box_uint64(v_res_122_);
return v_r_123_;
}
}
LEAN_EXPORT uint64_t l_main___lam__1(lean_object* v_i_124_, lean_object* v_j_125_){
_start:
{
uint64_t v___x_126_; uint64_t v___x_127_; uint64_t v___x_128_; 
v___x_126_ = lean_int64_of_nat(v_i_124_);
v___x_127_ = lean_int64_of_nat(v_j_125_);
v___x_128_ = lean_int64_sub(v___x_126_, v___x_127_);
return v___x_128_;
}
}
LEAN_EXPORT lean_object* l_main___lam__1___boxed(lean_object* v_i_129_, lean_object* v_j_130_){
_start:
{
uint64_t v_res_131_; lean_object* v_r_132_; 
v_res_131_ = l_main___lam__1(v_i_129_, v_j_130_);
lean_dec(v_j_130_);
lean_dec(v_i_129_);
v_r_132_ = lean_box_uint64(v_res_131_);
return v_r_132_;
}
}
LEAN_EXPORT uint64_t l_main___lam__2(lean_object* v___x_133_, lean_object* v___x_134_, lean_object* v_x_135_){
_start:
{
uint64_t v___x_136_; 
v___x_136_ = l_sum(v___x_133_, v___x_134_);
return v___x_136_;
}
}
LEAN_EXPORT lean_object* l_main___lam__2___boxed(lean_object* v___x_137_, lean_object* v___x_138_, lean_object* v_x_139_){
_start:
{
uint64_t v_res_140_; lean_object* v_r_141_; 
v_res_140_ = l_main___lam__2(v___x_137_, v___x_138_, v_x_139_);
lean_dec_ref(v___x_137_);
v_r_141_ = lean_box_uint64(v_res_140_);
return v_r_141_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_142_){
_start:
{
lean_object* v___x_144_; lean_object* v_putStr_145_; lean_object* v___x_146_; 
v___x_144_ = lean_get_stdout();
v_putStr_145_ = lean_ctor_get(v___x_144_, 4);
lean_inc_ref(v_putStr_145_);
lean_dec_ref(v___x_144_);
v___x_146_ = lean_apply_2(v_putStr_145_, v_s_142_, lean_box(0));
return v___x_146_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_147_, lean_object* v_a_148_){
_start:
{
lean_object* v_res_149_; 
v_res_149_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_147_);
return v_res_149_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_150_){
_start:
{
lean_object* v___x_152_; lean_object* v___x_153_; uint32_t v___x_154_; lean_object* v___x_155_; lean_object* v___x_156_; 
v___x_152_ = lean_int64_to_int_sint(v_s_150_);
v___x_153_ = l_Int_repr(v___x_152_);
lean_dec(v___x_152_);
v___x_154_ = 10;
v___x_155_ = lean_string_push(v___x_153_, v___x_154_);
v___x_156_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_155_);
return v___x_156_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_157_, lean_object* v_a_158_){
_start:
{
uint64_t v_s_boxed_159_; lean_object* v_res_160_; 
v_s_boxed_159_ = lean_unbox_uint64(v_s_157_);
lean_dec_ref(v_s_157_);
v_res_160_ = l_IO_println___at___00main_spec__0(v_s_boxed_159_);
return v_res_160_;
}
}
static lean_object* _init_l_main___closed__2(void){
_start:
{
lean_object* v___f_163_; lean_object* v___x_164_; lean_object* v___x_165_; 
v___f_163_ = ((lean_object*)(l_main___closed__0));
v___x_164_ = lean_unsigned_to_nat(1000u);
v___x_165_ = l_build(v___x_164_, v___f_163_);
return v___x_165_;
}
}
static lean_object* _init_l_main___closed__3(void){
_start:
{
lean_object* v___f_166_; lean_object* v___x_167_; lean_object* v___x_168_; 
v___f_166_ = ((lean_object*)(l_main___closed__1));
v___x_167_ = lean_unsigned_to_nat(1000u);
v___x_168_ = l_build(v___x_167_, v___f_166_);
return v___x_168_;
}
}
static lean_object* _init_l_main___closed__4(void){
_start:
{
lean_object* v___x_169_; lean_object* v___x_170_; lean_object* v___x_171_; lean_object* v___x_172_; 
v___x_169_ = lean_unsigned_to_nat(1000000u);
v___x_170_ = lean_obj_once(&l_main___closed__3, &l_main___closed__3_once, _init_l_main___closed__3);
v___x_171_ = lean_obj_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_172_ = l_add(v___x_171_, v___x_170_, v___x_169_);
return v___x_172_;
}
}
static lean_object* _init_l_main___closed__5(void){
_start:
{
lean_object* v___x_173_; lean_object* v___x_174_; lean_object* v___f_175_; 
v___x_173_ = lean_unsigned_to_nat(1000000u);
v___x_174_ = lean_obj_once(&l_main___closed__4, &l_main___closed__4_once, _init_l_main___closed__4);
v___f_175_ = lean_alloc_closure((void*)(l_main___lam__2___boxed), 3, 2);
lean_closure_set(v___f_175_, 0, v___x_174_);
lean_closure_set(v___f_175_, 1, v___x_173_);
return v___f_175_;
}
}
static double _init_l_main___closed__6(void){
_start:
{
lean_object* v___x_176_; uint8_t v___x_177_; lean_object* v___x_178_; double v___x_179_; 
v___x_176_ = lean_unsigned_to_nat(1u);
v___x_177_ = 1;
v___x_178_ = lean_unsigned_to_nat(10000000u);
v___x_179_ = l_Float_ofScientific(v___x_178_, v___x_177_, v___x_176_);
return v___x_179_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_182_; lean_object* v___f_183_; lean_object* v___x_184_; lean_object* v_a_185_; lean_object* v___x_186_; lean_object* v___x_187_; double v___x_188_; double v___x_189_; double v___x_190_; lean_object* v___x_191_; lean_object* v___x_192_; lean_object* v___x_193_; lean_object* v___x_194_; 
v___x_182_ = lean_io_mono_nanos_now();
v___f_183_ = lean_obj_once(&l_main___closed__5, &l_main___closed__5_once, _init_l_main___closed__5);
v___x_184_ = l_forceIO___redArg(v___f_183_);
v_a_185_ = lean_ctor_get(v___x_184_, 0);
lean_inc(v_a_185_);
lean_dec_ref(v___x_184_);
v___x_186_ = lean_io_mono_nanos_now();
v___x_187_ = lean_nat_sub(v___x_186_, v___x_182_);
lean_dec(v___x_182_);
lean_dec(v___x_186_);
v___x_188_ = lean_float_of_nat(v___x_187_);
v___x_189_ = lean_float_once(&l_main___closed__6, &l_main___closed__6_once, _init_l_main___closed__6);
v___x_190_ = lean_float_div(v___x_188_, v___x_189_);
v___x_191_ = ((lean_object*)(l_main___closed__7));
v___x_192_ = lean_float_to_string(v___x_190_);
v___x_193_ = lean_string_append(v___x_191_, v___x_192_);
lean_dec_ref(v___x_192_);
v___x_194_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_193_);
if (lean_obj_tag(v___x_194_) == 0)
{
uint64_t v___x_195_; lean_object* v___x_196_; 
lean_dec_ref_known(v___x_194_, 1);
v___x_195_ = lean_unbox_uint64(v_a_185_);
lean_dec(v_a_185_);
v___x_196_ = l_IO_println___at___00main_spec__0(v___x_195_);
return v___x_196_;
}
else
{
lean_dec(v_a_185_);
return v___x_194_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_197_){
_start:
{
lean_object* v_res_198_; 
v_res_198_ = _lean_main();
return v_res_198_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0012__matrix__add(uint8_t builtin) {
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
l_add_go___boxed__const__1 = _init_l_add_go___boxed__const__1();
lean_mark_persistent(l_add_go___boxed__const__1);
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
  res = initialize_0012__matrix__add(1 /* builtin */);
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
