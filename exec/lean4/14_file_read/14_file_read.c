// Lean compiler output
// Module: «14_file_read»
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
lean_object* lean_io_prim_handle_read(lean_object*, size_t);
uint8_t l_ByteArray_isEmpty(lean_object*);
lean_object* lean_byte_array_size(lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
size_t lean_usize_of_nat(lean_object*);
uint8_t lean_usize_dec_eq(size_t, size_t);
uint8_t lean_byte_array_uget(lean_object*, size_t);
uint64_t lean_uint8_to_uint64(uint8_t);
uint64_t lean_uint64_add(uint64_t, uint64_t);
size_t lean_usize_add(size_t, size_t);
lean_object* lean_io_mono_nanos_now();
lean_object* lean_io_prim_handle_mk(lean_object*, uint8_t);
lean_object* lean_nat_sub(lean_object*, lean_object*);
double lean_float_of_nat(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
uint64_t lean_uint64_mod(uint64_t, uint64_t);
lean_object* lean_uint64_to_nat(uint64_t);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
LEAN_EXPORT uint64_t l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(lean_object*, size_t, size_t, uint64_t);
LEAN_EXPORT lean_object* l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_sumBytes(lean_object*);
LEAN_EXPORT lean_object* l_sumBytes___boxed(lean_object*);
LEAN_EXPORT lean_object* l_readAll(lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_readAll___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static const lean_string_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "data.bin"};
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static lean_once_cell_t l_main___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__1;
static const lean_string_object l_main___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__2 = (const lean_object*)&l_main___closed__2_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT uint64_t l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(lean_object* v_as_1_, size_t v_i_2_, size_t v_stop_3_, uint64_t v_b_4_){
_start:
{
uint8_t v___x_5_; 
v___x_5_ = lean_usize_dec_eq(v_i_2_, v_stop_3_);
if (v___x_5_ == 0)
{
uint8_t v___x_6_; uint64_t v___x_7_; uint64_t v___x_8_; size_t v___x_9_; size_t v___x_10_; 
v___x_6_ = lean_byte_array_uget(v_as_1_, v_i_2_);
v___x_7_ = lean_uint8_to_uint64(v___x_6_);
v___x_8_ = lean_uint64_add(v_b_4_, v___x_7_);
v___x_9_ = ((size_t)1ULL);
v___x_10_ = lean_usize_add(v_i_2_, v___x_9_);
v_i_2_ = v___x_10_;
v_b_4_ = v___x_8_;
goto _start;
}
else
{
return v_b_4_;
}
}
}
LEAN_EXPORT lean_object* l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0___boxed(lean_object* v_as_12_, lean_object* v_i_13_, lean_object* v_stop_14_, lean_object* v_b_15_){
_start:
{
size_t v_i_boxed_16_; size_t v_stop_boxed_17_; uint64_t v_b_boxed_18_; uint64_t v_res_19_; lean_object* v_r_20_; 
v_i_boxed_16_ = lean_unbox_usize(v_i_13_);
lean_dec(v_i_13_);
v_stop_boxed_17_ = lean_unbox_usize(v_stop_14_);
lean_dec(v_stop_14_);
v_b_boxed_18_ = lean_unbox_uint64(v_b_15_);
lean_dec_ref(v_b_15_);
v_res_19_ = l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(v_as_12_, v_i_boxed_16_, v_stop_boxed_17_, v_b_boxed_18_);
lean_dec_ref(v_as_12_);
v_r_20_ = lean_box_uint64(v_res_19_);
return v_r_20_;
}
}
LEAN_EXPORT uint64_t l_sumBytes(lean_object* v_b_21_){
_start:
{
lean_object* v___x_22_; uint64_t v___x_23_; lean_object* v___x_24_; uint8_t v___x_25_; 
v___x_22_ = lean_unsigned_to_nat(0u);
v___x_23_ = 0ULL;
v___x_24_ = lean_byte_array_size(v_b_21_);
v___x_25_ = lean_nat_dec_lt(v___x_22_, v___x_24_);
if (v___x_25_ == 0)
{
return v___x_23_;
}
else
{
uint8_t v___x_26_; 
v___x_26_ = lean_nat_dec_le(v___x_24_, v___x_24_);
if (v___x_26_ == 0)
{
if (v___x_25_ == 0)
{
return v___x_23_;
}
else
{
size_t v___x_27_; size_t v___x_28_; uint64_t v___x_29_; 
v___x_27_ = ((size_t)0ULL);
v___x_28_ = lean_usize_of_nat(v___x_24_);
v___x_29_ = l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(v_b_21_, v___x_27_, v___x_28_, v___x_23_);
return v___x_29_;
}
}
else
{
size_t v___x_30_; size_t v___x_31_; uint64_t v___x_32_; 
v___x_30_ = ((size_t)0ULL);
v___x_31_ = lean_usize_of_nat(v___x_24_);
v___x_32_ = l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(v_b_21_, v___x_30_, v___x_31_, v___x_23_);
return v___x_32_;
}
}
}
}
LEAN_EXPORT lean_object* l_sumBytes___boxed(lean_object* v_b_33_){
_start:
{
uint64_t v_res_34_; lean_object* v_r_35_; 
v_res_34_ = l_sumBytes(v_b_33_);
lean_dec_ref(v_b_33_);
v_r_35_ = lean_box_uint64(v_res_34_);
return v_r_35_;
}
}
LEAN_EXPORT lean_object* l_readAll(lean_object* v_h_36_, uint64_t v_total_37_){
_start:
{
size_t v___x_39_; lean_object* v___x_40_; 
v___x_39_ = ((size_t)1048576ULL);
v___x_40_ = lean_io_prim_handle_read(v_h_36_, v___x_39_);
if (lean_obj_tag(v___x_40_) == 0)
{
lean_object* v_a_41_; lean_object* v___x_43_; uint8_t v_isShared_44_; uint8_t v_isSharedCheck_53_; 
v_a_41_ = lean_ctor_get(v___x_40_, 0);
v_isSharedCheck_53_ = !lean_is_exclusive(v___x_40_);
if (v_isSharedCheck_53_ == 0)
{
v___x_43_ = v___x_40_;
v_isShared_44_ = v_isSharedCheck_53_;
goto v_resetjp_42_;
}
else
{
lean_inc(v_a_41_);
lean_dec(v___x_40_);
v___x_43_ = lean_box(0);
v_isShared_44_ = v_isSharedCheck_53_;
goto v_resetjp_42_;
}
v_resetjp_42_:
{
uint8_t v___x_45_; 
v___x_45_ = l_ByteArray_isEmpty(v_a_41_);
if (v___x_45_ == 0)
{
uint64_t v___x_46_; uint64_t v___x_47_; 
lean_del_object(v___x_43_);
v___x_46_ = l_sumBytes(v_a_41_);
lean_dec(v_a_41_);
v___x_47_ = lean_uint64_add(v_total_37_, v___x_46_);
v_total_37_ = v___x_47_;
goto _start;
}
else
{
lean_object* v___x_49_; lean_object* v___x_51_; 
lean_dec(v_a_41_);
v___x_49_ = lean_box_uint64(v_total_37_);
if (v_isShared_44_ == 0)
{
lean_ctor_set(v___x_43_, 0, v___x_49_);
v___x_51_ = v___x_43_;
goto v_reusejp_50_;
}
else
{
lean_object* v_reuseFailAlloc_52_; 
v_reuseFailAlloc_52_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_52_, 0, v___x_49_);
v___x_51_ = v_reuseFailAlloc_52_;
goto v_reusejp_50_;
}
v_reusejp_50_:
{
return v___x_51_;
}
}
}
}
else
{
lean_object* v_a_54_; lean_object* v___x_56_; uint8_t v_isShared_57_; uint8_t v_isSharedCheck_61_; 
v_a_54_ = lean_ctor_get(v___x_40_, 0);
v_isSharedCheck_61_ = !lean_is_exclusive(v___x_40_);
if (v_isSharedCheck_61_ == 0)
{
v___x_56_ = v___x_40_;
v_isShared_57_ = v_isSharedCheck_61_;
goto v_resetjp_55_;
}
else
{
lean_inc(v_a_54_);
lean_dec(v___x_40_);
v___x_56_ = lean_box(0);
v_isShared_57_ = v_isSharedCheck_61_;
goto v_resetjp_55_;
}
v_resetjp_55_:
{
lean_object* v___x_59_; 
if (v_isShared_57_ == 0)
{
v___x_59_ = v___x_56_;
goto v_reusejp_58_;
}
else
{
lean_object* v_reuseFailAlloc_60_; 
v_reuseFailAlloc_60_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_60_, 0, v_a_54_);
v___x_59_ = v_reuseFailAlloc_60_;
goto v_reusejp_58_;
}
v_reusejp_58_:
{
return v___x_59_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_readAll___boxed(lean_object* v_h_62_, lean_object* v_total_63_, lean_object* v_a_64_){
_start:
{
uint64_t v_total_boxed_65_; lean_object* v_res_66_; 
v_total_boxed_65_ = lean_unbox_uint64(v_total_63_);
lean_dec_ref(v_total_63_);
v_res_66_ = l_readAll(v_h_62_, v_total_boxed_65_);
lean_dec(v_h_62_);
return v_res_66_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_67_){
_start:
{
lean_object* v___x_69_; lean_object* v_putStr_70_; lean_object* v___x_71_; 
v___x_69_ = lean_get_stdout();
v_putStr_70_ = lean_ctor_get(v___x_69_, 4);
lean_inc_ref(v_putStr_70_);
lean_dec_ref(v___x_69_);
v___x_71_ = lean_apply_2(v_putStr_70_, v_s_67_, lean_box(0));
return v___x_71_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_72_, lean_object* v_a_73_){
_start:
{
lean_object* v_res_74_; 
v_res_74_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_72_);
return v_res_74_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_75_){
_start:
{
lean_object* v___x_77_; lean_object* v___x_78_; uint32_t v___x_79_; lean_object* v___x_80_; lean_object* v___x_81_; 
v___x_77_ = lean_uint64_to_nat(v_s_75_);
v___x_78_ = l_Nat_reprFast(v___x_77_);
v___x_79_ = 10;
v___x_80_ = lean_string_push(v___x_78_, v___x_79_);
v___x_81_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_80_);
return v___x_81_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_82_, lean_object* v_a_83_){
_start:
{
uint64_t v_s_boxed_84_; lean_object* v_res_85_; 
v_s_boxed_84_ = lean_unbox_uint64(v_s_82_);
lean_dec_ref(v_s_82_);
v_res_85_ = l_IO_println___at___00main_spec__0(v_s_boxed_84_);
return v_res_85_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_87_; uint8_t v___x_88_; lean_object* v___x_89_; double v___x_90_; 
v___x_87_ = lean_unsigned_to_nat(1u);
v___x_88_ = 1;
v___x_89_ = lean_unsigned_to_nat(10000000u);
v___x_90_ = l_Float_ofScientific(v___x_89_, v___x_88_, v___x_87_);
return v___x_90_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_93_; lean_object* v___x_94_; uint8_t v___x_95_; lean_object* v___x_96_; 
v___x_93_ = lean_io_mono_nanos_now();
v___x_94_ = ((lean_object*)(l_main___closed__0));
v___x_95_ = 0;
v___x_96_ = lean_io_prim_handle_mk(v___x_94_, v___x_95_);
if (lean_obj_tag(v___x_96_) == 0)
{
lean_object* v_a_97_; uint64_t v___x_98_; lean_object* v___x_99_; 
v_a_97_ = lean_ctor_get(v___x_96_, 0);
lean_inc(v_a_97_);
lean_dec_ref_known(v___x_96_, 1);
v___x_98_ = 0ULL;
v___x_99_ = l_readAll(v_a_97_, v___x_98_);
lean_dec(v_a_97_);
if (lean_obj_tag(v___x_99_) == 0)
{
lean_object* v_a_100_; lean_object* v___x_101_; lean_object* v___x_102_; double v___x_103_; double v___x_104_; double v___x_105_; lean_object* v___x_106_; lean_object* v___x_107_; lean_object* v___x_108_; lean_object* v___x_109_; 
v_a_100_ = lean_ctor_get(v___x_99_, 0);
lean_inc(v_a_100_);
lean_dec_ref_known(v___x_99_, 1);
v___x_101_ = lean_io_mono_nanos_now();
v___x_102_ = lean_nat_sub(v___x_101_, v___x_93_);
lean_dec(v___x_93_);
lean_dec(v___x_101_);
v___x_103_ = lean_float_of_nat(v___x_102_);
v___x_104_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_105_ = lean_float_div(v___x_103_, v___x_104_);
v___x_106_ = ((lean_object*)(l_main___closed__2));
v___x_107_ = lean_float_to_string(v___x_105_);
v___x_108_ = lean_string_append(v___x_106_, v___x_107_);
lean_dec_ref(v___x_107_);
v___x_109_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_108_);
if (lean_obj_tag(v___x_109_) == 0)
{
uint64_t v___x_110_; uint64_t v___x_111_; uint64_t v___x_112_; lean_object* v___x_113_; 
lean_dec_ref_known(v___x_109_, 1);
v___x_110_ = 4294967296ULL;
v___x_111_ = lean_unbox_uint64(v_a_100_);
lean_dec(v_a_100_);
v___x_112_ = lean_uint64_mod(v___x_111_, v___x_110_);
v___x_113_ = l_IO_println___at___00main_spec__0(v___x_112_);
return v___x_113_;
}
else
{
lean_dec(v_a_100_);
return v___x_109_;
}
}
else
{
lean_object* v_a_114_; lean_object* v___x_116_; uint8_t v_isShared_117_; uint8_t v_isSharedCheck_121_; 
lean_dec(v___x_93_);
v_a_114_ = lean_ctor_get(v___x_99_, 0);
v_isSharedCheck_121_ = !lean_is_exclusive(v___x_99_);
if (v_isSharedCheck_121_ == 0)
{
v___x_116_ = v___x_99_;
v_isShared_117_ = v_isSharedCheck_121_;
goto v_resetjp_115_;
}
else
{
lean_inc(v_a_114_);
lean_dec(v___x_99_);
v___x_116_ = lean_box(0);
v_isShared_117_ = v_isSharedCheck_121_;
goto v_resetjp_115_;
}
v_resetjp_115_:
{
lean_object* v___x_119_; 
if (v_isShared_117_ == 0)
{
v___x_119_ = v___x_116_;
goto v_reusejp_118_;
}
else
{
lean_object* v_reuseFailAlloc_120_; 
v_reuseFailAlloc_120_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_120_, 0, v_a_114_);
v___x_119_ = v_reuseFailAlloc_120_;
goto v_reusejp_118_;
}
v_reusejp_118_:
{
return v___x_119_;
}
}
}
}
else
{
lean_object* v_a_122_; lean_object* v___x_124_; uint8_t v_isShared_125_; uint8_t v_isSharedCheck_129_; 
lean_dec(v___x_93_);
v_a_122_ = lean_ctor_get(v___x_96_, 0);
v_isSharedCheck_129_ = !lean_is_exclusive(v___x_96_);
if (v_isSharedCheck_129_ == 0)
{
v___x_124_ = v___x_96_;
v_isShared_125_ = v_isSharedCheck_129_;
goto v_resetjp_123_;
}
else
{
lean_inc(v_a_122_);
lean_dec(v___x_96_);
v___x_124_ = lean_box(0);
v_isShared_125_ = v_isSharedCheck_129_;
goto v_resetjp_123_;
}
v_resetjp_123_:
{
lean_object* v___x_127_; 
if (v_isShared_125_ == 0)
{
v___x_127_ = v___x_124_;
goto v_reusejp_126_;
}
else
{
lean_object* v_reuseFailAlloc_128_; 
v_reuseFailAlloc_128_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_128_, 0, v_a_122_);
v___x_127_ = v_reuseFailAlloc_128_;
goto v_reusejp_126_;
}
v_reusejp_126_:
{
return v___x_127_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_130_){
_start:
{
lean_object* v_res_131_; 
v_res_131_ = _lean_main();
return v_res_131_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0014__file__read(uint8_t builtin) {
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
  res = initialize_0014__file__read(1 /* builtin */);
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
