// Lean compiler output
// Module: Erdos.Erdos519
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
lean_object* lean_nat_sub(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxDegree(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxDegree___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxDegree(lean_object* v_vertices_1_){
_start:
{
lean_object* v___x_2_; lean_object* v___x_3_; 
v___x_2_ = lean_unsigned_to_nat(1u);
v___x_3_ = lean_nat_sub(v_vertices_1_, v___x_2_);
return v___x_3_;
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_MaxDegree___boxed(lean_object* v_vertices_4_){
_start:
{
lean_object* v_res_5_; 
v_res_5_ = lp_erdos_Erdos_MaxDegree(v_vertices_4_);
lean_dec(v_vertices_4_);
return v_res_5_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Basic(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_erdos_Erdos_Erdos519(uint8_t builtin) {
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
