# erdosproblems

Honest attempts at cracking open Erdős problems from https://www.erdosproblems.com

## State of the repository

| | |
|---|---|
| Lean files | 31 problem files plus `Basic` and `Audit`, all compiling |
| Correctly numbered **and** fully proved | **389, 396, 727, 458** |
| Correctly numbered, still open in this repo | 135 |
| Mislabelled (number does not match the stated question) | 25 files — see `ATTRIBUTION_AUDIT.md` |

Read `ATTRIBUTION_AUDIT.md` before trusting any file's problem number.

## Erdős 458

The newest work is `lean/Erdos/Erdos458.lean` and `458/`.  It reduces

> `lcm(1,...,p_{k+1}-1) < p_k * lcm(1,...,p_k)`

to an exact criterion about prime powers inside prime gaps, proves the criterion for every gap
holding at most two prime powers, and reports a search over every prime power below `10^19`.
The problem remains open.  See `458/README.md`.

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
