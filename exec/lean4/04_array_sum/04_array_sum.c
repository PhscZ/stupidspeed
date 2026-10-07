// Lean compiler output
// Module: «04_array_sum»
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
lean_object* lean_nat_add(lean_object*, lean_object*);
uint64_t lean_uint64_of_nat(lean_object*);
lean_object* lean_array_push(lean_object*, lean_object*);
lean_object* lean_array_get_borrowed(lean_object*, lean_object*, lean_object*);
uint64_t lean_uint64_add(uint64_t, uint64_t);
lean_object* lean_mk_empty_array_with_capacity(lean_object*);
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
LEAN_EXPORT lean_object* l_fill_go(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_fill(lean_object*);
static const lean_ctor_object l_sum_go___boxed__const__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*0 + 8, .m_other = 0, .m_tag = 0}, .m_objs = {LEAN_SCALAR_PTR_LITERAL(0, 0, 0, 0, 0, 0, 0, 0)}};
LEAN_EXPORT const lean_object* l_sum_go___boxed__const__1 = (const lean_object*)&l_sum_go___boxed__const__1_value;
LEAN_EXPORT uint64_t l_sum_go(lean_object*, lean_object*, lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_sum_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_sum(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_sum___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_main___lam__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static lean_once_cell_t l_main___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__0;
static lean_once_cell_t l_main___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__1;
static lean_once_cell_t l_main___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__2;
static const lean_string_object l_main___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__3 = (const lean_object*)&l_main___closed__3_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT lean_object* l_fill_go(lean_object* v_a_1_, lean_object* v_a_2_, lean_object* v_a_3_){
_start:
{
lean_object* v_zero_4_; uint8_t v_isZero_5_; 
v_zero_4_ = lean_unsigned_to_nat(0u);
v_isZero_5_ = lean_nat_dec_eq(v_a_1_, v_zero_4_);
if (v_isZero_5_ == 1)
{
lean_dec(v_a_2_);
lean_dec(v_a_1_);
return v_a_3_;
}
else
{
lean_object* v_one_6_; lean_object* v_n_7_; lean_object* v___x_8_; uint64_t v___x_9_; lean_object* v___x_10_; lean_object* v___x_11_; 
v_one_6_ = lean_unsigned_to_nat(1u);
v_n_7_ = lean_nat_sub(v_a_1_, v_one_6_);
lean_dec(v_a_1_);
v___x_8_ = lean_nat_add(v_a_2_, v_one_6_);
v___x_9_ = lean_uint64_of_nat(v_a_2_);
lean_dec(v_a_2_);
v___x_10_ = lean_box_uint64(v___x_9_);
v___x_11_ = lean_array_push(v_a_3_, v___x_10_);
v_a_1_ = v_n_7_;
v_a_2_ = v___x_8_;
v_a_3_ = v___x_11_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_fill(lean_object* v_n_13_){
_start:
{
lean_object* v___x_14_; lean_object* v___x_15_; lean_object* v___x_16_; 
v___x_14_ = lean_unsigned_to_nat(0u);
v___x_15_ = lean_mk_empty_array_with_capacity(v_n_13_);
v___x_16_ = l_fill_go(v_n_13_, v___x_14_, v___x_15_);
return v___x_16_;
}
}
LEAN_EXPORT uint64_t l_sum_go(lean_object* v_a_19_, lean_object* v_a_20_, lean_object* v_a_21_, uint64_t v_a_22_){
_start:
{
lean_object* v_zero_23_; uint8_t v_isZero_24_; 
v_zero_23_ = lean_unsigned_to_nat(0u);
v_isZero_24_ = lean_nat_dec_eq(v_a_20_, v_zero_23_);
if (v_isZero_24_ == 1)
{
lean_dec(v_a_21_);
lean_dec(v_a_20_);
return v_a_22_;
}
else
{
lean_object* v_one_25_; lean_object* v_n_26_; lean_object* v___x_27_; lean_object* v___x_28_; lean_object* v___x_29_; uint64_t v___x_30_; uint64_t v___x_31_; 
v_one_25_ = lean_unsigned_to_nat(1u);
v_n_26_ = lean_nat_sub(v_a_20_, v_one_25_);
lean_dec(v_a_20_);
v___x_27_ = lean_nat_add(v_a_21_, v_one_25_);
v___x_28_ = ((lean_object*)(l_sum_go___boxed__const__1));
v___x_29_ = lean_array_get_borrowed(v___x_28_, v_a_19_, v_a_21_);
lean_dec(v_a_21_);
v___x_30_ = lean_unbox_uint64(v___x_29_);
v___x_31_ = lean_uint64_add(v_a_22_, v___x_30_);
v_a_20_ = v_n_26_;
v_a_21_ = v___x_27_;
v_a_22_ = v___x_31_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_sum_go___boxed(lean_object* v_a_33_, lean_object* v_a_34_, lean_object* v_a_35_, lean_object* v_a_36_){
_start:
{
uint64_t v_a_67__boxed_37_; uint64_t v_res_38_; lean_object* v_r_39_; 
v_a_67__boxed_37_ = lean_unbox_uint64(v_a_36_);
lean_dec_ref(v_a_36_);
v_res_38_ = l_sum_go(v_a_33_, v_a_34_, v_a_35_, v_a_67__boxed_37_);
lean_dec_ref(v_a_33_);
v_r_39_ = lean_box_uint64(v_res_38_);
return v_r_39_;
}
}
LEAN_EXPORT uint64_t l_sum(lean_object* v_a_40_, lean_object* v_n_41_){
_start:
{
lean_object* v___x_42_; uint64_t v___x_43_; uint64_t v___x_44_; 
v___x_42_ = lean_unsigned_to_nat(0u);
v___x_43_ = 0ULL;
v___x_44_ = l_sum_go(v_a_40_, v_n_41_, v___x_42_, v___x_43_);
return v___x_44_;
}
}
LEAN_EXPORT lean_object* l_sum___boxed(lean_object* v_a_45_, lean_object* v_n_46_){
_start:
{
uint64_t v_res_47_; lean_object* v_r_48_; 
v_res_47_ = l_sum(v_a_45_, v_n_46_);
lean_dec_ref(v_a_45_);
v_r_48_ = lean_box_uint64(v_res_47_);
return v_r_48_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_49_){
_start:
{
lean_object* v___x_51_; 
v___x_51_ = l_IO_lazyPure___redArg(v_x_49_);
return v___x_51_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_52_, lean_object* v_a_53_){
_start:
{
lean_object* v_res_54_; 
v_res_54_ = l_forceIO___redArg(v_x_52_);
return v_res_54_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_55_, lean_object* v_x_56_){
_start:
{
lean_object* v___x_58_; 
v___x_58_ = l_forceIO___redArg(v_x_56_);
return v___x_58_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_59_, lean_object* v_x_60_, lean_object* v_a_61_){
_start:
{
lean_object* v_res_62_; 
v_res_62_ = l_forceIO(v_00_u03b1_59_, v_x_60_);
return v_res_62_;
}
}
LEAN_EXPORT uint64_t l_main___lam__0(lean_object* v___x_63_, lean_object* v___x_64_, lean_object* v_x_65_){
_start:
{
uint64_t v___x_66_; 
v___x_66_ = l_sum(v___x_63_, v___x_64_);
return v___x_66_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object* v___x_67_, lean_object* v___x_68_, lean_object* v_x_69_){
_start:
{
uint64_t v_res_70_; lean_object* v_r_71_; 
v_res_70_ = l_main___lam__0(v___x_67_, v___x_68_, v_x_69_);
lean_dec_ref(v___x_67_);
v_r_71_ = lean_box_uint64(v_res_70_);
return v_r_71_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_72_){
_start:
{
lean_object* v___x_74_; lean_object* v_putStr_75_; lean_object* v___x_76_; 
v___x_74_ = lean_get_stdout();
v_putStr_75_ = lean_ctor_get(v___x_74_, 4);
lean_inc_ref(v_putStr_75_);
lean_dec_ref(v___x_74_);
v___x_76_ = lean_apply_2(v_putStr_75_, v_s_72_, lean_box(0));
return v___x_76_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_77_, lean_object* v_a_78_){
_start:
{
lean_object* v_res_79_; 
v_res_79_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_77_);
return v_res_79_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_80_){
_start:
{
lean_object* v___x_82_; lean_object* v___x_83_; uint32_t v___x_84_; lean_object* v___x_85_; lean_object* v___x_86_; 
v___x_82_ = lean_uint64_to_nat(v_s_80_);
v___x_83_ = l_Nat_reprFast(v___x_82_);
v___x_84_ = 10;
v___x_85_ = lean_string_push(v___x_83_, v___x_84_);
v___x_86_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_85_);
return v___x_86_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_87_, lean_object* v_a_88_){
_start:
{
uint64_t v_s_boxed_89_; lean_object* v_res_90_; 
v_s_boxed_89_ = lean_unbox_uint64(v_s_87_);
lean_dec_ref(v_s_87_);
v_res_90_ = l_IO_println___at___00main_spec__0(v_s_boxed_89_);
return v_res_90_;
}
}
static lean_object* _init_l_main___closed__0(void){
_start:
{
lean_object* v___x_91_; lean_object* v___x_92_; 
v___x_91_ = lean_unsigned_to_nat(1000000u);
v___x_92_ = l_fill(v___x_91_);
return v___x_92_;
}
}
static lean_object* _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_93_; lean_object* v___x_94_; lean_object* v___f_95_; 
v___x_93_ = lean_unsigned_to_nat(1000000u);
v___x_94_ = lean_obj_once(&l_main___closed__0, &l_main___closed__0_once, _init_l_main___closed__0);
v___f_95_ = lean_alloc_closure((void*)(l_main___lam__0___boxed), 3, 2);
lean_closure_set(v___f_95_, 0, v___x_94_);
lean_closure_set(v___f_95_, 1, v___x_93_);
return v___f_95_;
}
}
static double _init_l_main___closed__2(void){
_start:
{
lean_object* v___x_96_; uint8_t v___x_97_; lean_object* v___x_98_; double v___x_99_; 
v___x_96_ = lean_unsigned_to_nat(1u);
v___x_97_ = 1;
v___x_98_ = lean_unsigned_to_nat(10000000u);
v___x_99_ = l_Float_ofScientific(v___x_98_, v___x_97_, v___x_96_);
return v___x_99_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_102_; lean_object* v___f_103_; lean_object* v___x_104_; lean_object* v_a_105_; lean_object* v___x_106_; lean_object* v___x_107_; double v___x_108_; double v___x_109_; double v___x_110_; lean_object* v___x_111_; lean_object* v___x_112_; lean_object* v___x_113_; lean_object* v___x_114_; 
v___x_102_ = lean_io_mono_nanos_now();
v___f_103_ = lean_obj_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_104_ = l_forceIO___redArg(v___f_103_);
v_a_105_ = lean_ctor_get(v___x_104_, 0);
lean_inc(v_a_105_);
lean_dec_ref(v___x_104_);
v___x_106_ = lean_io_mono_nanos_now();
v___x_107_ = lean_nat_sub(v___x_106_, v___x_102_);
lean_dec(v___x_102_);
lean_dec(v___x_106_);
v___x_108_ = lean_float_of_nat(v___x_107_);
v___x_109_ = lean_float_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_110_ = lean_float_div(v___x_108_, v___x_109_);
v___x_111_ = ((lean_object*)(l_main___closed__3));
v___x_112_ = lean_float_to_string(v___x_110_);
v___x_113_ = lean_string_append(v___x_111_, v___x_112_);
lean_dec_ref(v___x_112_);
v___x_114_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_113_);
if (lean_obj_tag(v___x_114_) == 0)
{
uint64_t v___x_115_; lean_object* v___x_116_; 
lean_dec_ref_known(v___x_114_, 1);
v___x_115_ = lean_unbox_uint64(v_a_105_);
lean_dec(v_a_105_);
v___x_116_ = l_IO_println___at___00main_spec__0(v___x_115_);
return v___x_116_;
}
else
{
lean_dec(v_a_105_);
return v___x_114_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_117_){
_start:
{
lean_object* v_res_118_; 
v_res_118_ = _lean_main();
return v_res_118_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0004__array__sum(uint8_t builtin) {
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
  res = initialize_0004__array__sum(1 /* builtin */);
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
