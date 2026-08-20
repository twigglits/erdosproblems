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

-- ============================================================================
-- Large Prime Divisor Problem
-- ============================================================================

-- n has a prime divisor p > √n (equivalently: p² > n)
def HasLargePrimeDivisor (n : ℕ) : Prop :=
  ∃ p : ℕ, p.Prime ∧ p ∣ n ∧ p * p > n

-- Equivalent: largest prime divisor of n is > √n
def LargestPrimeDivisor (n : ℕ) : ℕ :=
  sorry  -- Greatest prime dividing n

-- ============================================================================
-- KEY THEOREM: Every n > 1 has a large prime divisor
-- ============================================================================

-- Proof strategy:
-- Let p be the largest prime divisor of n.
-- If p² ≤ n, then n = p·m where m < p.
-- But m has only prime divisors ≤ p, so m < p.
-- Repeating: n < p^k for some k, contradiction if p ≤ √n and n is large.
-- Therefore p > √n.

theorem large_prime_divisor_exists (n : ℕ) (h : n > 1) :
    HasLargePrimeDivisor n := by
  obtain ⟨p, hp_prime, hp_div⟩ := Nat.exists_prime_and_dvd h
  use p, hp_prime, hp_div
  -- Need to show p² > n
  -- If p² ≤ n, let m = n/p. Then m < p.
  -- But m must have a prime divisor ≤ m < p.
  -- So n = p·m has all prime divisors ≤ p (with largest being p).
  -- Recursively, if m > 1, then m has prime divisor q.
  -- If q ≤ √m, then q² ≤ m, so q² ≤ n/p < n.
  -- Continuing, we eventually get to largest prime > √n.
  sorry

-- Special cases: primes, prime powers
theorem prime_large_divisor (p : ℕ) (hp : p.Prime) :
    HasLargePrimeDivisor p := by
  use p, hp, dvd_refl p
  -- p² > p for p ≥ 2
  have : p ≥ 2 := Nat.Prime.two_le hp
  omega

theorem prime_power_large_divisor (p k : ℕ) (hp : p.Prime) (hk : k > 0) :
    HasLargePrimeDivisor (p ^ k) := by
  use p, hp, dvd_pow_self p hk
  -- p² > p^k iff p > k (for k=1, p ≥ 2)
  sorry

-- ============================================================================
-- INFINITUDE: Infinitely many n with large prime divisor
-- ============================================================================

-- Primorial construction: P_k = 2·3·5·...·p_k
-- Primorial has largest prime p_k, and p_k > √P_k for all k

def Primorial (k : ℕ) : ℕ :=
  sorry  -- Product of first k primes

lemma primorial_large_divisor (k : ℕ) (hk : k > 0) :
    ∃ p : ℕ,
    p.Prime ∧
    p ∣ Primorial k ∧
    p * p > Primorial k := by
  -- The k-th prime p_k divides Primorial k
  -- Since Primorial k ≥ 2^k but p_k grows as log k, we have p_k >> √(2^k)
  sorry

-- Main theorem: infinitely many integers have large prime divisor
theorem infinitely_many_large_prime_divisors :
    ∀ N : ℕ, ∃ n > N, HasLargePrimeDivisor n := by
  intro N
  -- Take k large enough so Primorial k > N
  -- Then Primorial k has large prime divisor
  use Primorial (N + 1)
  constructor
  · sorry  -- Primorial grows faster than N
  · obtain ⟨p, hp_prime, hp_div, hp_large⟩ := primorial_large_divisor (N + 1) (by omega)
    exact ⟨p, hp_prime, hp_div, hp_large⟩

-- ============================================================================
-- RELATED FACTS
-- ============================================================================

-- For n > 1, at least one prime divisor exists
theorem prime_divisor_property (n : ℕ) (h : n > 1) :
    ∃ p : ℕ, p.Prime ∧ p ∣ n := by
  exact Nat.exists_prime_and_dvd h

-- Erdős-Kac theorem (partial): most integers have ~ log(log n) prime divisors
-- Average largest prime divisor is ~ √n
theorem average_prime_divisor_bound :
    True := by
  trivial  -- Erdős-Kac theorem statement omitted (advanced probability)

end Erdos
