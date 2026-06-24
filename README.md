# PEF mathematics — companion paper

Solo-authored mathematical companion to the empirical PEF paper in [`pef-empirical`](../pef-empirical).

**Project memory:** [`PEF_PROJECT_MEMORY.md`](PEF_PROJECT_MEMORY.md)  
**Roadmap:** canonical checklist in [`../pef-empirical/PAPER_ROADMAP.md`](../pef-empirical/PAPER_ROADMAP.md) (local stub: [`PAPER_ROADMAP.md`](PAPER_ROADMAP.md))  
**Literature / priority claims:** [`RESEARCH_README.md`](RESEARCH_README.md)

## Status

**First full draft** (2026-06-22): all sections (`abstract` through `discussion`, plus appendix) have prose; §7 reports numbers from `validation_inputs/` (empirical commit `5aa9cfc` per `_manifest.csv`).

**Polish still open before submission:**

- Wire `figures/Figure_4_sphere.png` into §4 (`\includegraphics` not yet added)
- §7.6 regime-change LRT: direction reported; full test statistics pending pipeline update
- Local compile check with `latexmk` (biber)

Empirical paper submits first; this companion preprints around the same time.

## Scope

Distribution-free geometry of \(\eta = (1+\kappa)/(1+\kappa-2\sqrt{\kappa}\,\rho)\): canonical form, \(\kappa \leftrightarrow 1/\kappa\) symmetry, sphere and partition-function readings, Fisher–Rao coordinate \(\psi\). The bivariate-normal mutual-information link in the empirical paper is the Gaussian specialisation.

## Layout

```
pef-mathematics/
├── main.tex, sections/, references.bib
├── figures/Figure_4_sphere.png   §4 sphere plot (script-generated)
├── validation_inputs/            CSVs + _manifest.csv (§7 provenance)
├── scripts/
│   ├── generate_figure_sphere.m  companion Fig 4
│   └── lib/                      mirrored pef_theory_helpers.m (read-only)
└── .cursor/rules/
```

## Numerical validation (§7)

**Do not** duplicate `run_paper_pipeline.m` here. Regenerate inputs in the empirical repo, then sync from the **empirical repo root**:

```bash
cd ../pef-empirical
bash scripts/paper_pipeline/sync_to_companion.sh
```

This copies eight CSVs (`kappa_symmetry_*`, `psi_*`, `pef_landscape_2season_geometry.csv`, `domain_summary.csv`, `table_numbers.csv`), mirrors `scripts/lib/pef_theory_helpers.m`, and writes `validation_inputs/_manifest.csv` with SHA256 provenance.

## Figures

Regenerate the companion sphere figure from this repo root:

```bash
/Applications/MATLAB_R2025b.app/bin/matlab -batch "cd('scripts'); run('generate_figure_sphere.m')"
```

Input: `validation_inputs/pef_landscape_2season_geometry.csv`. Output: `figures/Figure_4_sphere.png`.

## Compile

```bash
latexmk -pdf -bibtex- -e '$bibtex = q/biber %O %B;' main.tex
```

Requires pdfLaTeX + biber. UK English throughout.

## Archive

Development history lives in `UP1_PEF` (archived). These two repos are the maintained sources.
