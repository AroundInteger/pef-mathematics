# PEF Mathematics — Research Companion

**Purpose:** This document guides the literature review and complementary-research check for the companion mathematics paper. It maps each of the paper's six contributions to the literature it intersects, flags priority search terms, and records novelty verdicts from the June 2026 review.

Use this alongside the manuscript draft (`main.tex`) and the empirical companion paper (`pef-empirical`).

**Literature review status:** Tier A and Tier B references in `references.bib`; Related Work in `sections/introduction.tex`; citations integrated in §§2–7 and Discussion. Priority-claim audit and manuscript fixes applied 2026-06-23 (see §12 below).

---

## 1. Canonical Form and Involution (§2)

### What we claim
- The substitution `τ = ½ log κ` collapses `η` to `cosh τ / (cosh τ − ρ)`.
- The map `κ ↦ 1/κ` acts trivially on `η` (exact involution).
- The four-quadrant empirical taxonomy is a 2:1 covering of the half-strip `τ ≥ 0`.

### Literature verdict (2026-06-22)

| Topic | Verdict | Key references |
|-------|---------|----------------|
| Fisher paired efficiency `1/(1−ρ)` | **Found** — primary source | `fisher1935` |
| Pitman–Morgan equal-variance test for paired margins | **Found** — related, not efficiency | `pitman1939`, `morgan1939` |
| Pitman (1948) ARE framework | **Found** — design efficiency context | `lehmann1999` (Ch. 14); Pitman 1948 lecture notes |
| Welch / Behrens–Fisher unequal variances | **Found** — **unpaired** design; distinguish | `welch1947` |
| Bose (1935) ratio of correlated variances | **Found** — historical neighbour for `κ` | `bose1935` |
| `τ = ½ log κ` as DOE/ANOVA parameterisation | **Not found** — Box (1953) and Brown & Forsythe (1974) checked; neither uses log-variance-ratio canonical coordinates | No cite needed for `τ`; see §11 |
| `κ ↦ 1/κ` symmetry of an efficiency statistic | **Novel interpretation** — symmetry immediate in `τ`; quadrant 2:1 cover is ours | — |

### Open questions
- ~~Direct JSTOR pass: Brown & Forsythe (1974), Box (1953)~~ — **closed** (2026-06-23): no `τ = ½ log κ` parameterisation found.
- Lehmann (1999) §14: ARE under label permutation — check for involution analogues (low priority).

---

## 2. Affine Linearisation and Chebyshev/Poisson Expansion (§3)

### What we claim
- `1/η = 1 − ρ sech τ` is affine in `ρ`; iso-η contours are hyperbolic cosines.
- Canonical form `η = cosh τ/(cosh τ − ρ)` is a Möbius fraction in `ρ` (hyperbolic coefficients).
- `η = (1+r²)/|1−r e^{iφ}|²` with `r = e^τ`, `φ = arccos ρ` (Poisson-kernel form; **not** the classical interior Poisson kernel).
- Geometric series `η = Σ (ρ sech τ)^k` on the fundamental domain; Chebyshev‑`U` cognate `η = (1+r²) Σ U_n(ρ) r^n` for `|r| < 1`.

### Literature verdict (2026-06-23)

| Topic | Verdict | Key references |
|-------|---------|----------------|
| Chebyshev generating function / `U_n` series | **Found** — machinery only | `rivlin1990` |
| Classical Poisson kernel `(1−r²)/|1−re^{iθ}|²` | **Found** — cognate, not identical | `garnett2007` |
| Our kernel `(1+r²)/|1−re^{iφ}|²` | **Novel application** — not the standard Poisson kernel | Manuscript states distinction |
| Geometric series `1/(1−ρ sech τ)` | **Found** — immediate from reciprocal form | — |
| Incorrect `T_n` expansion with factor 2 | **Removed** (2026-06-23) — was mathematically wrong | Replaced by geometric + `U_n` remark |
| AR(1) spectral density `∝ 1/(1−2φ cos ω + φ²)` | **Found** — structural parallel to `1/η` | Time-series texts; not paired efficiency |

### Open questions
- Bayesian DOE / GP priors on correlation: Poisson-kernel exploitation?
- Hardy-space / Toeplitz treatment (`Böttcher & Silbermann 1990`) — Discussion extension.

