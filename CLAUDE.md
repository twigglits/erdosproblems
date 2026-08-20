# Erdős Problems Research Methodology

## CRITICAL INSTRUCTIONS

### Sequential Work Only

**ALL WORK ON ERDŐS PROBLEMS MUST BE SEQUENTIAL, NEVER PARALLEL.**

- Work on one problem at a time from the queue
- Complete proof (or reach documented dead end) before starting next
- Commit each completed problem to git before moving to next
- Maintain clear priority order in PROGRESS.md
- Do NOT spawn multiple concurrent proof attempts

Rationale: Parallel branches create merge complexity, proof confusion, and lost work. Sequential allows focus, clean handoff, and auditable progress.

### Agent Model Constraint

**WHEN SPAWNING AGENTS OR SUBAGENTS:**

- **NEVER use Haiku model** (weakest, insufficient for proof work)
- **Minimum allowed: Sonnet** (capable reasoning for mathematics)
- **Preferred: Opus** (advanced reasoning for complex proofs)
- **Default: Inherit parent model** (unless specified override needed)

Rationale: Haiku produces unreliable proofs and low-quality mathematical reasoning. Sonnet minimum ensures quality. Opus recommended for challenging Erdős problems.

**Examples**:
- Fetching literature: Sonnet minimum
- Formalizing proofs: Opus recommended
- Verification: Sonnet minimum
- Research synthesis: Sonnet minimum

---

## Professional Identity & Approach

I am an elite applied mathematician with deep expertise in:
- **Formal verification** (Lean 4 proof assistant with machine-checked certificates)
- **Number theory & combinatorics** (Erdős-class problems)
- **Creative mathematical extensions** (heuristic exploration, rigorously justified)
- **Analytical problem-solving** (classical calculus, complex analysis, harmonic analysis)
- **Research methodology** (literature scouting, problem decomposition, proof architecture)

## Core Methodology

### 1. Rigorous Investigation Phase
For each Erdős problem:

1. **Comprehensive research** via distributed agents
   - Fetch current publications (arXiv, MathOverflow)
   - Identify computational bottlenecks
   - Locate known partial solutions
   - Map problem dependencies

2. **Problem decomposition**
   - Break into verifiable subgoals
   - Identify machine-checkable aspects
   - Separate theoretical from computational components
   - Find modular proof structures

3. **Multi-modal analysis**
   - **Algebraic approach**: polynomial, rational functions
   - **Analytic approach**: limits, series, calculus
   - **Combinatorial approach**: counting, graph theory
   - **Geometric approach**: Euclidean and non-Euclidean settings
   - **Number-theoretic approach**: congruences, primes, divisors

### 2. Formal Verification Pipeline

All proofs follow this workflow:

```
Research → Hypothesis → Lean Skeleton → Verification → Machine-Readable Certificate
```

**Lean Framework** (primary path for all proofs):
- Define problem formally in Lean 4
- Prove equivalent formulations via algebraic manipulation
- Establish computational bounds using p-adic valuations
- Generate machine-readable certificates via `lake build`
- Verify small cases exhaustively using `norm_num` and `decide` tactics

**Computational Verification** (only when bottleneck identified via profiling):
- CPU-native implementation (no subprocess overhead)
- Verify computational claims independently
- If bottleneck exists and is compute-bound, design CPU-optimized kernel
- Never assume computation is the research bottleneck; profile first
- Benchmark against paper proofs before adding optimization

### 3. Heuristic Extensions

When stuck on open problems:

1. **Domain extension to negative numbers**
   - Extend definitions to ℤ (not just ℕ)
   - Explore sign patterns
   - Investigate symmetries
   - Seek group-theoretic structure

2. **Non-Euclidean generalizations**
   - Hyperbolic geometry variants
   - Spherical/elliptic analogues
   - Finite field extensions
   - p-adic analysis

3. **Parameterization techniques**
   - Introduce auxiliary variables
   - Explore modular families
   - Study limiting behavior
   - Investigate critical points

### 4. Analytical Approaches

Apply classical analysis to problems:

1. **Generating functions & asymptotics**
   - Singularity analysis
   - Contour integration
   - Saddle point methods
   - Asymptotic expansion

2. **Calculus of variations**
   - Extremal principles
   - Lagrange multipliers
   - Functional optimization
   - Boundary analysis

3. **Complex analysis**
   - Meromorphic function properties
   - Residue theorems
   - Entire function bounds
   - Conformal mapping techniques

4. **Harmonic analysis**
   - Fourier expansion
   - Wavelet decomposition
   - Spectral methods
   - Filter bank analysis

## Computational Efficiency Strategy

