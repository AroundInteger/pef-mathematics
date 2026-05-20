# PEF Mathematics — Companion Paper

This folder contains the Overleaf project for the **mathematical companion** to the empirical PEF paper at [`../overleaf_pef_article/`](../overleaf_pef_article/).

## Scope

The empirical paper generalises Fisher's paired efficiency formula to unequal variances and validates the resulting Paired Efficiency Factor (PEF) across six domains. This companion paper develops the geometric and information-theoretic structure of the PEF formula:

- Canonical form on the half-strip $(|\tau|, \rho)$ with $\tau = \tfrac{1}{2}\log\kappa$.
- The $\kappa \leftrightarrow 1/\kappa$ involution.
- Möbius linearisation and Chebyshev/Poisson series.
- Riemann-sphere realisation $\eta = 1/(1 - \cos\sigma)$ with marked pole at independence.
- Partition-function reading $\log\eta = -\log(1 - \rho\,\operatorname{sech}\tau)$ as the cumulant generating function of a one-parameter geometric exponential family.
- Fisher–Rao geometry and the variance-stabilising coordinate $\psi = 2\operatorname{arctanh}\sqrt{\rho\,\operatorname{sech}\tau}$.

These results are distribution-free; the bivariate-normal mutual-information derivation in the empirical paper is the Gaussian specialisation of the more general partition-function reading.

## Authorship

Solo-authored (Rowan Brown). The empirical companion paper carries the group authorship needed for data access; this paper does not require those data, only the results derived from them.

## Status

**Scaffolded only.** The empirical paper is the immediate priority and should be submitted first. This companion will be drafted in parallel once the empirical paper is in final-draft form, and preprinted on arXiv around the same time as the empirical paper's submission.

## Structure

```
overleaf_pef_mathematics/
├── main.tex                          --- Overleaf entry-point
├── references.bib                    --- companion-specific bibliography (math/stats only)
├── README.md                         --- this file
├── sections/
│   ├── abstract.tex
│   ├── introduction.tex              --- §1: motivation and contributions
│   ├── canonical_form.tex            --- §2: cosh-τ form and κ↔1/κ symmetry
│   ├── mobius_chebyshev.tex          --- §3: Möbius linearisation and series expansion
│   ├── sphere_realisation.tex        --- §4: η as inverse spherical chord [novel]
│   ├── partition_function.tex        --- §5: CGF and the latent geometric family [novel]
│   ├── fisher_rao.tex                --- §6: ψ coordinate and meta-analytic scale
│   ├── numerical_validation.tex      --- §7: six-domain numerical validation
│   ├── discussion.tex                --- §8: information geometry and future work
│   └── appendix.tex                  --- detailed algebra and pseudocode
└── figures/                          --- planned figures listed in figures/.gitkeep
```

Sections 4 and 5 are the genuinely novel contributions; Sections 2, 3, and 6 are scaffolding (likely admit related forms elsewhere in the design-of-experiments / information-geometry literature and require a directed literature scan before drafting).

## Relation to the empirical paper

The two papers cross-cite without circular dependency:

- Empirical paper cites this paper for: the geometric structure, the $\psi$ coordinate, the partition-function identity, and the regime-change observation at $\rho = 0$. These are referenced as cited infrastructure rather than reproduced.
- This paper cites the empirical paper for: the six-domain validation data, the four-quadrant taxonomy as a teaching device, and the empirical machine-learning improvement numbers used in §7.

Either paper is readable independently. The companion does not depend on the empirical paper for any mathematical claim; the empirical paper does not depend on the companion for any reproducibility claim.

## Numerical pipeline

The numerical validation in §7 reuses the MATLAB pipeline at [`../overleaf_pef_article/scripts/paper_pipeline/`](../overleaf_pef_article/scripts/paper_pipeline/). New scripts (symmetry tests at all three levels, cumulant identity check, sphere-distance equivalence, $\psi$ stabilisation, regime-change LRT) are added to that pipeline rather than duplicated here, and this paper imports the resulting CSVs.

## Target venues (provisional)

In rough order of fit:

1. **Information Geometry** (Springer) — best fit for Sections 4–6 as headline contributions.
2. **Bernoulli** — strong methodological fit for the CGF identity and the $\psi$ coordinate.
3. **Journal of Multivariate Analysis** — appropriate if the operator-theoretic / Hardy-space extension (§3.5) is developed.
4. **Biometrika** — appropriate if the writing emphasises hypothesis testing and $\psi$ as a meta-analytic scale.

Final venue decision deferred until the draft is complete.

## Compilation

Standard Overleaf pdfLaTeX + biber. Locally:

```
cd paper/overleaf_pef_mathematics
latexmk -pdf -bibtex- -e '$bibtex = q/biber %O %B/' main.tex
```

UK English throughout (per [`../draft_v13_comprehensive_theoretical/documentation/OVERLEAF_BEST_PRACTICES.md`](../draft_v13_comprehensive_theoretical/documentation/OVERLEAF_BEST_PRACTICES.md)). All mathematics in LaTeX, no raw Unicode Greek.