---

## 3. Sphere Realisation (§4)

### What we claim
- `cos σ = ρ sech τ = 2√κ ρ / (1+κ)` realises `(κ, ρ)` as a point on the unit sphere.
- `η = 1/(1 − cos σ)` — the Paired Efficiency Factor is an inverse spherical chord length.
- Verified at machine precision: max residual 8.88×10⁻¹⁶ across 113 KPI studies.

### Literature verdict (2026-06-23)

| Topic | Verdict | Key references |
|-------|---------|----------------|
| Correlation as dot product / angle on sphere | **Found** — general multivariate | Mardia, Kent & Bibby (1979); geometric expositions |
| Hyperspherical Cholesky parameterisation of correlation matrices | **Found** — **matrix** context, not scalar PEF | `joe2006`; Pourahmadi & Wang (2015) |
| `2√κ ρ / (1+κ)` as normalised-margin correlation | **Implicit** in bivariate-normal construction | Anderson (1984); Muirhead (1982) Ch. 5 |
| `η = 1/(1 − cos σ)` as efficiency / inverse versine | **Not found** | **Novel** — cite Joe for sphere context only |
| Fisher `κ=1` is a **meridian**; `ρ=0` is **equator** | Manuscript geometry | Fixed in intro contributions (2026-06-23) |
| Kendall / Dryden shape space | **Different object** — configuration shape, not design efficiency | Discussion only |

### Open questions
- Antipodal symmetry `σ ↦ π − σ` vs `κ ↦ 1/κ` involution — statistical interpretation?
- Spherical harmonics non-parametric extension?

---

## 4. Partition-Function Structure (§5)

### What we claim
- `log η = −log(1 − ρ sech τ)` is the log-partition function of a geometric exponential family with natural parameter `θ = log(ρ sech τ)`.
- Distribution-free cumulant identities: `E[N] = η − 1`, `Var[N] = η(η−1)`.
- Regime change at `ρ = 0`: the geometric series becomes sign-alternating.

### Literature verdict (2026-06-22)

| Topic | Verdict | Key references |
|-------|---------|----------------|
| Geometric exponential family / cumulant function | **Found** — textbook | `brown1986`, `coverThomas2006` |
| Bregman / partition-function divergences | **Found** — general framework | Banerjee et al. (2005); Nielsen MDPI 2024 |
| `log η` as CGF of geometric = efficiency statistic | **Not found** | **Distinctive theoretical claim** |
| GEE / paired longitudinal (Liang & Zeger; Moulton & Zeger) | **Found** — correlated data, different functional role | Tier B for Discussion |
| Fisher information → 0 at `η = 1` | **Found** — singular-FI theory | Le Cam (1960); Rotnitzky et al. (2000, Bernoulli) |
| Regime change at `ρ = 0` as phase transition | **Series sign change standard**; ML-residual prediction is ours | `davies1987` for LRT methodology |

### Open questions
- Siegmund (1985) change-point in exponential families — unchecked.
- Small-sample flat likelihood near pairing null — Le Cam connection.

---

## 5. Fisher–Rao Geometry and ψ Coordinate (§6)

### What we claim
- `ψ = 2 arctanh √(ρ sech τ)` is the Fisher–Rao arc length from independence.
- `Var(ψ̂) ≈ 1/n` uniformly across the half-strip.
- ψ is the natural meta-analytic scale for cross-domain pooling.

### Literature verdict (2026-06-23)

| Topic | Verdict | Key references |
|-------|---------|----------------|
| Fisher–Rao metric / information geometry | **Found** | `rao1945`, `chentsov1982`, `amari1985`, `amari2016` |
| Fisher `z = arctanh(ρ)` variance stabilisation | **Found** | `fisher1921`; `olkinPratt1958` for bias |
| `ψ` as Fisher–Rao arc length for PEF family | **Not found** | **Novel** — compare explicitly to Fisher `z` |
| Meta-analysis VST then pool | **Found** — paradigm | `dersimonianLaird1986`; Kulinskaya et al. (2012) |
| `ψ ↔ σ` link | **Found** — classical once lift fixed: `ψ = 2 arctanh √cos σ`, `σ = arccos(tanh²(ψ/2))` | Fixed in `fisher_rao.tex`, `discussion.tex` (2026-06-23) |
| Olkin–Pratt analogue for `ψ̂` | **Open** — no published correction found | Future work |

