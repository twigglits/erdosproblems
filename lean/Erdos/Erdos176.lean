/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 176, but the question stated below is NOT that problem.

  Erdős Problem 176 actually asks: N(k,l): discrepancy of +-1 colourings on k-term arithmetic progressions
  This file instead studies:       size of sum-free sets in abelian groups

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 176.
-/
/-
# Erdős Problem 176

> On the size of sum-free sets in abelian groups

Reference: https://www.erdosproblems.com/176
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Sum-free set: no a,b,c in A with a+b=c
def SumFree (A : Set ℕ) : Prop :=
  ∀ a ∈ A, ∀ b ∈ A, a + b ∉ A

-- Maximum size of sum-free set in [1,n]
def MaxSumFreeSize (n : ℕ) : ℕ :=
  sorry  -- Computed as ⌈n/2⌉

-- Theorem: largest sum-free subset is odd numbers or {⌈n/2⌉, ..., n}
theorem sum_free_bound (n : ℕ) :
    MaxSumFreeSize n = (n + 1) / 2 := by
  sorry  -- Optimal: odd numbers in [1,n]

-- Erdős-Ko-Rado / Cauchy-Davenport bounds
theorem sum_free_density (A : Finset ℕ) (h : SumFree A) (h_range : ∀ a ∈ A, a ≤ n) :
    A.card ≤ n / 2 + 1 := by
  sorry  -- Standard bound

end Erdos
