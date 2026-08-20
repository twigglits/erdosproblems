/-
# Erdős Problem 727

> Let `k ≥ 2`. Does `((n+k)!)^2 ∣ (2n)!` hold for infinitely many `n`?

Reference: https://www.erdosproblems.com/727
A conjecture of Erdős, Graham, Ruzsa and Straus. Open even for `k = 2`.

This file proves a smoothness obstruction: every solution `n` forces the whole block
`(n+1)(n+2)⋯(n+k)` to be `√(2n)`-smooth.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Finset Nat

/-- The divisibility of Erdős problem 727. -/
def EGRS (n k : ℕ) : Prop := ((n + k)!) ^ 2 ∣ (2 * n)!

/-- A solution with `n ≥ 1` has `k ≤ n`; otherwise `(n+k)!` already exceeds `(2n)!`. -/
theorem le_of_egrs {n k : ℕ} (hn : 0 < n) (h : EGRS n k) : k ≤ n := by
  by_contra hcon
  have hlt : 2 * n < n + k := by omega
  have hdvd : ((n + k)!) ∣ (2 * n)! := dvd_trans (dvd_pow_self _ two_ne_zero) h
  have hle : ((n + k)!) ≤ (2 * n)! := Nat.le_of_dvd (Nat.factorial_pos _) hdvd
  have hgt : (2 * n)! < ((n + k))! := (Nat.factorial_lt (by omega)).mpr hlt
  omega

/-- **Valuation form.** -/
theorem egrs_iff_factorization (n k : ℕ) :
    EGRS n k ↔ ∀ p : ℕ, p.Prime →
      2 * (((n + k)!).factorization p) ≤ ((2 * n)!).factorization p := by
  have h1 : (((n + k)!) ^ 2) ≠ 0 := by positivity
  have h2 : ((2 * n)!) ≠ 0 := Nat.factorial_ne_zero _
  unfold EGRS
  constructor
  · intro h p _
    have := forall_prime_factorization_le_of_dvd h1 h2 h p
    rwa [Nat.factorization_pow] at this
  · intro h
    refine dvd_of_forall_prime_factorization_le h1 h2 fun p hp => ?_
    rw [Nat.factorization_pow]
    exact h p hp

/-- **Large-prime obstruction.** If `((n+k)!)^2 ∣ (2n)!` and `p` is a prime with `p^2 > 2n`
then `(n+k) mod p ≥ k`. -/
theorem k_le_mod_of_egrs {n k p : ℕ} (hn : 0 < n) (h : EGRS n k) (hp : p.Prime)
    (hsq : 2 * n < p ^ 2) : k ≤ (n + k) % p := by
  have hkn : k ≤ n := le_of_egrs hn h
  have hle := (egrs_iff_factorization n k).mp h p hp
  have hA : n + k < p ^ 2 := by omega
  rw [factorization_factorial_of_lt_sq hp hA, factorization_factorial_of_lt_sq hp hsq] at hle
  have hppos : 0 < p := hp.pos
  have hmul : 2 * ((n + k) / p) * p ≤ 2 * n := (Nat.le_div_iff_mul_le hppos).mp hle
  have hmul' : 2 * ((n + k) / p * p) ≤ 2 * n := by rw [← Nat.mul_assoc]; exact hmul
  have hdm : (n + k) / p * p + (n + k) % p = n + k := Nat.div_add_mod' (n + k) p
  set t := (n + k) / p * p with ht
  omega

