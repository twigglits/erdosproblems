/-
# Erdős Problem 632

> For a prime p, is the largest prime factor of n^2 - 1 asymptotically at least some positive power of n?

Reference: https://www.erdosproblems.com/632

This file studies largest prime divisors of polynomial values.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat

-- Largest prime divisor of n
def LargestPrimeDivisor (n : ℕ) : ℕ :=
  if n ≤ 1 then 1
  else Finset.max' (Finset.filter Nat.Prime (Finset.divisors n)) (sorry : ∃ x ∈ Finset.filter Nat.Prime (Finset.divisors n), True)

-- Largest prime factor grows with n
theorem lpf_polynomial_growth (n : ℕ) (h : n > 1) :
    LargestPrimeDivisor (n^2 - 1) > n := by
  sorry

end Erdos
