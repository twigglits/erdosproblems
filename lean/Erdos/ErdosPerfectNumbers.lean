/-
# Perfect Numbers and Erdős Bounds

> Do odd perfect numbers exist? What are bounds on their size and form?

Reference: Erdős studied perfect numbers extensively; odd perfect numbers remain open
-/

import Erdos.Basic
import Erdos.Lemmas

open Nat

namespace Erdos

-- Several statements below filter on Props (`Abundant`, `Deficient`, `Perfect`) that carry no
-- `Decidable` instance. Classical decidability is opened once here rather than per theorem.
open scoped Classical

-- ============================================================================
-- PERFECT NUMBERS
-- ============================================================================

-- Perfect number: σ(n) = 2n (sum of proper divisors equals n)
def Perfect (n : ℕ) : Prop :=
  Finset.sum (Finset.filter (fun d => d ∣ n ∧ d < n) (Finset.range (n + 1)))
    (fun d => d) = n

-- Even perfect numbers: 2^(p-1)(2^p - 1) where 2^p - 1 is prime
def EvenPerfect (n : ℕ) : Prop :=
  ∃ p : ℕ, p.Prime ∧
  (2^p - 1).Prime ∧
  n = 2^(p - 1) * (2^p - 1)

-- Known even perfect numbers (verified)
-- `Perfect n` is a finite decidable computation, so `decide` discharges it outright.
-- 6 = 1 + 2 + 3 and 28 = 1 + 2 + 4 + 7 + 14.
example : Perfect 6 := by unfold Perfect; decide

example : Perfect 28 := by unfold Perfect; decide

-- Odd perfect numbers (open)
-- If an odd perfect number exists, it satisfies multiple constraints
theorem odd_perfect_constraints (n : ℕ) (h : Perfect n ∧ Odd n) :
    ∃ k : ℕ,
    (n = (2 * k + 1)^2 * m ∨ n = p^a * m) ∧  -- Form constraint
    k > 10^1500 ∧  -- Minimum bound (Nielsen 2019)
    ∃ distinct_primes : ℕ,
    distinct_primes ≥ 10  -- Minimum distinct prime factors
    := by
  sorry

-- Erdős bound: if odd perfect number exists, it must be huge
theorem erdos_odd_perfect_bound :
    ∀ n : ℕ,
    Perfect n ∧ Odd n →
    n > 10^1500 := by
  sorry  -- Follows from congruence constraints

-- ============================================================================
-- ABUNDANT AND DEFICIENT NUMBERS
-- ============================================================================

-- Abundant: σ(n) > 2n
def Abundant (n : ℕ) : Prop :=
  Finset.sum (Finset.filter (fun d => d ∣ n) (Finset.range (n + 1)))
    (fun d => d) > 2 * n

-- Deficient: σ(n) < 2n
def Deficient (n : ℕ) : Prop :=
  Finset.sum (Finset.filter (fun d => d ∣ n) (Finset.range (n + 1)))
    (fun d => d) < 2 * n

-- All primes are deficient
theorem prime_deficient (p : ℕ) (hp : p.Prime) :
    Deficient p := by
  simp [Deficient]
  sorry  -- σ(p) = p + 1 < 2p for p > 1

-- ============================================================================
-- DENSITY OF PERFECT AND ABUNDANT NUMBERS
-- ============================================================================

-- Abundant numbers have positive density (though small)
-- Three corrections to the original statement:
--   1. `Abundant n` is a `Prop` with no `Decidable` instance, so `Finset.filter` needed
--      classical decidability.
--   2. `.card / N` was ℕ division compared against a rational δ; the count is now cast to ℚ.
--   3. The original claimed the ratio exceeds δ for EVERY `N`, which is false: at `N = 1`
--      the count is 0, so the ratio is 0. A density claim needs "for all large `N`".
open scoped Classical in
theorem abundant_positive_density :
    ∃ δ : ℚ, δ > 0 ∧ ∃ N₀ : ℕ, ∀ N ≥ N₀,
    (((Finset.filter (fun n => n < N ∧ Abundant n) (Finset.range N)).card : ℚ) / N > δ) := by
  sorry  -- Abundant numbers have natural density ≈ 0.2476

-- Deficient numbers have density ~1
theorem deficient_nearly_full_density :
    ∀ ε > 0,
    ∃ N : ℕ,
    ∀ n ≥ N,
    (((Finset.filter (fun m => m ≤ n ∧ Deficient m) (Finset.range (n + 1))).card : ℚ)
      / (n + 1) > 1 - ε) := by
  sorry

-- Odd abundant numbers exist (smallest is 945)
example : Abundant 945 := by
  simp [Abundant]
  sorry  -- Tedious divisor sum calculation

-- ============================================================================
-- ERDŐS' CONJECTURE ON PERFECT NUMBERS
-- ============================================================================

-- Erdős: the set of odd perfect numbers has density 0 (or is empty)
-- The original wrote `... .card / N → 0`, using implication `→` between a natural number
-- and `0`, which is not a limit and does not typecheck. "Density tends to 0" is stated
-- properly with `Filter.Tendsto` along `atTop`, over ℝ.
theorem erdos_odd_perfect_density_zero :
    Filter.Tendsto
      (fun N : ℕ =>
        (((Finset.filter (fun n => n < N ∧ Perfect n ∧ Odd n) (Finset.range N)).card : ℝ) / N))
      Filter.atTop (nhds 0)
    ∨ (¬∃ n : ℕ, Perfect n ∧ Odd n) := by
  sorry  -- Open: even if odd perfect numbers exist, they're vanishingly rare

-- Multiperfect numbers: σ(n) = k*n
def Multiperfect (k n : ℕ) : Prop :=
  Finset.sum (Finset.filter (fun d => d ∣ n) (Finset.range (n + 1)))
    (fun d => d) = k * n

-- k=3: 3-perfect numbers (triperfect)
example : Multiperfect 3 120 := by
  simp [Multiperfect]
  sorry  -- σ(120) = 360 = 3 * 120

end Erdos
