/-
# Erdős Problem 396

> Is it true that for every `k` there exists `n` such that `∏_{0≤i≤k} (n-i) ∣ C(2n, n)`?

Reference: https://www.erdosproblems.com/396

This file proves a smoothness obstruction. We index by `m = n - k`, so the block is
`m, m+1, …, m+k` and `n = m + k`.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Finset Nat

/-- The divisibility of Erdős problem 396, with `n = m + k`. -/
def Block396 (m k : ℕ) : Prop :=
  (∏ i ∈ range (k + 1), (m + i)) ∣ (2 * (m + k)).choose (m + k)

/-- The `p`-adic valuation of the central binomial coefficient below `p ^ 2`. -/
theorem factorization_centralBinom_of_lt_sq {p n : ℕ} (hp : p.Prime) (h : 2 * n < p ^ 2) :
    ((2 * n).choose n).factorization p = 2 * n / p - 2 * (n / p) := by
  have hkey : (2 * n).choose n * (n ! * n !) = (2 * n)! := by
    have h1 : n ≤ 2 * n := by omega
    have := Nat.choose_mul_factorial_mul_factorial h1
    rw [show 2 * n - n = n by omega] at this
    rw [← this]; ring
  have hc0 : (2 * n).choose n ≠ 0 := (Nat.choose_pos (by omega)).ne'
  have hf0 : (n ! * n !) ≠ 0 := by positivity
  have hfac : ((2 * n).choose n * (n ! * n !)).factorization p = ((2 * n)!).factorization p := by
    rw [hkey]
  rw [Nat.factorization_mul hc0 hf0,
    Nat.factorization_mul (Nat.factorial_ne_zero n) (Nat.factorial_ne_zero n)] at hfac
  simp only [Finsupp.coe_add, Pi.add_apply] at hfac
  rw [factorization_factorial_of_lt_sq hp h,
    factorization_factorial_of_lt_sq hp (show n < p ^ 2 by omega)] at hfac
  omega

/-- **Large-prime obstruction.** If the divisibility holds, `p` is a prime with `p ^ 2 > 2n`
and `p > k`, and `p` divides one of `m, m+1, …, m+k`, then `p ≤ 2 (k - i)`; that is,
`p ≤ 2j` where `n - j` is the multiple of `p`. -/
theorem le_two_mul_of_block396 {m k p i : ℕ} (h : Block396 m k) (hp : p.Prime)
    (hsq : 2 * (m + k) < p ^ 2) (hpk : k < p) (hik : i ≤ k) (hdvd : p ∣ (m + i)) :
    p ≤ 2 * (k - i) := by
  set n := m + k with hn
  -- `p` divides the central binomial coefficient
  have hmem : (m + i) ∣ ∏ j ∈ range (k + 1), (m + j) :=
    Finset.dvd_prod_of_mem _ (Finset.mem_range.mpr (by omega))
  have hpc : p ∣ (2 * n).choose n := hdvd.trans (hmem.trans h)
  have hc0 : (2 * n).choose n ≠ 0 := (Nat.choose_pos (by omega)).ne'
  have hpos : 0 < ((2 * n).choose n).factorization p :=
    hp.factorization_pos_of_dvd hc0 hpc
  rw [factorization_centralBinom_of_lt_sq hp hsq] at hpos
  -- so `2 * (n % p) ≥ p`
  have hppos : 0 < p := hp.pos
  have hlt : n % p < p := Nat.mod_lt _ hppos
  have hkey : p ≤ 2 * (n % p) := by
    by_contra hcon
    have hq : n = n / p * p + n % p := (Nat.div_add_mod' n p).symm
    have heq : 2 * n = 2 * (n % p) + p * (2 * (n / p)) := by
      conv_lhs => rw [hq]
      ring
    have hzero : 2 * (n % p) / p = 0 := Nat.div_eq_of_lt (by omega)
    have hdiv : 2 * n / p = 2 * (n / p) := by
      rw [heq, Nat.add_mul_div_left _ _ hppos, hzero, Nat.zero_add]
    omega
  -- and `n % p = k - i`
  have hmod : n % p = k - i := by
    obtain ⟨c, hc⟩ := hdvd
    have : n = p * c + (k - i) := by omega
    rw [this, Nat.mul_add_mod]
    exact Nat.mod_eq_of_lt (by omega)
  omega

/-- **Smoothness corollary.** In particular (`i = k`, so `j = 0`) no prime `p > k` with
`p ^ 2 > 2n` divides `n` itself: `n` must be `max(k, √(2n))`-smooth. -/
theorem smooth_of_block396 {m k p : ℕ} (h : Block396 m k) (hp : p.Prime)
    (hpk : k < p) (hdvd : p ∣ (m + k)) : p ^ 2 ≤ 2 * (m + k) := by
  by_contra hcon
  have h2 := le_two_mul_of_block396 h hp (by omega) hpk (le_refl k) hdvd
  rw [Nat.sub_self] at h2
  have := hp.two_le
  omega

end Erdos