### Open questions
- Cochran's Q / I² on ψ scale — adapt standard meta-analysis?
- Burbea–Rao / geodesic distance on exponential family — Tier B.

---

## 6. Numerical Validation (§7)

### What we claim
- Symmetry test at machine precision across 20,016 `(κ̂, ρ̂)` estimates.
- Sphere equivalence at machine precision (max 8.88×10⁻¹⁶).
- CI widths scale as 1/√n across domains.
- Regime-change LRT detects slope discontinuity at ρ = 0.

### Literature verdict (2026-06-22)

| Topic | Verdict | Key references |
|-------|---------|----------------|
| Bootstrap CIs | **Found** | `efron1979` |
| Energy statistics / symmetry test | **Found** — methodology | `szekeleyRizzo2013` |
| Davies LRT for slope change-point | **Found** — methodology | `davies1987` |
| Hansen (2000) structural breaks | **Unchecked** | Optional for regime-change discussion |

---

## 7. Discussion and Extensions

### Tier B references (in `references.bib`; cited in Discussion)

| Reference | Bib key | Use |
|-----------|---------|-----|
| Anderson (1984) | `anderson1984` | Canonical correlations; multivariate PEF |
| Mardia, Kent & Bibby (1979) | `mardia1979` | Multivariate correlation geometry |
| Muirhead (1982) | `muirhead1982` | Correlation distribution theory |
| Pashley & Miratrix (2021) | `pashleyMiratrix2021` | Design-based variance, matched pairs |
| Rosenbaum (2002) | `rosenbaum2002` | Observational matched pairs; negative ρ |
| Liang & Zeger (1986) | `liangZeger1986` | GEE / correlated repeated measures |
| Pourahmadi & Wang (2015) | `pourahmadiWang2015` | Hyperspherical correlation matrices |

---

## 8. Priority Reading List

| Priority | Paper | Status | Bib key |
|----------|-------|--------|---------|
| 1 | Fisher (1935) *Design of Experiments* §24 | Read for citation | `fisher1935` |
| 2 | Amari (2016) Ch. 2–3 | In bib | `amari2016` |
| 3 | Cover & Thomas (2006) Ch. 8–9 | In bib | `coverThomas2006` |
| 4 | Brown (1986) | In bib | `brown1986` |
| 5 | Garnett (2007) Ch. 1–2 | In bib | `garnett2007` |
| 6 | Rivlin (1990) Ch. 1–2 | In bib | `rivlin1990` |
| 7 | Rao (1945) | In bib | `rao1945` |
| 8 | Olkin & Pratt (1958) | In bib | `olkinPratt1958` |
| 9 | Székely & Rizzo (2013) | In bib | `szekeleyRizzo2013` |
| 10 | DerSimonian & Laird (1986) | In bib | `dersimonianLaird1986` |

**Also in bib (Tier A):** `fisher1921`, `pitman1939`, `morgan1939`, `bose1935`, `joe2006`, `davies1987`, `efron1979`, `welch1947`.

---

## 9. Novelty Self-Check

| Claim | Status (2026-06-22) | Manuscript stance |
|-------|---------------------|-------------------|
| `η = cosh τ / (cosh τ − ρ)` canonical form | **Novel** — not found as named result | Claim as new canonical form |
| `κ ↦ 1/κ` involution trivial in `τ` | **Novel interpretation** — algebra immediate | Claim involution + 2:1 quadrant cover |
| `η = 1/(1 − cos σ)` sphere realisation | **Novel** — normalised-margin corr. implicit; inverse-chord reading not found | Claim theorem; acknowledge bivariate-normal antecedent |
| `log η` = geometric CGF / partition function | **Novel identification** for efficiency | **Distinctive theoretical contribution** |
| `ψ = 2 arctanh √(ρ sech τ)` Fisher–Rao arc length | **Novel** — Fisher `z` is closest analogue | Claim with explicit Fisher-`z` comparison |
| Regime change at `ρ = 0` | **Mathematical prediction novel**; Davies LRT is method | Present as prediction validated in §7 |