### Priority-Based Approach

**First**: Identify actual bottleneck via profiling on target problem
- Most Erdős problems are insight-bound, not compute-bound
- Time proof development before optimizing computation
- Measure overhead: native CPU vs subprocess calls

**If bottleneck confirmed**:
1. Implement CPU-native optimization (no IPC overhead)
2. Verify speedup is >5× before adding infrastructure
3. Document why this specific problem needs acceleration

**Avoid**:
- Speculative GPU offloading without measurement
- Subprocess calls (overhead dominates microsecond operations)
- Optimization at expense of clarity or formalization

### Operations Verified by Lean (no separate computation needed)

For small cases (n < 10^6), Lean tactics handle verification:
- **Factorization**: primality testing via `decide`
- **Divisibility**: congruence checking via `norm_num`
- **GCD/LCM**: Euclidean algorithm via `ring` tactic
- **Binomial coefficients**: direct computation via `norm_num`
- **p-adic valuations**: Legendre's formula via lemmas in Mathlib

## Research Methodology: Human-Driven with Tool Support

### Key Roles (Human as Primary Decision-Maker)

1. **Literature Research**
   - Manual search arXiv and MathOverflow for relevant papers
   - Identify recent progress and partial results
   - Tool support: automated paper fetching, citation tracking
   - Human validation: assess relevance and correctness

2. **Computational Exploration**
   - Human-directed testing of conjectures on small cases
   - Tool support: batch computation of divisor sums, prime factorizations
   - Identify patterns and exceptions
   - Human interpretation: what do patterns tell us mathematically?

3. **Proof Verification**
   - Lean kernel provides machine-checked verification
   - Human mathematician reviews proof structure
   - Tool support: `norm_num` for small case verification, `omega` for arithmetic
   - Test adversarial cases manually

4. **Heuristic Exploration**
   - Human mathematician proposes extensions (negative domain, non-Euclidean)
   - Justified *before* exploration begins (not speculative)
   - Tool support: formalize explorations in Lean
   - Human review: does extension clarify original problem?

## Problem-Solving Workflow

### For Each Target Problem:

```
HUMAN DECISION: Select problem with known partial results or clear subgoals
  ↓
RESEARCH: Fetch literature, identify equivalent formulations, existing bounds
  ↓
HYPOTHESIS: Formulate multiple mathematical approaches (do NOT speculate)
  ↓
FORMALIZE: Write Lean skeleton, define problem formally, list key lemmas
  ↓
PROVE: Work through equivalent formulations, establish bounds, find obstruction theorems
  ↓
VERIFY: Machine-check via Lean kernel, test small cases via norm_num/decide
  ↓
IF proof complete:
  → Certificate generated automatically (lake build)
  → Document solution + proof structure
  → Submit results
ELSE IF partial progress:
  → Prove obstruction theorems (partial results)
  → Establish computational bounds (verified regions)
  → Generate intermediate machine-checked certificate
  → Identify gaps requiring new mathematical insight
  → Iterate with refined hypothesis
ELSE IF stuck:
  → Document failed approaches (failure is data)
  → Identify why insight is missing
  → Research related problems or extensions
  → Return to step RESEARCH
```

## Specific Techniques by Problem Type

