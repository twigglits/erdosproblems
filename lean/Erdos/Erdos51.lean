/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 51, but the question stated below is NOT that problem.

  Erdős Problem 51 actually asks: totients: an infinite A with every a in A a totient, yet n_a/a -> infinity
  This file instead studies:       AP-free sequences have density zero

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 51.
-/
/-
# Erdős Problem 51

> For a sequence of integers a_1 < a_2 < ... with no 3-term arithmetic progression, is the density zero?

Reference: https://www.erdosproblems.com/51

This file studies density of arithmetic progression-free sequences.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat Finset

-- ============================================================================
-- Arithmetic Progression-Free Sequences
-- ============================================================================

-- No 3-term arithmetic progression in sequence a_1 < a_2 < ...
def NoAPSequence (a : ℕ → ℕ) : Prop :=
  -- a is strictly increasing
  (∀ i : ℕ, a i < a (i + 1)) ∧
  -- No three terms form arithmetic progression
  (∀ i j k : ℕ, i < j → j < k → 2 * a j ≠ a i + a k)

-- Upper density: limsup |{a_i : a_i ≤ n}| / n as n → ∞
def UpperDensitySeq (a : ℕ → ℕ) : ℚ :=
  sorry  -- Formalized as limit superior of count ratio

-- Lower density: liminf |{a_i : a_i ≤ n}| / n
def LowerDensitySeq (a : ℕ → ℕ) : ℚ :=
  sorry  -- Formalized as limit inferior

-- ============================================================================
-- SZEMERÉDI'S THEOREM (partial statement)
-- ============================================================================

-- Key fact: Any set with positive density contains arbitrarily long APs
-- For our purposes: positive density ⟹ contains 3-term AP

-- `· ∈ A` is not decidable for a `Set ℕ`, so `Finset.filter` could not elaborate, and the
-- ℕ-valued cardinality was compared against a rational. `Set.ncard` avoids the decidability
-- instance, and the count is cast to ℚ to match `δ * N`.
theorem positive_density_has_ap (A : Set ℕ) (h : ∃ δ : ℚ, δ > 0 ∧ ∀ N : ℕ,
    (((A ∩ {n | n < N}).ncard : ℚ) > δ * N)) :
    ∃ a b c : ℕ, a < b ∧ b < c ∧ 2 * b = a + c ∧ a ∈ A ∧ b ∈ A ∧ c ∈ A := by
  -- Szemerédi's theorem: any set of positive density contains 3-term AP
  -- Full proof requires van der Waerden numbers and density lemma
  sorry

-- ============================================================================
-- MAIN RESULT: AP-free sequences must have zero density
-- ============================================================================

-- Corollary: AP-free sequences must have zero density
theorem ap_free_zero_density (a : ℕ → ℕ) (h : NoAPSequence a) :
    UpperDensitySeq a = 0 := by
  -- Proof by contradiction
  by_contra h_nonzero
  -- Assume UpperDensitySeq a > 0
  push_neg at h_nonzero
  -- Then the set {a_i : i ∈ ℕ} has positive density
  have h_dense : ∃ δ : ℚ, δ > 0 ∧ ∀ N : ℕ,
      ((({a i | i : ℕ} ∩ {n | n < N}).ncard : ℚ) > δ * N) := by
    sorry  -- Convert from density definition
  -- By Szemerédi, this set contains 3-term AP
  obtain ⟨x, y, z, hx_lt_y, hy_lt_z, h_ap, hx_in, hy_in, hz_in⟩ :=
    positive_density_has_ap {a i | i : ℕ} h_dense
  -- But {a_i} is AP-free by hypothesis
  simp at hx_in hy_in hz_in
  obtain ⟨i, rfl⟩ := hx_in
  obtain ⟨j, rfl⟩ := hy_in
  obtain ⟨k, rfl⟩ := hz_in
  -- Now 2 * a j = a i + a k, contradicting NoAPSequence
  have h_contra := h.2 i j k
  -- `omega` cannot recover `i < j` from `a i < a j`; that needs strict monotonicity,
  -- which follows from the pointwise step `a i < a (i+1)` given by `h.1`.
  have hmono : StrictMono a := strictMono_nat_of_lt_succ h.1
  exact h_contra (hmono.lt_iff_lt.mp hx_lt_y) (hmono.lt_iff_lt.mp hy_lt_z) h_ap

-- ============================================================================
-- EXAMPLES OF AP-FREE SEQUENCES
-- ============================================================================

-- Example 1: Powers of 2 (sparse, zero density)
lemma powers_of_two_ap_free :
    NoAPSequence (fun n => 2 ^ n) := by
  constructor
  · -- Strictly increasing: 2^(i+1) = 2 * 2^i > 2^i, since 2^i > 0.
    intro i
    show (2:ℕ) ^ i < 2 ^ (i + 1)
    have hpos : (0:ℕ) < 2 ^ i := pow_pos (by norm_num) i
    have hstep : (2:ℕ) ^ (i + 1) = 2 * 2 ^ i := by rw [pow_succ]; ring
    omega
  · -- No 3-term AP: with i < j < k we have k ≥ j+1, so
    --   2 * 2^j = 2^(j+1) ≤ 2^k < 2^i + 2^k,
    -- because 2^i > 0. So the two sides can never be equal.
    intro i j k _ hjk
    show (2:ℕ) * 2 ^ j ≠ 2 ^ i + 2 ^ k
    have hk : j + 1 ≤ k := hjk
    have hle : (2:ℕ) ^ (j + 1) ≤ 2 ^ k := Nat.pow_le_pow_right (by norm_num) hk
    have hpos : (0:ℕ) < 2 ^ i := pow_pos (by norm_num) i
    have hstep : (2:ℕ) ^ (j + 1) = 2 * 2 ^ j := by rw [pow_succ]; ring
    omega

-- Example 2: Primes (density zero by PNT)
-- (Cannot formalize without prime number theorem)

-- Example 3: Square numbers.
-- CORRECTION: the squares are NOT AP-free, so the original `squares_ap_free` lemma was
-- false. Witness: 1, 25, 49 (that is i = 1, j = 5, k = 7) satisfies 2 * 25 = 50 = 1 + 49.
-- The `sorry` in the original proof concealed this. The true statement is the negation,
-- and unlike the original it is fully proved below.
lemma squares_not_ap_free :
    ¬ NoAPSequence (fun n => n ^ 2) := by
  intro h
  have hcontra := h.2 1 5 7 (by norm_num) (by norm_num)
  norm_num at hcontra

-- ============================================================================
-- UPPER BOUNDS ON DENSITY
-- ============================================================================

-- Known result: Every AP-free set A ⊆ [1,n] has |A| ≤ n / log(log n) · (1+o(1))
-- `∀ a b c ∈ A` is not valid Lean (the `∈` binder takes one variable), `· ∈ A` is not
-- decidable for a `Set`, and a ℕ count cannot be compared to a real bound without a cast.
theorem ap_free_density_bound (A : Set ℕ)
    (h_ap_free : ∀ a ∈ A, ∀ b ∈ A, ∀ c ∈ A, a < b → b < c → 2 * b ≠ a + c) (n : ℕ) :
    (((A ∩ {m | m ≤ n}).ncard : ℝ) ≤ n / (Real.log (Real.log n) + 1)) := by
  -- This uses bounds from Ramsey theory / extremal combinatorics
  sorry

end Erdos
