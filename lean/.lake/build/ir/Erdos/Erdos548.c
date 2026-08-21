// Lean compiler output
// Module: Erdos.Erdos548
// Imports: public import Init public meta import Init public import Erdos.Basic
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
LEAN_EXPORT lean_object* lp_erdos_Erdos_ChromaticNumberComplete(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_ChromaticNumberComplete___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxClique(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxClique___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_ChromaticNumberComplete(lean_object* v_n_1_){
_start:
{
lean_inc(v_n_1_);
return v_n_1_;
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_ChromaticNumberComplete___boxed(lean_object* v_n_2_){
_start:
{
lean_object* v_res_3_; 
v_res_3_ = lp_erdos_Erdos_ChromaticNumberComplete(v_n_2_);
lean_dec(v_n_2_);
return v_res_3_;
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxClique(lean_object* v_n_4_){
_start:
{
lean_inc(v_n_4_);
return v_n_4_;
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxClique___boxed(lean_object* v_n_5_){
_start:
{
lean_object* v_res_6_; 
v_res_6_ = lp_erdos_Erdos_MaxClique(v_n_5_);
lean_dec(v_n_5_);
return v_res_6_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Basic(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_erdos_Erdos_Erdos548(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Basic(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
