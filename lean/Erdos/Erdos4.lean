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
-- Proof strategy: Partition {1..2n} into n pairs {1,2}, {3,4}, ..., {2n-1,2n}
-- By pigeonhole, with n+1 elements and n pairs, some pair must have both elements

-- ============================================================================
-- PIGEONHOLE PRINCIPLE: Consecutive integers in dense subset
-- ============================================================================

-- For small n, direct verification
-- n=0: Note that DenseSubset 0 A means |A|=1 and A ⊆ {1}
-- Since {1} has only one element and |A|=1, we can't have both k and k+1
-- n=1: DenseSubset 1 A means |A|=2 and A ⊆ {1,2}, so A = {1,2}, giving consecutive 1,2
-- n=2: DenseSubset 2 A means |A|=3 and A ⊆ {1,2,3,4}; pigeonhole gives consecutive pair
lemma dense_contains_consecutive_small (n : ℕ) (A : Finset ℕ) (h : DenseSubset n A) (hn : n ≤ 2) :
    n = 0 ∨ (∃ k : ℕ, k ∈ A ∧ k + 1 ∈ A) := by
  interval_cases n
  -- n=0: A ⊆ {1} with |A|=1
  · left; rfl
  -- n=1: A ⊆ {1,2} with |A|=2, must be {1,2}
  · right
    obtain ⟨hcard, hrange⟩ := h
    -- A has exactly 2 elements, all in [1,2]
    -- The only 2-element subset of {1,2} is {1,2} itself
    have h_card_two : A.card = 2 := by simp [DenseSubset] at h; exact h.1
    have h_range : ∀ a ∈ A, 1 ≤ a ∧ a ≤ 2 := by
      intro a ha
      simp [DenseSubset] at h
      exact h.2 a ha
    -- Need both 1 and 2 in A (only way to have 2 distinct elements in {1,2})
    have h1 : 1 ∈ A := by
      by_contra h1_not
      -- If 1 ∉ A, then A ⊆ {2}, so |A| ≤ 1, contradicting |A|=2
      have : A ⊆ {2} := by
        intro a ha
        have := h_range a ha
        by_contra h_ne_1
        simp at h_ne_1
        have : a = 2 := by omega
        simp [this]
      have : A.card ≤ 1 := Finset.card_le_one.mpr (fun a b ha hb => by
        simp [Finset.subset_singleton_iff_singleton] at this
        sorry)
      omega
    have h2 : 2 ∈ A := by
      by_contra h2_not
      -- If 2 ∉ A, then A ⊆ {1}, so |A| ≤ 1, contradicting |A|=2
      have : A ⊆ {1} := by
        intro a ha
        have := h_range a ha
        by_contra h_ne_2
        simp at h_ne_2
        have : a = 1 := by omega
        simp [this]
      sorry  -- Similar contradiction
    use 1
    exact ⟨h1, h2⟩
  -- n=2: A ⊆ {1,2,3,4} with |A|=3
  -- Pigeonhole: partition into pairs {1,2}, {3,4}; 3 elements must complete one pair
  · right
    obtain ⟨hcard, hrange⟩ := h
    have h_card_three : A.card = 3 := by simp [DenseSubset] at h; exact h.1
    -- Partition logic: 3 elements from 4, partition into 2 pairs
    -- At least one pair must be complete
    -- This requires careful case analysis or a pigeonhole lemma
    sorry  -- Requires formalized pigeonhole lemma

-- ============================================================================
-- GENERAL CASE: Pigeonhole principle for all n
-- ============================================================================

-- Key lemma: n+1 elements from {1..2n} must include consecutive integers
-- Proof: Partition {1..2n} into n pairs: {1,2}, {3,4}, ..., {2n-1,2n}
-- With n+1 elements and n pairs, pigeonhole guarantees at least one complete pair
lemma dense_contains_consecutive (n : ℕ) (A : Finset ℕ) (h : DenseSubset n A) :
    n = 0 ∨ (∃ k : ℕ, k ∈ A ∧ k + 1 ∈ A) := by
  by_cases hn : n = 0
  · left; exact hn
  · right
    -- For n > 0: use pigeonhole on partition into n pairs
    -- A has n+1 elements, partition {1..2n} has n pairs
    -- By pigeonhole, some pair {k, k+1} must be completely in A
    push_neg at hn
    have n_pos : n > 0 := Nat.pos_of_ne_zero hn
    sorry

-- ============================================================================
-- MAIN THEOREM: Coprimality
-- ============================================================================

-- ============================================================================
-- MAIN RESULT: Erdős Coprimality Theorem
-- ============================================================================

-- Theorem: Every (n+1)-subset of {1..2n} contains a coprime pair
-- Proof Strategy:
-- 1. Use pigeonhole to find consecutive integers k and k+1 in A
-- 2. Apply consecutive_coprime lemma: gcd(k, k+1) = 1
-- 3. Conclude k and k+1 form a coprime pair

theorem dense_subset_has_coprime_pair (n : ℕ) (A : Finset ℕ) (h : DenseSubset n A) :
    n = 0 ∨ HasCoprimePair A := by
  obtain h_consecutive := dense_contains_consecutive n A h
  cases h_consecutive with
  | inl h0 =>
    -- n = 0 case: trivial (but doesn't guarantee coprime pair in empty A)
    left; exact h0
  | inr h_consecutive =>
    -- n > 0: found consecutive k and k+1
    right
    obtain ⟨k, hk, hk1⟩ := h_consecutive
    use k, k + 1, hk, hk1
    refine ⟨Nat.succ_ne_self k, consecutive_coprime k⟩

-- Simplified version: for n ≥ 1, always has coprime pair
theorem dense_subset_has_coprime_pair_pos (n : ℕ) (A : Finset ℕ) (h : DenseSubset n A) (hn : n > 0) :
    HasCoprimePair A := by
  obtain h_consecutive := dense_contains_consecutive n A h
  cases h_consecutive with
  | inl h0 => -- n = 0, contradicts hn
    have : n ≠ 0 := Nat.pos_iff_ne_zero.mp hn
    contradiction
  | inr h_consecutive =>
    -- Found consecutive k and k+1
    obtain ⟨k, hk, hk1⟩ := h_consecutive
    use k, k + 1, hk, hk1
    exact ⟨Nat.succ_ne_self k, consecutive_coprime k⟩

-- ============================================================================
-- VERIFICATION EXAMPLES
-- ============================================================================

-- Example 1: n=1, A = {1,2}
example : HasCoprimePair {1, 2} := by
  use 1, 2
  norm_num [HasCoprimePair]

-- Example 2: n=2, A = {1,2,3}
example : HasCoprimePair {1, 2, 3} := by
  use 1, 2
  norm_num [HasCoprimePair]

-- Example 3: n=3, A = {1,2,3,4}
example : HasCoprimePair {1, 2, 3, 4} := by
  use 1, 2
  norm_num [HasCoprimePair]

-- Example 4: Arbitrary dense subset n=2
example : DenseSubset 2 {2, 3, 4} := by
  simp [DenseSubset]

example : HasCoprimePair {2, 3, 4} := by
  use 2, 3
  norm_num [HasCoprimePair]

end Erdos
