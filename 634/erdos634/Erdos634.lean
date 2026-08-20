import Mathlib.NumberTheory.SumTwoSquares
import Mathlib.Tactic

/-!
# Erdős Problem #634 — the arithmetic of cutting a triangle into congruent triangles

**The problem (open).** *Find all `n` such that some triangle can be cut into `n`
congruent triangles.* The full set is **not known**: the smallest open case is `n = 19`.
Beeson proved `7` and `11` are impossible (*No triangle can be cut into seven congruent
triangles*), and conjectured no prime `≡ 3 (mod 4)` is possible.

**What is settled, and is formalized here.** The *constructions* known to work all
produce counts `N` of a specific arithmetic shape. Beeson's **Theorem 7**: for a tile
whose three angles are all rational multiples of `2π` (the classical, "commensurable-angle"
tilings — squares, biquadratic/sum-of-two-squares, the equilateral triple- and
hexagonal-square families), `N` must be

> a square, a sum of two squares, or `2`, `3`, or `6` times a square.

This file formalizes the **complete number theory of that set** — `BeesonForm` — with no
`sorry` and no axioms:

* `beesonForm_iff`        : the five families collapse to **three** (`Σ ∪ 3·□ ∪ 6·□`),
                            since `□` and `2·□ ⊆ Σ`.
* `beesonForm_mul_sq`     : `BeesonForm` is closed under `×k²` (subdividing each tile).
* `prime_beesonForm_iff`  : a **prime** `p` is a Beeson form `↔ p = 2 ∨ p = 3 ∨ p % 4 = 1`
                            — Fermat's two-square theorem, pinning the obstruction exactly.
* `not_beesonForm_of_prime_mod_four` + `not_beesonForm_seven / _eleven / _nineteen`:
                            the primes `≡ 3 (mod 4)` other than `3` (`7, 11, 19, 23, …`)
                            lie outside every classical construction — *why* `7, 11`
                            (proved) and `19` (open) are the hard cases.
* `not_beesonForm_of_oddPow` : Beeson's general "Remark" obstruction for composite `N`.
* `ClassicalTiling`       : the classical constructions encoded as an inductive family of
                            achievable tile-counts, with `classicalTiling_iff_beesonForm`
                            proving they realize **exactly** the Beeson forms.

**Scope / honesty.** This does *not* formalize Euclidean dissection from scratch; the
*existence* of each construction is the geometric content of Beeson's figures and is the
intended meaning of the `ClassicalTiling` constructors. Nor does it resolve the open
problem: Zhang's `γ = 2π/3` tilings (non-commensurable angles) can reach counts *outside*
`BeesonForm` (e.g. `7·n²` for large `n`), exactly the gap in which `n = 19` still lives.
What is proved here is the exact arithmetic dividing line organizing the whole problem.
-/

namespace Erdos634

/-- `n` is a sum of two squares. (Beeson's biquadratic family; also contains every
square `k² = k² + 0²` and every `2k² = k² + k²`.) -/
def Sum2Sq (n : ℕ) : Prop := ∃ a b : ℕ, n = a ^ 2 + b ^ 2

/-- **Beeson's "form of `N`" (Theorem 7).** The tile-counts realizable by a classical,
commensurable-angle tiling: a square, a sum of two squares, or `2`, `3`, `6` times a
square. -/
def BeesonForm (n : ℕ) : Prop :=
  (∃ k, n = k ^ 2) ∨ Sum2Sq n ∨ (∃ k, n = 2 * k ^ 2) ∨
    (∃ k, n = 3 * k ^ 2) ∨ (∃ k, n = 6 * k ^ 2)

/-- The five families collapse to three: squares and twice-squares are themselves sums of
two squares, so `BeesonForm n ↔ Sum2Sq n ∨ 3·□ ∨ 6·□`. -/
theorem beesonForm_iff (n : ℕ) :
    BeesonForm n ↔ Sum2Sq n ∨ (∃ k, n = 3 * k ^ 2) ∨ (∃ k, n = 6 * k ^ 2) := by
  constructor
  · rintro (⟨k, rfl⟩ | h | ⟨k, rfl⟩ | h | h)
    · exact Or.inl ⟨k, 0, by ring⟩
    · exact Or.inl h
    · exact Or.inl ⟨k, k, by ring⟩
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr h)
  · rintro (h | h | h)
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inr (Or.inl h)))
    · exact Or.inr (Or.inr (Or.inr (Or.inr h)))

