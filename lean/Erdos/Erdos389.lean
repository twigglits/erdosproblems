/-
# Erdős Problem 389 (Erdős–Straus)

> Is it true that for every `n ≥ 1` there is a `k` such that
> `n (n+1) ⋯ (n+k-1)  ∣  (n+k) (n+k+1) ⋯ (n+2k-1)` ?

Reference: https://www.erdosproblems.com/389

The problem is open. This file proves three equivalent forms of the divisibility and a
smoothness obstruction that every solution must satisfy.

Throughout we write `n = a + 1`, so `a = n - 1`, and we set `A = a + k`. The two blocks are
then `(a+1)(a+2)⋯A` and `(A+1)(A+2)⋯(2A-a)`.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Finset Nat

/-- `ErdosStraus a k` is the divisibility of Erdős problem 389 for `n = a + 1` and window
length `k`, written in factorial form. `erdosStraus_iff_prod` shows this is the same
statement as the one on erdosproblems.com. -/
def ErdosStraus (a k : ℕ) : Prop := ((a + k)!) ^ 2 ∣ (a + 2 * k)! * a !

/-! ## Equivalent forms -/

/-- The factorial form is the block form of the problem:
`(a+1)⋯(a+k) ∣ (a+k+1)⋯(a+2k)`, i.e. `n(n+1)⋯(n+k-1) ∣ (n+k)⋯(n+2k-1)` for `n = a+1`. -/
theorem erdosStraus_iff_prod (a k : ℕ) :
    ErdosStraus a k ↔
      (∏ i ∈ range k, (a + 1 + i)) ∣ (∏ i ∈ range k, (a + 1 + k + i)) := by
  have hP : a ! * (a + 1).ascFactorial k = (a + k)! := Nat.factorial_mul_ascFactorial a k
  have hQ : (a + k)! * (a + k + 1).ascFactorial k = (a + 2 * k)! := by
    have := Nat.factorial_mul_ascFactorial (a + k) k
    rwa [show a + k + k = a + 2 * k by ring] at this
  have hPpos : 0 < (a + 1).ascFactorial k := Nat.ascFactorial_pos a k
  have hQpos : 0 < (a + k + 1).ascFactorial k := Nat.ascFactorial_pos (a + k) k
  have hfa : 0 < a ! := Nat.factorial_pos a
  rw [show (∏ i ∈ range k, (a + 1 + i)) = (a + 1).ascFactorial k from
        (Nat.ascFactorial_eq_prod_range (a + 1) k).symm,
      show (∏ i ∈ range k, (a + 1 + k + i)) = (a + k + 1).ascFactorial k from
        (Nat.ascFactorial_eq_prod_range (a + k + 1) k).symm ▸ by
          refine Finset.prod_congr rfl fun i _ => by ring]
  constructor
  · intro h
    unfold ErdosStraus at h
    rw [← hP, ← hQ, ← hP] at h
    -- `(a! * P)^2 ∣ (a! * P * Q) * a!`
    have h' : a ! * a ! * ((a + 1).ascFactorial k * (a + 1).ascFactorial k) ∣
        a ! * a ! * ((a + 1).ascFactorial k * (a + k + 1).ascFactorial k) := by
      refine Dvd.dvd.trans (dvd_of_eq (by ring)) (h.trans (dvd_of_eq (by ring)))
    have h2 := (Nat.mul_dvd_mul_iff_left (by positivity : 0 < a ! * a !)).mp h'
    exact (Nat.mul_dvd_mul_iff_left hPpos).mp h2
  · intro h
    unfold ErdosStraus
    rw [← hP, ← hQ, ← hP]
    have h2 : (a + 1).ascFactorial k * (a + 1).ascFactorial k ∣
        (a + 1).ascFactorial k * (a + k + 1).ascFactorial k :=
      Nat.mul_dvd_mul_left _ h
    have h3 : a ! * a ! * ((a + 1).ascFactorial k * (a + 1).ascFactorial k) ∣
        a ! * a ! * ((a + 1).ascFactorial k * (a + k + 1).ascFactorial k) :=
      Nat.mul_dvd_mul_left _ h2
    exact Dvd.dvd.trans (dvd_of_eq (by ring)) (h3.trans (dvd_of_eq (by ring)))

