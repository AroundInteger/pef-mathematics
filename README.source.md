# PEF Mathematics — Companion Paper

This folder contains the LaTeX project for the **mathematical companion** to the empirical PEF paper at [`../pef-empirical/`](../pef-empirical/).

## Scope

The empirical paper generalises Fisher's paired efficiency formula to unequal variances and validates the resulting Paired Efficiency Factor (PEF) across six domains. This companion paper develops the geometric and information-theoretic structure of the PEF formula:

- Canonical form on the half-strip $(|\tau|, \rho)$ with $\tau = \tfrac{1}{2}\log\kappa$.
- The $\kappa \leftrightarrow 1/\kappa$ involution.
- Affine linearisation (`1/η` affine in `ρ`), Poisson-kernel form, and geometric/Chebyshev‑`U` series.
- Riemann-sphere realisation $\eta = 1/(1 - \cos\sigma)$ with marked pole at independence.
- Partition-function reading $\log\eta = -\log(1 - \rho\,\operatorname{sech}\tau)$ as the cumulant generating function of a one-parameter geometric exponential family.
- Fisher–Rao geometry and the variance-stabilising coordinate $\psi = 2\operatorname{arctanh}\sqrt{\rho\,\operatorname{sech}\tau}$.

These results are distribution-free; the bivariate-normal mutual-information derivation in the empirical paper is the Gaussian specialisation of the more general partition-function reading.

## Authorship

Solo-authored (Rowan Brown). The empirical companion paper carries the group authorship needed for data access; this paper does not require those data, only the results derived from them.

## Status

**First full draft** (2026-06-22). All body sections have prose; §7 uses CSVs in `validation_inputs/` stamped by `_manifest.csv` (empirical commit `5aa9cfc`).

Open polish: include Figure 4 in §4 LaTeX; finalise §7.6 LRT statistics in the empirical pipeline; compile with biber before submission.

The empirical paper remains the immediate submission priority.

## Structure

```
pef-mathematics/
├── main.tex                          --- entry-point
├── references.bib                    --- companion bibliography
├── sections/
│   ├── abstract.tex
│   ├── introduction.tex              --- §1
│   ├── canonical_form.tex            --- §2
│   ├── mobius_chebyshev.tex          --- §3
│   ├── sphere_realisation.tex        --- §4
│   ├── partition_function.tex        --- §5
│   ├── fisher_rao.tex                --- §6
│   ├── numerical_validation.tex      --- §7
│   ├── discussion.tex                --- §8
│   └── appendix.tex
├── figures/Figure_4_sphere.png
├── scripts/generate_figure_sphere.m
├── scripts/lib/pef_theory_helpers.m  --- read-only mirror from empirical sync
└── validation_inputs/                --- §7 CSVs + _manifest.csv
```

Sections 4 and 5 are the headline novel identifications (sphere and partition-function reading). Priority-claim audit: `RESEARCH_README.md` (literature scan 2026-06-23).

## Relation to the empirical paper

The two papers cross-cite without circular dependency:

- Empirical paper cites this paper for geometric structure, $\psi$, partition-function identity, and the regime change at $\rho = 0$.
- This paper cites the empirical paper for six-domain validation data, the four-quadrant taxonomy, and ML numbers in §7.

Either paper is readable independently.

## Numerical pipeline

§7 numbers come from [`pef-empirical/scripts/paper_pipeline/`](../pef-empirical/scripts/paper_pipeline/). Refresh via:

```bash
cd ../pef-empirical
bash scripts/paper_pipeline/sync_to_companion.sh
```

Do not maintain a second pipeline here.

## Compilation

```bash
latexmk -pdf -bibtex- -e '$bibtex = q/biber %O %B;' main.tex
```

UK English throughout. All mathematics in LaTeX, no raw Unicode Greek.
