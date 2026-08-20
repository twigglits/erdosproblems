// Lean compiler output
// Module: Erdos
// Imports: public import Init public meta import Init public import Erdos.Basic public import Erdos.Erdos162 public import Erdos.Erdos213 public import Erdos.Erdos250 public import Erdos.Erdos389 public import Erdos.Erdos396 public import Erdos.Erdos441 public import Erdos.Erdos519 public import Erdos.Erdos548 public import Erdos.Erdos727 public import Erdos.Audit
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
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Basic(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos162(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos213(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos250(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos389(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos396(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos441(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos519(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos548(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos727(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Audit(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_erdos_Erdos(uint8_t builtin) {
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
res = initialize_erdos_Erdos_Erdos162(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos213(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos250(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos389(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos396(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos441(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos519(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos548(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos727(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Audit(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
