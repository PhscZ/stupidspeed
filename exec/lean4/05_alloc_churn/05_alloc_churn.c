// Lean compiler output
// Module: «05_alloc_churn»
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
extern lean_object* l_ByteArray_empty;
lean_object* lean_mk_array(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_byte_array_mk(lean_object*);
lean_object* lean_nat_mod(lean_object*, lean_object*);
uint8_t lean_uint8_of_nat(lean_object*);
lean_object* lean_byte_array_set(lean_object*, lean_object*, uint8_t);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_array_set(lean_object*, lean_object*, lean_object*);
uint64_t lean_uint8_to_uint64(uint8_t);
uint64_t lean_uint64_add(uint64_t, uint64_t);
lean_object* lean_byte_array_size(lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* l_outOfBounds___redArg(lean_object*);
uint8_t lean_byte_array_fget(lean_object*, lean_object*);
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
static lean_once_cell_t l_churn_go___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_churn_go___closed__0;
static lean_once_cell_t l_churn_go___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_churn_go___closed__1;
LEAN_EXPORT uint64_t l_churn_go(lean_object*, lean_object*, lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_churn_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_churn___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_churn___closed__0;
LEAN_EXPORT uint64_t l_churn(lean_object*);
LEAN_EXPORT lean_object* l_churn___boxed(lean_object*);
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
static lean_object* _init_l_churn_go___closed__0(void){
_start:
{
uint8_t v___x_1_; lean_object* v___x_2_; lean_object* v___x_3_; lean_object* v___x_4_; 
v___x_1_ = 0;
v___x_2_ = lean_unsigned_to_nat(64u);
v___x_3_ = lean_box(v___x_1_);
v___x_4_ = lean_mk_array(v___x_2_, v___x_3_);
return v___x_4_;
}
}
static lean_object* _init_l_churn_go___closed__1(void){
_start:
{
lean_object* v___x_5_; lean_object* v___x_6_; 
v___x_5_ = lean_obj_once(&l_churn_go___closed__0, &l_churn_go___closed__0_once, _init_l_churn_go___closed__0);
v___x_6_ = lean_byte_array_mk(v___x_5_);
return v___x_6_;
}
}
LEAN_EXPORT uint64_t l_churn_go(lean_object* v_a_7_, lean_object* v_a_8_, lean_object* v_a_9_, uint64_t v_a_10_){
_start:
{
lean_object* v_zero_11_; uint8_t v_isZero_12_; 
v_zero_11_ = lean_unsigned_to_nat(0u);
v_isZero_12_ = lean_nat_dec_eq(v_a_7_, v_zero_11_);
if (v_isZero_12_ == 1)
{
lean_dec_ref(v_a_9_);
lean_dec(v_a_8_);
lean_dec(v_a_7_);
return v_a_10_;
}
else
{
lean_object* v_one_13_; lean_object* v_n_14_; uint8_t v___x_15_; lean_object* v___x_16_; lean_object* v___x_17_; lean_object* v___x_18_; uint8_t v___x_19_; lean_object* v_buf_20_; lean_object* v___x_21_; lean_object* v___x_22_; uint8_t v___y_24_; lean_object* v___x_28_; uint8_t v___x_29_; 
v_one_13_ = lean_unsigned_to_nat(1u);
v_n_14_ = lean_nat_sub(v_a_7_, v_one_13_);
lean_dec(v_a_7_);
v___x_15_ = 0;
v___x_16_ = lean_obj_once(&l_churn_go___closed__1, &l_churn_go___closed__1_once, _init_l_churn_go___closed__1);
v___x_17_ = lean_unsigned_to_nat(256u);
v___x_18_ = lean_nat_mod(v_a_8_, v___x_17_);
v___x_19_ = lean_uint8_of_nat(v___x_18_);
v_buf_20_ = lean_byte_array_set(v___x_16_, v_zero_11_, v___x_19_);
v___x_21_ = lean_nat_add(v_a_8_, v_one_13_);
lean_dec(v_a_8_);
lean_inc_ref(v_buf_20_);
v___x_22_ = lean_array_set(v_a_9_, v___x_18_, v_buf_20_);
lean_dec(v___x_18_);
v___x_28_ = lean_byte_array_size(v_buf_20_);
v___x_29_ = lean_nat_dec_lt(v_zero_11_, v___x_28_);
if (v___x_29_ == 0)
{
lean_object* v___x_30_; lean_object* v___x_31_; uint8_t v___x_32_; 
lean_dec_ref(v_buf_20_);
v___x_30_ = lean_box(v___x_15_);
v___x_31_ = l_outOfBounds___redArg(v___x_30_);
lean_dec(v___x_30_);
v___x_32_ = lean_unbox(v___x_31_);
lean_dec(v___x_31_);
v___y_24_ = v___x_32_;
goto v___jp_23_;
}
else
{
uint8_t v___x_33_; 
v___x_33_ = lean_byte_array_fget(v_buf_20_, v_zero_11_);
lean_dec_ref(v_buf_20_);
v___y_24_ = v___x_33_;
goto v___jp_23_;
}
v___jp_23_:
{
uint64_t v___x_25_; uint64_t v___x_26_; 
v___x_25_ = lean_uint8_to_uint64(v___y_24_);
v___x_26_ = lean_uint64_add(v_a_10_, v___x_25_);
v_a_7_ = v_n_14_;
v_a_8_ = v___x_21_;
v_a_9_ = v___x_22_;
v_a_10_ = v___x_26_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l_churn_go___boxed(lean_object* v_a_34_, lean_object* v_a_35_, lean_object* v_a_36_, lean_object* v_a_37_){
_start:
{
uint64_t v_a_166__boxed_38_; uint64_t v_res_39_; lean_object* v_r_40_; 
v_a_166__boxed_38_ = lean_unbox_uint64(v_a_37_);
lean_dec_ref(v_a_37_);
v_res_39_ = l_churn_go(v_a_34_, v_a_35_, v_a_36_, v_a_166__boxed_38_);
v_r_40_ = lean_box_uint64(v_res_39_);
return v_r_40_;
}
}
static lean_object* _init_l_churn___closed__0(void){
_start:
{
lean_object* v___x_41_; lean_object* v___x_42_; lean_object* v___x_43_; 
v___x_41_ = l_ByteArray_empty;
v___x_42_ = lean_unsigned_to_nat(256u);
v___x_43_ = lean_mk_array(v___x_42_, v___x_41_);
return v___x_43_;
}
}
LEAN_EXPORT uint64_t l_churn(lean_object* v_n_44_){
_start:
{
lean_object* v___x_45_; lean_object* v___x_46_; uint64_t v___x_47_; uint64_t v___x_48_; 
v___x_45_ = lean_unsigned_to_nat(0u);
v___x_46_ = lean_obj_once(&l_churn___closed__0, &l_churn___closed__0_once, _init_l_churn___closed__0);
v___x_47_ = 0ULL;
v___x_48_ = l_churn_go(v_n_44_, v___x_45_, v___x_46_, v___x_47_);
return v___x_48_;
}
}
LEAN_EXPORT lean_object* l_churn___boxed(lean_object* v_n_49_){
_start:
{
uint64_t v_res_50_; lean_object* v_r_51_; 
v_res_50_ = l_churn(v_n_49_);
v_r_51_ = lean_box_uint64(v_res_50_);
return v_r_51_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_52_){
_start:
{
lean_object* v___x_54_; 
v___x_54_ = l_IO_lazyPure___redArg(v_x_52_);
return v___x_54_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_55_, lean_object* v_a_56_){
_start:
{
lean_object* v_res_57_; 
v_res_57_ = l_forceIO___redArg(v_x_55_);
return v_res_57_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_58_, lean_object* v_x_59_){
_start:
{
lean_object* v___x_61_; 
v___x_61_ = l_forceIO___redArg(v_x_59_);
return v___x_61_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_62_, lean_object* v_x_63_, lean_object* v_a_64_){
_start:
{
lean_object* v_res_65_; 
v_res_65_ = l_forceIO(v_00_u03b1_62_, v_x_63_);
return v_res_65_;
}
}
static uint64_t _init_l_main___lam__0___closed__0(void){
_start:
{
lean_object* v___x_66_; uint64_t v___x_67_; 
v___x_66_ = lean_unsigned_to_nat(10000000u);
v___x_67_ = l_churn(v___x_66_);
return v___x_67_;
}
}
LEAN_EXPORT uint64_t l_main___lam__0(lean_object* v_x_68_){
_start:
{
uint64_t v___x_69_; 
v___x_69_ = lean_uint64_once(&l_main___lam__0___closed__0, &l_main___lam__0___closed__0_once, _init_l_main___lam__0___closed__0);
return v___x_69_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0___boxed(lean_object* v_x_70_){
_start:
{
uint64_t v_res_71_; lean_object* v_r_72_; 
v_res_71_ = l_main___lam__0(v_x_70_);
v_r_72_ = lean_box_uint64(v_res_71_);
return v_r_72_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_73_){
_start:
{
lean_object* v___x_75_; lean_object* v_putStr_76_; lean_object* v___x_77_; 
v___x_75_ = lean_get_stdout();
v_putStr_76_ = lean_ctor_get(v___x_75_, 4);
lean_inc_ref(v_putStr_76_);
lean_dec_ref(v___x_75_);
v___x_77_ = lean_apply_2(v_putStr_76_, v_s_73_, lean_box(0));
return v___x_77_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_78_, lean_object* v_a_79_){
_start:
{
lean_object* v_res_80_; 
v_res_80_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_78_);
return v_res_80_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_81_){
_start:
{
lean_object* v___x_83_; lean_object* v___x_84_; uint32_t v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; 
v___x_83_ = lean_uint64_to_nat(v_s_81_);
v___x_84_ = l_Nat_reprFast(v___x_83_);
v___x_85_ = 10;
v___x_86_ = lean_string_push(v___x_84_, v___x_85_);
v___x_87_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_86_);
return v___x_87_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_88_, lean_object* v_a_89_){
_start:
{
uint64_t v_s_boxed_90_; lean_object* v_res_91_; 
v_s_boxed_90_ = lean_unbox_uint64(v_s_88_);
lean_dec_ref(v_s_88_);
v_res_91_ = l_IO_println___at___00main_spec__0(v_s_boxed_90_);
return v_res_91_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_93_; uint8_t v___x_94_; lean_object* v___x_95_; double v___x_96_; 
v___x_93_ = lean_unsigned_to_nat(1u);
v___x_94_ = 1;
v___x_95_ = lean_unsigned_to_nat(10000000u);
v___x_96_ = l_Float_ofScientific(v___x_95_, v___x_94_, v___x_93_);
return v___x_96_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_99_; lean_object* v___f_100_; lean_object* v___x_101_; lean_object* v_a_102_; lean_object* v___x_103_; lean_object* v___x_104_; double v___x_105_; double v___x_106_; double v___x_107_; lean_object* v___x_108_; lean_object* v___x_109_; lean_object* v___x_110_; lean_object* v___x_111_; 
v___x_99_ = lean_io_mono_nanos_now();
v___f_100_ = ((lean_object*)(l_main___closed__0));
v___x_101_ = l_forceIO___redArg(v___f_100_);
v_a_102_ = lean_ctor_get(v___x_101_, 0);
lean_inc(v_a_102_);
lean_dec_ref(v___x_101_);
v___x_103_ = lean_io_mono_nanos_now();
v___x_104_ = lean_nat_sub(v___x_103_, v___x_99_);
lean_dec(v___x_99_);
lean_dec(v___x_103_);
v___x_105_ = lean_float_of_nat(v___x_104_);
v___x_106_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_107_ = lean_float_div(v___x_105_, v___x_106_);
v___x_108_ = ((lean_object*)(l_main___closed__2));
v___x_109_ = lean_float_to_string(v___x_107_);
v___x_110_ = lean_string_append(v___x_108_, v___x_109_);
lean_dec_ref(v___x_109_);
v___x_111_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_110_);
if (lean_obj_tag(v___x_111_) == 0)
{
uint64_t v___x_112_; lean_object* v___x_113_; 
lean_dec_ref_known(v___x_111_, 1);
v___x_112_ = lean_unbox_uint64(v_a_102_);
lean_dec(v_a_102_);
v___x_113_ = l_IO_println___at___00main_spec__0(v___x_112_);
return v___x_113_;
}
else
{
lean_dec(v_a_102_);
return v___x_111_;
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_114_){
_start:
{
lean_object* v_res_115_; 
v_res_115_ = _lean_main();
return v_res_115_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0005__alloc__churn(uint8_t builtin) {
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
  res = initialize_0005__alloc__churn(1 /* builtin */);
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