/-- A square is `0` or `1` mod `4`. -/
private theorem sq_mod_four (m : ℕ) : m ^ 2 % 4 = 0 ∨ m ^ 2 % 4 = 1 := by
  rcases Nat.even_or_odd m with ⟨k, hk⟩ | ⟨k, hk⟩
  · left
    have : m ^ 2 = 4 * k ^ 2 := by rw [hk]; ring
    rw [this]; omega
  · right
    have : m ^ 2 = 4 * (k ^ 2 + k) + 1 := by rw [hk]; ring
    rw [this]; omega

/-- A sum of two squares is never `≡ 3 (mod 4)`. (The elementary half of the two-square
theorem; this is what excludes primes `≡ 3 (mod 4)`.) -/
theorem sum2sq_mod_four_ne_three {n : ℕ} (h : Sum2Sq n) : n % 4 ≠ 3 := by
  obtain ⟨a, b, rfl⟩ := h
  rcases sq_mod_four a with ha | ha <;> rcases sq_mod_four b with hb | hb <;> omega

/-- **Obstruction (Beeson, Corollary 1 / Theorem 7).** A prime `p ≡ 3 (mod 4)` other than
`3` is never a Beeson form: no classical construction can `p`-tile a triangle. -/
theorem not_beesonForm_of_prime_mod_four
    {p : ℕ} (hp : p.Prime) (h3 : p % 4 = 3) (hne : p ≠ 3) : ¬ BeesonForm p := by
  rw [beesonForm_iff]
  rintro (hsum | ⟨k, hk⟩ | ⟨k, hk⟩)
  · exact sum2sq_mod_four_ne_three hsum h3
  · rcases hp.eq_one_or_self_of_dvd 3 ⟨k ^ 2, hk⟩ with h | h
    · norm_num at h
    · exact hne h.symm
  · rcases hp.eq_one_or_self_of_dvd 3 ⟨2 * k ^ 2, by rw [hk]; ring⟩ with h | h
    · norm_num at h
    · exact hne h.symm

/-- **Positive direction.** Every prime that is `2`, `3`, or `≡ 1 (mod 4)` is a Beeson
form. The `≡ 1 (mod 4)` case is **Fermat's theorem on sums of two squares**. -/
theorem beesonForm_of_prime {p : ℕ} (hp : p.Prime)
    (h : p = 2 ∨ p = 3 ∨ p % 4 = 1) : BeesonForm p := by
  rw [beesonForm_iff]
  rcases h with rfl | rfl | h
  · exact Or.inl ⟨1, 1, by norm_num⟩
  · exact Or.inr (Or.inl ⟨1, by norm_num⟩)
  · haveI : Fact p.Prime := ⟨hp⟩
    obtain ⟨a, b, hab⟩ := Nat.Prime.sq_add_sq (p := p) (by omega)
    exact Or.inl ⟨a, b, hab.symm⟩

/-- **Exact characterization for primes.** A prime `p` is a Beeson form iff `p ∈ {2, 3}`
or `p ≡ 1 (mod 4)`. Equivalently: the primes excluded by all classical constructions are
exactly the primes `≡ 3 (mod 4)` other than `3` — `7, 11, 19, 23, 31, …`. -/
theorem prime_beesonForm_iff {p : ℕ} (hp : p.Prime) :
    BeesonForm p ↔ p = 2 ∨ p = 3 ∨ p % 4 = 1 := by
  refine ⟨fun hB => ?_, beesonForm_of_prime hp⟩
  by_contra hcon
  rw [not_or, not_or] at hcon
  obtain ⟨h2, h3, h1⟩ := hcon
  have hodd : p % 2 = 1 := hp.eq_two_or_odd.resolve_left h2
  exact not_beesonForm_of_prime_mod_four hp (by omega) h3 hB

/-- `7` is not a Beeson form. (Beeson: no `7`-tiling exists at all.) -/
theorem not_beesonForm_seven : ¬ BeesonForm 7 := by
  rw [prime_beesonForm_iff (by norm_num)]; decide

/-- `11` is not a Beeson form. (Beeson: no `11`-tiling exists at all.) -/
theorem not_beesonForm_eleven : ¬ BeesonForm 11 := by
  rw [prime_beesonForm_iff (by norm_num)]; decide

/-- `19` is not a Beeson form — so no *classical* construction tiles `19`. Whether *any*
triangle can be cut into `19` congruent triangles is the famous **open** case of #634. -/
theorem not_beesonForm_nineteen : ¬ BeesonForm 19 := by
  rw [prime_beesonForm_iff (by norm_num)]; decide

