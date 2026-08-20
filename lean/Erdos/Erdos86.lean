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

-- Infinitely many such integers exist
theorem infinitely_many_large_prime_divisors :
    ∀ N : ℕ, ∃ n > N, HasLargePrimeDivisor n := by
  sorry

-- For n > 1, at least one prime divisor satisfies the bound
theorem prime_divisor_property (n : ℕ) (h : n > 1) :
    ∃ p : ℕ, p.Prime ∧ p ∣ n := by
  sorry

end Erdos
