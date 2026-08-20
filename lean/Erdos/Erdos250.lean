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
-- Proof: If d | n, then 2^d ≡ 1 (mod 2^d - 1), so 2^n ≡ 1 (mod 2^d - 1)
-- This requires the geometric series identity: 1 + x + x^2 + ... + x^(m-1) = (x^m - 1)/(x - 1)
theorem mersenne_divisibility_property (d n : ℕ) (hd : d ∣ n) (hd0 : d > 0) :
    ∃ k, 2^n - 1 = (2^d - 1) * k := by
  -- We have d | n, so n = d * m for some m
  obtain ⟨m, hm⟩ := hd
  -- Then 2^n = 2^(d*m) = (2^d)^m
  rw [hm, pow_mul]
  -- Now we use the factorization: x^m - 1 = (x - 1)(1 + x + x^2 + ... + x^(m-1))
  -- For x = 2^d: (2^d)^m - 1 = (2^d - 1) * (1 + 2^d + (2^d)^2 + ... + (2^d)^(m-1))
  use (Finset.range m).sum (fun i => 2^(d * i))
  have sum_geom : (2 ^ d) ^ m - 1 = (2 ^ d - 1) * ((Finset.range m).sum fun i => (2 ^ d) ^ i) := by
    -- `geom_sum_mul` lives in a commutative RING. Over ℕ subtraction truncates, so the
    -- identity has to be proved over ℤ and transferred back using `2 ^ d ≥ 1`.
    sorry
  rw [sum_geom]
  congr 1
  -- `ext` has no extensionality lemma for ℕ; the two sums agree termwise instead,
  -- because `(2 ^ d) ^ i = 2 ^ (d * i)` by `pow_mul`.
  refine Finset.sum_congr rfl ?_
  intro i _
  rw [← pow_mul]

-- If p | M_n, then p divides M_m for some m | n (and m is minimal divisor of n)
-- The `n > 0` hypothesis is REQUIRED and was missing. At `n = 0` the hypothesis reads
-- `p ∣ 2^0 - 1 = 0`, which every `p` satisfies, while the conclusion needs some `m > 0`
-- with `p ∣ 2^m - 1`. Taking `p = 2` breaks it: `2^m - 1` is odd for every `m ≥ 1`.
-- NOTE: the mathematically interesting statement asks for the MINIMAL such `m` (the
-- multiplicative order of 2 mod p). That is strictly stronger than what is stated here.
theorem mersenne_prime_index (n p : ℕ) (hp : p.Prime) (hn : n > 0) (hp_div : p ∣ 2^n - 1) :
    ∃ m, m ∣ n ∧ p ∣ 2^m - 1 ∧ m > 0 := by
  -- By Well-ordering, there exists a minimal divisor m of n with p | 2^m - 1
  -- Such m exists because p | 2^n - 1, and divisors of n form a nonempty set
  -- As stated, the conclusion only asks for SOME divisor `m` of `n` with `p ∣ 2^m - 1`,
  -- and `m = n` already satisfies all three conjuncts. No induction is needed.
  exact ⟨n, dvd_refl n, hp_div, hn⟩

-- Simple verification: M_2 = 3, M_3 = 7, M_5 = 31 are Mersenne primes
example : MersenneMod 2 = 3 := by unfold MersenneMod; norm_num
example : MersenneMod 3 = 7 := by unfold MersenneMod; norm_num
example : MersenneMod 5 = 31 := by unfold MersenneMod; norm_num

-- These are indeed prime
example : Nat.Prime 3 := by norm_num
example : Nat.Prime 7 := by norm_num
example : Nat.Prime 31 := by norm_num

end Erdos
