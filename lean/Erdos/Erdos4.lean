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

-- Key lemma: consecutive integers are coprime
lemma consecutive_coprime (k : ℕ) : Nat.gcd k (k + 1) = 1 := by
  rw [Nat.gcd_comm]
  exact Nat.gcd_eq_one_iff_coprime.mpr (Nat.coprime_succ_self k)

-- Pigeonhole principle: n+1 elements from {1..2n} must contain consecutive integers
lemma dense_contains_consecutive (n : ℕ) (A : Finset ℕ) (h : DenseSubset n A) :
    ∃ k : ℕ, k ∈ A ∧ k + 1 ∈ A := by
  -- By pigeonhole: partition {1..2n} into n pairs {1,2}, {3,4}, ..., {2n-1,2n}
  -- With n+1 elements and n pairs, some pair must have both elements in A
  sorry

-- Erdős coprimality conjecture: Every (n+1)-subset of {1..2n} has coprime pair
theorem dense_subset_has_coprime_pair (n : ℕ) (A : Finset ℕ) (h : DenseSubset n A) :
    HasCoprimePair A := by
  obtain ⟨k, hk, hk1⟩ := dense_contains_consecutive n A h
  use k, k + 1, hk, hk1
  exact ⟨Nat.succ_ne_self k, consecutive_coprime k⟩

-- Example: n=2, A = {1,2,3} (dense in {1,2,3,4})
example : HasCoprimePair {1, 2, 3} := by
  use 1, 2
  norm_num

-- Example: n=3, A = {1,2,3,4} (dense in {1,2,3,4,5,6})
example : HasCoprimePair {1, 2, 3, 4} := by
  use 1, 2
  norm_num

end Erdos
