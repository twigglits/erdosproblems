/-
Shared arithmetic used by the Erdős–Graham–Ruzsa–Straus divisibility problems
(#389, #396, #727).

Everything here is elementary: Legendre's formula for the `p`-adic valuation of a
factorial, plus the special case `m < p ^ 2` in which the formula has a single term.
-/
import Mathlib

namespace Erdos

open Finset Nat

/-- Legendre's formula in the range `m < p ^ 2`: only the first term survives. -/
theorem factorization_factorial_of_lt_sq {p m : ℕ} (hp : p.Prime) (h : m < p ^ 2) :
    (m !).factorization p = m / p := by
  have hb : Nat.log p m < 2 := by
    rcases Nat.eq_zero_or_pos m with rfl | hm
    · simp
    · exact Nat.log_lt_of_lt_pow hm.ne' h
  rw [Nat.factorization_factorial hp hb]
  simp

/-- `a ! ∣ b !` and friends: divisibility of naturals is a pointwise statement about
factorizations. -/
theorem dvd_of_forall_prime_factorization_le {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0)
    (h : ∀ p, p.Prime → a.factorization p ≤ b.factorization p) : a ∣ b := by
  rw [← Nat.factorization_le_iff_dvd ha hb]
  intro p
  by_cases hp : p.Prime
  · exact h p hp
  · simp [Nat.factorization_eq_zero_of_not_prime _ hp]

theorem forall_prime_factorization_le_of_dvd {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0)
    (h : a ∣ b) (p : ℕ) : a.factorization p ≤ b.factorization p := by
  rw [← Nat.factorization_le_iff_dvd ha hb] at h
  exact h p

end Erdos
