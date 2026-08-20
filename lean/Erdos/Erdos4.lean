/-
# Erdős Problem 4

> Is it true that every set of n+1 distinct positive integers from {1, 2, ..., 2n} contains a pair with gcd 1?

Reference: https://www.erdosproblems.com/4

This file studies coprimality in dense subsets.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat

-- Subset of {1, 2, ..., 2n} has size n+1
def DenseSubset (n : ℕ) (A : Finset ℕ) : Prop :=
  A.card = n + 1 ∧ ∀ a ∈ A, a ≥ 1 ∧ a ≤ 2 * n

-- A contains coprime pair
def HasCoprimePair (A : Finset ℕ) : Prop :=
  ∃ a b ∈ A, a ≠ b ∧ Nat.gcd a b = 1

-- Erdős coprimality conjecture
theorem dense_subset_has_coprime_pair (n : ℕ) (A : Finset ℕ) (h : DenseSubset n A) :
    HasCoprimePair A := by
  sorry

end Erdos
