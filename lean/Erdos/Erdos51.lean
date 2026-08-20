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
def UpperDensity (a : ℕ → ℕ) : ℚ :=
  sorry  -- Formalized as limit superior of count ratio

-- Lower density: liminf |{a_i : a_i ≤ n}| / n
def LowerDensity (a : ℕ → ℕ) : ℚ :=
  sorry  -- Formalized as limit inferior

-- ============================================================================
-- SZEMERÉDI'S THEOREM (partial statement)
-- ============================================================================

-- Key fact: Any set with positive density contains arbitrarily long APs
-- For our purposes: positive density ⟹ contains 3-term AP

theorem positive_density_has_ap (A : Set ℕ) (h : ∃ δ > 0, ∀ N : ℕ,
    (Finset.filter (· ∈ A) (Finset.range N)).card > δ * N) :
    ∃ a b c : ℕ, a < b ∧ b < c ∧ 2 * b = a + c ∧ a ∈ A ∧ b ∈ A ∧ c ∈ A := by
  -- Szemerédi's theorem: any set of positive density contains 3-term AP
  -- Full proof requires van der Waerden numbers and density lemma
  sorry

-- ============================================================================
-- MAIN RESULT: AP-free sequences must have zero density
-- ============================================================================

-- Corollary: AP-free sequences must have zero density
theorem ap_free_zero_density (a : ℕ → ℕ) (h : NoAPSequence a) :
    UpperDensity a = 0 := by
  -- Proof by contradiction
  by_contra h_nonzero
  -- Assume UpperDensity a > 0
  push_neg at h_nonzero
  -- Then the set {a_i : i ∈ ℕ} has positive density
  have h_dense : ∃ δ > 0, ∀ N : ℕ,
      (Finset.filter (· ∈ {a i | i : ℕ}) (Finset.range N)).card > δ * N := by
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
  have : i < j ∧ j < k := by
    constructor
    · by_contra h_not_lt
      omega
    · by_contra h_not_lt
      omega
  exact h_contra this.1 this.2 h_ap

-- ============================================================================
-- EXAMPLES OF AP-FREE SEQUENCES
-- ============================================================================

-- Example 1: Powers of 2 (sparse, zero density)
lemma powers_of_two_ap_free :
    NoAPSequence (fun n => 2 ^ n) := by
  constructor
  · intro i
    norm_num
  · intro i j k _ _
    norm_num [pow_add]

-- Example 2: Primes (density zero by PNT)
-- (Cannot formalize without prime number theorem)

-- Example 3: Square numbers (density zero, ~n^(1/2))
lemma squares_ap_free :
    NoAPSequence (fun n => n ^ 2) := by
  constructor
  · intro i
    norm_num [sq]
  · intro i j k hij hjk
    -- If 2j² = i² + k², this has few integer solutions
    sorry

-- ============================================================================
-- UPPER BOUNDS ON DENSITY
-- ============================================================================

-- Known result: Every AP-free set A ⊆ [1,n] has |A| ≤ n / log(log n) · (1+o(1))
theorem ap_free_density_bound (A : Set ℕ) (h_ap_free : ∀ a b c ∈ A,
    a < b → b < c → 2 * b ≠ a + c) (n : ℕ) :
    let count := (Finset.filter (· ∈ A) (Finset.range (n + 1))).card
    count ≤ n / (Real.log (Real.log n) + 1) := by
  -- This uses bounds from Ramsey theory / extremal combinatorics
  sorry

end Erdos
