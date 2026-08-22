# Work queue

**RULE**: one problem at a time.  Never parallel.  Commit each before starting the next.

The old queue was built on the file headers in `lean/Erdos/`.  Those headers name the wrong
Erdős problems (see `ATTRIBUTION_AUDIT.md`), so the old queue pointed at problems the files do
not study.  It is replaced below.

## Ground truth

Take every problem number, statement and status from:

* `https://github.com/teorth/erdosproblems` — `data/problems.yaml`, the community database.
  It carries the status of all 1217 problems.
* `https://github.com/google-deepmind/formal-conjectures` — Lean statements for 611 of them.
* `https://www.erdosproblems.com/<n>` — the problem page and its literature notes.

Never take a statement from a file header in this repository without checking it there first.

## Done

| # | What | Where |
|---|---|---|
| 458 | Exact reduction to prime powers in prime gaps; settled for every gap holding at most two of them; search to `10^19` | `lean/Erdos/Erdos458.lean`, `458/` |
| 307 | Exact reduction to a 2-cycle of the arithmetic derivative; link to the Ufnarovski–Åhlander conjecture; `\|P ∪ Q\| ≥ 60` proved | `lean/Erdos/Erdos307.lean`, `307/` |
| 389 | Equivalent formulations and obstructions | `lean/Erdos/Erdos389.lean` |
| 396 | Large-prime obstruction | `lean/Erdos/Erdos396.lean` |
| 727 | Smoothness obstruction | `lean/Erdos/Erdos727.lean` |

## Next — repair before extending

1. **Decide the fate of each mislabelled file.**  For every row marked MISLABELLED in
   `ATTRIBUTION_AUDIT.md`, choose one:
   * keep the mathematics, drop the number, rename the file; or
   * keep the number, replace the contents with the real statement from formal-conjectures.
2. **Remove the `sorry` definitions.**  A `def f : ℕ := sorry` makes every theorem about `f`
   empty.  These exist in the files for 86, 100, 176, 197 and others.  Fix the definitions
   before touching the theorems.

## Then — new targets

Pick from the database by status, not by guesswork.  The productive classes are:

* **`falsifiable` (27 problems)** — open, but a finite search would disprove them.  A search is
  real evidence, and a hit would be a solution.  458 came from this class.
* **`decidable` (9)** — open, but reduced to a finite computation: 19, 475, 506, 547, 551, 556,
  580, 742, 848.  Check whether the finite bound is effective before starting; for 848 and 742
  it is not.
* **`verifiable` (7)** — open, provable by a finite computation if true: 7, 364, 366, 647, 672,
  835 (307 is done, above).
* **solved but not yet formalised (63)** — a complete Lean proof of one of these is a
  contribution to formal-conjectures.  The short ones are 48, 248, 822, 109, 277, 587, 1214.

## Workflow per problem

```
CHECK the number against teorth/erdosproblems and formal-conjectures
  ↓
COPY the formal statement from formal-conjectures if one exists
  ↓
REDUCE: look for an exact equivalent that is easier to attack
  ↓
FORMALISE the reduction in Lean, zero `sorry`, zero `native_decide`
  ↓
COMPUTE: search the reduced criterion as far as the hardware allows
  ↓
REPORT what is proved, what is searched, and what is still open — separately
```
