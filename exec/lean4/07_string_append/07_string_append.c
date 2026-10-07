// Lean compiler output
// Module: «07_string_append»
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
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_mono_nanos_now();
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_string_length(lean_object*);
double lean_float_of_nat(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_get_stdout();
LEAN_EXPORT lean_object* l_appendXs_go(lean_object*, lean_object*);
static const lean_string_object l_appendXs___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 1, .m_capacity = 1, .m_length = 0, .m_data = ""};
static const lean_object* l_appendXs___closed__0 = (const lean_object*)&l_appendXs___closed__0_value;
LEAN_EXPORT lean_object* l_appendXs(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_main___lam__0___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___lam__0___closed__0;
static lean_once_cell_t l_main___lam__0___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___lam__0___closed__1;
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
LEAN_EXPORT lean_object* l_appendXs_go(lean_object* v_a_1_, lean_object* v_a_2_){
_start:
{
lean_object* v_zero_3_; uint8_t v_isZero_4_; 
v_zero_3_ = lean_unsigned_to_nat(0u);
v_isZero_4_ = lean_nat_dec_eq(v_a_1_, v_zero_3_);
if (v_isZero_4_ == 1)
{
lean_dec(v_a_1_);
return v_a_2_;
}
else
{
lean_object* v_one_5_; lean_object* v_n_6_; uint32_t v___x_7_; lean_object* v___x_8_; 
v_one_5_ = lean_unsigned_to_nat(1u);
v_n_6_ = lean_nat_sub(v_a_1_, v_one_5_);
lean_dec(v_a_1_);
v___x_7_ = 120;
v___x_8_ = lean_string_push(v_a_2_, v___x_7_);
v_a_1_ = v_n_6_;
v_a_2_ = v___x_8_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_appendXs(lean_object* v_n_11_){
_start:
{
lean_object* v___x_12_; lean_object* v___x_13_; 
v___x_12_ = ((lean_object*)(l_appendXs___closed__0));
v___x_13_ = l_appendXs_go(v_n_11_, v___x_12_);
return v___x_13_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_14_){
_start:
{
lean_object* v___x_16_; 
v___x_16_ = l_IO_lazyPure___redArg(v_x_14_);
return v___x_16_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_17_, lean_object* v_a_18_){
_start:
{
lean_object* v_res_19_; 
v_res_19_ = l_forceIO___redArg(v_x_17_);
return v_res_19_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_20_, lean_object* v_x_21_){
_start:
{
lean_object* v___x_23_; 
v___x_23_ = l_forceIO___redArg(v_x_21_);
return v___x_23_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_24_, lean_object* v_x_25_, lean_object* v_a_26_){
_start:
{
lean_object* v_res_27_; 
v_res_27_ = l_forceIO(v_00_u03b1_24_, v_x_25_);
return v_res_27_;
}
}
static lean_object* _init_l_main___lam__0___closed__0(void){
_start:
{
lean_object* v___x_28_; lean_object* v___x_29_; 
v___x_28_ = lean_unsigned_to_nat(250000u);
v___x_29_ = l_appendXs(v___x_28_);
return v___x_29_;
}
}
static lean_object* _init_l_main___lam__0___closed__1(void){
_start:
{
lean_object* v___x_30_; lean_object* v___x_31_; 
v___x_30_ = lean_obj_once(&l_main___lam__0___closed__0, &l_main___lam__0___closed__0_once, _init_l_main___lam__0___closed__0);
v___x_31_ = lean_string_length(v___x_30_);
return v___x_31_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0(lean_object* v_x_32_){
_start:
{
lean_object* v___x_33_; 
v___x_33_ = lean_obj_once(&l_main___lam__0___closed__1, &l_main___lam__0___closed__1_once, _init_l_main___lam__0___closed__1);
return v___x_33_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_34_){
_start:
{
lean_object* v___x_36_; lean_object* v_putStr_37_; lean_object* v___x_38_; 
v___x_36_ = lean_get_stdout();
v_putStr_37_ = lean_ctor_get(v___x_36_, 4);
lean_inc_ref(v_putStr_37_);
lean_dec_ref(v___x_36_);
v___x_38_ = lean_apply_2(v_putStr_37_, v_s_34_, lean_box(0));
return v___x_38_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_39_, lean_object* v_a_40_){
_start:
{
lean_object* v_res_41_; 
v_res_41_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_39_);
return v_res_41_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(lean_object* v_s_42_){
_start:
{
lean_object* v___x_44_; uint32_t v___x_45_; lean_object* v___x_46_; lean_object* v___x_47_; 
v___x_44_ = l_Nat_reprFast(v_s_42_);
v___x_45_ = 10;
v___x_46_ = lean_string_push(v___x_44_, v___x_45_);
v___x_47_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_46_);
return v___x_47_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_48_, lean_object* v_a_49_){
_start:
{
lean_object* v_res_50_; 
v_res_50_ = l_IO_println___at___00main_spec__0(v_s_48_);
return v_res_50_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_52_; uint8_t v___x_53_; lean_object* v___x_54_; double v___x_55_; 
v___x_52_ = lean_unsigned_to_nat(1u);
v___x_53_ = 1;
v___x_54_ = lean_unsigned_to_nat(10000000u);
v___x_55_ = l_Float_ofScientific(v___x_54_, v___x_53_, v___x_52_);
return v___x_55_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_58_; lean_object* v___f_59_; lean_object* v___x_60_; lean_object* v_a_61_; lean_object* v___x_62_; lean_object* v___x_63_; double v___x_64_; double v___x_65_; double v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; lean_object* v___x_70_; 
v___x_58_ = lean_io_mono_nanos_now();
v___f_59_ = ((lean_object*)(l_main___closed__0));
v___x_60_ = l_forceIO___redArg(v___f_59_);
v_a_61_ = lean_ctor_get(v___x_60_, 0);
lean_inc(v_a_61_);
lean_dec_ref(v___x_60_);
v___x_62_ = lean_io_mono_nanos_now();
v___x_63_ = lean_nat_sub(v___x_62_, v___x_58_);
lean_dec(v___x_58_);
lean_dec(v___x_62_);
v___x_64_ = lean_float_of_nat(v___x_63_);
v___x_65_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_66_ = lean_float_div(v___x_64_, v___x_65_);
v___x_67_ = ((lean_object*)(l_main___closed__2));
v___x_68_ = lean_float_to_string(v___x_66_);
v___x_69_ = lean_string_append(v___x_67_, v___x_68_);
lean_dec_ref(v___x_68_);
v___x_70_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_69_);
if (lean_obj_tag(v___x_70_) == 0)
{
lean_object* v___x_71_; 
lean_dec_ref_known(v___x_70_, 1);
v___x_71_ = l_IO_println___at___00main_spec__0(v_a_61_);
return v___x_71_;
}
else
{
lean_dec(v_a_61_);
return v___x_70_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_72_){
_start:
{
lean_object* v_res_73_; 
v_res_73_ = _lean_main();
return v_res_73_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0007__string__append(uint8_t builtin) {
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
  res = initialize_0007__string__append(1 /* builtin */);
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
