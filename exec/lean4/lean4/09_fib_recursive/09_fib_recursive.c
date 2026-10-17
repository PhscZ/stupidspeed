// Lean compiler output
// Module: «09_fib_recursive»
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
LEAN_EXPORT uint64_t l_fib(lean_object*);
LEAN_EXPORT lean_object* l_fib___boxed(lean_object*);
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
LEAN_EXPORT uint64_t l_fib(lean_object* v_x_1_){
_start:
{
lean_object* v_zero_2_; uint8_t v_isZero_3_; 
v_zero_2_ = lean_unsigned_to_nat(0u);
v_isZero_3_ = lean_nat_dec_eq(v_x_1_, v_zero_2_);
if (v_isZero_3_ == 1)
{
uint64_t v___x_4_; 
v___x_4_ = 0ULL;
return v___x_4_;
}
else
{
lean_object* v_one_5_; lean_object* v_n_6_; uint8_t v_isZero_7_; 
v_one_5_ = lean_unsigned_to_nat(1u);
v_n_6_ = lean_nat_sub(v_x_1_, v_one_5_);
v_isZero_7_ = lean_nat_dec_eq(v_n_6_, v_zero_2_);
if (v_isZero_7_ == 1)
{
uint64_t v___x_8_; 
lean_dec(v_n_6_);
v___x_8_ = 1ULL;
return v___x_8_;
}
else
{
lean_object* v_n_9_; lean_object* v___x_10_; uint64_t v___x_11_; uint64_t v___x_12_; uint64_t v___x_13_; 
v_n_9_ = lean_nat_sub(v_n_6_, v_one_5_);
lean_dec(v_n_6_);
v___x_10_ = lean_nat_add(v_n_9_, v_one_5_);
v___x_11_ = l_fib(v___x_10_);
lean_dec(v___x_10_);
v___x_12_ = l_fib(v_n_9_);
lean_dec(v_n_9_);
v___x_13_ = lean_uint64_add(v___x_11_, v___x_12_);
return v___x_13_;
}
}
}
}
LEAN_EXPORT lean_object* l_fib___boxed(lean_object* v_x_14_){
_start:
{
uint64_t v_res_15_; lean_object* v_r_16_; 
v_res_15_ = l_fib(v_x_14_);
lean_dec(v_x_14_);
v_r_16_ = lean_box_uint64(v_res_15_);
return v_r_16_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_17_){
_start:
{
lean_object* v___x_19_; 
v___x_19_ = l_IO_lazyPure___redArg(v_x_17_);
return v___x_19_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_20_, lean_object* v_a_21_){
_start:
{
lean_object* v_res_22_; 
v_res_22_ = l_forceIO___redArg(v_x_20_);
return v_res_22_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_23_, lean_object* v_x_24_){
_start:
{
lean_object* v___x_26_; 
v___x_26_ = l_forceIO___redArg(v_x_24_);
return v___x_26_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_27_, lean_object* v_x_28_, lean_object* v_a_29_){
_start:
{
lean_object* v_res_30_; 
v_res_30_ = l_forceIO(v_00_u03b1_27_, v_x_28_);
return v_res_30_;
}
}
static uint64_t _init_l_main___lam__0___closed__0(void){
_start:
{
lean_object* v___x_31_; uint64_t v___x_32_; 
v___x_31_ = lean_unsigned_to_nat(40u);
v___x_32_ = l_fib(v___x_31_);
return v___x_32_;
}
}
LEAN_EXPORT uint64_t l_main___lam__0(lean_object* v_x_33_){
_start:
{
uint64_t v___x_34_; 
v___x_34_ = lean_uint64_once(&l_main___lam__0___closed__0, &l_main___lam__0___closed__0_once, _init_l_main___lam__0___closed__0);
return v___x_34_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object* v_x_35_){
_start:
{
uint64_t v_res_36_; lean_object* v_r_37_; 
v_res_36_ = l_main___lam__0(v_x_35_);
v_r_37_ = lean_box_uint64(v_res_36_);
return v_r_37_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_38_){
_start:
{
lean_object* v___x_40_; lean_object* v_putStr_41_; lean_object* v___x_42_; 
v___x_40_ = lean_get_stdout();
v_putStr_41_ = lean_ctor_get(v___x_40_, 4);
lean_inc_ref(v_putStr_41_);
lean_dec_ref(v___x_40_);
v___x_42_ = lean_apply_2(v_putStr_41_, v_s_38_, lean_box(0));
return v___x_42_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_43_, lean_object* v_a_44_){
_start:
{
lean_object* v_res_45_; 
v_res_45_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_43_);
return v_res_45_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_46_){
_start:
{
lean_object* v___x_48_; lean_object* v___x_49_; uint32_t v___x_50_; lean_object* v___x_51_; lean_object* v___x_52_; 
v___x_48_ = lean_uint64_to_nat(v_s_46_);
v___x_49_ = l_Nat_reprFast(v___x_48_);
v___x_50_ = 10;
v___x_51_ = lean_string_push(v___x_49_, v___x_50_);
v___x_52_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_51_);
return v___x_52_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_53_, lean_object* v_a_54_){
_start:
{
uint64_t v_s_boxed_55_; lean_object* v_res_56_; 
v_s_boxed_55_ = lean_unbox_uint64(v_s_53_);
lean_dec_ref(v_s_53_);
v_res_56_ = l_IO_println___at___00main_spec__0(v_s_boxed_55_);
return v_res_56_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_58_; uint8_t v___x_59_; lean_object* v___x_60_; double v___x_61_; 
v___x_58_ = lean_unsigned_to_nat(1u);
v___x_59_ = 1;
v___x_60_ = lean_unsigned_to_nat(10000000u);
v___x_61_ = l_Float_ofScientific(v___x_60_, v___x_59_, v___x_58_);
return v___x_61_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_64_; lean_object* v___f_65_; lean_object* v___x_66_; lean_object* v_a_67_; lean_object* v___x_68_; lean_object* v___x_69_; double v___x_70_; double v___x_71_; double v___x_72_; lean_object* v___x_73_; lean_object* v___x_74_; lean_object* v___x_75_; lean_object* v___x_76_; 
v___x_64_ = lean_io_mono_nanos_now();
v___f_65_ = ((lean_object*)(l_main___closed__0));
v___x_66_ = l_forceIO___redArg(v___f_65_);
v_a_67_ = lean_ctor_get(v___x_66_, 0);
lean_inc(v_a_67_);
lean_dec_ref(v___x_66_);
v___x_68_ = lean_io_mono_nanos_now();
v___x_69_ = lean_nat_sub(v___x_68_, v___x_64_);
lean_dec(v___x_64_);
lean_dec(v___x_68_);
v___x_70_ = lean_float_of_nat(v___x_69_);
v___x_71_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_72_ = lean_float_div(v___x_70_, v___x_71_);
v___x_73_ = ((lean_object*)(l_main___closed__2));
v___x_74_ = lean_float_to_string(v___x_72_);
v___x_75_ = lean_string_append(v___x_73_, v___x_74_);
lean_dec_ref(v___x_74_);
v___x_76_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_75_);
if (lean_obj_tag(v___x_76_) == 0)
{
uint64_t v___x_77_; lean_object* v___x_78_; 
lean_dec_ref_known(v___x_76_, 1);
v___x_77_ = lean_unbox_uint64(v_a_67_);
lean_dec(v_a_67_);
v___x_78_ = l_IO_println___at___00main_spec__0(v___x_77_);
return v___x_78_;
}
else
{
lean_dec(v_a_67_);
return v___x_76_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_79_){
_start:
{
lean_object* v_res_80_; 
v_res_80_ = _lean_main();
return v_res_80_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0009__fib__recursive(uint8_t builtin) {
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
  res = initialize_0009__fib__recursive(1 /* builtin */);
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
