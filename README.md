# PEF mathematics — companion paper

Solo-authored mathematical companion to the empirical PEF paper in [`pef-empirical`](../pef-empirical).

**Project memory:** [`PEF_PROJECT_MEMORY.md`](PEF_PROJECT_MEMORY.md)  
**Roadmap:** canonical checklist in [`../pef-empirical/PAPER_ROADMAP.md`](../pef-empirical/PAPER_ROADMAP.md) (local stub: [`PAPER_ROADMAP.md`](PAPER_ROADMAP.md))  
**Literature / priority claims:** [`RESEARCH_README.md`](RESEARCH_README.md)

## Status

**First full draft** (2026-06-22): all sections (`abstract` through `discussion`, plus appendix) have prose; §7 reports numbers from `validation_inputs/` (empirical commit `5aa9cfc` per `_manifest.csv`).

**Polish still open before submission:**

- §7.6 regime-change LRT: direction reported; full test statistics pending pipeline update
- Local compile check with `latexmk` (biber)

**Figures (ideal main-text sequence):** `Figure_1` … `Figure_6` generated and cited in §§2–7 (2026-09-06).

Empirical paper submits first; this companion preprints around the same time.

## Scope

Distribution-free geometry of \(\eta = (1+\kappa)/(1+\kappa-2\sqrt{\kappa}\,\rho)\): canonical form, \(\kappa \leftrightarrow 1/\kappa\) symmetry, sphere and partition-function readings, Fisher–Rao coordinate \(\psi\). The bivariate-normal mutual-information link in the empirical paper is the Gaussian specialisation.

## Layout

```
pef-mathematics/
├── main.tex, sections/, references.bib
├── figures/
│   ├── Figure_1_halfstrip_domain.png
│   ├── Figure_2_mobius_linearisation.png
│   ├── Figure_3_sphere_theory.png
│   ├── Figure_4_psi_partition.png
│   ├── Figure_5_halfstrip_geometry.png
│   ├── Figure_5b_psi_stabilisation.png
│   └── Figure_6_sphere_empirical.png
├── validation_inputs/            CSVs + _manifest.csv (§7 empirical provenance)
├── scripts/
│   ├── generate_figures_companion_main.m   Figs 1–4
│   ├── generate_figure_geometry_model.m    Fig 5 / 5b
│   ├── generate_figure_sphere.m            Fig 6
│   ├── run_pef_geometry_numerical_model.m
│   ├── outputs/
│   └── lib/
└── .cursor/rules/
```

## Figures

Ideal main-text sequence (standalone companion numbering):

| Fig | File | Section | Script |
|-----|------|---------|--------|
| 1 | `Figure_1_halfstrip_domain.png` | §2 Canonical | `generate_figures_companion_main.m` |
| 2 | `Figure_2_mobius_linearisation.png` | §3 Möbius | same |
| 3 | `Figure_3_sphere_theory.png` | §4 Sphere | same |
| 4 | `Figure_4_psi_partition.png` | §5–6 Partition / ψ | same |
| 5 | `Figure_5_halfstrip_geometry.png` | §7 model | `generate_figure_geometry_model.m` |
| 5b | `Figure_5b_psi_stabilisation.png` | §7 model | same |
| 6 | `Figure_6_sphere_empirical.png` | §7 empirical | `generate_figure_sphere.m` |

```bash
cd scripts
/Applications/MATLAB_R2025b.app/bin/matlab -batch "run('generate_figures_companion_main.m')"
/Applications/MATLAB_R2025b.app/bin/matlab -batch "run('generate_figure_geometry_model.m')"   # needs outputs/
/Applications/MATLAB_R2025b.app/bin/matlab -batch "run('generate_figure_sphere.m')"            # needs validation_inputs/
```

## Numerical validation (§7)

1. **Half-strip geometry model** (this repo): `run_pef_geometry_numerical_model.m` → `scripts/outputs/`
2. **Empirical CSV witnesses:** sync from `pef-empirical` via `sync_to_companion.sh` (do not re-run the sports pipeline here)

The empirical idealised probit simulation stays in `pef-empirical`. The half-strip model here validates geometry without an outcome layer.

## Compile

```bash
latexmk -pdf -bibtex- -e '$bibtex = q/biber %O %B;' main.tex
```

Requires pdfLaTeX + biber. UK English throughout.

## Independent paper review

Structured review skill files live in the empirical repo:

**[`../pef-empirical/Paper Review Process/`](../pef-empirical/Paper%20Review%20Process/)**

For companion reviews, read `review-pef-papers.md` (scope boundaries, §7 CSV provenance, Mode D joint consistency with empirical). Default venue: **AoAS** (see empirical `TARGET_JOURNAL_MATRIX.md`).

## Archive

Development history lives in `UP1_PEF` (archived). These two repos are the maintained sources.
