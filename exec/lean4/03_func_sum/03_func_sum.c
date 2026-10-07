// Lean compiler output
// Module: «03_func_sum»
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
LEAN_EXPORT uint64_t l_addOne(uint64_t);
LEAN_EXPORT lean_object* l_addOne___boxed(lean_object*);
LEAN_EXPORT uint64_t l_funcSum_go(lean_object*, uint64_t, uint64_t);
LEAN_EXPORT lean_object* l_funcSum_go___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_funcSum(lean_object*);
LEAN_EXPORT lean_object* l_funcSum___boxed(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_main___lam__0___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static uint64_t l_main___lam__0___closed__0;
LEAN_EXPORT uint64_t l_main___lam__0(lean_object*);
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static const lean_closure_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)l_main___lam__0___boxed, .m_arity = 1, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static lean_once_cell_t l_main___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__1;
static const lean_string_object l_main___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__2 = (const lean_object*)&l_main___closed__2_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT uint64_t l_addOne(uint64_t v_n_1_){
_start:
{
uint64_t v___x_2_; uint64_t v___x_3_; 
v___x_2_ = 1ULL;
v___x_3_ = lean_uint64_add(v_n_1_, v___x_2_);
return v___x_3_;
}
}
LEAN_EXPORT lean_object* l_addOne___boxed(lean_object* v_n_4_){
_start:
{
uint64_t v_n_boxed_5_; uint64_t v_res_6_; lean_object* v_r_7_; 
v_n_boxed_5_ = lean_unbox_uint64(v_n_4_);
lean_dec_ref(v_n_4_);
v_res_6_ = l_addOne(v_n_boxed_5_);
v_r_7_ = lean_box_uint64(v_res_6_);
return v_r_7_;
}
}
LEAN_EXPORT uint64_t l_funcSum_go(lean_object* v_a_8_, uint64_t v_a_9_, uint64_t v_a_10_){
_start:
{
lean_object* v_zero_11_; uint8_t v_isZero_12_; 
v_zero_11_ = lean_unsigned_to_nat(0u);
v_isZero_12_ = lean_nat_dec_eq(v_a_8_, v_zero_11_);
if (v_isZero_12_ == 1)
{
lean_dec(v_a_8_);
return v_a_10_;
}
else
{
lean_object* v_one_13_; lean_object* v_n_14_; uint64_t v___x_15_; uint64_t v___x_16_; uint64_t v___x_17_; 
v_one_13_ = lean_unsigned_to_nat(1u);
v_n_14_ = lean_nat_sub(v_a_8_, v_one_13_);
lean_dec(v_a_8_);
v___x_15_ = 1ULL;
v___x_16_ = lean_uint64_add(v_a_9_, v___x_15_);
v___x_17_ = l_addOne(v_a_10_);
v_a_8_ = v_n_14_;
v_a_9_ = v___x_16_;
v_a_10_ = v___x_17_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_funcSum_go___boxed(lean_object* v_a_19_, lean_object* v_a_20_, lean_object* v_a_21_){
_start:
{
uint64_t v_a_39__boxed_22_; uint64_t v_a_40__boxed_23_; uint64_t v_res_24_; lean_object* v_r_25_; 
v_a_39__boxed_22_ = lean_unbox_uint64(v_a_20_);
lean_dec_ref(v_a_20_);
v_a_40__boxed_23_ = lean_unbox_uint64(v_a_21_);
lean_dec_ref(v_a_21_);
v_res_24_ = l_funcSum_go(v_a_19_, v_a_39__boxed_22_, v_a_40__boxed_23_);
v_r_25_ = lean_box_uint64(v_res_24_);
return v_r_25_;
}
}
LEAN_EXPORT uint64_t l_funcSum(lean_object* v_n_26_){
_start:
{
uint64_t v___x_27_; uint64_t v___x_28_; 
v___x_27_ = 0ULL;
v___x_28_ = l_funcSum_go(v_n_26_, v___x_27_, v___x_27_);
return v___x_28_;
}
}
LEAN_EXPORT lean_object* l_funcSum___boxed(lean_object* v_n_29_){
_start:
{
uint64_t v_res_30_; lean_object* v_r_31_; 
v_res_30_ = l_funcSum(v_n_29_);
v_r_31_ = lean_box_uint64(v_res_30_);
return v_r_31_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_32_){
_start:
{
lean_object* v___x_34_; 
v___x_34_ = l_IO_lazyPure___redArg(v_x_32_);
return v___x_34_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_35_, lean_object* v_a_36_){
_start:
{
lean_object* v_res_37_; 
v_res_37_ = l_forceIO___redArg(v_x_35_);
return v_res_37_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_38_, lean_object* v_x_39_){
_start:
{
lean_object* v___x_41_; 
v___x_41_ = l_forceIO___redArg(v_x_39_);
return v___x_41_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_42_, lean_object* v_x_43_, lean_object* v_a_44_){
_start:
{
lean_object* v_res_45_; 
v_res_45_ = l_forceIO(v_00_u03b1_42_, v_x_43_);
return v_res_45_;
}
}
static uint64_t _init_l_main___lam__0___closed__0(void){
_start:
{
lean_object* v___x_46_; uint64_t v___x_47_; 
v___x_46_ = lean_unsigned_to_nat(100000000u);
v___x_47_ = l_funcSum(v___x_46_);
return v___x_47_;
}
}
LEAN_EXPORT uint64_t l_main___lam__0(lean_object* v_x_48_){
_start:
{
uint64_t v___x_49_; 
v___x_49_ = lean_uint64_once(&l_main___lam__0___closed__0, &l_main___lam__0___closed__0_once, _init_l_main___lam__0___closed__0);
return v___x_49_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object* v_x_50_){
_start:
{
uint64_t v_res_51_; lean_object* v_r_52_; 
v_res_51_ = l_main___lam__0(v_x_50_);
v_r_52_ = lean_box_uint64(v_res_51_);
return v_r_52_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_53_){
_start:
{
lean_object* v___x_55_; lean_object* v_putStr_56_; lean_object* v___x_57_; 
v___x_55_ = lean_get_stdout();
v_putStr_56_ = lean_ctor_get(v___x_55_, 4);
lean_inc_ref(v_putStr_56_);
lean_dec_ref(v___x_55_);
v___x_57_ = lean_apply_2(v_putStr_56_, v_s_53_, lean_box(0));
return v___x_57_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_58_, lean_object* v_a_59_){
_start:
{
lean_object* v_res_60_; 
v_res_60_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_58_);
return v_res_60_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_61_){
_start:
{
lean_object* v___x_63_; lean_object* v___x_64_; uint32_t v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; 
v___x_63_ = lean_uint64_to_nat(v_s_61_);
v___x_64_ = l_Nat_reprFast(v___x_63_);
v___x_65_ = 10;
v___x_66_ = lean_string_push(v___x_64_, v___x_65_);
v___x_67_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_66_);
return v___x_67_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_68_, lean_object* v_a_69_){
_start:
{
uint64_t v_s_boxed_70_; lean_object* v_res_71_; 
v_s_boxed_70_ = lean_unbox_uint64(v_s_68_);
lean_dec_ref(v_s_68_);
v_res_71_ = l_IO_println___at___00main_spec__0(v_s_boxed_70_);
return v_res_71_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_73_; uint8_t v___x_74_; lean_object* v___x_75_; double v___x_76_; 
v___x_73_ = lean_unsigned_to_nat(1u);
v___x_74_ = 1;
v___x_75_ = lean_unsigned_to_nat(10000000u);
v___x_76_ = l_Float_ofScientific(v___x_75_, v___x_74_, v___x_73_);
return v___x_76_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_79_; lean_object* v___f_80_; lean_object* v___x_81_; lean_object* v_a_82_; lean_object* v___x_83_; lean_object* v___x_84_; double v___x_85_; double v___x_86_; double v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; 
v___x_79_ = lean_io_mono_nanos_now();
v___f_80_ = ((lean_object*)(l_main___closed__0));
v___x_81_ = l_forceIO___redArg(v___f_80_);
v_a_82_ = lean_ctor_get(v___x_81_, 0);
lean_inc(v_a_82_);
lean_dec_ref(v___x_81_);
v___x_83_ = lean_io_mono_nanos_now();
v___x_84_ = lean_nat_sub(v___x_83_, v___x_79_);
lean_dec(v___x_79_);
lean_dec(v___x_83_);
v___x_85_ = lean_float_of_nat(v___x_84_);
v___x_86_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_87_ = lean_float_div(v___x_85_, v___x_86_);
v___x_88_ = ((lean_object*)(l_main___closed__2));
v___x_89_ = lean_float_to_string(v___x_87_);
v___x_90_ = lean_string_append(v___x_88_, v___x_89_);
lean_dec_ref(v___x_89_);
v___x_91_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_90_);
if (lean_obj_tag(v___x_91_) == 0)
{
uint64_t v___x_92_; lean_object* v___x_93_; 
lean_dec_ref_known(v___x_91_, 1);
v___x_92_ = lean_unbox_uint64(v_a_82_);
lean_dec(v_a_82_);
v___x_93_ = l_IO_println___at___00main_spec__0(v___x_92_);
return v___x_93_;
}
else
{
lean_dec(v_a_82_);
return v___x_91_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_94_){
_start:
{
lean_object* v_res_95_; 
v_res_95_ = _lean_main();
return v_res_95_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0003__func__sum(uint8_t builtin) {
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
  res = initialize_0003__func__sum(1 /* builtin */);
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