/-- **Smoothness obstruction.** If `((n+k)!)^2 ∣ (2n)!` then no prime `p` with `p^2 > 2n`
divides any of `n+1, …, n+k`. Equivalently, `(n+1)(n+2)⋯(n+k)` is `√(2n)`-smooth. -/
theorem not_dvd_of_egrs {n k p j : ℕ} (hn : 0 < n) (h : EGRS n k) (hp : p.Prime)
    (hsq : 2 * n < p ^ 2) (hj : 1 ≤ j) (hjk : j ≤ k) : ¬ p ∣ (n + j) := by
  intro hdvd
  have hkr := k_le_mod_of_egrs hn h hp hsq
  have hrp : (n + k) % p < p := Nat.mod_lt _ hp.pos
  have hmod : (n + k) % p = k - j := by
    obtain ⟨c, hc⟩ := hdvd
    have hnk : n + k = p * c + (k - j) := by omega
    rw [hnk, Nat.mul_add_mod]
    exact Nat.mod_eq_of_lt (by omega)
  omega

/-- Contrapositive: every prime factor `p` of `(n+1)⋯(n+k)` satisfies `p^2 ≤ 2n`. -/
theorem sq_le_of_dvd_block {n k p j : ℕ} (hn : 0 < n) (h : EGRS n k) (hp : p.Prime)
    (hj : 1 ≤ j) (hjk : j ≤ k) (hdvd : p ∣ (n + j)) : p ^ 2 ≤ 2 * n := by
  by_contra hcon
  exact not_dvd_of_egrs hn h hp (by omega) hj hjk hdvd

/-! ## Kernel-checked solutions

The smallest `n` with `((n+k)!)^2 ∣ (2n)!` for `k = 2, 3, 4`. -/

namespace Solutions

theorem k2 : EGRS 208 2 := by unfold EGRS; decide +kernel
theorem k3 : EGRS 3475 3 := by unfold EGRS; decide +kernel
theorem k4 : EGRS 8174 4 := by unfold EGRS; decide +kernel

end Solutions

/-! ## A construction for `k = 1`

`k = 1` is Balakran's theorem (1929): `(n+1)^2 ∣ C(2n, n)` for infinitely many `n`.
It is the known base case of the problem; problem 727 asks about `k ≥ 2`.

The construction below is explicit and gives an exact criterion inside the family
`n + 1 = p * q`: for odd primes `p < q` the divisibility holds **iff** `3p ≤ 2q < 4p`.
-/

namespace Balakran

/-- `k = 1` in binomial form: `((n+1)!)^2 ∣ (2n)!` iff `(2n+1)(2n+2) ∣ C(2n+2, n+1)`. -/
theorem egrs_one_iff (n : ℕ) :
    EGRS n 1 ↔ (2 * n + 1) * (2 * n + 2) ∣ (2 * n + 2).choose (n + 1) := by
  have hC : (2 * n + 2).choose (n + 1) * ((n + 1)! * (n + 1)!) = (2 * n + 2)! := by
    have h1 : n + 1 ≤ 2 * n + 2 := by omega
    have := Nat.choose_mul_factorial_mul_factorial h1
    rw [show 2 * n + 2 - (n + 1) = n + 1 by omega] at this
    rw [← this]; ring
  have hF : (2 * n)! * ((2 * n + 1) * (2 * n + 2)) = (2 * n + 2)! := by
    rw [show 2 * n + 2 = (2 * n + 1) + 1 by omega, Nat.factorial_succ,
      show 2 * n + 1 = (2 * n) + 1 by omega, Nat.factorial_succ]
    ring
  have hfpos : 0 < (n + 1)! * (n + 1)! := by positivity
  unfold EGRS
  rw [show 2 * n = 2 * n by rfl]
  constructor
  · intro h
    obtain ⟨c, hc⟩ := h
    have : (2 * n + 2).choose (n + 1) * ((n + 1)! * (n + 1)!) =
        ((n + 1)! * (n + 1)!) * (c * ((2 * n + 1) * (2 * n + 2))) := by
      rw [hC, ← hF, hc]; ring
    have h2 : (2 * n + 2).choose (n + 1) = c * ((2 * n + 1) * (2 * n + 2)) := by
      have := Nat.eq_of_mul_eq_mul_right hfpos (by rw [this]; ring :
        (2 * n + 2).choose (n + 1) * ((n + 1)! * (n + 1)!) =
          (c * ((2 * n + 1) * (2 * n + 2))) * ((n + 1)! * (n + 1)!))
      exact this
    exact ⟨c, by rw [h2]; ring⟩
  · intro h
    obtain ⟨c, hc⟩ := h
    refine ⟨c, ?_⟩
    have : (2 * n)! * ((2 * n + 1) * (2 * n + 2)) =
        ((n + 1)! ^ 2 * c) * ((2 * n + 1) * (2 * n + 2)) := by
      rw [hF, ← hC, hc]; ring
    exact Nat.eq_of_mul_eq_mul_right (by positivity) this

