// Lean compiler output
// Module: «13_matrix_mul»
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
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_nat_mod(lean_object*, lean_object*);
uint64_t lean_int64_of_nat(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_div(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
extern uint64_t l_instInhabitedInt64;
lean_object* lean_array_get_borrowed(lean_object*, lean_object*, lean_object*);
uint64_t lean_int64_mul(uint64_t, uint64_t);
uint64_t lean_int64_add(uint64_t, uint64_t);
lean_object* lean_array_push(lean_object*, lean_object*);
lean_object* lean_mk_empty_array_with_capacity(lean_object*);
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_mono_nanos_now();
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
LEAN_EXPORT lean_object* l_dot_go___boxed__const__1;
LEAN_EXPORT uint64_t l_dot_go(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_dot_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_dot___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static uint64_t l_dot___closed__0;
LEAN_EXPORT uint64_t l_dot(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_dot___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_mul_go(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_mul_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_mul(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_mul___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_sum_go(lean_object*, lean_object*, lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_sum_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
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
static lean_object* _init_l_dot_go___boxed__const__1(void){
_start:
{
uint64_t v___x_31_; lean_object* v___x_32_; 
v___x_31_ = l_instInhabitedInt64;
v___x_32_ = lean_box_uint64(v___x_31_);
return v___x_32_;
}
}
LEAN_EXPORT uint64_t l_dot_go(lean_object* v_a_33_, lean_object* v_b_34_, lean_object* v_n_35_, lean_object* v_i_36_, lean_object* v_j_37_, lean_object* v_a_38_, lean_object* v_a_39_, uint64_t v_a_40_){
_start:
{
lean_object* v_zero_41_; uint8_t v_isZero_42_; 
v_zero_41_ = lean_unsigned_to_nat(0u);
v_isZero_42_ = lean_nat_dec_eq(v_a_38_, v_zero_41_);
if (v_isZero_42_ == 1)
{
lean_dec(v_a_39_);
lean_dec(v_a_38_);
return v_a_40_;
}
else
{
lean_object* v_one_43_; lean_object* v_n_44_; lean_object* v___x_45_; lean_object* v___x_46_; lean_object* v___x_47_; lean_object* v___x_48_; lean_object* v___x_49_; lean_object* v___x_50_; lean_object* v___x_51_; lean_object* v___x_52_; lean_object* v___x_53_; uint64_t v___x_54_; uint64_t v___x_55_; uint64_t v___x_56_; uint64_t v___x_57_; 
v_one_43_ = lean_unsigned_to_nat(1u);
v_n_44_ = lean_nat_sub(v_a_38_, v_one_43_);
lean_dec(v_a_38_);
v___x_45_ = lean_nat_add(v_a_39_, v_one_43_);
v___x_46_ = lean_nat_mul(v_i_36_, v_n_35_);
v___x_47_ = lean_nat_add(v___x_46_, v_a_39_);
lean_dec(v___x_46_);
v___x_48_ = l_dot_go___boxed__const__1;
v___x_49_ = lean_array_get_borrowed(v___x_48_, v_a_33_, v___x_47_);
lean_dec(v___x_47_);
v___x_50_ = lean_nat_mul(v_a_39_, v_n_35_);
lean_dec(v_a_39_);
v___x_51_ = lean_nat_add(v___x_50_, v_j_37_);
lean_dec(v___x_50_);
v___x_52_ = l_dot_go___boxed__const__1;
v___x_53_ = lean_array_get_borrowed(v___x_52_, v_b_34_, v___x_51_);
lean_dec(v___x_51_);
v___x_54_ = lean_unbox_uint64(v___x_49_);
v___x_55_ = lean_unbox_uint64(v___x_53_);
v___x_56_ = lean_int64_mul(v___x_54_, v___x_55_);
v___x_57_ = lean_int64_add(v_a_40_, v___x_56_);
v_a_38_ = v_n_44_;
v_a_39_ = v___x_45_;
v_a_40_ = v___x_57_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_dot_go___boxed(lean_object* v_a_59_, lean_object* v_b_60_, lean_object* v_n_61_, lean_object* v_i_62_, lean_object* v_j_63_, lean_object* v_a_64_, lean_object* v_a_65_, lean_object* v_a_66_){
_start:
{
uint64_t v_a_113__boxed_67_; uint64_t v_res_68_; lean_object* v_r_69_; 
v_a_113__boxed_67_ = lean_unbox_uint64(v_a_66_);
lean_dec_ref(v_a_66_);
v_res_68_ = l_dot_go(v_a_59_, v_b_60_, v_n_61_, v_i_62_, v_j_63_, v_a_64_, v_a_65_, v_a_113__boxed_67_);
lean_dec(v_j_63_);
lean_dec(v_i_62_);
lean_dec(v_n_61_);
lean_dec_ref(v_b_60_);
lean_dec_ref(v_a_59_);
v_r_69_ = lean_box_uint64(v_res_68_);
return v_r_69_;
}
}
static uint64_t _init_l_dot___closed__0(void){
_start:
{
lean_object* v___x_70_; uint64_t v___x_71_; 
v___x_70_ = lean_unsigned_to_nat(0u);
v___x_71_ = lean_int64_of_nat(v___x_70_);
return v___x_71_;
}
}
LEAN_EXPORT uint64_t l_dot(lean_object* v_a_72_, lean_object* v_b_73_, lean_object* v_n_74_, lean_object* v_i_75_, lean_object* v_j_76_){
_start:
{
lean_object* v___x_77_; uint64_t v___x_78_; uint64_t v___x_79_; 
v___x_77_ = lean_unsigned_to_nat(0u);
v___x_78_ = lean_uint64_once(&l_dot___closed__0, &l_dot___closed__0_once, _init_l_dot___closed__0);
lean_inc(v_n_74_);
v___x_79_ = l_dot_go(v_a_72_, v_b_73_, v_n_74_, v_i_75_, v_j_76_, v_n_74_, v___x_77_, v___x_78_);
lean_dec(v_n_74_);
return v___x_79_;
}
}
LEAN_EXPORT lean_object* l_dot___boxed(lean_object* v_a_80_, lean_object* v_b_81_, lean_object* v_n_82_, lean_object* v_i_83_, lean_object* v_j_84_){
_start:
{
uint64_t v_res_85_; lean_object* v_r_86_; 
v_res_85_ = l_dot(v_a_80_, v_b_81_, v_n_82_, v_i_83_, v_j_84_);
lean_dec(v_j_84_);
lean_dec(v_i_83_);
lean_dec_ref(v_b_81_);
lean_dec_ref(v_a_80_);
v_r_86_ = lean_box_uint64(v_res_85_);
return v_r_86_;
}
}
LEAN_EXPORT lean_object* l_mul_go(lean_object* v_a_87_, lean_object* v_b_88_, lean_object* v_n_89_, lean_object* v_a_90_, lean_object* v_a_91_, lean_object* v_a_92_){
_start:
{
lean_object* v_zero_93_; uint8_t v_isZero_94_; 
v_zero_93_ = lean_unsigned_to_nat(0u);
v_isZero_94_ = lean_nat_dec_eq(v_a_90_, v_zero_93_);
if (v_isZero_94_ == 1)
{
lean_dec(v_a_91_);
lean_dec(v_a_90_);
lean_dec(v_n_89_);
return v_a_92_;
}
else
{
lean_object* v_one_95_; lean_object* v_n_96_; lean_object* v___x_97_; lean_object* v___x_98_; lean_object* v___x_99_; uint64_t v___x_100_; lean_object* v___x_101_; lean_object* v___x_102_; 
v_one_95_ = lean_unsigned_to_nat(1u);
v_n_96_ = lean_nat_sub(v_a_90_, v_one_95_);
lean_dec(v_a_90_);
v___x_97_ = lean_nat_add(v_a_91_, v_one_95_);
v___x_98_ = lean_nat_div(v_a_91_, v_n_89_);
v___x_99_ = lean_nat_mod(v_a_91_, v_n_89_);
lean_dec(v_a_91_);
lean_inc(v_n_89_);
v___x_100_ = l_dot(v_a_87_, v_b_88_, v_n_89_, v___x_98_, v___x_99_);
lean_dec(v___x_99_);
lean_dec(v___x_98_);
v___x_101_ = lean_box_uint64(v___x_100_);
v___x_102_ = lean_array_push(v_a_92_, v___x_101_);
v_a_90_ = v_n_96_;
v_a_91_ = v___x_97_;
v_a_92_ = v___x_102_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_mul_go___boxed(lean_object* v_a_104_, lean_object* v_b_105_, lean_object* v_n_106_, lean_object* v_a_107_, lean_object* v_a_108_, lean_object* v_a_109_){
_start:
{
lean_object* v_res_110_; 
v_res_110_ = l_mul_go(v_a_104_, v_b_105_, v_n_106_, v_a_107_, v_a_108_, v_a_109_);
lean_dec_ref(v_b_105_);
lean_dec_ref(v_a_104_);
return v_res_110_;
}
}
LEAN_EXPORT lean_object* l_mul(lean_object* v_a_111_, lean_object* v_b_112_, lean_object* v_n_113_){
_start:
{
lean_object* v___x_114_; lean_object* v___x_115_; lean_object* v___x_116_; lean_object* v___x_117_; 
v___x_114_ = lean_nat_mul(v_n_113_, v_n_113_);
v___x_115_ = lean_unsigned_to_nat(0u);
v___x_116_ = lean_mk_empty_array_with_capacity(v___x_114_);
v___x_117_ = l_mul_go(v_a_111_, v_b_112_, v_n_113_, v___x_114_, v___x_115_, v___x_116_);
return v___x_117_;
}
}
LEAN_EXPORT lean_object* l_mul___boxed(lean_object* v_a_118_, lean_object* v_b_119_, lean_object* v_n_120_){
_start:
{
lean_object* v_res_121_; 
v_res_121_ = l_mul(v_a_118_, v_b_119_, v_n_120_);
lean_dec_ref(v_b_119_);
lean_dec_ref(v_a_118_);
return v_res_121_;
}
}
LEAN_EXPORT uint64_t l_sum_go(lean_object* v_a_122_, lean_object* v_a_123_, lean_object* v_a_124_, uint64_t v_a_125_){
_start:
{
lean_object* v_zero_126_; uint8_t v_isZero_127_; 
v_zero_126_ = lean_unsigned_to_nat(0u);
v_isZero_127_ = lean_nat_dec_eq(v_a_123_, v_zero_126_);
if (v_isZero_127_ == 1)
{
lean_dec(v_a_124_);
lean_dec(v_a_123_);
return v_a_125_;
}
else
{
lean_object* v_one_128_; lean_object* v_n_129_; lean_object* v___x_130_; lean_object* v___x_131_; lean_object* v___x_132_; uint64_t v___x_133_; uint64_t v___x_134_; 
v_one_128_ = lean_unsigned_to_nat(1u);
v_n_129_ = lean_nat_sub(v_a_123_, v_one_128_);
lean_dec(v_a_123_);
v___x_130_ = lean_nat_add(v_a_124_, v_one_128_);
v___x_131_ = l_dot_go___boxed__const__1;
v___x_132_ = lean_array_get_borrowed(v___x_131_, v_a_122_, v_a_124_);
lean_dec(v_a_124_);
v___x_133_ = lean_unbox_uint64(v___x_132_);
v___x_134_ = lean_int64_add(v_a_125_, v___x_133_);
v_a_123_ = v_n_129_;
v_a_124_ = v___x_130_;
v_a_125_ = v___x_134_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_sum_go___boxed(lean_object* v_a_136_, lean_object* v_a_137_, lean_object* v_a_138_, lean_object* v_a_139_){
_start:
{
uint64_t v_a_66__boxed_140_; uint64_t v_res_141_; lean_object* v_r_142_; 
v_a_66__boxed_140_ = lean_unbox_uint64(v_a_139_);
lean_dec_ref(v_a_139_);
v_res_141_ = l_sum_go(v_a_136_, v_a_137_, v_a_138_, v_a_66__boxed_140_);
lean_dec_ref(v_a_136_);
v_r_142_ = lean_box_uint64(v_res_141_);
return v_r_142_;
}
}
LEAN_EXPORT uint64_t l_sum(lean_object* v_a_143_, lean_object* v_elems_144_){
_start:
{
lean_object* v___x_145_; uint64_t v___x_146_; uint64_t v___x_147_; 
v___x_145_ = lean_unsigned_to_nat(0u);
v___x_146_ = lean_uint64_once(&l_dot___closed__0, &l_dot___closed__0_once, _init_l_dot___closed__0);
v___x_147_ = l_sum_go(v_a_143_, v_elems_144_, v___x_145_, v___x_146_);
return v___x_147_;
}
}
LEAN_EXPORT lean_object* l_sum___boxed(lean_object* v_a_148_, lean_object* v_elems_149_){
_start:
{
uint64_t v_res_150_; lean_object* v_r_151_; 
v_res_150_ = l_sum(v_a_148_, v_elems_149_);
lean_dec_ref(v_a_148_);
v_r_151_ = lean_box_uint64(v_res_150_);
return v_r_151_;
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
LEAN_EXPORT uint64_t l_main___lam__0(lean_object* v_i_166_, lean_object* v_j_167_){
_start:
{
lean_object* v___x_168_; lean_object* v___x_169_; lean_object* v___x_170_; uint64_t v___x_171_; 
v___x_168_ = lean_nat_add(v_i_166_, v_j_167_);
v___x_169_ = lean_unsigned_to_nat(7u);
v___x_170_ = lean_nat_mod(v___x_168_, v___x_169_);
lean_dec(v___x_168_);
v___x_171_ = lean_int64_of_nat(v___x_170_);
lean_dec(v___x_170_);
return v___x_171_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object* v_i_172_, lean_object* v_j_173_){
_start:
{
uint64_t v_res_174_; lean_object* v_r_175_; 
v_res_174_ = l_main___lam__0(v_i_172_, v_j_173_);
lean_dec(v_j_173_);
lean_dec(v_i_172_);
v_r_175_ = lean_box_uint64(v_res_174_);
return v_r_175_;
}
}
LEAN_EXPORT uint64_t l_main___lam__1(lean_object* v_i_176_, lean_object* v_j_177_){
_start:
{
lean_object* v___x_178_; lean_object* v___x_179_; lean_object* v___x_180_; uint64_t v___x_181_; 
v___x_178_ = lean_nat_mul(v_i_176_, v_j_177_);
v___x_179_ = lean_unsigned_to_nat(5u);
v___x_180_ = lean_nat_mod(v___x_178_, v___x_179_);
lean_dec(v___x_178_);
v___x_181_ = lean_int64_of_nat(v___x_180_);
lean_dec(v___x_180_);
return v___x_181_;
}
}
LEAN_EXPORT lean_object* l_main___lam__1___boxed(lean_object* v_i_182_, lean_object* v_j_183_){
_start:
{
uint64_t v_res_184_; lean_object* v_r_185_; 
v_res_184_ = l_main___lam__1(v_i_182_, v_j_183_);
lean_dec(v_j_183_);
lean_dec(v_i_182_);
v_r_185_ = lean_box_uint64(v_res_184_);
return v_r_185_;
}
}
LEAN_EXPORT uint64_t l_main___lam__2(lean_object* v___x_186_, lean_object* v___x_187_, lean_object* v_x_188_){
_start:
{
uint64_t v___x_189_; 
v___x_189_ = l_sum(v___x_186_, v___x_187_);
return v___x_189_;
}
}
LEAN_EXPORT lean_object* l_main___lam__2___boxed(lean_object* v___x_190_, lean_object* v___x_191_, lean_object* v_x_192_){
_start:
{
uint64_t v_res_193_; lean_object* v_r_194_; 
v_res_193_ = l_main___lam__2(v___x_190_, v___x_191_, v_x_192_);
lean_dec_ref(v___x_190_);
v_r_194_ = lean_box_uint64(v_res_193_);
return v_r_194_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_195_){
_start:
{
lean_object* v___x_197_; lean_object* v_putStr_198_; lean_object* v___x_199_; 
v___x_197_ = lean_get_stdout();
v_putStr_198_ = lean_ctor_get(v___x_197_, 4);
lean_inc_ref(v_putStr_198_);
lean_dec_ref(v___x_197_);
v___x_199_ = lean_apply_2(v_putStr_198_, v_s_195_, lean_box(0));
return v___x_199_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_200_, lean_object* v_a_201_){
_start:
{
lean_object* v_res_202_; 
v_res_202_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_200_);
return v_res_202_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_203_){
_start:
{
lean_object* v___x_205_; lean_object* v___x_206_; uint32_t v___x_207_; lean_object* v___x_208_; lean_object* v___x_209_; 
v___x_205_ = lean_int64_to_int_sint(v_s_203_);
v___x_206_ = l_Int_repr(v___x_205_);
lean_dec(v___x_205_);
v___x_207_ = 10;
v___x_208_ = lean_string_push(v___x_206_, v___x_207_);
v___x_209_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_208_);
return v___x_209_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_210_, lean_object* v_a_211_){
_start:
{
uint64_t v_s_boxed_212_; lean_object* v_res_213_; 
v_s_boxed_212_ = lean_unbox_uint64(v_s_210_);
lean_dec_ref(v_s_210_);
v_res_213_ = l_IO_println___at___00main_spec__0(v_s_boxed_212_);
return v_res_213_;
}
}
static lean_object* _init_l_main___closed__2(void){
_start:
{
lean_object* v___f_216_; lean_object* v___x_217_; lean_object* v___x_218_; 
v___f_216_ = ((lean_object*)(l_main___closed__0));
v___x_217_ = lean_unsigned_to_nat(500u);
v___x_218_ = l_build(v___x_217_, v___f_216_);
return v___x_218_;
}
}
static lean_object* _init_l_main___closed__3(void){
_start:
{
lean_object* v___f_219_; lean_object* v___x_220_; lean_object* v___x_221_; 
v___f_219_ = ((lean_object*)(l_main___closed__1));
v___x_220_ = lean_unsigned_to_nat(500u);
v___x_221_ = l_build(v___x_220_, v___f_219_);
return v___x_221_;
}
}
static lean_object* _init_l_main___closed__4(void){
_start:
{
lean_object* v___x_222_; lean_object* v___x_223_; lean_object* v___x_224_; lean_object* v___x_225_; 
v___x_222_ = lean_unsigned_to_nat(500u);
v___x_223_ = lean_obj_once(&l_main___closed__3, &l_main___closed__3_once, _init_l_main___closed__3);
v___x_224_ = lean_obj_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_225_ = l_mul(v___x_224_, v___x_223_, v___x_222_);
return v___x_225_;
}
}
static lean_object* _init_l_main___closed__5(void){
_start:
{
lean_object* v___x_226_; lean_object* v___x_227_; lean_object* v___f_228_; 
v___x_226_ = lean_unsigned_to_nat(250000u);
v___x_227_ = lean_obj_once(&l_main___closed__4, &l_main___closed__4_once, _init_l_main___closed__4);
v___f_228_ = lean_alloc_closure((void*)(l_main___lam__2___boxed), 3, 2);
lean_closure_set(v___f_228_, 0, v___x_227_);
lean_closure_set(v___f_228_, 1, v___x_226_);
return v___f_228_;
}
}
static double _init_l_main___closed__6(void){
_start:
{
lean_object* v___x_229_; uint8_t v___x_230_; lean_object* v___x_231_; double v___x_232_; 
v___x_229_ = lean_unsigned_to_nat(1u);
v___x_230_ = 1;
v___x_231_ = lean_unsigned_to_nat(10000000u);
v___x_232_ = l_Float_ofScientific(v___x_231_, v___x_230_, v___x_229_);
return v___x_232_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_235_; lean_object* v___f_236_; lean_object* v___x_237_; lean_object* v_a_238_; lean_object* v___x_239_; lean_object* v___x_240_; double v___x_241_; double v___x_242_; double v___x_243_; lean_object* v___x_244_; lean_object* v___x_245_; lean_object* v___x_246_; lean_object* v___x_247_; 
v___x_235_ = lean_io_mono_nanos_now();
v___f_236_ = lean_obj_once(&l_main___closed__5, &l_main___closed__5_once, _init_l_main___closed__5);
v___x_237_ = l_forceIO___redArg(v___f_236_);
v_a_238_ = lean_ctor_get(v___x_237_, 0);
lean_inc(v_a_238_);
lean_dec_ref(v___x_237_);
v___x_239_ = lean_io_mono_nanos_now();
v___x_240_ = lean_nat_sub(v___x_239_, v___x_235_);
lean_dec(v___x_235_);
lean_dec(v___x_239_);
v___x_241_ = lean_float_of_nat(v___x_240_);
v___x_242_ = lean_float_once(&l_main___closed__6, &l_main___closed__6_once, _init_l_main___closed__6);
v___x_243_ = lean_float_div(v___x_241_, v___x_242_);
v___x_244_ = ((lean_object*)(l_main___closed__7));
v___x_245_ = lean_float_to_string(v___x_243_);
v___x_246_ = lean_string_append(v___x_244_, v___x_245_);
lean_dec_ref(v___x_245_);
v___x_247_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_246_);
if (lean_obj_tag(v___x_247_) == 0)
{
uint64_t v___x_248_; lean_object* v___x_249_; 
lean_dec_ref_known(v___x_247_, 1);
v___x_248_ = lean_unbox_uint64(v_a_238_);
lean_dec(v_a_238_);
v___x_249_ = l_IO_println___at___00main_spec__0(v___x_248_);
return v___x_249_;
}
else
{
lean_dec(v_a_238_);
return v___x_247_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_250_){
_start:
{
lean_object* v_res_251_; 
v_res_251_ = _lean_main();
return v_res_251_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0013__matrix__mul(uint8_t builtin) {
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
l_dot_go___boxed__const__1 = _init_l_dot_go___boxed__const__1();
lean_mark_persistent(l_dot_go___boxed__const__1);
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
  res = initialize_0013__matrix__mul(1 /* builtin */);
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
