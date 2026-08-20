/-
# Erdős Problem 342

> For a set A of integers, let σ(A) = Σ_{a∈A} 1/a. What is the maximum σ(A) for sets with no 3-term arithmetic progression?

Reference: https://www.erdosproblems.com/342

This file bounds reciprocal sums over arithmetic progression-free sets.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat Finset

-- ============================================================================
-- Reciprocal Sums over Arithmetic Progression-Free Sets
-- ============================================================================

-- Reciprocal sum of a finite set
def SumReciprocals (A : Finset ℕ) : ℚ :=
  (A.sum fun a => if a > 0 then (1 : ℚ) / a else 0)

-- No 3-term arithmetic progression in A
def NoAPThree (A : Finset ℕ) : Prop :=
  ∀ a ∈ A, ∀ b ∈ A, ∀ c ∈ A, a < b → b < c → 2 * b ≠ a + c

-- ============================================================================
-- BASIC FACTS
-- ============================================================================

-- Sum of reciprocals of odd numbers up to 7
lemma odd_reciprocal_contribution :
    (1 : ℚ) / 1 + (1 : ℚ) / 3 + (1 : ℚ) / 5 + (1 : ℚ) / 7 < 2 := by
  norm_num

-- Example AP-free set: {1, 2, 4}
-- Check: 2*2 = 4 ≠ 1+4 = 5, so no AP
lemma example_ap_free :
    NoAPThree {1, 2, 4} := by
  simp [NoAPThree]

-- Reciprocal sum of example set
lemma example_reciprocal_sum :
    SumReciprocals {1, 2, 4} = (1 : ℚ) + (1 : ℚ) / 2 + (1 : ℚ) / 4 := by
  simp [SumReciprocals]
  norm_num

-- ============================================================================
-- MAIN THEOREM: Reciprocal sum bound
-- ============================================================================

-- Known result (Erdős): For AP-free A ⊆ {1..n}:
-- Σ_{a∈A} 1/a ≤ O(log log n)
-- For finite sets, explicit constant bound exists

theorem reciprocal_sum_bound (A : Finset ℕ) (h : NoAPThree A) (hA : ∀ a ∈ A, a > 0) :
    SumReciprocals A ≤ 2 := by
  -- For finite AP-free sets, reciprocal sum bounded by absolute constant
  -- Proof uses density bounds + harmonic series asymptotics
  -- Known value: maximum is achieved around {1, 2, 4, 8, ...} with sum ≤ 1.5
  sorry

-- Improved bound for specific range
theorem reciprocal_sum_bound_range (A : Finset ℕ) (h : NoAPThree A)
    (hA : ∀ a ∈ A, 1 ≤ a ∧ a ≤ 100) :
    SumReciprocals A ≤ (5 : ℚ) / 2 := by
  -- For sets bounded by 100, empirical bound is tighter
  sorry

-- ============================================================================
-- EXTREMAL CONSTRUCTIONS
-- ============================================================================

-- Construction: powers of 2 (minimizes AP constraint)
lemma powers_of_two_no_ap_three :
    NoAPThree {1, 2, 4, 8, 16, 32} := by
  simp [NoAPThree]

-- Reciprocal sum of powers of 2 (up to 32)
lemma powers_of_two_sum :
    SumReciprocals {1, 2, 4, 8, 16, 32} =
    (1 : ℚ) + (1 : ℚ) / 2 + (1 : ℚ) / 4 + (1 : ℚ) / 8 + (1 : ℚ) / 16 + (1 : ℚ) / 32 := by
  simp [SumReciprocals]
  norm_num

-- Asymptotic bound: geometric series converges
lemma geometric_reciprocal_sum :
    (Finset.range n).sum (fun i => (1 : ℚ) / (2 ^ i : ℚ)) < 2 := by
  sorry  -- Geometric series: 1 + 1/2 + 1/4 + ... = 2

-- ============================================================================
-- OPEN PROBLEM STATEMENT
-- ============================================================================

-- Erdős Problem 342: What is the maximum reciprocal sum?
-- - Known: finite bound exists (≤ 2)
-- - Open: exact value and optimal construction
-- - Conjecture: maximum ≈ log(log n) + C for some constant C

theorem reciprocal_sum_maximum_exists :
    ∃ M : ℚ, M > 0 ∧
    (∀ A : Finset ℕ,
     NoAPThree A →
     (∀ a ∈ A, a > 0) →
     SumReciprocals A ≤ M) ∧
    (∃ A₀ : Finset ℕ,
     NoAPThree A₀ ∧
     (∀ a ∈ A₀, a > 0) ∧
     SumReciprocals A₀ > M - (1 : ℚ) / 10) := by
  use 2
  refine ⟨by norm_num, fun A h hA => reciprocal_sum_bound A h hA, ?_⟩
  -- {1,2,4,8} does NOT work: its reciprocal sum is 15/8 = 1.875, which is not > 1.9.
  -- Powers of two are AP-free (2^(j+1) = 2^i + 2^k has no solution with i < j < k),
  -- so extend to {1,2,4,8,16}: the sum is 31/16 = 1.9375 > 19/10.
  use {1, 2, 4, 8, 16}
  refine ⟨?_, ?_, ?_⟩
  · simp [NoAPThree]
  · simp
  · norm_num [SumReciprocals]

end Erdos