/-- **Beeson's Remark (general obstruction).** If `3 ∤ n` and some prime `q ≡ 3 (mod 4)`
divides `n` to an odd power, then `n` is not a Beeson form. (The prime results above are
the case `n = q`.) Uses Beeson's Lemma 2 = `Nat.eq_sq_add_sq_iff`. -/
theorem not_beesonForm_of_oddPow {n q : ℕ} (h3 : ¬ 3 ∣ n)
    (hq : q.Prime) (hq3 : q % 4 = 3) (hodd : Odd (padicValNat q n)) :
    ¬ BeesonForm n := by
  rw [beesonForm_iff]
  rintro (hsum | ⟨k, rfl⟩ | ⟨k, rfl⟩)
  · have hn0 : n ≠ 0 := by rintro rfl; exact h3 (dvd_zero 3)
    have hdvd : q ∣ n := by
      by_contra hd
      rw [padicValNat.eq_zero_of_not_dvd hd] at hodd
      exact absurd hodd (by decide)
    have hmem : q ∈ n.primeFactors := Nat.mem_primeFactors.mpr ⟨hq, hdvd, hn0⟩
    have heven : Even (padicValNat q n) := Nat.eq_sq_add_sq_iff.mp hsum q hmem hq3
    rw [Nat.even_iff] at heven
    rw [Nat.odd_iff] at hodd
    omega
  · exact h3 ⟨k ^ 2, by ring⟩
  · exact h3 ⟨2 * k ^ 2, by ring⟩

/-- `BeesonForm` is closed under multiplication by a square — geometrically, subdividing
every tile of an `n`-tiling into `m²` smaller copies gives an `m²·n`-tiling. -/
theorem beesonForm_mul_sq {n : ℕ} (m : ℕ) (h : BeesonForm n) : BeesonForm (m ^ 2 * n) := by
  rw [beesonForm_iff] at h ⊢
  rcases h with ⟨a, b, rfl⟩ | ⟨k, rfl⟩ | ⟨k, rfl⟩
  · exact Or.inl ⟨m * a, m * b, by ring⟩
  · exact Or.inr (Or.inl ⟨m * k, by ring⟩)
  · exact Or.inr (Or.inr ⟨m * k, by ring⟩)

/-- The classical, commensurable-angle tiling constructions, as the set of tile-counts
they realize. Each constructor records one construction proved in the literature
(quadratic / biquadratic / isosceles-split / equilateral triple-square / hexagonal), plus
closure under subdividing every tile into `m²` pieces. -/
inductive ClassicalTiling : ℕ → Prop
  | quadratic   (k : ℕ) (hk : 0 < k)              : ClassicalTiling (k ^ 2)
  | biquadratic (a b : ℕ) (h : 0 < a ^ 2 + b ^ 2) : ClassicalTiling (a ^ 2 + b ^ 2)
  | isosceles   (k : ℕ) (hk : 0 < k)              : ClassicalTiling (2 * k ^ 2)
  | triple      (k : ℕ) (hk : 0 < k)              : ClassicalTiling (3 * k ^ 2)
  | hexagonal   (k : ℕ) (hk : 0 < k)              : ClassicalTiling (6 * k ^ 2)
  | subdivide   {n : ℕ} (m : ℕ) (hm : 0 < m) (h : ClassicalTiling n) :
                                                    ClassicalTiling (m ^ 2 * n)

theorem classicalTiling_to_beesonForm {n : ℕ} (h : ClassicalTiling n) : BeesonForm n := by
  induction h with
  | quadratic k _      => exact Or.inl ⟨k, rfl⟩
  | biquadratic a b _  => exact Or.inr (Or.inl ⟨a, b, rfl⟩)
  | isosceles k _      => exact Or.inr (Or.inr (Or.inl ⟨k, rfl⟩))
  | triple k _         => exact Or.inr (Or.inr (Or.inr (Or.inl ⟨k, rfl⟩)))
  | hexagonal k _      => exact Or.inr (Or.inr (Or.inr (Or.inr ⟨k, rfl⟩)))
  | subdivide m _ _ ih => exact beesonForm_mul_sq m ih

theorem beesonForm_to_classicalTiling {n : ℕ} (hn : 0 < n) (h : BeesonForm n) :
    ClassicalTiling n := by
  rw [beesonForm_iff] at h
  rcases h with ⟨a, b, rfl⟩ | ⟨k, rfl⟩ | ⟨k, rfl⟩
  · exact ClassicalTiling.biquadratic a b hn
  · have hk : k ≠ 0 := by rintro rfl; simp at hn
    exact ClassicalTiling.triple k (Nat.pos_of_ne_zero hk)
  · have hk : k ≠ 0 := by rintro rfl; simp at hn
    exact ClassicalTiling.hexagonal k (Nat.pos_of_ne_zero hk)

