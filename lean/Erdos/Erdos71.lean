/-
# Erdős Problem 71

> What is the maximum number of edges in a triangle-free graph on n vertices?

Reference: https://www.erdosproblems.com/71
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Triangle-free graph
def TriangleFree (edges : Set (ℕ × ℕ)) : Prop :=
  ∀ a b c : ℕ, (a,b) ∈ edges → (b,c) ∈ edges → (a,c) ∈ edges → False

-- Maximum edges in triangle-free graph
def MaxTriangleFreeEdges (n : ℕ) : ℕ :=
  sorry  -- Computed by Turán's theorem

-- Turán's theorem: ex(n, K₃) = ⌊n²/4⌋
theorem turan_theorem_triangle_free (n : ℕ) :
    MaxTriangleFreeEdges n = n * n / 4 := by
  sorry  -- Turán's theorem: tight bound

-- Extremal graph: complete bipartite K_{⌊n/2⌋,⌈n/2⌉} achieves bound
theorem turan_graph_optimal (n : ℕ) :
    ∃ edges : Set (ℕ × ℕ),
    TriangleFree edges ∧
    edges.ncard = n * n / 4 := by
  sorry  -- Construction via complete bipartite graph

-- Main conjecture: only bipartite graphs achieve equality
theorem erdos_71 :
    ∀ n : ℕ,
    ∀ edges : Set (ℕ × ℕ),
    edges.ncard = n * n / 4 →
    TriangleFree edges →
    ∃ A B : Set ℕ, (∀ a ∈ A, ∀ b ∈ B, (a,b) ∈ edges ∨ (b,a) ∈ edges) :=
  by sorry  -- Extremal graphs are bipartite

-- Related: Kővári–Sós–Turán bound for K_{s,t}-free graphs
def KovarisSosTuranBound (n s t : ℕ) : ℕ :=
  sorry  -- (1/2)(t-1)^(1/s) n^(2-1/s) + (s-1)n

theorem kovari_sos_turan (n s t : ℕ) (h : s ≥ t) :
    ∀ edges : Set (ℕ × ℕ),
    (∀ a b c d : ℕ, (a,c) ∈ edges → (a,d) ∈ edges → (b,c) ∈ edges → (b,d) ∈ edges → False) →
    edges.ncard ≤ KovarisSosTuranBound n s t := by
  sorry  -- Kővári–Sós–Turán theorem

end Erdos
