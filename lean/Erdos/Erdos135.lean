/-
# Erdős Problem 135 (Erdős–Gyárfás)

> Let `A ⊆ ℝ²` be a set of `n` points such that any subset of size 4 determines at least
> 5 distinct distances. Must `A` determine `≫ n²` many distances?

Reference: https://www.erdosproblems.com/135

Original source: P. Erdős, *On some metric and combinatorial geometric problems*,
Discrete Math. **60** (1986), 147–153, p. 149, equation (8). Restated by Erdős at least
five further times, and recorded as Conjecture 6, p. 204 of Braß–Moser–Pach,
*Research Problems in Discrete Geometry* (Springer, 2005).

STATUS: **DISPROVED** by T. Tao, *Planar point sets with forbidden 4-point patterns and
few distinct distances*, arXiv:2409.01343 (2 September 2024).

IMPORTANT: the hypothesis "every 4 points determine at least 5 distinct distances" is a
RESTRICTION on `A`, not a claim that all 4-point sets satisfy it. Most 4-point sets do
not: Dumitrescu (Discrete Math. 343 (2020), 111967) classifies the eight configurations
π₁–π₈ that fail it, including the parallelogram and the collinear arithmetic progression.
Exhibiting such a configuration therefore refutes nothing.

This file states the problem. It does not prove it.
-/
import Erdos.Basic

namespace Erdos

open scoped Classical

/-- The set of the six pairwise distances determined by four points. -/
noncomputable def fourPointDistances (p₁ p₂ p₃ p₄ : ℝ × ℝ) : Set ℝ :=
  {dist p₁ p₂, dist p₁ p₃, dist p₁ p₄, dist p₂ p₃, dist p₂ p₄, dist p₃ p₄}

/-- Dumitrescu's property `Φ(4, k)`: every four distinct points of `S` determine at least
`k` distinct distances. For `k = 5` this is the hypothesis of Erdős Problem 135. -/
def FourPointBound (S : Set (ℝ × ℝ)) (k : ℕ) : Prop :=
  ∀ p₁ ∈ S, ∀ p₂ ∈ S, ∀ p₃ ∈ S, ∀ p₄ ∈ S,
    p₁ ≠ p₂ → p₁ ≠ p₃ → p₁ ≠ p₄ → p₂ ≠ p₃ → p₂ ≠ p₄ → p₃ ≠ p₄ →
    k ≤ (fourPointDistances p₁ p₂ p₃ p₄).ncard

/-- The number of distinct pairwise distances determined by `S`. -/
noncomputable def TotalDistances (S : Set (ℝ × ℝ)) : ℕ :=
  {d : ℝ | ∃ p ∈ S, ∃ q ∈ S, p ≠ q ∧ dist p q = d}.ncard

/-- **Erdős Problem 135.** Does the local property `Φ(4,5)` force a quadratic number of
distinct distances globally? -/
def Problem135 : Prop :=
  ∃ c > 0, ∀ S : Finset (ℝ × ℝ),
    FourPointBound (S : Set (ℝ × ℝ)) 5 →
    c * (S.card : ℝ) ^ 2 ≤ TotalDistances (S : Set (ℝ × ℝ))

/-- Tao (2024) answered Problem 135 in the negative: for arbitrarily large `n` there is an
`n`-point planar set satisfying `Φ(4,5)` with only `O(n² / √(log n))` distinct distances,
which is `o(n²)`. Formalizing that construction is a substantial separate project. -/
theorem problem_135_false : ¬ Problem135 := by
  sorry

/-- Erdős's stronger companion conjecture, also refuted by Tao (2024): a set satisfying
`Φ(4,5)` must contain `≫ n` points with all pairwise distances distinct. -/
def Problem135Stronger : Prop :=
  ∃ c > 0, ∀ S : Finset (ℝ × ℝ),
    FourPointBound (S : Set (ℝ × ℝ)) 5 →
    ∃ T ⊆ S, c * (S.card : ℝ) ≤ T.card ∧
      ∀ p ∈ T, ∀ q ∈ T, ∀ r ∈ T, ∀ s ∈ T,
        (p ≠ q → r ≠ s → (p, q) ≠ (r, s) → dist p q ≠ dist r s)

theorem problem_135_stronger_false : ¬ Problem135Stronger := by
  sorry

end Erdos
