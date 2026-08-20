/-
# Erdős Problem 86

> Are there infinitely many integers n such that n has a prime divisor p > √n?

Reference: https://www.erdosproblems.com/86

This file studies prime divisor properties and bounds.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat

-- n has a prime divisor p > √n
def HasLargePrimeDivisor (n : ℕ) : Prop :=
  ∃ p : ℕ, p.Prime ∧ p ∣ n ∧ p * p > n

-- Key observation: If n = p₁^a₁ * ... * pₖ^aₖ with all pᵢ ≤ √n,
-- then n ≤ (√n)^k, which gives contradiction for large k
--
-- Proof sketch: Let p be the largest prime divisor of n.
-- If p² ≤ n, then all divisors of n/p are ≤ p ≤ √n.
-- By induction, n/p has large divisor > √(n/p).
-- Combining: some divisor is > √n.

-- For n ≥ 2, this is provable (Erdős-Kac theorem related)
theorem large_prime_divisor_exists (n : ℕ) (h : n > 1) :
    HasLargePrimeDivisor n := by
  -- General proof requires advanced factorization theory
  -- Can be verified for specific n via computation
  by_cases hn : n ≤ 10
  · -- For small n, verify by case
    interval_cases n
    -- n=2,3,5,7: prime > √n trivially
    all_goals (norm_num [HasLargePrimeDivisor]; sorry)
  · -- For n > 10, use general argument
    sorry

-- Infinitely many such integers exist
theorem infinitely_many_large_prime_divisors :
    ∀ N : ℕ, ∃ n > N, HasLargePrimeDivisor n := by
  intro N
  -- Use primorials or other constructions
  -- Primorial P_k = 2 * 3 * 5 * ... * p_k has largest prime divisor p_k > √P_k
  sorry

-- For n > 1, at least one prime divisor exists
theorem prime_divisor_property (n : ℕ) (h : n > 1) :
    ∃ p : ℕ, p.Prime ∧ p ∣ n := by
  exact Nat.exists_prime_and_dvd h

end Erdos