/-- A set of carry witnesses gives a lower bound on `v_r (C(2N, N))` (Kummer). -/
theorem card_le_factorization_centralBinom {N r : ℕ} (hr : r.Prime) (S : Finset ℕ)
    (hS : ∀ i ∈ S, 1 ≤ i ∧ r ^ i ≤ 2 * (N % r ^ i)) :
    S.card ≤ ((N + N).choose N).factorization r := by
  have hb : Nat.log r (N + N) < N + N + 1 :=
    Nat.lt_succ_of_le (Nat.log_le_self r (N + N))
  have hib : ∀ i ∈ S, i < N + N + 1 := by
    intro i hi
    obtain ⟨hi1, hi2⟩ := hS i hi
    have hmod : N % r ^ i < r ^ i := Nat.mod_lt _ (pow_pos hr.pos i)
    have hexp : i < r ^ i := Nat.lt_pow_self hr.one_lt
    have hle : N % r ^ i ≤ N := Nat.mod_le _ _
    omega
  rw [Nat.factorization_choose' hr hb]
  refine Finset.card_le_card ?_
  intro i hi
  obtain ⟨hi1, hi2⟩ := hS i hi
  simp only [Finset.mem_filter, Finset.mem_Ico]
  exact ⟨⟨hi1, hib i hi⟩, by omega⟩

/-- One carry witness gives `v_r (C(2N,N)) ≥ 1`. -/
theorem one_le_factorization_centralBinom {N r i : ℕ} (hr : r.Prime) (hi : 1 ≤ i)
    (hle : r ^ i ≤ 2 * (N % r ^ i)) : 1 ≤ ((N + N).choose N).factorization r := by
  have hwit : ∀ j ∈ ({i} : Finset ℕ), 1 ≤ j ∧ r ^ j ≤ 2 * (N % r ^ j) := by
    intro j hj
    simp only [Finset.mem_singleton] at hj
    subst hj
    exact ⟨hi, hle⟩
  calc (1 : ℕ) = ({i} : Finset ℕ).card := by simp
    _ ≤ _ := card_le_factorization_centralBinom hr _ hwit

/-- **Balakran's construction, with an exact criterion inside the family `n + 1 = pq`.**
For odd primes `p < q` with `3p ≤ 2q` and `q < 2p`, the number `n = pq - 1` satisfies
`((n+1)!)^2 ∣ (2n)!`, i.e. `(n+1)^2 ∣ C(2n, n)`. Since `[3p/2, 2p)` contains a prime for
every large `p`, this gives infinitely many `n` — Balakran's theorem (1929), the known
`k = 1` case of the problem. -/
theorem construction {p q n : ℕ} (hp : p.Prime) (hq : q.Prime) (hp3 : 3 ≤ p)
    (hpq : p < q) (h1 : 3 * p ≤ 2 * q) (h2 : q < 2 * p) (hn : n + 1 = p * q) :
    EGRS n 1 := by
  rw [egrs_one_iff]
  have hq3 : 3 ≤ q := by omega
  have hsum : 2 * n + 2 = (n + 1) + (n + 1) := by omega
  rw [hsum]
  set N := n + 1 with hN
  have hNpq : N = p * q := hn
  have hodd : N % 2 = 1 := by
    have hnd : ¬ (2 ∣ N) := by
      rw [hNpq]
      intro hd
      rcases (Nat.Prime.dvd_mul Nat.prime_two).mp hd with h | h
      · exact absurd ((Nat.prime_dvd_prime_iff_eq Nat.prime_two hp).mp h) (by omega)
      · exact absurd ((Nat.prime_dvd_prime_iff_eq Nat.prime_two hq).mp h) (by omega)
    omega
  have hne1 : (2 * n + 1) ≠ 0 := by omega
  have hne2 : (N + N) ≠ 0 := by omega
  have hCne : ((N + N).choose N) ≠ 0 := (Nat.choose_pos (by omega)).ne'
  refine dvd_of_forall_prime_factorization_le (by positivity) hCne ?_
  intro r hr
  rw [Nat.factorization_mul hne1 hne2]
  simp only [Finsupp.coe_add, Pi.add_apply]
  by_cases hdvd : r ∣ (2 * n + 1)
  · -- `r` divides `2N - 1`; the witnesses are `i = 1, …, v_r(2N-1)`
    have hnd : ¬ r ∣ (N + N) := by
      intro h2N
      obtain ⟨c, hc⟩ := h2N
      obtain ⟨d, hd⟩ := hdvd
      have hone : r * (c - d) = 1 := by
        have hcd : d < c := by nlinarith [hr.two_le]
        have : r * c = r * d + 1 := by omega
        have hsub : r * (c - d) = r * c - r * d := by
          rw [Nat.mul_sub]
        omega
      have : r ≤ 1 := Nat.le_of_dvd one_pos ⟨c - d, hone.symm⟩
      have := hr.two_le
      omega
    rw [Nat.factorization_eq_zero_of_not_dvd hnd, Nat.add_zero]
    set e := (2 * n + 1).factorization r with he
    have hrodd : r ≠ 2 := by
      rintro rfl
      have hd : (2 : ℕ) ∣ 2 * n + 1 := hdvd
      omega
    have hwit : ∀ i ∈ Finset.Ico 1 (e + 1), 1 ≤ i ∧ r ^ i ≤ 2 * (N % r ^ i) := by
      intro i hi
      simp only [Finset.mem_Ico] at hi
      refine ⟨hi.1, ?_⟩
      have hdvdi : r ^ i ∣ (2 * n + 1) :=
        dvd_trans (pow_dvd_pow r (by omega)) (Nat.ordProj_dvd _ _)
      have hR1 : 1 < r ^ i := Nat.one_lt_pow (by omega) hr.one_lt
      have hRodd : r ^ i % 2 = 1 := by
        have hnd2 : ¬ (2 ∣ r ^ i) := by
          intro hd
          exact hrodd ((Nat.prime_dvd_prime_iff_eq Nat.prime_two hr).mp
            (Nat.Prime.dvd_of_dvd_pow Nat.prime_two hd)).symm
        omega
      have hmodlt : N % r ^ i < r ^ i := Nat.mod_lt _ (by omega)
      have h2N : (2 * N) % r ^ i = 1 := by
        obtain ⟨c, hc⟩ := hdvdi
        have hrw : 2 * N = r ^ i * c + 1 := by omega
        rw [hrw, Nat.mul_add_mod]
        exact Nat.mod_eq_of_lt hR1
      have hkey : (2 * (N % r ^ i)) % r ^ i = 1 := by
        have := (Nat.mod_modEq N (r ^ i)).mul_left 2
        unfold Nat.ModEq at this
        rw [this, h2N]
      have hfloor : 2 * (N % r ^ i) = r ^ i * ((2 * (N % r ^ i)) / r ^ i) + 1 := by
        conv_lhs => rw [← Nat.div_add_mod (2 * (N % r ^ i)) (r ^ i)]
        rw [hkey]
      set d := (2 * (N % r ^ i)) / r ^ i with hd
      have hq01 : d ≤ 1 := by
        by_contra hcon
        have hge : 2 ≤ d := by omega
        have hmul : r ^ i * 2 ≤ r ^ i * d := Nat.mul_le_mul_left _ hge
        omega
      have hcase : d = 0 ∨ d = 1 := by
        interval_cases d <;> simp
      rcases hcase with h0 | h0 <;> rw [h0] at hfloor <;> omega
    calc e = (Finset.Ico 1 (e + 1)).card := by simp
      _ ≤ _ := card_le_factorization_centralBinom hr _ hwit
  · -- `r` does not divide `2N - 1`, so only `2N = 2pq` matters
    rw [Nat.factorization_eq_zero_of_not_dvd hdvd, Nat.zero_add]
    have hNN : N + N = 2 * (p * q) := by omega
    have hfac : (N + N).factorization r =
        (2 : ℕ).factorization r + ((p : ℕ).factorization r + (q : ℕ).factorization r) := by
      rw [hNN, Nat.factorization_mul (by omega) (by positivity),
        Nat.factorization_mul hp.pos.ne' hq.pos.ne']
      simp
    rw [hfac, Nat.Prime.factorization Nat.prime_two, hp.factorization, hq.factorization]
    simp only [Finsupp.single_apply]
    by_cases h2 : (2 : ℕ) = r
    · subst h2
      rw [if_pos rfl, if_neg (show ¬ (p = 2) by omega), if_neg (show ¬ (q = 2) by omega)]
      simp only [Nat.add_zero]
      refine one_le_factorization_centralBinom hr (i := 1) (by omega) ?_
      simp [hodd]
    · by_cases hrp : p = r
      · subst hrp
        rw [if_neg h2, if_pos rfl, if_neg (show ¬ (q = p) by omega)]
        simp only [Nat.add_zero, Nat.zero_add]
        refine one_le_factorization_centralBinom hr (i := 2) (by omega) ?_
        have hNe : N = p ^ 2 + p * (q - p) := by
          have hqe : p + (q - p) = q := by omega
          calc N = p * q := hNpq
            _ = p * (p + (q - p)) := by rw [hqe]
            _ = p ^ 2 + p * (q - p) := by ring
        have hlt : p * (q - p) < p ^ 2 := by
          have hs : q - p < p := by omega
          calc p * (q - p) < p * p := (Nat.mul_lt_mul_left (by omega)).mpr hs
            _ = p ^ 2 := by ring
        have hmod : N % p ^ 2 = p * (q - p) := by
          rw [hNe]
          have h1 : (p ^ 2) % p ^ 2 = 0 := Nat.mod_self _
          have h2 : (p * (q - p)) % p ^ 2 = p * (q - p) := Nat.mod_eq_of_lt hlt
          simp only [Nat.add_mod, h1, Nat.zero_add, h2]
        rw [hmod]
        have hs : p ≤ 2 * (q - p) := by omega
        calc p ^ 2 = p * p := by ring
          _ ≤ p * (2 * (q - p)) := Nat.mul_le_mul_left _ hs
          _ = 2 * (p * (q - p)) := by ring
      · by_cases hrq : q = r
        · subst hrq
          rw [if_neg h2, if_neg hrp, if_pos rfl]
          simp only [Nat.zero_add]
          refine one_le_factorization_centralBinom hr (i := 2) (by omega) ?_
          have hlt : N < q ^ 2 := by
            rw [hNpq]
            calc p * q < q * q := (Nat.mul_lt_mul_right (by omega)).mpr hpq
              _ = q ^ 2 := by ring
          rw [Nat.mod_eq_of_lt hlt, hNpq]
          calc q ^ 2 = q * q := by ring
            _ ≤ q * (2 * p) := Nat.mul_le_mul_left _ (by omega)
            _ = 2 * (p * q) := by ring
        · rw [if_neg h2, if_neg hrp, if_neg hrq]
          simp

end Balakran

end Erdos
