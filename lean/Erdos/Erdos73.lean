/-
# Erdős Problem 73

> For a graph G, is χ(G) · α(G) ≥ n where χ is chromatic number and α is independence number?

Reference: https://www.erdosproblems.com/73

This file studies the product of chromatic number and independence number.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- Chromatic number χ(G) of a graph with vertices vertices
def ChromaticNumber (vertices : ℕ) : ℕ :=
  sorry

-- Independence number α(G): maximum independent set size
def IndependenceNumber (vertices : ℕ) : ℕ :=
  sorry

-- Key observation: vertex cover partitions into χ(G) independent sets
-- Therefore: α(G) * χ(G) ≥ vertices
theorem chromatic_independence_partition (vertices : ℕ) :
    let χ := ChromaticNumber vertices
    let α := IndependenceNumber vertices
    χ * α ≥ vertices := by
  -- A proper coloring partitions vertices into χ independent sets
  -- The largest set has size ≥ vertices / χ
  -- So α ≥ vertices / χ, giving α * χ ≥ vertices
  sorry

-- Equivalent form: χ(G) · α(G) ≥ |V|
theorem chromatic_independence_product (vertices : ℕ) :
    let χ := ChromaticNumber vertices
    let α := IndependenceNumber vertices
    χ * α ≥ vertices := chromatic_independence_partition vertices

end Erdos