---

## 10. Citation Map by Section

| Section | Primary `\cite` keys | Role |
|---------|---------------------|------|
| Introduction | `fisher1935`, `brownPEFempirical` | Origin + extension |
| Related Work | All Tier A keys | Positioning |
| §2 Canonical | `fisher1935`, `pitman1939`, `morgan1939`, `bose1935`, `welch1947` | Anchor + distinguish |
| §3 Möbius | `rivlin1990`, `garnett2007` | Series + harmonic analysis |
| §4 Sphere | `joe2006` | Correlation-on-sphere context |
| §5 Partition | `brown1986`, `coverThomas2006` | Exponential family |
| §6 Fisher–Rao | `rao1945`, `amari2016`, `fisher1921`, `olkinPratt1958`, `dersimonianLaird1986` | Geometry + meta-analysis |
| §7 Numerical | `efron1979`, `szekeleyRizzo2013`, `davies1987` | Methods |
| Discussion | `anderson1984`, `mardia1979`, `muirhead1982`, `pashleyMiratrix2021`, `rosenbaum2002`, `liangZeger1986`, `pourahmadiWang2015`, `olkinPratt1958` | Extensions |

---

## 11. Search Strategy Notes

**Databases:** MathSciNet, zbMATH, JSTOR, arXiv stat.ME + stat.TH, Google Scholar.

**Key journals:** *Annals of Statistics*, *JRSS B*, *Biometrika*, *J. Multivariate Analysis*, *Information Geometry*, *Statistical Science*.

**Cross-check empirical companion:** §2.2 (involution), §5.2 (cumulants), §6.4 (ψ meta-analytic recipe), §5.3 (regime change).

**Gaps resolved (2026-06-23):**

| Gap | Verdict | Manuscript action |
|-----|---------|-------------------|
| Box (1953) / Brown & Forsythe (1974) — `τ = ½ log κ` in ANOVA? | **Not found.** Box (1953): robustness of variance *tests* under non-normality. Brown–Forsythe (1974): Levene-type homogeneity of *variances* across groups. Neither uses log-variance-ratio coordinates for paired efficiency. | No citation needed for canonical `τ`. |
| Anderson (1958) Ch. 4 — Chebyshev expansion of correlation? | **Not found** for our `η` series. Ch. 4 covers sampling distributions of correlation coefficients, not Chebyshev expansions of efficiency. | Keep Rivlin + geometric series only. |
| Siegmund (1985) — change-point in exponential families? | **Cognate but different design.** Sequential change-point / GLR in exponential families. Our regime at `ρ = 0` is a cross-sectional slope break in ML residuals. | Optional Discussion cite; **primary** cite remains `davies1987`. |
| Hansen (2000) — structural breaks? | **Cognate but different.** Threshold regression with unknown split; similar nuisance-parameter spirit to Davies but not the same test. | Optional one-line in Discussion. |

**Still optional (Tier C — cite only if expanding Discussion):**
- Banerjee et al. (2005, JMLR) — Bregman ↔ exponential-family bijection (supports §5 partition-function framing).
- Rotnitzky et al. (2000, Bernoulli) — singular Fisher information at `η = 1`.
- Davies (1977, Biometrika) — first paper in the Davies nuisance-parameter series.
- Pitman (1948) lecture notes — primary ARE source; empirical uses `lehmann1999` Ch. 14 as proxy.

---

*Last updated: 2026-06-23. Literature review + JSTOR gap check + cross-paper audit (§13).*

---

## 12. Manuscript corrections log (2026-06-23)

Priority-claim audit fixes applied to the draft:

| File | Change |
|------|--------|
| `sections/introduction.tex` | Contribution (iii): Fisher `κ=1` is a **meridian**, not equator; contribution (ii) softened from “Möbius image of disc” to affine/Poisson/geometric series |
| `sections/abstract.tex` | Same softening for §3 priority wording |
| `sections/mobius_chebyshev.tex` | Removed incorrect `T_n` Chebyshev expansion; replaced with geometric series + Chebyshev‑`U` cognate remark |
| `sections/fisher_rao.tex` | Corrected `ψ ↔ σ`: `σ = arccos(tanh²(ψ/2))` |
| `sections/discussion.tex` | Removed incorrect Mercator formula; same `ψ ↔ σ` identity |
| `README.source.md` | Priority-claims table for §3–§4 |

