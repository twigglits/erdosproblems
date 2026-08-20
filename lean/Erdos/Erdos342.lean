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

-- Maximum reciprocal sum over AP-free sets
theorem reciprocal_sum_bound (A : Finset ℕ) (h : NoAPThree A) :
    SumReciprocals A ≤ 2 := by
  sorry

end Erdos