/-- Binomial form: the problem asks whether `C(A, a)` divides `C(2A - a, A)`, `A = a + k`. -/
theorem erdosStraus_iff_choose (a k : ℕ) :
    ErdosStraus a k ↔ (a + k).choose a ∣ (a + 2 * k).choose (a + k) := by
  have hX : (a + k).choose a * (a ! * k !) = (a + k)! := by
    have := Nat.choose_mul_factorial_mul_factorial (Nat.le_add_right a k)
    rw [Nat.add_sub_cancel_left] at this
    rw [← this]; ring
  have hY : (a + 2 * k).choose (a + k) * ((a + k)! * k !) = (a + 2 * k)! := by
    have h1 : a + k ≤ a + 2 * k := by omega
    have := Nat.choose_mul_factorial_mul_factorial h1
    rw [show a + 2 * k - (a + k) = k by omega] at this
    rw [← this]; ring
  have hfa : 0 < a ! := Nat.factorial_pos a
  have hfk : 0 < k ! := Nat.factorial_pos k
  have hfak : 0 < (a + k)! := Nat.factorial_pos (a + k)
  constructor
  · intro h
    unfold ErdosStraus at h
    rw [← hY] at h
    -- `H^2 ∣ (Y * H * k!) * a!` with `H = (a+k)!`
    have h' : (a + k)! * (a + k)! ∣ (a + k)! *
        ((a + 2 * k).choose (a + k) * (k ! * a !)) := by
      refine Dvd.dvd.trans (dvd_of_eq (by ring)) (h.trans (dvd_of_eq (by ring)))
    have h2 := (Nat.mul_dvd_mul_iff_left hfak).mp h'
    rw [← hX] at h2
    have h3 : (a + k).choose a * (a ! * k !) ∣
        (a + 2 * k).choose (a + k) * (a ! * k !) := by
      refine Dvd.dvd.trans (dvd_of_eq (by ring)) (h2.trans (dvd_of_eq (by ring)))
    exact (Nat.mul_dvd_mul_iff_right (by positivity : 0 < a ! * k !)).mp h3
  · intro h
    unfold ErdosStraus
    rw [← hY]
    have h3 : (a + k).choose a * (a ! * k !) ∣ (a + 2 * k).choose (a + k) * (a ! * k !) :=
      mul_dvd_mul_right h _
    rw [hX] at h3
    have h4 : (a + k)! * (a + k)! ∣
        (a + k)! * ((a + 2 * k).choose (a + k) * (a ! * k !)) := Nat.mul_dvd_mul_left _ h3
    refine Dvd.dvd.trans (dvd_of_eq (by ring)) (h4.trans (dvd_of_eq (by ring)))

/-- Valuation form: the divisibility holds iff, for every prime `p`,
`2 · v_p((a+k)!) ≤ v_p((a+2k)!) + v_p(a!)`. -/
theorem erdosStraus_iff_factorization (a k : ℕ) :
    ErdosStraus a k ↔ ∀ p : ℕ, p.Prime →
      2 * ((a + k)!).factorization p ≤ ((a + 2 * k)!).factorization p + (a !).factorization p := by
  have h1 : (((a + k)!) ^ 2) ≠ 0 := by positivity
  have h2 : ((a + 2 * k)! * a !) ≠ 0 := by positivity
  unfold ErdosStraus
  constructor
  · intro h p _
    have := forall_prime_factorization_le_of_dvd h1 h2 h p
    rwa [Nat.factorization_pow, Nat.factorization_mul (Nat.factorial_ne_zero _)
      (Nat.factorial_ne_zero _)] at this
  · intro h
    refine dvd_of_forall_prime_factorization_le h1 h2 fun p hp => ?_
    rw [Nat.factorization_pow, Nat.factorization_mul (Nat.factorial_ne_zero _)
      (Nat.factorial_ne_zero _)]
    exact h p hp

