// Lean compiler output
// Module: «11_parallel_sum»
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
uint8_t lean_usize_dec_lt(size_t, size_t);
lean_object* lean_array_uget_borrowed(lean_object*, size_t);
lean_object* lean_io_wait(lean_object*);
uint64_t lean_uint64_add(uint64_t, uint64_t);
size_t lean_usize_add(size_t, size_t);
uint64_t lean_uint64_mul(uint64_t, uint64_t);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
uint64_t lean_uint64_mod(uint64_t, uint64_t);
uint8_t lean_uint64_dec_eq(uint64_t, uint64_t);
uint64_t lean_uint64_shift_left(uint64_t, uint64_t);
uint64_t lean_uint64_of_nat(lean_object*);
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_as_task(lean_object*, lean_object*);
lean_object* lean_array_uset(lean_object*, size_t, lean_object*);
lean_object* lean_io_mono_nanos_now();
lean_object* l_Array_range(lean_object*);
size_t lean_array_size(lean_object*);
double lean_float_of_nat(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
lean_object* lean_uint64_to_nat(uint64_t);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
LEAN_EXPORT uint64_t l_work_go(lean_object*, uint64_t, uint64_t);
LEAN_EXPORT lean_object* l_work_go___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_work(uint64_t);
LEAN_EXPORT lean_object* l_work___boxed(lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_forIn_x27Unsafe_loop___at___00main_spec__1(lean_object*, size_t, size_t, uint64_t);
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_forIn_x27Unsafe_loop___at___00main_spec__1___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__1(lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0(size_t, size_t, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2(uint64_t);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2___boxed(lean_object*, lean_object*);
static lean_once_cell_t l_main___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__0;
static lean_once_cell_t l_main___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static size_t l_main___closed__1;
static lean_once_cell_t l_main___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__2;
static const lean_string_object l_main___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__3 = (const lean_object*)&l_main___closed__3_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT uint64_t l_work_go(lean_object* v_a_1_, uint64_t v_a_2_, uint64_t v_a_3_){
_start:
{
lean_object* v_zero_4_; uint8_t v_isZero_5_; 
v_zero_4_ = lean_unsigned_to_nat(0u);
v_isZero_5_ = lean_nat_dec_eq(v_a_1_, v_zero_4_);
if (v_isZero_5_ == 1)
{
lean_dec(v_a_1_);
return v_a_3_;
}
else
{
lean_object* v_one_6_; lean_object* v_n_7_; uint64_t v___x_8_; uint64_t v___x_9_; uint64_t v___x_10_; uint8_t v___x_11_; 
v_one_6_ = lean_unsigned_to_nat(1u);
v_n_7_ = lean_nat_sub(v_a_1_, v_one_6_);
lean_dec(v_a_1_);
v___x_8_ = 4ULL;
v___x_9_ = lean_uint64_mod(v_a_2_, v___x_8_);
v___x_10_ = 0ULL;
v___x_11_ = lean_uint64_dec_eq(v___x_9_, v___x_10_);
if (v___x_11_ == 0)
{
uint64_t v___x_12_; uint8_t v___x_13_; 
v___x_12_ = 1ULL;
v___x_13_ = lean_uint64_dec_eq(v___x_9_, v___x_12_);
if (v___x_13_ == 0)
{
uint64_t v___x_14_; uint8_t v___x_15_; 
v___x_14_ = 2ULL;
v___x_15_ = lean_uint64_dec_eq(v___x_9_, v___x_14_);
if (v___x_15_ == 0)
{
uint64_t v___x_16_; uint64_t v___x_17_; uint64_t v___x_18_; uint64_t v___x_19_; 
v___x_16_ = lean_uint64_add(v_a_2_, v___x_12_);
v___x_17_ = 3ULL;
v___x_18_ = lean_uint64_mul(v___x_17_, v_a_2_);
v___x_19_ = lean_uint64_add(v_a_3_, v___x_18_);
v_a_1_ = v_n_7_;
v_a_2_ = v___x_16_;
v_a_3_ = v___x_19_;
goto _start;
}
else
{
uint64_t v___x_21_; uint64_t v___x_22_; uint64_t v___x_23_; 
v___x_21_ = lean_uint64_add(v_a_2_, v___x_12_);
v___x_22_ = lean_uint64_shift_left(v_a_2_, v___x_12_);
v___x_23_ = lean_uint64_add(v_a_3_, v___x_22_);
v_a_1_ = v_n_7_;
v_a_2_ = v___x_21_;
v_a_3_ = v___x_23_;
goto _start;
}
}
else
{
uint64_t v___x_25_; uint64_t v___x_26_; 
v___x_25_ = lean_uint64_add(v_a_2_, v___x_12_);
v___x_26_ = lean_uint64_add(v_a_3_, v_a_2_);
v_a_1_ = v_n_7_;
v_a_2_ = v___x_25_;
v_a_3_ = v___x_26_;
goto _start;
}
}
else
{
uint64_t v___x_28_; uint64_t v___x_29_; uint64_t v___x_30_; 
v___x_28_ = 1ULL;
v___x_29_ = lean_uint64_add(v_a_2_, v___x_28_);
v___x_30_ = lean_uint64_add(v_a_3_, v___x_28_);
v_a_1_ = v_n_7_;
v_a_2_ = v___x_29_;
v_a_3_ = v___x_30_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l_work_go___boxed(lean_object* v_a_32_, lean_object* v_a_33_, lean_object* v_a_34_){
_start:
{
uint64_t v_a_281__boxed_35_; uint64_t v_a_282__boxed_36_; uint64_t v_res_37_; lean_object* v_r_38_; 
v_a_281__boxed_35_ = lean_unbox_uint64(v_a_33_);
lean_dec_ref(v_a_33_);
v_a_282__boxed_36_ = lean_unbox_uint64(v_a_34_);
lean_dec_ref(v_a_34_);
v_res_37_ = l_work_go(v_a_32_, v_a_281__boxed_35_, v_a_282__boxed_36_);
v_r_38_ = lean_box_uint64(v_res_37_);
return v_r_38_;
}
}
LEAN_EXPORT uint64_t l_work(uint64_t v_t_39_){
_start:
{
lean_object* v___x_40_; uint64_t v___x_41_; uint64_t v___x_42_; uint64_t v___x_43_; uint64_t v___x_44_; 
v___x_40_ = lean_unsigned_to_nat(25000000u);
v___x_41_ = 25000000ULL;
v___x_42_ = lean_uint64_mul(v_t_39_, v___x_41_);
v___x_43_ = 0ULL;
v___x_44_ = l_work_go(v___x_40_, v___x_42_, v___x_43_);
return v___x_44_;
}
}
LEAN_EXPORT lean_object* l_work___boxed(lean_object* v_t_45_){
_start:
{
uint64_t v_t_boxed_46_; uint64_t v_res_47_; lean_object* v_r_48_; 
v_t_boxed_46_ = lean_unbox_uint64(v_t_45_);
lean_dec_ref(v_t_45_);
v_res_47_ = l_work(v_t_boxed_46_);
v_r_48_ = lean_box_uint64(v_res_47_);
return v_r_48_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_forIn_x27Unsafe_loop___at___00main_spec__1(lean_object* v_as_49_, size_t v_sz_50_, size_t v_i_51_, uint64_t v_b_52_){
_start:
{
uint8_t v___x_54_; 
v___x_54_ = lean_usize_dec_lt(v_i_51_, v_sz_50_);
if (v___x_54_ == 0)
{
lean_object* v___x_55_; lean_object* v___x_56_; 
v___x_55_ = lean_box_uint64(v_b_52_);
v___x_56_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_56_, 0, v___x_55_);
return v___x_56_;
}
else
{
lean_object* v_a_57_; lean_object* v___x_58_; 
v_a_57_ = lean_array_uget_borrowed(v_as_49_, v_i_51_);
lean_inc(v_a_57_);
v___x_58_ = lean_io_wait(v_a_57_);
if (lean_obj_tag(v___x_58_) == 0)
{
lean_object* v_a_59_; lean_object* v___x_61_; uint8_t v_isShared_62_; uint8_t v_isSharedCheck_66_; 
v_a_59_ = lean_ctor_get(v___x_58_, 0);
v_isSharedCheck_66_ = !lean_is_exclusive(v___x_58_);
if (v_isSharedCheck_66_ == 0)
{
v___x_61_ = v___x_58_;
v_isShared_62_ = v_isSharedCheck_66_;
goto v_resetjp_60_;
}
else
{
lean_inc(v_a_59_);
lean_dec(v___x_58_);
v___x_61_ = lean_box(0);
v_isShared_62_ = v_isSharedCheck_66_;
goto v_resetjp_60_;
}
v_resetjp_60_:
{
lean_object* v___x_64_; 
if (v_isShared_62_ == 0)
{
lean_ctor_set_tag(v___x_61_, 1);
v___x_64_ = v___x_61_;
goto v_reusejp_63_;
}
else
{
lean_object* v_reuseFailAlloc_65_; 
v_reuseFailAlloc_65_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_65_, 0, v_a_59_);
v___x_64_ = v_reuseFailAlloc_65_;
goto v_reusejp_63_;
}
v_reusejp_63_:
{
return v___x_64_;
}
}
}
else
{
lean_object* v_a_67_; uint64_t v___x_68_; uint64_t v___x_69_; size_t v___x_70_; size_t v___x_71_; 
v_a_67_ = lean_ctor_get(v___x_58_, 0);
lean_inc(v_a_67_);
lean_dec_ref_known(v___x_58_, 1);
v___x_68_ = lean_unbox_uint64(v_a_67_);
lean_dec(v_a_67_);
v___x_69_ = lean_uint64_add(v_b_52_, v___x_68_);
v___x_70_ = ((size_t)1ULL);
v___x_71_ = lean_usize_add(v_i_51_, v___x_70_);
v_i_51_ = v___x_71_;
v_b_52_ = v___x_69_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_forIn_x27Unsafe_loop___at___00main_spec__1___boxed(lean_object* v_as_73_, lean_object* v_sz_74_, lean_object* v_i_75_, lean_object* v_b_76_, lean_object* v___y_77_){
_start:
{
size_t v_sz_boxed_78_; size_t v_i_boxed_79_; uint64_t v_b_boxed_80_; lean_object* v_res_81_; 
v_sz_boxed_78_ = lean_unbox_usize(v_sz_74_);
lean_dec(v_sz_74_);
v_i_boxed_79_ = lean_unbox_usize(v_i_75_);
lean_dec(v_i_75_);
v_b_boxed_80_ = lean_unbox_uint64(v_b_76_);
lean_dec_ref(v_b_76_);
v_res_81_ = l___private_Init_Data_Array_Basic_0__Array_forIn_x27Unsafe_loop___at___00main_spec__1(v_as_73_, v_sz_boxed_78_, v_i_boxed_79_, v_b_boxed_80_);
lean_dec_ref(v_as_73_);
return v_res_81_;
}
}
LEAN_EXPORT uint64_t l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__0(lean_object* v_v_82_, lean_object* v_x_83_){
_start:
{
uint64_t v___x_84_; uint64_t v___x_85_; 
v___x_84_ = lean_uint64_of_nat(v_v_82_);
v___x_85_ = l_work(v___x_84_);
return v___x_85_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__0___boxed(lean_object* v_v_86_, lean_object* v_x_87_){
_start:
{
uint64_t v_res_88_; lean_object* v_r_89_; 
v_res_88_ = l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__0(v_v_86_, v_x_87_);
lean_dec(v_v_86_);
v_r_89_ = lean_box_uint64(v_res_88_);
return v_r_89_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__1(lean_object* v___f_90_){
_start:
{
lean_object* v___x_92_; 
v___x_92_ = l_IO_lazyPure___redArg(v___f_90_);
if (lean_obj_tag(v___x_92_) == 0)
{
lean_object* v_a_93_; lean_object* v___x_95_; uint8_t v_isShared_96_; uint8_t v_isSharedCheck_100_; 
v_a_93_ = lean_ctor_get(v___x_92_, 0);
v_isSharedCheck_100_ = !lean_is_exclusive(v___x_92_);
if (v_isSharedCheck_100_ == 0)
{
v___x_95_ = v___x_92_;
v_isShared_96_ = v_isSharedCheck_100_;
goto v_resetjp_94_;
}
else
{
lean_inc(v_a_93_);
lean_dec(v___x_92_);
v___x_95_ = lean_box(0);
v_isShared_96_ = v_isSharedCheck_100_;
goto v_resetjp_94_;
}
v_resetjp_94_:
{
lean_object* v___x_98_; 
if (v_isShared_96_ == 0)
{
lean_ctor_set_tag(v___x_95_, 1);
v___x_98_ = v___x_95_;
goto v_reusejp_97_;
}
else
{
lean_object* v_reuseFailAlloc_99_; 
v_reuseFailAlloc_99_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_99_, 0, v_a_93_);
v___x_98_ = v_reuseFailAlloc_99_;
goto v_reusejp_97_;
}
v_reusejp_97_:
{
return v___x_98_;
}
}
}
else
{
lean_object* v_a_101_; lean_object* v___x_103_; uint8_t v_isShared_104_; uint8_t v_isSharedCheck_108_; 
v_a_101_ = lean_ctor_get(v___x_92_, 0);
v_isSharedCheck_108_ = !lean_is_exclusive(v___x_92_);
if (v_isSharedCheck_108_ == 0)
{
v___x_103_ = v___x_92_;
v_isShared_104_ = v_isSharedCheck_108_;
goto v_resetjp_102_;
}
else
{
lean_inc(v_a_101_);
lean_dec(v___x_92_);
v___x_103_ = lean_box(0);
v_isShared_104_ = v_isSharedCheck_108_;
goto v_resetjp_102_;
}
v_resetjp_102_:
{
lean_object* v___x_106_; 
if (v_isShared_104_ == 0)
{
lean_ctor_set_tag(v___x_103_, 0);
v___x_106_ = v___x_103_;
goto v_reusejp_105_;
}
else
{
lean_object* v_reuseFailAlloc_107_; 
v_reuseFailAlloc_107_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_107_, 0, v_a_101_);
v___x_106_ = v_reuseFailAlloc_107_;
goto v_reusejp_105_;
}
v_reusejp_105_:
{
return v___x_106_;
}
}
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__1___boxed(lean_object* v___f_109_, lean_object* v___y_110_){
_start:
{
lean_object* v_res_111_; 
v_res_111_ = l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__1(v___f_109_);
return v_res_111_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0(size_t v_sz_112_, size_t v_i_113_, lean_object* v_bs_114_){
_start:
{
uint8_t v___x_116_; 
v___x_116_ = lean_usize_dec_lt(v_i_113_, v_sz_112_);
if (v___x_116_ == 0)
{
lean_object* v___x_117_; 
v___x_117_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_117_, 0, v_bs_114_);
return v___x_117_;
}
else
{
lean_object* v_v_118_; lean_object* v___f_119_; lean_object* v___f_120_; lean_object* v___x_121_; lean_object* v___x_122_; lean_object* v_bs_x27_123_; size_t v___x_124_; size_t v___x_125_; lean_object* v___x_126_; 
v_v_118_ = lean_array_uget_borrowed(v_bs_114_, v_i_113_);
lean_inc(v_v_118_);
v___f_119_ = lean_alloc_closure((void*)(l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__0___boxed), 2, 1);
lean_closure_set(v___f_119_, 0, v_v_118_);
v___f_120_ = lean_alloc_closure((void*)(l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___lam__1___boxed), 2, 1);
lean_closure_set(v___f_120_, 0, v___f_119_);
v___x_121_ = lean_unsigned_to_nat(0u);
v___x_122_ = lean_io_as_task(v___f_120_, v___x_121_);
v_bs_x27_123_ = lean_array_uset(v_bs_114_, v_i_113_, v___x_121_);
v___x_124_ = ((size_t)1ULL);
v___x_125_ = lean_usize_add(v_i_113_, v___x_124_);
v___x_126_ = lean_array_uset(v_bs_x27_123_, v_i_113_, v___x_122_);
v_i_113_ = v___x_125_;
v_bs_114_ = v___x_126_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0___boxed(lean_object* v_sz_128_, lean_object* v_i_129_, lean_object* v_bs_130_, lean_object* v___y_131_){
_start:
{
size_t v_sz_boxed_132_; size_t v_i_boxed_133_; lean_object* v_res_134_; 
v_sz_boxed_132_ = lean_unbox_usize(v_sz_128_);
lean_dec(v_sz_128_);
v_i_boxed_133_ = lean_unbox_usize(v_i_129_);
lean_dec(v_i_129_);
v_res_134_ = l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0(v_sz_boxed_132_, v_i_boxed_133_, v_bs_130_);
return v_res_134_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(lean_object* v_s_135_){
_start:
{
lean_object* v___x_137_; lean_object* v_putStr_138_; lean_object* v___x_139_; 
v___x_137_ = lean_get_stdout();
v_putStr_138_ = lean_ctor_get(v___x_137_, 4);
lean_inc_ref(v_putStr_138_);
lean_dec_ref(v___x_137_);
v___x_139_ = lean_apply_2(v_putStr_138_, v_s_135_, lean_box(0));
return v___x_139_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2___boxed(lean_object* v_s_140_, lean_object* v_a_141_){
_start:
{
lean_object* v_res_142_; 
v_res_142_ = l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(v_s_140_);
return v_res_142_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2(uint64_t v_s_143_){
_start:
{
lean_object* v___x_145_; lean_object* v___x_146_; uint32_t v___x_147_; lean_object* v___x_148_; lean_object* v___x_149_; 
v___x_145_ = lean_uint64_to_nat(v_s_143_);
v___x_146_ = l_Nat_reprFast(v___x_145_);
v___x_147_ = 10;
v___x_148_ = lean_string_push(v___x_146_, v___x_147_);
v___x_149_ = l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(v___x_148_);
return v___x_149_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2___boxed(lean_object* v_s_150_, lean_object* v_a_151_){
_start:
{
uint64_t v_s_boxed_152_; lean_object* v_res_153_; 
v_s_boxed_152_ = lean_unbox_uint64(v_s_150_);
lean_dec_ref(v_s_150_);
v_res_153_ = l_IO_println___at___00main_spec__2(v_s_boxed_152_);
return v_res_153_;
}
}
static lean_object* _init_l_main___closed__0(void){
_start:
{
lean_object* v___x_154_; lean_object* v___x_155_; 
v___x_154_ = lean_unsigned_to_nat(4u);
v___x_155_ = l_Array_range(v___x_154_);
return v___x_155_;
}
}
static size_t _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_156_; size_t v_sz_157_; 
v___x_156_ = lean_obj_once(&l_main___closed__0, &l_main___closed__0_once, _init_l_main___closed__0);
v_sz_157_ = lean_array_size(v___x_156_);
return v_sz_157_;
}
}
static double _init_l_main___closed__2(void){
_start:
{
lean_object* v___x_158_; uint8_t v___x_159_; lean_object* v___x_160_; double v___x_161_; 
v___x_158_ = lean_unsigned_to_nat(1u);
v___x_159_ = 1;
v___x_160_ = lean_unsigned_to_nat(10000000u);
v___x_161_ = l_Float_ofScientific(v___x_160_, v___x_159_, v___x_158_);
return v___x_161_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_164_; lean_object* v___x_165_; size_t v_sz_166_; size_t v___x_167_; lean_object* v___x_168_; 
v___x_164_ = lean_io_mono_nanos_now();
v___x_165_ = lean_obj_once(&l_main___closed__0, &l_main___closed__0_once, _init_l_main___closed__0);
v_sz_166_ = lean_usize_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_167_ = ((size_t)0ULL);
v___x_168_ = l___private_Init_Data_Array_Basic_0__Array_mapMUnsafe_map___at___00main_spec__0(v_sz_166_, v___x_167_, v___x_165_);
if (lean_obj_tag(v___x_168_) == 0)
{
lean_object* v_a_169_; uint64_t v___x_170_; size_t v_sz_171_; lean_object* v___x_172_; 
v_a_169_ = lean_ctor_get(v___x_168_, 0);
lean_inc(v_a_169_);
lean_dec_ref_known(v___x_168_, 1);
v___x_170_ = 0ULL;
v_sz_171_ = lean_array_size(v_a_169_);
v___x_172_ = l___private_Init_Data_Array_Basic_0__Array_forIn_x27Unsafe_loop___at___00main_spec__1(v_a_169_, v_sz_171_, v___x_167_, v___x_170_);
lean_dec(v_a_169_);
if (lean_obj_tag(v___x_172_) == 0)
{
lean_object* v_a_173_; lean_object* v___x_174_; lean_object* v___x_175_; double v___x_176_; double v___x_177_; double v___x_178_; lean_object* v___x_179_; lean_object* v___x_180_; lean_object* v___x_181_; lean_object* v___x_182_; 
v_a_173_ = lean_ctor_get(v___x_172_, 0);
lean_inc(v_a_173_);
lean_dec_ref_known(v___x_172_, 1);
v___x_174_ = lean_io_mono_nanos_now();
v___x_175_ = lean_nat_sub(v___x_174_, v___x_164_);
lean_dec(v___x_164_);
lean_dec(v___x_174_);
v___x_176_ = lean_float_of_nat(v___x_175_);
v___x_177_ = lean_float_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_178_ = lean_float_div(v___x_176_, v___x_177_);
v___x_179_ = ((lean_object*)(l_main___closed__3));
v___x_180_ = lean_float_to_string(v___x_178_);
v___x_181_ = lean_string_append(v___x_179_, v___x_180_);
lean_dec_ref(v___x_180_);
v___x_182_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_181_);
if (lean_obj_tag(v___x_182_) == 0)
{
uint64_t v___x_183_; lean_object* v___x_184_; 
lean_dec_ref_known(v___x_182_, 1);
v___x_183_ = lean_unbox_uint64(v_a_173_);
lean_dec(v_a_173_);
v___x_184_ = l_IO_println___at___00main_spec__2(v___x_183_);
return v___x_184_;
}
else
{
lean_dec(v_a_173_);
return v___x_182_;
}
}
else
{
lean_object* v_a_185_; lean_object* v___x_187_; uint8_t v_isShared_188_; uint8_t v_isSharedCheck_192_; 
lean_dec(v___x_164_);
v_a_185_ = lean_ctor_get(v___x_172_, 0);
v_isSharedCheck_192_ = !lean_is_exclusive(v___x_172_);
if (v_isSharedCheck_192_ == 0)
{
v___x_187_ = v___x_172_;
v_isShared_188_ = v_isSharedCheck_192_;
goto v_resetjp_186_;
}
else
{
lean_inc(v_a_185_);
lean_dec(v___x_172_);
v___x_187_ = lean_box(0);
v_isShared_188_ = v_isSharedCheck_192_;
goto v_resetjp_186_;
}
v_resetjp_186_:
{
lean_object* v___x_190_; 
if (v_isShared_188_ == 0)
{
v___x_190_ = v___x_187_;
goto v_reusejp_189_;
}
else
{
lean_object* v_reuseFailAlloc_191_; 
v_reuseFailAlloc_191_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_191_, 0, v_a_185_);
v___x_190_ = v_reuseFailAlloc_191_;
goto v_reusejp_189_;
}
v_reusejp_189_:
{
return v___x_190_;
}
}
}
}
else
{
lean_object* v_a_193_; lean_object* v___x_195_; uint8_t v_isShared_196_; uint8_t v_isSharedCheck_200_; 
lean_dec(v___x_164_);
v_a_193_ = lean_ctor_get(v___x_168_, 0);
v_isSharedCheck_200_ = !lean_is_exclusive(v___x_168_);
if (v_isSharedCheck_200_ == 0)
{
v___x_195_ = v___x_168_;
v_isShared_196_ = v_isSharedCheck_200_;
goto v_resetjp_194_;
}
else
{
lean_inc(v_a_193_);
lean_dec(v___x_168_);
v___x_195_ = lean_box(0);
v_isShared_196_ = v_isSharedCheck_200_;
goto v_resetjp_194_;
}
v_resetjp_194_:
{
lean_object* v___x_198_; 
if (v_isShared_196_ == 0)
{
v___x_198_ = v___x_195_;
goto v_reusejp_197_;
}
else
{
lean_object* v_reuseFailAlloc_199_; 
v_reuseFailAlloc_199_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_199_, 0, v_a_193_);
v___x_198_ = v_reuseFailAlloc_199_;
goto v_reusejp_197_;
}
v_reusejp_197_:
{
return v___x_198_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_201_){
_start:
{
lean_object* v_res_202_; 
v_res_202_ = _lean_main();
return v_res_202_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0011__parallel__sum(uint8_t builtin) {
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
  res = initialize_0011__parallel__sum(1 /* builtin */);
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