/-- **The classical constructions realize exactly the Beeson forms** (for `n ≥ 1`). -/
theorem classicalTiling_iff_beesonForm {n : ℕ} (hn : 0 < n) :
    ClassicalTiling n ↔ BeesonForm n :=
  ⟨classicalTiling_to_beesonForm, beesonForm_to_classicalTiling hn⟩

/-- No classical construction yields a `7`-tiling. -/
theorem not_classicalTiling_seven : ¬ ClassicalTiling 7 :=
  fun h => not_beesonForm_seven (classicalTiling_to_beesonForm h)

/-- No classical construction yields an `11`-tiling. -/
theorem not_classicalTiling_eleven : ¬ ClassicalTiling 11 :=
  fun h => not_beesonForm_eleven (classicalTiling_to_beesonForm h)

/-- No classical construction yields a `19`-tiling (the open case). -/
theorem not_classicalTiling_nineteen : ¬ ClassicalTiling 19 :=
  fun h => not_beesonForm_nineteen (classicalTiling_to_beesonForm h)

/-! ### A decision procedure for the classical case

`BeesonForm` is decidable by bounded search, so classical tileability of any concrete `n`
is settled by `decide`. (Mathlib's `Decidable` instance for sums of two squares routes
through `padicValNat` and does not kernel-reduce; the bounded versions below do.) -/

/-- Bounded-search test for a sum of two squares. -/
def sum2SqB (n : ℕ) : Bool :=
  (List.range (n + 1)).any fun a => (List.range (n + 1)).any fun b => n == a ^ 2 + b ^ 2

theorem sum2SqB_iff (n : ℕ) : sum2SqB n = true ↔ Sum2Sq n := by
  simp only [sum2SqB, List.any_eq_true, List.mem_range, beq_iff_eq, Sum2Sq]
  constructor
  · rintro ⟨a, _, b, _, h⟩; exact ⟨a, b, h⟩
  · rintro ⟨a, b, h⟩
    have ha2 : a ^ 2 ≤ n := by rw [h]; exact Nat.le_add_right _ _
    have hb2 : b ^ 2 ≤ n := by rw [h]; exact Nat.le_add_left _ _
    have ha : a ≤ a ^ 2 := Nat.le_self_pow (by norm_num) a
    have hb : b ≤ b ^ 2 := Nat.le_self_pow (by norm_num) b
    exact ⟨a, by omega, b, by omega, h⟩

/-- Bounded-search test for `n = c · k²`. -/
def mulSqB (c n : ℕ) : Bool := (List.range (n + 1)).any fun k => n == c * k ^ 2

theorem mulSqB_iff {c : ℕ} (hc : 0 < c) (n : ℕ) :
    mulSqB c n = true ↔ ∃ k, n = c * k ^ 2 := by
  simp only [mulSqB, List.any_eq_true, List.mem_range, beq_iff_eq]
  constructor
  · rintro ⟨k, _, h⟩; exact ⟨k, h⟩
  · rintro ⟨k, h⟩
    have hk2 : k ^ 2 ≤ n := by rw [h]; exact Nat.le_mul_of_pos_left _ hc
    have hk : k ≤ k ^ 2 := Nat.le_self_pow (by norm_num) k
    exact ⟨k, by omega, h⟩

instance : DecidablePred Sum2Sq := fun n => decidable_of_iff _ (sum2SqB_iff n)
instance (n : ℕ) : Decidable (∃ k, n = 3 * k ^ 2) :=
  decidable_of_iff _ (mulSqB_iff (by norm_num) n)
instance (n : ℕ) : Decidable (∃ k, n = 6 * k ^ 2) :=
  decidable_of_iff _ (mulSqB_iff (by norm_num) n)
instance : DecidablePred BeesonForm := fun n => decidable_of_iff _ (beesonForm_iff n).symm

-- With the computable instances, `decide` settles concrete cases directly.
example : ¬ BeesonForm 7  := by decide
example : ¬ BeesonForm 11 := by decide
example : ¬ BeesonForm 19 := by decide
example : BeesonForm 12   := by decide
example : BeesonForm 27   := by decide

/-- **Complete machine-checked classification of the classical case for `n ≤ 30`.** These
ten values are exactly the `n ≤ 30` that NO classical (commensurable-angle) construction can
tile. Of them, `7` and `11` are *proved* untileable by any tile (Beeson); `19, 14, 15, 21,
22, 23, 28, 30` are not settled by classical methods — and `19` is the open case of #634. -/
example :
    (List.range 31).filter (fun n => decide (¬ BeesonForm n))
      = [7, 11, 14, 15, 19, 21, 22, 23, 28, 30] := by decide

