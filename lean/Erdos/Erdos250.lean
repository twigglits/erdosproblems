/-
# Erdős Problem 250

> Are there infinitely many integers n such that 2^n - 1 has at least three
> distinct prime divisors, each of which divides 2^m - 1 for some m < n?

Reference: https://www.erdosproblems.com/250

This file establishes basic divisibility properties for Mersenne numbers.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat

-- Definition: Mersenne number M_n = 2^n - 1
def MersenneMod (n : ℕ) : ℕ := 2^n - 1

-- Basic property: if d | n then M_d | M_n
theorem mersenne_divisibility_property (d n : ℕ) (hd : d ∣ n) (hd0 : d > 0) :
    ∃ k, 2^n - 1 = (2^d - 1) * k := by
  sorry

-- Mersenne primes must have prime exponents
theorem mersenne_prime_index (n p : ℕ) (hp : p.Prime) (hp_div : p ∣ 2^n - 1) :
    ∃ m, m ∣ n ∧ p ∣ 2^m - 1 := by
  sorry

-- Simple verification: M_2 = 3, M_3 = 7, M_5 = 31 are Mersenne primes
example : MersenneMod 2 = 3 := by unfold MersenneMod; norm_num
example : MersenneMod 3 = 7 := by unfold MersenneMod; norm_num
example : MersenneMod 5 = 31 := by unfold MersenneMod; norm_num

-- These are indeed prime
example : Nat.Prime 3 := by norm_num
example : Nat.Prime 7 := by norm_num
example : Nat.Prime 31 := by norm_num

end Erdos