---

## 13. Cross-paper gap audit (empirical ↔ mathematics)

Checked 2026-06-23 against both manuscripts and `references.bib` files.

### Cross-citations (intentional split)

| Topic | Empirical | Math | Gap? |
|-------|-----------|------|------|
| PEF formula + quadrants | Owns data, ML, guidance | Cites `brownPEFempirical` | OK |
| Pitman ARE proof | Appendix `\ref{sec:pitman}` + `lehmann1999` | Related Work cites `lehmann1999` + `brownPEFempirical` | **Done** (2026-06-23) |
| `κ ↔ 1/κ` involution | Theory cites `brownPEFmath` | Full theory + §7 | **Done** (2026-06-23) |
| `ψ` scale / meta-analysis | Pipeline; Fig 3b → companion | Full §6 + `dersimonianLaird1986` | OK |
| Partition / cumulants | Gaussian MI under (A1)–(A2) | Distribution-free §5 | OK |
| Regime change at `ρ = 0` | ML residual pattern; Fig 3b | LRT + theory §6.3 | OK |

### References in math but missing from empirical

| Bib key | Why empirical might want it |
|---------|---------------------------|
| `pitman1939`, `morgan1939` | Align provenance in `theoretical_framework.tex` with math Related Work |
| `bose1935` | Historical neighbour for correlated variance ratios |
| `fisher1921`, `olkinPratt1958` | Only if empirical discusses correlation CI / bias (currently does not) |

**Status (2026-06-23):** `pitman1939`, `morgan1939` added to empirical `references.bib` and cited in `theoretical_framework.tex`.

### Provenance alignment issue (empirical)

In `theoretical_framework.tex`, the sentence citing `fisher1935,welch1947,cochran1977` for “unequal-variance paired designs” is **partially misaligned**:
- **Welch (1947)** is Behrens–Fisher for *independent* groups, not paired efficiency.
- **Cochran (1977)** is general DOE, not the PEF formula.

**Recommended empirical edit:** ~~replace `welch1947,cochran1977` with `pitman1939,morgan1939`~~ **Done** (2026-06-23); companion forward cite added in same subsection.

### Methodology alignment

| Check | Empirical | Math | Status |
|-------|-----------|------|--------|
| Symmetry audit CSVs | Pipeline generates | §7 imports | OK |
| Energy test L2.5 | Pipeline; not cited in empirical `.tex` | `szekeleyRizzo2013` cited | **Optional** empirical Methods cite |
| Davies LRT | Pipeline | `davies1987` cited | OK |
| Bootstrap | `efron1979` cited | `efron1979` cited | OK |

### Priority action list

1. ~~**Empirical Theory provenance** — fix Welch/Cochran sentence; add `pitman1939,morgan1939` (+ bib).~~ **Done** (2026-06-23).
2. ~~**Math Related Work or §2** — one cite to `lehmann1999` linking Pitman ARE to empirical appendix.~~ **Done** (2026-06-23): `sections/introduction.tex` Related Work.
3. ~~**Empirical Theory** — one sentence + `brownPEFmath` for involution/ψ/regime (beyond Fig 3b footnote).~~ **Done** (2026-06-23): `sections/theoretical_framework.tex` provenance subsection.
4. **Tier C bib (math, optional)** — `banerjee2005`, `siegmund1985`, `rotnitzky2000` if Discussion expanded.

---

## 14. Cross-paper alignment implementation log

| Date | Repo | File | Change |
|------|------|------|--------|
| 2026-06-23 | `pef-empirical` | `sections/theoretical_framework.tex` | Provenance cites: `fisher1935,pitman1939,morgan1939` (removed `welch1947,cochran1977`); added companion sentence for involution, $\psi$, cumulants, regime change (`brownPEFmath`). |
| 2026-06-23 | `pef-empirical` | `references.bib` | Added `pitman1939`, `morgan1939`. |
| 2026-06-23 | `pef-mathematics` | `sections/introduction.tex` | Related Work: Pitman ARE cross-link via `lehmann1999` and empirical appendix (`brownPEFempirical`). |
