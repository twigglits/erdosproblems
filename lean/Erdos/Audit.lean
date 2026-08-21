/-
Axiom audit. Every headline theorem must rest only on Lean's standard base
`[propext, Classical.choice, Quot.sound]` — no `sorry`, no `sorryAx`, no custom axiom,
and no `native_decide`.
-/
import Erdos.Erdos389
import Erdos.Erdos396
import Erdos.Erdos727
import Erdos.Erdos458

namespace Erdos

-- Erdős 389
#print axioms erdosStraus_iff_prod
#print axioms erdosStraus_iff_choose
#print axioms erdosStraus_iff_factorization
#print axioms erdosStraus_iff_digits
#print axioms local_condition_iff
#print axioms two_mul_mod_ge_of_erdosStraus
#print axioms not_dvd_of_erdosStraus
#print axioms smooth_of_erdosStraus
#print axioms Solutions.n1
#print axioms Solutions.n11

-- Erdős 396
#print axioms factorization_centralBinom_of_lt_sq
#print axioms le_two_mul_of_block396
#print axioms smooth_of_block396

-- Erdős 727
#print axioms le_of_egrs
#print axioms egrs_iff_factorization
#print axioms k_le_mod_of_egrs
#print axioms not_dvd_of_egrs
#print axioms sq_le_of_dvd_block
#print axioms Solutions.k2
#print axioms Solutions.k4


-- Erdős 458 (added 2026-08-21)
#print axioms Erdos458.gapFactor_mul
#print axioms Erdos458.erdos458_iff
#print axioms Erdos458.log_sub_log_le_one
#print axioms Erdos458.gapFactor_eq_prod
#print axioms Erdos458.contributor_lt
#print axioms Erdos458.erdos458_of_card_le_one
#print axioms Erdos458.mem_contributors_of_sq
#print axioms Erdos458.fails_of_two_prime_squares
#print axioms Erdos458.q_le_two_mul
#print axioms Erdos458.sq_le_pred
#print axioms Erdos458.cube_lt_of_sq_le
#print axioms Erdos458.erdos458_of_card_le_two
#print axioms Erdos458.erdos458_iff_no_two_prime_squares
#print axioms Erdos458.contributors_eq_filter
#print axioms Erdos458.consecutive_nth
#print axioms Erdos458.erdos458_iff_gapFactor
#print axioms Erdos458.erdos458_iff_prod_contributors
#print axioms Erdos458.gapFactor_7_11
#print axioms Erdos458.gapFactor_23_29
#print axioms Erdos458.gapFactor_113_127
#print axioms Erdos458.gapFactor_2179_2203
#print axioms Erdos458.gapFactor_32749_32771
#print axioms Erdos458.sq_gap_gt_of_two_squares
#print axioms Erdos458.erdos458_of_gap_bound
#print axioms Erdos458.erdos458_at_exceptional_gaps

end Erdos
