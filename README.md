# PEF mathematics — companion paper

Solo-authored mathematical companion to the empirical PEF paper in [`pef-empirical`](../pef-empirical).

## Scope

Distribution-free geometry of \(\eta = (1+\kappa)/(1+\kappa-2\sqrt{\kappa}\,\rho)\): canonical form, \(\kappa \leftrightarrow 1/\kappa\) symmetry, sphere and partition-function readings, Fisher–Rao coordinate \(\psi\). The bivariate-normal mutual-information link in the empirical paper is the Gaussian specialisation.

## Layout

```
pef-mathematics/
├── main.tex, sections/, references.bib
├── figures/                 % companion-specific figures (when drafted)
├── validation_inputs/       % CSVs imported from pef-empirical pipeline (§7)
└── .cursor/rules/           % empirical-paper + git workflow
```

## Numerical validation (§7)

**Do not** duplicate `run_paper_pipeline.m` here. Regenerate inputs in the empirical repo, then refresh:

```bash
EMPIRICAL=../pef-empirical
cp "$EMPIRICAL"/scripts/paper_pipeline/outputs/{kappa_symmetry_*,psi_*,pef_landscape_2season_geometry.csv} \
   validation_inputs/
```

Or re-run `paper/create_pef_mathematics_repo.sh` after a pipeline run.

## Compile

```bash
latexmk -pdf -bibtex- -e '$bibtex = q/biber %O %B;' main.tex
```

## Submission order

Empirical paper first; this companion preprints around the same time but does not gate empirical reproducibility.

## Archive

Development history lives in `UP1_PEF` (archived). These two repos are the maintained sources.