/-- Digit-sum form. Writing `s_p` for the sum of the base-`p` digits, the divisibility holds
iff `s_p(a) + s_p(a + 2k) ≤ 2 · s_p(a + k)` for every prime `p`. -/
theorem erdosStraus_iff_digits (a k : ℕ) :
    ErdosStraus a k ↔ ∀ p : ℕ, p.Prime →
      (p.digits a).sum + (p.digits (a + 2 * k)).sum ≤ 2 * (p.digits (a + k)).sum := by
  rw [erdosStraus_iff_factorization]
  constructor <;> intro h p hp <;> have hle := h p hp
  · have e1 := Nat.sub_one_mul_factorization_factorial (n := a + k) hp
    have e2 := Nat.sub_one_mul_factorization_factorial (n := a + 2 * k) hp
    have e3 := Nat.sub_one_mul_factorization_factorial (n := a) hp
    have d1 := Nat.digit_sum_le p (a + k)
    have d2 := Nat.digit_sum_le p (a + 2 * k)
    have d3 := Nat.digit_sum_le p a
    have hp2 : 2 ≤ p := hp.two_le
    have key : (p - 1) * (2 * ((a + k)!).factorization p) ≤
        (p - 1) * (((a + 2 * k)!).factorization p + (a !).factorization p) :=
      Nat.mul_le_mul_left _ hle
    rw [Nat.mul_left_comm, e1, Nat.mul_add, e2, e3] at key
    omega
  · have e1 := Nat.sub_one_mul_factorization_factorial (n := a + k) hp
    have e2 := Nat.sub_one_mul_factorization_factorial (n := a + 2 * k) hp
    have e3 := Nat.sub_one_mul_factorization_factorial (n := a) hp
    have d1 := Nat.digit_sum_le p (a + k)
    have d2 := Nat.digit_sum_le p (a + 2 * k)
    have d3 := Nat.digit_sum_le p a
    have hp2 : 2 ≤ p := hp.two_le
    have hpos : 0 < p - 1 := by omega
    have key : (p - 1) * (2 * ((a + k)!).factorization p) ≤
        (p - 1) * (((a + 2 * k)!).factorization p + (a !).factorization p) := by
      rw [Nat.mul_left_comm, e1, Nat.mul_add, e2, e3]
      omega
    exact Nat.le_of_mul_le_mul_left key hpos

/-! ## The smoothness obstruction

Every solution forces a long run of smooth numbers immediately below `A = a + k`. This is
what makes the minimal `k` grow so quickly (see `A375071`).
-/

/-- **The large-prime part of the criterion, exactly.** At a prime `p` with `a < p` and
`a + 2k < p ^ 2` the local condition of `erdosStraus_iff_factorization` is *equivalent* to
`a ≤ 2 · (A mod p)`, where `A = a + k`. -/
theorem local_condition_iff {a k p : ℕ} (hp : p.Prime) (hap : a < p) (hsq : a + 2 * k < p ^ 2) :
    (2 * (((a + k)!).factorization p) ≤
        ((a + 2 * k)!).factorization p + (a !).factorization p)
      ↔ a ≤ 2 * ((a + k) % p) := by
  have hA : a + k < p ^ 2 := by omega
  have ha : a < p ^ 2 := by omega
  have hppos : 0 < p := hp.pos
  rw [factorization_factorial_of_lt_sq hp hA, factorization_factorial_of_lt_sq hp hsq,
    factorization_factorial_of_lt_sq hp ha, Nat.div_eq_of_lt hap, Nat.add_zero]
  have hdm : (a + k) / p * p + (a + k) % p = a + k := Nat.div_add_mod' (a + k) p
  constructor
  · intro hle
    have hmul : 2 * ((a + k) / p) * p ≤ a + 2 * k := (Nat.le_div_iff_mul_le hppos).mp hle
    have hmul' : 2 * ((a + k) / p * p) ≤ a + 2 * k := by rw [← Nat.mul_assoc]; exact hmul
    set t := (a + k) / p * p with ht
    omega
  · intro hr
    refine (Nat.le_div_iff_mul_le hppos).mpr ?_
    have : 2 * ((a + k) / p) * p = 2 * ((a + k) / p * p) := by ring
    rw [this]
    set t := (a + k) / p * p with ht
    omega

