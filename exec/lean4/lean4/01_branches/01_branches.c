// Lean compiler output
// Module: «01_branches»
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
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
uint64_t lean_uint64_mod(uint64_t, uint64_t);
uint8_t lean_uint64_dec_eq(uint64_t, uint64_t);
uint64_t lean_uint64_add(uint64_t, uint64_t);
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_mono_nanos_now();
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
LEAN_EXPORT lean_object* l_branches_go(lean_object*, uint64_t, uint64_t, uint64_t, uint64_t, uint64_t);
LEAN_EXPORT lean_object* l_branches_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_branches(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_main___lam__0___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___lam__0___closed__0;
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
static const lean_string_object l_main___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = " "};
static const lean_object* l_main___closed__3 = (const lean_object*)&l_main___closed__3_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT lean_object* l_branches_go(lean_object* v_a_1_, uint64_t v_a_2_, uint64_t v_a_3_, uint64_t v_a_4_, uint64_t v_a_5_, uint64_t v_a_6_){
_start:
{
lean_object* v_zero_7_; uint8_t v_isZero_8_; 
v_zero_7_ = lean_unsigned_to_nat(0u);
v_isZero_8_ = lean_nat_dec_eq(v_a_1_, v_zero_7_);
if (v_isZero_8_ == 1)
{
lean_object* v___x_9_; lean_object* v___x_10_; lean_object* v___x_11_; lean_object* v___x_12_; lean_object* v___x_13_; lean_object* v___x_14_; lean_object* v___x_15_; 
lean_dec(v_a_1_);
v___x_9_ = lean_box_uint64(v_a_5_);
v___x_10_ = lean_box_uint64(v_a_6_);
v___x_11_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_11_, 0, v___x_9_);
lean_ctor_set(v___x_11_, 1, v___x_10_);
v___x_12_ = lean_box_uint64(v_a_4_);
v___x_13_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_13_, 0, v___x_12_);
lean_ctor_set(v___x_13_, 1, v___x_11_);
v___x_14_ = lean_box_uint64(v_a_3_);
v___x_15_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_15_, 0, v___x_14_);
lean_ctor_set(v___x_15_, 1, v___x_13_);
return v___x_15_;
}
else
{
lean_object* v_one_16_; lean_object* v_n_17_; uint64_t v___x_18_; uint64_t v___x_19_; uint64_t v___x_20_; uint8_t v___x_21_; 
v_one_16_ = lean_unsigned_to_nat(1u);
v_n_17_ = lean_nat_sub(v_a_1_, v_one_16_);
lean_dec(v_a_1_);
v___x_18_ = 3ULL;
v___x_19_ = lean_uint64_mod(v_a_2_, v___x_18_);
v___x_20_ = 0ULL;
v___x_21_ = lean_uint64_dec_eq(v___x_19_, v___x_20_);
if (v___x_21_ == 0)
{
uint64_t v___x_22_; uint64_t v___x_23_; uint8_t v___x_24_; 
v___x_22_ = 5ULL;
v___x_23_ = lean_uint64_mod(v_a_2_, v___x_22_);
v___x_24_ = lean_uint64_dec_eq(v___x_23_, v___x_20_);
if (v___x_24_ == 0)
{
uint64_t v___x_25_; uint64_t v___x_26_; uint8_t v___x_27_; 
v___x_25_ = 7ULL;
v___x_26_ = lean_uint64_mod(v_a_2_, v___x_25_);
v___x_27_ = lean_uint64_dec_eq(v___x_26_, v___x_20_);
if (v___x_27_ == 0)
{
uint64_t v___x_28_; uint64_t v___x_29_; uint64_t v___x_30_; 
v___x_28_ = 1ULL;
v___x_29_ = lean_uint64_add(v_a_2_, v___x_28_);
v___x_30_ = lean_uint64_add(v_a_6_, v___x_28_);
v_a_1_ = v_n_17_;
v_a_2_ = v___x_29_;
v_a_6_ = v___x_30_;
goto _start;
}
else
{
uint64_t v___x_32_; uint64_t v___x_33_; uint64_t v___x_34_; 
v___x_32_ = 1ULL;
v___x_33_ = lean_uint64_add(v_a_2_, v___x_32_);
v___x_34_ = lean_uint64_add(v_a_5_, v___x_32_);
v_a_1_ = v_n_17_;
v_a_2_ = v___x_33_;
v_a_5_ = v___x_34_;
goto _start;
}
}
else
{
uint64_t v___x_36_; uint64_t v___x_37_; uint64_t v___x_38_; 
v___x_36_ = 1ULL;
v___x_37_ = lean_uint64_add(v_a_2_, v___x_36_);
v___x_38_ = lean_uint64_add(v_a_4_, v___x_36_);
v_a_1_ = v_n_17_;
v_a_2_ = v___x_37_;
v_a_4_ = v___x_38_;
goto _start;
}
}
else
{
uint64_t v___x_40_; uint64_t v___x_41_; uint64_t v___x_42_; 
v___x_40_ = 1ULL;
v___x_41_ = lean_uint64_add(v_a_2_, v___x_40_);
v___x_42_ = lean_uint64_add(v_a_3_, v___x_40_);
v_a_1_ = v_n_17_;
v_a_2_ = v___x_41_;
v_a_3_ = v___x_42_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l_branches_go___boxed(lean_object* v_a_44_, lean_object* v_a_45_, lean_object* v_a_46_, lean_object* v_a_47_, lean_object* v_a_48_, lean_object* v_a_49_){
_start:
{
uint64_t v_a_425__boxed_50_; uint64_t v_a_426__boxed_51_; uint64_t v_a_427__boxed_52_; uint64_t v_a_428__boxed_53_; uint64_t v_a_429__boxed_54_; lean_object* v_res_55_; 
v_a_425__boxed_50_ = lean_unbox_uint64(v_a_45_);
lean_dec_ref(v_a_45_);
v_a_426__boxed_51_ = lean_unbox_uint64(v_a_46_);
lean_dec_ref(v_a_46_);
v_a_427__boxed_52_ = lean_unbox_uint64(v_a_47_);
lean_dec_ref(v_a_47_);
v_a_428__boxed_53_ = lean_unbox_uint64(v_a_48_);
lean_dec_ref(v_a_48_);
v_a_429__boxed_54_ = lean_unbox_uint64(v_a_49_);
lean_dec_ref(v_a_49_);
v_res_55_ = l_branches_go(v_a_44_, v_a_425__boxed_50_, v_a_426__boxed_51_, v_a_427__boxed_52_, v_a_428__boxed_53_, v_a_429__boxed_54_);
return v_res_55_;
}
}
LEAN_EXPORT lean_object* l_branches(lean_object* v_n_56_){
_start:
{
uint64_t v___x_57_; lean_object* v___x_58_; 
v___x_57_ = 0ULL;
v___x_58_ = l_branches_go(v_n_56_, v___x_57_, v___x_57_, v___x_57_, v___x_57_, v___x_57_);
return v___x_58_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_59_){
_start:
{
lean_object* v___x_61_; 
v___x_61_ = l_IO_lazyPure___redArg(v_x_59_);
return v___x_61_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_62_, lean_object* v_a_63_){
_start:
{
lean_object* v_res_64_; 
v_res_64_ = l_forceIO___redArg(v_x_62_);
return v_res_64_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_65_, lean_object* v_x_66_){
_start:
{
lean_object* v___x_68_; 
v___x_68_ = l_forceIO___redArg(v_x_66_);
return v___x_68_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_69_, lean_object* v_x_70_, lean_object* v_a_71_){
_start:
{
lean_object* v_res_72_; 
v_res_72_ = l_forceIO(v_00_u03b1_69_, v_x_70_);
return v_res_72_;
}
}
static lean_object* _init_l_main___lam__0___closed__0(void){
_start:
{
lean_object* v___x_73_; lean_object* v___x_74_; 
v___x_73_ = lean_unsigned_to_nat(100000000u);
v___x_74_ = l_branches(v___x_73_);
return v___x_74_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0(lean_object* v_x_75_){
_start:
{
lean_object* v___x_76_; 
v___x_76_ = lean_obj_once(&l_main___lam__0___closed__0, &l_main___lam__0___closed__0_once, _init_l_main___lam__0___closed__0);
return v___x_76_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_77_){
_start:
{
lean_object* v___x_79_; lean_object* v_putStr_80_; lean_object* v___x_81_; 
v___x_79_ = lean_get_stdout();
v_putStr_80_ = lean_ctor_get(v___x_79_, 4);
lean_inc_ref(v_putStr_80_);
lean_dec_ref(v___x_79_);
v___x_81_ = lean_apply_2(v_putStr_80_, v_s_77_, lean_box(0));
return v___x_81_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_82_, lean_object* v_a_83_){
_start:
{
lean_object* v_res_84_; 
v_res_84_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_82_);
return v_res_84_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(lean_object* v_s_85_){
_start:
{
uint32_t v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; 
v___x_87_ = 10;
v___x_88_ = lean_string_push(v_s_85_, v___x_87_);
v___x_89_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_88_);
return v___x_89_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_90_, lean_object* v_a_91_){
_start:
{
lean_object* v_res_92_; 
v_res_92_ = l_IO_println___at___00main_spec__0(v_s_90_);
return v_res_92_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_94_; uint8_t v___x_95_; lean_object* v___x_96_; double v___x_97_; 
v___x_94_ = lean_unsigned_to_nat(1u);
v___x_95_ = 1;
v___x_96_ = lean_unsigned_to_nat(10000000u);
v___x_97_ = l_Float_ofScientific(v___x_96_, v___x_95_, v___x_94_);
return v___x_97_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_101_; lean_object* v___f_102_; lean_object* v___x_103_; lean_object* v_a_104_; lean_object* v_snd_105_; lean_object* v_snd_106_; lean_object* v_fst_107_; lean_object* v_fst_108_; lean_object* v_fst_109_; lean_object* v_snd_110_; lean_object* v___x_111_; lean_object* v___x_112_; double v___x_113_; double v___x_114_; double v___x_115_; lean_object* v___x_116_; lean_object* v___x_117_; lean_object* v___x_118_; lean_object* v___x_119_; 
v___x_101_ = lean_io_mono_nanos_now();
v___f_102_ = ((lean_object*)(l_main___closed__0));
v___x_103_ = l_forceIO___redArg(v___f_102_);
v_a_104_ = lean_ctor_get(v___x_103_, 0);
lean_inc(v_a_104_);
lean_dec_ref(v___x_103_);
v_snd_105_ = lean_ctor_get(v_a_104_, 1);
lean_inc(v_snd_105_);
v_snd_106_ = lean_ctor_get(v_snd_105_, 1);
lean_inc(v_snd_106_);
v_fst_107_ = lean_ctor_get(v_a_104_, 0);
lean_inc(v_fst_107_);
lean_dec(v_a_104_);
v_fst_108_ = lean_ctor_get(v_snd_105_, 0);
lean_inc(v_fst_108_);
lean_dec(v_snd_105_);
v_fst_109_ = lean_ctor_get(v_snd_106_, 0);
lean_inc(v_fst_109_);
v_snd_110_ = lean_ctor_get(v_snd_106_, 1);
lean_inc(v_snd_110_);
lean_dec(v_snd_106_);
v___x_111_ = lean_io_mono_nanos_now();
v___x_112_ = lean_nat_sub(v___x_111_, v___x_101_);
lean_dec(v___x_101_);
lean_dec(v___x_111_);
v___x_113_ = lean_float_of_nat(v___x_112_);
v___x_114_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_115_ = lean_float_div(v___x_113_, v___x_114_);
v___x_116_ = ((lean_object*)(l_main___closed__2));
v___x_117_ = lean_float_to_string(v___x_115_);
v___x_118_ = lean_string_append(v___x_116_, v___x_117_);
lean_dec_ref(v___x_117_);
v___x_119_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_118_);
if (lean_obj_tag(v___x_119_) == 0)
{
uint64_t v___x_120_; lean_object* v___x_121_; lean_object* v___x_122_; lean_object* v___x_123_; lean_object* v___x_124_; uint64_t v___x_125_; lean_object* v___x_126_; lean_object* v___x_127_; lean_object* v___x_128_; lean_object* v___x_129_; uint64_t v___x_130_; lean_object* v___x_131_; lean_object* v___x_132_; lean_object* v___x_133_; lean_object* v___x_134_; uint64_t v___x_135_; lean_object* v___x_136_; lean_object* v___x_137_; lean_object* v___x_138_; lean_object* v___x_139_; 
lean_dec_ref_known(v___x_119_, 1);
v___x_120_ = lean_unbox_uint64(v_fst_107_);
lean_dec(v_fst_107_);
v___x_121_ = lean_uint64_to_nat(v___x_120_);
v___x_122_ = l_Nat_reprFast(v___x_121_);
v___x_123_ = ((lean_object*)(l_main___closed__3));
v___x_124_ = lean_string_append(v___x_122_, v___x_123_);
v___x_125_ = lean_unbox_uint64(v_fst_108_);
lean_dec(v_fst_108_);
v___x_126_ = lean_uint64_to_nat(v___x_125_);
v___x_127_ = l_Nat_reprFast(v___x_126_);
v___x_128_ = lean_string_append(v___x_124_, v___x_127_);
lean_dec_ref(v___x_127_);
v___x_129_ = lean_string_append(v___x_128_, v___x_123_);
v___x_130_ = lean_unbox_uint64(v_fst_109_);
lean_dec(v_fst_109_);
v___x_131_ = lean_uint64_to_nat(v___x_130_);
v___x_132_ = l_Nat_reprFast(v___x_131_);
v___x_133_ = lean_string_append(v___x_129_, v___x_132_);
lean_dec_ref(v___x_132_);
v___x_134_ = lean_string_append(v___x_133_, v___x_123_);
v___x_135_ = lean_unbox_uint64(v_snd_110_);
lean_dec(v_snd_110_);
v___x_136_ = lean_uint64_to_nat(v___x_135_);
v___x_137_ = l_Nat_reprFast(v___x_136_);
v___x_138_ = lean_string_append(v___x_134_, v___x_137_);
lean_dec_ref(v___x_137_);
v___x_139_ = l_IO_println___at___00main_spec__0(v___x_138_);
return v___x_139_;
}
else
{
lean_dec(v_snd_110_);
lean_dec(v_fst_109_);
lean_dec(v_fst_108_);
lean_dec(v_fst_107_);
return v___x_119_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_140_){
_start:
{
lean_object* v_res_141_; 
v_res_141_ = _lean_main();
return v_res_141_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0001__branches(uint8_t builtin) {
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
  res = initialize_0001__branches(1 /* builtin */);
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
