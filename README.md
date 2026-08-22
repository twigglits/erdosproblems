# erdosproblems

Honest attempts at cracking open Erdős problems from https://www.erdosproblems.com

## State of the repository

| | |
|---|---|
| Lean files | 32 problem files plus `Basic` and `Audit`, all compiling |
| Correctly numbered **and** fully proved | **389, 396, 727, 458, 307** |
| Correctly numbered, still open in this repo | 135 |
| Mislabelled (number does not match the stated question) | 25 files — see `ATTRIBUTION_AUDIT.md` |

Read `ATTRIBUTION_AUDIT.md` before trusting any file's problem number.

## Open problems attacked

Both are **still open**.  In each case the work is an exact reduction, machine-checked in Lean,
plus a computation that closes a case the reduction leaves.

### Erdős 458 — `lean/Erdos/Erdos458.lean`, `458/`

> `lcm(1,...,p_{k+1}-1) < p_k * lcm(1,...,p_k)` for all `k`?

Reduced to an exact criterion about prime powers inside prime gaps.  Proved for every gap
holding at most two prime powers.  Searched over every prime power below `10^19`.

### Erdős 307 — `lean/Erdos/Erdos307.lean`, `307/`

> `1 = (Σ_{p ∈ P} 1/p)(Σ_{q ∈ Q} 1/q)` for finite sets of primes `P`, `Q`?

Reduced to a **2-cycle of the arithmetic derivative** on squarefree numbers, and from there to
a single test on one integer.  Consequence: the Ufnarovski–Åhlander conjecture implies the
answer is *no*.  The bound `|P ∪ Q| ≥ 60` is given a proof (the standard argument yields only
`59`).

## Build

```
cd lean && lake build          # needs elan; Lean 4.31.0 with Mathlib
cd 458  && cc -O2 -o verify458 verify458.c -lm && ./verify458 1000000000000
```

## Ground rules

* No `sorry` in anything reported as proved.
* No `native_decide`: every kernel-checked claim rests on
  `[propext, Classical.choice, Quot.sound]`, audited in `lean/Erdos/Audit.lean`.
* A C search is reported as a C search, never as a proof.
