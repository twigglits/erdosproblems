/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 213, but the question stated below is NOT that problem.

  Erdős Problem 213 actually asks: n points in R^2, no 3 on a line, no 4 on a circle, all distances integers
  This file instead studies:       maximum of sigma(n)/n^eps

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 213.
-/
/-
# Erdős Problem 213

> What is the maximum value of σ(n)/n^ε where σ(n) is sum of divisors?
> Develop bounds on highly composite number ratios.

Reference: https://www.erdosproblems.com/213

This file proves bounds on divisor sum functions.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat

-- Sum of divisors function σ(n)
def SigmaSum (n : ℕ) : ℕ :=
  match n with
  | 0 => 0
  | n + 1 => (Finset.range (n + 2)).sum (fun d => if d ∣ (n + 1) then d else 0)

-- Highly composite number: σ(n)/n ratio is larger than for all smaller m
def HighlyComposite (n : ℕ) : Prop :=
  ∀ m < n, (SigmaSum m : ℚ) / m < (SigmaSum n : ℚ) / n

-- Basic property: σ(1) = 1
example : SigmaSum 1 = 1 := by
  unfold SigmaSum
  -- SigmaSum 1 = (Finset.range 2).sum (fun d => if d ∣ 1 then d else 0)
  -- Finset.range 2 = {0, 1}, and only 1 divides 1
  simp [Finset.sum_range_succ]

-- σ(6) = 1 + 2 + 3 + 6 = 12
example : SigmaSum 6 = 12 := by
  -- `Nat.dvd_def` does not exist in Mathlib v4.31.0. This is a finite computation,
  -- so `decide` settles it directly.
  unfold SigmaSum
  decide

-- σ(n) ≥ n + 1 for all n ≥ 1 (1 and n divide n)
-- Since 1 | n and n | n, we have σ(n) ≥ 1 + n
theorem sigma_ge_n_plus_one (n : ℕ) (h : n ≥ 1) :
    SigmaSum n ≥ n + 1 := by
  unfold SigmaSum
  -- 1 and n both divide n, contributing at least 1 + n to the sum
  -- `Nat.dvd_refl n` has type `n ∣ n`, not `1 ∣ n`. Every natural divides by one.
  have h1 : 1 ∣ n := one_dvd n
  sorry -- Requires showing finset sum includes divisors 1 and n

-- For prime p: σ(p) = p + 1
-- If p is prime, only divisors are 1 and p
theorem sigma_prime (p : ℕ) (hp : p.Prime) :
    SigmaSum p = p + 1 := by
  unfold SigmaSum
  -- Divisors of p are only 1 and p (since p is prime)
  sorry -- Requires enumerating divisors of prime number

end Erdos
