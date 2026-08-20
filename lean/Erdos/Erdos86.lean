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
theorem large_prime_divisor_exists (n : ℕ) (h : n > 1) :
    HasLargePrimeDivisor n := by
  -- Consider the factorization of n
  -- If all prime divisors p satisfy p² ≤ n, then n ≤ product of all such p
  -- But this leads to bounded factorizations
  -- Therefore, some prime divisor must satisfy p² > n
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