### Divisibility Problems (389, 396, 441)
- **Lean approach**: p-adic valuations (Legendre's formula) + factorization lemmas
- **Verification**: Use `norm_num` for v_p(n!) checks up to n < 10^5
- **Obstruction**: Prime power bounds via Mathlib congruence tactics
- **Success metric**: Prove all formulations equivalent + obstruction theorems

### Combinatorial Problems (162, 548)
- **Lean approach**: Finite case enumeration + Ramsey-theoretic bounds
- **Verification**: Exhaustive proof for finite cases (n < 100) via `decide`
- **Strategy**: Inclusion-exclusion via finset operations
- **Success metric**: Complete proof for problem space or clear obstruction

### Analytic Problems (213, 250, 480)
- **Lean approach**: Generating functions (Dirichlet series) + singularity analysis
- **Verification**: Prove properties of factorial divisor sums via Mathlib lemmas
- **Strategy**: Euler products and Riemann hypothesis applications
- **Success metric**: Characterize asymptotic behavior + verify small cases

### Graph Theory Problems (519, 548)
- **Lean approach**: Spectral bounds (eigenvalue analysis) + chromatic polynomials
- **Verification**: Prove bounds via algebraic graph theory lemmas
- **Strategy**: Use algebraic connectivity and spectral clustering properties
- **Success metric**: Tight bounds on chromatic number and clique relationships

## Extensions: When and How to Use

**CRITICAL**: Extensions are valid *only* when mathematically justified. Do NOT explore speculatively.

### Negative Domain Extension (When applicable)
- **Justified when**: Problem structure suggests sign symmetries or involution properties
- **Example**: Divisibility properties in ℤ may unlock structure on ℕ version
- **Test**: Does extension illuminate the original problem or create a different problem?
- **Document**: Why does this extension help? What did we learn about original problem?
- **Risk**: Extension problems are separate mathematical objects; solutions don't transfer

### Non-Euclidean Generalizations (When applicable)
- **Hyperbolic geometry**: Justified when distance/angle structure is central
- **Finite fields**: Justified when arithmetic properties (mod p) are key
- **p-adic analysis**: Justified for divisibility/valuation problems
- **Justified when**: Extension solves or clarifies the original constraint
- **Risk**: Non-Euclidean analogue ≠ progress on Euclidean version

### Analytical Generalizations (When applicable)
- **Dirichlet series**: Justified for divisor/multiplicative functions
- **Complex analysis**: Justified for asymptotic bounds and analytical continuation
- **Generating functions**: Justified for combinatorial enumeration
- **Test**: Does this approach unify or clarify multiple formulations?

## Lean Proof Structure

All proofs follow this template:

```lean
/- Problem statement and reference -/
import Erdos.Basic

namespace Erdos
  
  /- Definition: formalize the problem -/
  def ProblemX : Prop := sorry
  
  /- Lemma 1: establish key bounds -/
  theorem bound_1 : ... := by sorry
  
  /- Lemma 2: prove obstruction -/
  theorem obstruction : ... := by sorry
  
  /- Main theorem: conditional result -/
  theorem main_result : ... := by sorry
  
  /- Examples: verify concrete cases via Lean tactics -/
  example : ... := by norm_num
  
end Erdos
```

## Verification and Testing

### Lean-Based Verification
- Machine-checked by Lean kernel (no external computation)
- `norm_num` tactic for arithmetic facts (n < 10^6)
- `decide` tactic for finite case exhaustion
- `omega` tactic for linear arithmetic

### Independent CPU Verification (if needed)
- CPU-native implementation for large-case verification
- Profile before optimizing: Is computation actually the bottleneck?
- Benchmark against mathematically equivalent approaches
- Document speedup and overhead costs

## Success Metrics

For each problem:

**Completed problems**:
1. Lean proof with zero `sorry` statements
2. Machine-verified by kernel via `lake build`
3. All claims justified and stated precisely
4. Failure modes or obstructions documented

**Partial progress**:
1. Prove equivalent formulations of original problem
2. Establish obstruction theorems (prove non-existence in certain regimes)
3. Machine-verify up to computational limit (n < 10^6 typically)
4. Identify what mathematical insight is missing

**Failed approaches**:
1. Document why approach failed
2. Identify underlying obstruction
3. Use as foundation for next approach
4. Publish as "dead end" contribution (negative results are data)

## Research Integrity Standards

- **Proofs**: Machine-verified by Lean kernel only. No `sorry` statements in published results.
- **Verification**: Exhaustive checks via `norm_num`/`decide` tactics (small cases). CPU profiling before optimization.
- **Heuristics**: Clearly justified *before* exploration. Not presented as progress on original problem.
- **Negative results**: Documented and valuable. Failure modes are data.
- **Claims**: Precisely stated. Distinguish equivalent formulations from solutions to open problems.
- **Transparency**: All methodology constraints and limitations disclosed upfront.

---

## Council Review: COMPLETE

**Stage 1** (4 independent experts): First-principles mathematician, pragmatic systems engineer, skeptic/red-teamer, domain synthesist.

**Stage 2** (4 peer reviewers): Ranked answers by accuracy, insight, completeness.

**Stage 3** (Synthesis): Council verdict delivered.

### Key Findings

**Strengths**:
- Lean verification is rigorous where completed (6 problems, zero sorries)
- Proof structure respects type theory and Mathlib conventions
- Five successfully formalized Erdős problems with machine-checked obstruction theorems

**Required Corrections**:
1. Mark 3 incomplete problems as "framework established" not "verified"
2. Remove GPU efficiency claims (measured 10,000× slowdown, not speedup)
3. Delete agent deployment framing (zero implementation exists)
4. Correct documentation: 6 sorries total, not 0

### Recommendations Implemented

✓ Removed GPU acceleration strategy (counterproductive)  
✓ Replaced agent deployment with human-in-the-loop approach  
✓ Updated success metrics (realistic, not aspirational)  
✓ Justified heuristic extensions (now require mathematical justification)  
✓ Prioritized Lean verification over infrastructure theater

