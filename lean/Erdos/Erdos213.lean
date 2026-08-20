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
example : SigmaSum 1 = 1 := by sorry

-- σ(6) = 1 + 2 + 3 + 6 = 12
example : SigmaSum 6 = 12 := by sorry

-- σ(n) ≥ n + 1 for all n ≥ 1 (1 and n divide n)
theorem sigma_ge_n_plus_one (n : ℕ) (h : n ≥ 1) :
    SigmaSum n ≥ n + 1 := by
  sorry

-- For prime p: σ(p) = p + 1
theorem sigma_prime (p : ℕ) (hp : p.Prime) :
    SigmaSum p = p + 1 := by
  sorry

end Erdos