/-- **Large-prime obstruction.** If the divisibility holds and `p` is a prime that is larger
than `a` and larger than `√(a+2k)`, then `a ≤ 2 · (A mod p)` where `A = a + k`. -/
theorem two_mul_mod_ge_of_erdosStraus {a k p : ℕ} (h : ErdosStraus a k) (hp : p.Prime)
    (hap : a < p) (hsq : a + 2 * k < p ^ 2) : a ≤ 2 * ((a + k) % p) :=
  (local_condition_iff hp hap hsq).mp ((erdosStraus_iff_factorization a k).mp h p hp)

/-- Restatement: no prime `p` with `a < p` and `p ^ 2 > a + 2k` divides any of the
`⌈a/2⌉` integers `A, A-1, …, A-⌈a/2⌉+1`, where `A = a + k`. -/
theorem not_dvd_of_erdosStraus {a k p j : ℕ} (h : ErdosStraus a k) (hp : p.Prime)
    (hap : a < p) (hsq : a + 2 * k < p ^ 2) (hj : 2 * j < a) (hjA : j ≤ a + k) :
    ¬ p ∣ (a + k - j) := by
  intro hdvd
  have hmod : (a + k) % p = j := by
    obtain ⟨c, hc⟩ := hdvd
    have : a + k = p * c + j := by omega
    rw [this, Nat.mul_add_mod]
    exact Nat.mod_eq_of_lt (by omega)
  have := two_mul_mod_ge_of_erdosStraus h hp hap hsq
  omega

/-- **Smoothness corollary.** If the divisibility holds then each of the `⌈a/2⌉` integers
`A, A-1, …, A-⌈a/2⌉+1` (with `A = a + k`) is `max(a, √(a+2k))`-smooth: every prime factor `p`
of such a number satisfies `p ≤ a` or `p ^ 2 ≤ a + 2k`. -/
theorem smooth_of_erdosStraus {a k j p : ℕ} (h : ErdosStraus a k) (hp : p.Prime)
    (hj : 2 * j < a) (hjA : j ≤ a + k) (hdvd : p ∣ (a + k - j)) :
    p ≤ a ∨ p ^ 2 ≤ a + 2 * k := by
  by_contra hcon
  rw [not_or, Nat.not_le, Nat.not_le] at hcon
  exact not_dvd_of_erdosStraus h hp hcon.1 hcon.2 hj hjA hdvd

/-! ## Kernel-checked solutions

The minimal `k` for `1 ≤ n ≤ 27` is `A375071` in the OEIS. The entries below are the ones
whose full factorial arithmetic the Lean kernel can still carry out directly. Each is stated
in the `a = n - 1` indexing, so `erdosStraus_a_k` certifies the entry for `n = a + 1`.
-/

namespace Solutions

theorem n1 : ErdosStraus 0 1 := by unfold ErdosStraus; decide +kernel
theorem n2 : ErdosStraus 1 5 := by unfold ErdosStraus; decide +kernel
theorem n3 : ErdosStraus 2 4 := by unfold ErdosStraus; decide +kernel
theorem n4 : ErdosStraus 3 207 := by unfold ErdosStraus; decide +kernel
theorem n5 : ErdosStraus 4 206 := by unfold ErdosStraus; decide +kernel
theorem n6 : ErdosStraus 5 2475 := by unfold ErdosStraus; decide +kernel
theorem n7 : ErdosStraus 6 984 := by unfold ErdosStraus; decide +kernel
theorem n8 : ErdosStraus 7 8171 := by unfold ErdosStraus; decide +kernel
theorem n9 : ErdosStraus 8 8170 := by unfold ErdosStraus; decide +kernel
theorem n10 : ErdosStraus 9 45144 := by unfold ErdosStraus; decide +kernel
theorem n11 : ErdosStraus 10 45143 := by unfold ErdosStraus; decide +kernel

end Solutions

end Erdos
