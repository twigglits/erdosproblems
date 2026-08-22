# Attribution audit of the Lean problem files

Date: 2026-08-21.  Source of truth: the community database
[teorth/erdosproblems](https://github.com/teorth/erdosproblems) (`data/problems.yaml`),
the statements in [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures), and the problem pages on
erdosproblems.com.

## Why this file exists

Each Lean file in `lean/Erdos/` names an Erdős problem number and states a question in
its header.  For most files the number and the question do not agree.  The header
states a real mathematical question, but it is not the question that carries that
number.  Problem 40 was retracted for exactly this reason on 2026-08-20.  This audit
checks every remaining file.

A file marked MISMATCH is not wrong mathematics.  It is mislabelled.  The proof work
inside it says nothing about the Erdős problem whose number it carries.

## Result: 6 of 31 files carry the right number

| File | # | Verdict | The real problem | What the file claims |
|---|---|---|---|---|
| `Erdos4.lean` | [4](https://www.erdosproblems.com/4) | **MISLABELLED** | prime gaps: for any C>0 are there infinitely many n with p_{n+1}-p_n > C log n loglog n log^4 n/(log^3 n)^2 (Erdos-Rankin; $10000; proved by Ford-Green-Konyagin-Tao and by Maynard) | every (n+1)-subset of {1,...,2n} contains a coprime pair |
| `Erdos33.lean` | [33](https://www.erdosproblems.com/33) | **MISLABELLED** | additive basis: A subseteq N with every integer of the form n^2+a for some a in A | A+B for sets of positive density |
| `Erdos51.lean` | [51](https://www.erdosproblems.com/51) | **MISLABELLED** | totients: an infinite A with every a in A a totient, yet n_a/a -> infinity | AP-free sequences have density zero |
| `Erdos52.lean` | [52](https://www.erdosproblems.com/52) | **MISLABELLED** | sum-product: max(|A+A|,|AA|) >> |A|^{2-eps} ($250) | maximum number of unit distances among n points |
| `Erdos60.lean` | [60](https://www.erdosproblems.com/60) | **MISLABELLED** | every graph with more than ex(n;C_4) edges has >> n^{1/2} copies of C_4 | distinct differences among a_1<...<a_n <= 2n |
| `Erdos69.lean` | [69](https://www.erdosproblems.com/69) | **MISLABELLED** | irrationality of sum_{n>=2} omega(n)/2^n | maximum number of unit distances among n points |
| `Erdos71.lean` | [71](https://www.erdosproblems.com/71) | **MISLABELLED** | cycles of length in a given arithmetic progression (Erdos-Burr; proved by Bollobas) | maximum edges in a triangle-free graph |
| `Erdos72.lean` | [72](https://www.erdosproblems.com/72) | **MISLABELLED** | graph theory, cycles ($100, proved) - statement not the one in this file | maximum size of an AP-free subset of {1,...,N} |
| `Erdos73.lean` | [73](https://www.erdosproblems.com/73) | **MISLABELLED** | if every subgraph H has an independent set of size >= (n-k)/2, must G be bipartite plus O_k(1) vertices? | chi(G) * alpha(G) >= n |
| `Erdos86.lean` | [86](https://www.erdosproblems.com/86) | **MISLABELLED** | hypercube: every subgraph of Q_n with >= (1/2+o(1)) n 2^{n-1} edges contains a C_4 ($100) | infinitely many n with a prime divisor p > sqrt(n) |
| `Erdos100.lean` | [100](https://www.erdosproblems.com/100) | **MISLABELLED** | geometry/distances: is the diameter of A at least Cn? | equal row and column pairs in a 0-1 matrix |
| `Erdos116.lean` | [116](https://www.erdosproblems.com/116) | **MISLABELLED** | polynomials: for p(z)=prod(z-z_i) with |z_i|<=1, is |{z:|p(z)|<1}| > n - O(1)? | Borsuk conjecture on partitions of bounded sets |
| `Erdos135.lean` | [135](https://www.erdosproblems.com/135) | OK | n points in R^2 where every 4 determine >= 5 distances: must A determine >> n^2 distances? ($250, disproved by Tao 2024) | same |
| `Erdos150.lean` | [150](https://www.erdosproblems.com/150) | **MISLABELLED** | minimal cuts of a graph | Ramsey colourings and monochromatic cliques |
| `Erdos162.lean` | [162](https://www.erdosproblems.com/162) | **MISLABELLED** | F(n,alpha) for 2-colourings of K_n, discrepancy of induced subgraphs | a<b<c<d positive integers |
| `Erdos176.lean` | [176](https://www.erdosproblems.com/176) | **MISLABELLED** | N(k,l): discrepancy of +-1 colourings on k-term arithmetic progressions | size of sum-free sets in abelian groups |
| `Erdos195.lean` | [195](https://www.erdosproblems.com/195) | **MISLABELLED** | largest k with a monotone k-term AP in every permutation of Z | monochromatic paths in edge colourings |
| `Erdos197.lean` | [197](https://www.erdosproblems.com/197) | **MISLABELLED** | can N be split into two sets each permutable to avoid monotone 3-term APs? | chromatic number of euclidean distance graphs |
| `Erdos213.lean` | [213](https://www.erdosproblems.com/213) | **MISLABELLED** | n points in R^2, no 3 on a line, no 4 on a circle, all distances integers | maximum of sigma(n)/n^eps |
| `Erdos244.lean` | [244](https://www.erdosproblems.com/244) | **MISLABELLED** | does {p + floor(C^k)} have positive density? | covering the plane with congruent convex copies |
| `Erdos250.lean` | [250](https://www.erdosproblems.com/250) | **MISLABELLED** | irrationality of sum sigma(n)/2^n (proved by Nesterenko) | 2^n-1 with three distinct prime divisors |
| `Erdos307.lean` | [307](https://www.erdosproblems.com/307) | OK | are there finite sets of primes P, Q with (sum 1/p)(sum 1/q) = 1? | same |
| `Erdos342.lean` | [342](https://www.erdosproblems.com/342) | **MISLABELLED** | Ulam sequences: unique representation as a(i)+a(j) | maximum reciprocal sum of an AP-free set |
| `Erdos389.lean` | [389](https://www.erdosproblems.com/389) | OK | is there always k with n(n+1)...(n+k-1) | (n+k)...(n+2k-1)? | same |
| `Erdos396.lean` | [396](https://www.erdosproblems.com/396) | OK | is there always n with prod_{0<=i<=k}(n-i) | C(2n,n)? | same |
| `Erdos441.lean` | [441](https://www.erdosproblems.com/441) | **MISLABELLED** | largest A in {1,...,N} with lcm(a,b) <= N for all a,b in A | integers appearing in solutions (x,y,z) |
| `Erdos458.lean` | [458](https://www.erdosproblems.com/458) | OK | is lcm(1,...,p_{k+1}-1) < p_k lcm(1,...,p_k) for all k? | same |
| `Erdos519.lean` | [519](https://www.erdosproblems.com/519) | **MISLABELLED** | Turan power sums: must max_k |sum z_i^k| > c for z_1=1? | chromatic polynomials and greedy colouring |
| `Erdos548.lean` | [548](https://www.erdosproblems.com/548) | **MISLABELLED** | Erdos-Sos: every graph with (k-1)n/2+1 edges contains every tree on k+1 vertices | chromatic number relations |
| `Erdos632.lean` | [632](https://www.erdosproblems.com/632) | **MISLABELLED** | if G is (a,b)-choosable then G is (am,bm)-choosable | regions determined by hyperplanes |
| `Erdos727.lean` | [727](https://www.erdosproblems.com/727) | OK | for k>=2, does ((n+k)!)^2 | (2n)! hold for infinitely many n? | same |

## Effect on the earlier completeness claims

`PROGRESS.md` listed 7 problems as machine-verified with zero `sorry`: 162, 389, 396,
441, 519, 548, 727.  Of those, **162, 441, 519 and 548 carry the wrong number**.  The
Lean proofs in them are still valid proofs of the statements they contain, but those
statements are not Erdős 162, 441, 519 or 548.

Correctly numbered and fully proved: **389, 396, 727**, plus **458** and **307** (both added 2026-08-21).

## Files that carry no Erdős number

`ErdosCollatz.lean`, `ErdosGoldbach.lean`, `ErdosPerfectNumbers.lean` and
`ErdosTwinPrimes.lean` name classical conjectures, not numbered Erdős problems.  They
are outside the scope of this audit.

## What to do with a mislabelled file

Two honest repairs, per file:

1. Keep the mathematics and drop the number.  Rename the file after the question it
   actually asks.
2. Keep the number and replace the contents with the real statement, taken from the
   formal-conjectures repository.

Neither repair is applied yet.  Every mislabelled file now carries a warning banner in
its header so that no reader mistakes it for work on the numbered problem.

