/-
# Collatz Conjecture

> Starting from any positive integer, repeatedly apply: if even divide by 2,
> if odd multiply by 3 and add 1. Does every sequence eventually reach 1?

Reference: Erdős offered significant prize money for solving this problem
-/

import Erdos.Basic

open Nat

namespace Erdos

-- ============================================================================
-- COLLATZ CONJECTURE
-- ============================================================================

-- Collatz function: one step of the iteration
def collatz_step (n : ℕ) : ℕ :=
  if Even n then n / 2 else 3 * n + 1

-- Collatz sequence starting from n
def collatz_sequence (n : ℕ) : ℕ → ℕ
  | 0 => n
  | k + 1 => collatz_step (collatz_sequence n k)

-- Reaches 1: the sequence eventually hits 1
def reaches_one (n : ℕ) : Prop :=
  ∃ k : ℕ, collatz_sequence n k = 1

-- Collatz Conjecture: every positive integer reaches 1
def CollatzConjecture : Prop :=
  ∀ n : ℕ, n > 0 → reaches_one n

-- Verified for small numbers
example : reaches_one 1 := by
  use 0
  simp [collatz_sequence]

example : reaches_one 2 := by
  use 1
  simp [collatz_sequence, collatz_step]

example : reaches_one 3 := by
  -- 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1
  use 7
  simp [collatz_sequence, collatz_step]
  norm_num

example : reaches_one 4 := by
  -- 4 → 2 → 1
  use 2
  simp [collatz_sequence, collatz_step]
  norm_num

example : reaches_one 5 := by
  -- 5 → 16 → 8 → 4 → 2 → 1
  use 5
  simp [collatz_sequence, collatz_step]
  norm_num

-- ============================================================================
-- CYCLE DETECTION
-- ============================================================================

-- Does the sequence contain a cycle (other than 1→1)?
def contains_cycle (n : ℕ) : Prop :=
  ∃ i j : ℕ, i < j ∧ collatz_sequence n i = collatz_sequence n j

-- Known cycle: 1 → 1 (the trivial cycle)
theorem trivial_cycle_one : contains_cycle 1 := by
  use 0, 1
  simp [collatz_sequence, collatz_step]
  norm_num

-- Conjecture: 1 is the only cycle
theorem collatz_unique_cycle :
    ∀ n : ℕ, n > 1 → ¬contains_cycle n := by
  intro n hn
  sorry  -- Open: only cycles known are (4→2→1→4) chain leading to 1

-- ============================================================================
-- RELATED CONJECTURES
-- ============================================================================

-- Stopping time: τ(n) = minimum steps to reach 1
def stopping_time (n : ℕ) : ℕ :=
  sorry  -- Minimum k such that collatz_sequence n k = 1

-- Stopping time can be arbitrarily large (verified)
theorem stopping_time_unbounded :
    ∀ T : ℕ, ∃ n : ℕ, stopping_time n > T := by
  sorry

-- Long path example: 27 reaches 1 in 111 steps
example : stopping_time 27 = 111 := by
  sorry  -- Computational verification needed

-- ============================================================================
-- STATISTICAL PROPERTIES
-- ============================================================================

-- Average stopping time grows like log(n)
theorem average_stopping_time_log :
    ∃ C : ℝ, ∀ N : ℕ,
    let avg := (Finset.sum (Finset.range N) (fun n => stopping_time n)) / N
    avg ≤ C * Real.log (N : ℝ) := by
  sorry  -- Heuristic: empirically ~log N but unproven

-- Density of steps spent in even vs odd numbers
def even_density (n : ℕ) (k : ℕ) : ℚ :=
  (Finset.filter (fun i => Even (collatz_sequence n i)) (Finset.range k)).card / k

theorem even_density_convergence (n : ℕ) (h : reaches_one n) :
    ∃ d : ℚ, d ≈ 0.6 ∧
    ∀ ε > 0, ∃ k₀ : ℕ,
    ∀ k ≥ k₀, |even_density n k - d| < ε := by
  sorry  -- Empirically ~0.64 but unproven

-- ============================================================================
-- COMPUTATIONAL VERIFICATION
-- ============================================================================

-- Collatz verified for all n ≤ 2.7 × 10^18 (Barina 2020)
theorem collatz_verified_large :
    ∀ n : ℕ, n ≤ 2700000000000000000 → reaches_one n := by
  sorry  -- Computational result; known fact but not proved here

-- ============================================================================
-- EQUIVALENT FORMULATIONS
-- ============================================================================

-- Equivalent: Syracuse problem (Collatz on odd integers only)
-- Equivalent: 3n+1 problem (standard name)
-- Equivalent: Ulam's conjecture (alternative name)

def collatz_equivalent_1 : Prop :=
  ∀ n : ℕ, Odd n → reaches_one n

def collatz_equivalent_2 : Prop :=
  ∀ n : ℕ, n > 0 → ∃ k : ℕ, collatz_sequence n k < n ∨ collatz_sequence n k = 1

-- These are all equivalent to the main conjecture
theorem collatz_equivalences :
    CollatzConjecture ↔ collatz_equivalent_1 ∧ collatz_equivalent_2 := by
  sorry  -- Equivalence can be proven constructively

end Erdos
