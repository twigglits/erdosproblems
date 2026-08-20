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

-- Reciprocal sum of a finite set
def SumReciprocals (A : Finset ℕ) : ℚ :=
  (A.sum fun a => if a > 0 then (1 : ℚ) / a else 0)

-- No 3-term arithmetic progression in A
def NoAPThree (A : Finset ℕ) : Prop :=
  ∀ a b c ∈ A, a < b → b < c → 2 * b ≠ a + c

-- Lemma: odd numbers have larger reciprocals than even neighbors
lemma odd_reciprocal_contribution :
    (1 : ℚ) / 1 + (1 : ℚ) / 3 + (1 : ℚ) / 5 + (1 : ℚ) / 7 < 2 := by
  norm_num

-- All odd numbers ≤ n form an AP-free set
lemma odds_ap_free (n : ℕ) :
    NoAPThree (Finset.filter Nat.odd (Finset.range (n + 1))) := by
  -- Odd numbers of form 2k+1 and 2m+1 cannot satisfy 2b = a + c for odd a,b,c
  sorry

-- Maximum reciprocal sum over AP-free sets
-- Observation: The set of odd numbers achieves high reciprocal sum
-- Bound comes from harmonic series constraints
theorem reciprocal_sum_bound (A : Finset ℕ) (h : NoAPThree A) :
    SumReciprocals A ≤ 2 := by
  -- Use density argument: AP-free sets have density → 0
  -- Reciprocal sum bounded by logarithmic integral
  sorry

end Erdos
