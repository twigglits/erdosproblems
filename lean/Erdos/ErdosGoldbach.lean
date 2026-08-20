/-
# Goldbach-Erdős Conjecture

> Every even number greater than 2 is the sum of two primes.

Reference: Related to Erdős work on additive number theory
-/

import Erdos.Basic
import Erdos.Lemmas

open Nat

namespace Erdos

-- ============================================================================
-- GOLDBACH'S CONJECTURE
-- ============================================================================

-- Every even n ≥ 4 is sum of two primes
def GoldbachProperty (n : ℕ) : Prop :=
  Even n ∧ n ≥ 4 →
  ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = n

-- Weak Goldbach (proven): every odd n ≥ 7 is sum of 3 primes
theorem weak_goldbach (n : ℕ) (h : Odd n ∧ n ≥ 7) :
    ∃ p q r : ℕ, p.Prime ∧ q.Prime ∧ r.Prime ∧ p + q + r = n := by
  sorry  -- Harald Helfgott's proof (2013)

-- Strong Goldbach (open): every even n ≥ 4 is sum of two primes
theorem strong_goldbach : ∀ n : ℕ, GoldbachProperty n := by
  sorry  -- Open problem: verified up to ~4×10^18

-- Goldbach for small even numbers (verified)
example : ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = 4 := by
  use 2, 2
  norm_num [Nat.prime_two]

example : ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = 6 := by
  use 3, 3
  norm_num

example : ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = 8 := by
  use 3, 5
  norm_num

example : ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = 10 := by
  use 5, 5
  norm_num

-- Erdős conjecture: Goldbach density
-- Among all ways to express even n as p+q, at least one has both p,q > √n
theorem erdos_goldbach_density (n : ℕ) (h : Even n ∧ n > 100) :
    ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = n ∧
    p > Nat.sqrt n ∧ q > Nat.sqrt n := by
  sorry  -- Open: might follow from prime distribution

-- ============================================================================
-- TERNARY GOLDBACH (PROVEN)
-- ============================================================================

-- Ternary Goldbach: every odd n ≥ 9 is sum of 3 odd primes
theorem ternary_goldbach (n : ℕ) (h : Odd n ∧ n ≥ 9) :
    ∃ p q r : ℕ, (∀ x ∈ [p, q, r], x.Prime ∧ Odd x) ∧ p + q + r = n := by
  sorry  -- Helfgott, 2013 (verified)

end Erdos