/-! ### A fully-resolved neighbour: tilings by a tile *similar to* `ABC`

Snover–Waiveris–Williams (1991) completely classified the case where every tile is similar
to the big triangle (the "rep-tile" case, also underlying Erdős #633): the possible counts
are **exactly** `n²`, `n² + m²`, and `3n²`. Its arithmetic is `SnoverForm`, and it obeys the
*same* Fermat dividing line as the congruent case. -/

/-- Snover–Waiveris–Williams form: a sum of two squares (covers `n²` and `n²+m²`) or `3·□`. -/
def SnoverForm (n : ℕ) : Prop := Sum2Sq n ∨ ∃ k, n = 3 * k ^ 2

instance : DecidablePred SnoverForm := fun n =>
  inferInstanceAs (Decidable (Sum2Sq n ∨ ∃ k, n = 3 * k ^ 2))

/-- The resolved similar-tile classification sits inside the congruent classical set. -/
theorem snoverForm_le_beesonForm {n : ℕ} (h : SnoverForm n) : BeesonForm n := by
  rw [beesonForm_iff]
  rcases h with h | h
  · exact Or.inl h
  · exact Or.inr (Or.inl h)

/-- The **same** prime dividing line governs the resolved similar-tile classification:
a prime is a Snover form iff it is `2`, `3`, or `≡ 1 (mod 4)`. -/
theorem prime_snoverForm_iff {p : ℕ} (hp : p.Prime) :
    SnoverForm p ↔ p = 2 ∨ p = 3 ∨ p % 4 = 1 := by
  constructor
  · rintro (h | ⟨k, hk⟩)
    · have := sum2sq_mod_four_ne_three h
      rcases hp.eq_two_or_odd with h2 | hodd
      · exact Or.inl h2
      · exact Or.inr (Or.inr (by omega))
    · rcases hp.eq_one_or_self_of_dvd 3 ⟨k ^ 2, hk⟩ with h | h
      · norm_num at h
      · exact Or.inr (Or.inl h.symm)
  · rintro (rfl | rfl | h)
    · exact Or.inl ⟨1, 1, by norm_num⟩
    · exact Or.inr ⟨1, by norm_num⟩
    · haveI : Fact p.Prime := ⟨hp⟩
      obtain ⟨a, b, hab⟩ := Nat.Prime.sq_add_sq (p := p) (by omega)
      exact Or.inl ⟨a, b, hab.symm⟩

-- The congruent classical case is *strictly* richer than the similar-tile case:
-- `6` is `6·1²`-tileable but is neither a sum of two squares nor `3·□`.
example : BeesonForm 6 := (beesonForm_iff 6).mpr (Or.inr (Or.inr ⟨1, by norm_num⟩))
example : ¬ SnoverForm 6 := by decide

/-! ### Sanity checks and worked examples (all machine-checked) -/

-- Positive: values that *are* tileable, matching Beeson's figures.
example (n : ℕ) : BeesonForm (n ^ 2) := Or.inl ⟨n, rfl⟩       -- any square (Fig 3)
example : BeesonForm 3  := beesonForm_of_prime (by norm_num) (Or.inr (Or.inl rfl))    -- Fig 1
example : BeesonForm 13 :=                                    -- 13 = 3²+2² (biquadratic, Fig 4)
  beesonForm_of_prime (by norm_num) (Or.inr (Or.inr (by norm_num)))
example : BeesonForm 12 := (beesonForm_iff 12).mpr (Or.inr (Or.inl ⟨2, by norm_num⟩)) -- 3·2², Fig 9
example : BeesonForm 27 := (beesonForm_iff 27).mpr (Or.inr (Or.inl ⟨3, by norm_num⟩)) -- 3·3²
example : Sum2Sq 50 := ⟨5, 5, by norm_num⟩                    -- 50 = 5²+5² = 2·5² (Fig 16)

-- Negative: the obstruction values, via the mod-4 lemma (`7,11,19 ≡ 3 mod 4`).
example : ¬ Sum2Sq 7  := fun h => sum2sq_mod_four_ne_three h (by decide)
example : ¬ Sum2Sq 11 := fun h => sum2sq_mod_four_ne_three h (by decide)
example : ¬ Sum2Sq 19 := fun h => sum2sq_mod_four_ne_three h (by decide)
-- Positive witnesses.
example : Sum2Sq 13 := ⟨3, 2, by norm_num⟩
example : Sum2Sq 25 := ⟨3, 4, by norm_num⟩

end Erdos634
