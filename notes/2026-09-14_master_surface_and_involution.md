# Research note: the relativisation-gain master surface and the $\kappa\leftrightarrow1/\kappa$ involution

**Date:** 14 September 2026
**Provenance:** finding obtained in the empirical repository `pef-empirical`
(idealised probit simulation, Supplementary Note S2, Figure S4b).
This note records how that outcome-layer result interacts with the
companion's canonical geometry, and flags a possible extension on the
$\kappa\leftrightarrow1/\kappa$ looped domain. It is a pointer, not a
manuscript edit; the outcome/ML layer remains empirical-owned.

## 1. The empirical finding (summary)

Under assumptions (A1)–(A2) — bivariate normal $(X_A,X_B)$ and probit link
$Y\sim\mathrm{Bernoulli}\big(\Phi(X/\sqrt{\operatorname{Var}X})\big)$ with
$X=X_A-X_B$ — the machine-learning gain from relativisation
($\Delta\mathrm{ML}$, relative minus absolute cross-validated accuracy)
is an almost deterministic function of just **two** canonical coordinates:

$$
d_{\mathrm{rel}}=\frac{\delta}{\sqrt{\operatorname{Var}X}}
=\frac{\delta}{\sigma_A}\sqrt{\frac{\eta}{1+\kappa}},
\qquad
r=\operatorname{corr}(X_A,X)=\frac{1-\rho\sqrt{\kappa}}{\sqrt{1+\kappa-2\sqrt{\kappa}\,\rho}}
=(1-\rho\sqrt{\kappa})\sqrt{\frac{\eta}{1+\kappa}}.
$$

The relative-feature accuracy depends on $d_{\mathrm{rel}}$ **alone**,
$\mathrm{acc}_R=g(d_{\mathrm{rel}})=\mathbb{E}_{u\sim N(0,1)}\Phi(|d_{\mathrm{rel}}+u|)$,
while the absolute-feature accuracy also needs $r$,
$\mathrm{acc}_A(d_{\mathrm{rel}},r)=\mathbb{E}_{w\sim N(0,1)}
\Phi\!\big(|d_{\mathrm{rel}}+rw|/\sqrt{2-r^2}\big)$. Hence

$$
\Delta\mathrm{ML}=100\,\frac{g(d_{\mathrm{rel}})-\mathrm{acc}_A(d_{\mathrm{rel}},r)}{\mathrm{acc}_A(d_{\mathrm{rel}},r)}
=F(d_{\mathrm{rel}},r),
$$

which reproduces the simulated gain at $r=0.9998$ over the 64-cell grid and is
bracketed by two closed-form envelopes at each $d_{\mathrm{rel}}$:

$$
\underbrace{0}_{r\to1\ \text{(floor)}}\ \le\ \Delta\mathrm{ML}\ \le\
\underbrace{100\Big(\tfrac{g(d_{\mathrm{rel}})}{\Phi(d_{\mathrm{rel}}/\sqrt2)}-1\Big)}_{r\to0\ \text{(ceiling)}}.
$$

## 2. Why this touches the companion

The companion's central symmetry is that $\eta$ is invariant under the
involution $\kappa\leftrightarrow1/\kappa$ (equivalently $\tau\mapsto-\tau$ with
$\tau=\tfrac12\log\kappa$):

$$
\eta(\kappa,\rho)=\frac{1+\kappa}{1+\kappa-2\sqrt{\kappa}\,\rho}=\eta(1/\kappa,\rho).
$$

The new result says the *predictive observables* built on top of $\eta$ do **not**
inherit this invariance. Two precise statements (both verified numerically):

1. **The signal coordinate is equivariant, not invariant.**
   Using $\operatorname{Var}_X(1/\kappa,\rho)=\operatorname{Var}_X(\kappa,\rho)/\kappa$
   (immediate from $1+1/\kappa-2\rho/\sqrt{\kappa}=(1+\kappa-2\rho\sqrt{\kappa})/\kappa$),
   at fixed $\delta/\sigma_A$ the signal coordinate obeys the clean law

   $$
   d_{\mathrm{rel}}(1/\kappa,\rho)=\sqrt{\kappa}\;d_{\mathrm{rel}}(\kappa,\rho).
   $$

   So $d_{\mathrm{rel}}=(\delta/\sigma_A)\sqrt{\eta/(1+\kappa)}$ is *not*
   $\kappa\leftrightarrow1/\kappa$ invariant, even though $\eta$ is: the *same*
   efficiency maps to *two different* predictive signals, related by the factor
   $\sqrt{\kappa}$. (Example: $\kappa=2,\rho=-0.3,\delta/\sigma_A=0.5$ gives
   $d_{\mathrm{rel}}=0.255$ at $\kappa$ versus $0.360=\sqrt{2}\cdot0.255$ at $1/\kappa$.)

2. **The two sheets exchange the absolute reference.**
   Writing $r_A=\operatorname{corr}(X_A,X)$ and $r_B=\operatorname{corr}(X_B,X)$,
   one finds

   $$
   r_B(\kappa,\rho)=-\,r_A(1/\kappa,\rho).
   $$

   Since $\mathrm{acc}_A$ depends on $r$ only through $|r|$ (it is even in $r$),
   the involution $\kappa\leftrightarrow1/\kappa$ acts on the outcome layer as the
   relabelling $X_A\leftrightarrow X_B$ of "which arm is the absolute yardstick".
   (Verified: $r_B=-0.874$ at $\kappa=2$ equals $-r_A$ at $1/\kappa=0.5$.)

In short: **attaching a Gaussian outcome/ML layer lifts the $\kappa\leftrightarrow1/\kappa$
symmetry that $\eta$ preserves.** The invariant ($\eta$) organises the geometry; the
gain lives on a two-coordinate surface $(d_{\mathrm{rel}},r)$ that carries a
non-trivial representation of the involution.

## 3. Possible extension (companion-owned)

Not like-for-like — the probit/ML layer stays in the empirical paper — but the
following are natural companion-side questions on the looped domain:

- **Equivariance on the half-strip / sphere.** How do $d_{\mathrm{rel}}$ and $|r|$
  transform under $\tau\mapsto-\tau$? The pair $(d_{\mathrm{rel}},|r|)$ appears to be
  the smallest set of coordinates on which the gain is a genuine function; is it a
  natural chart on the companion's half-strip, and what is the image of the
  involution fold there?
- **Signal transport that restores invariance.** The equivariance factor
  $\sqrt{\kappa}$ is undone by transporting the signal as
  $\delta/\sigma_A\mapsto(\delta/\sigma_A)/\sqrt{\kappa}$ (equivalently
  $\sigma_A\mapsto\sqrt{\kappa}\,\sigma_A$) — precisely a true $A\leftrightarrow B$
  relabelling, which also swaps $\sigma_A\leftrightarrow\sigma_B$ and leaves
  $\operatorname{Var}(X)$ and $|\delta|$, hence $d_{\mathrm{rel}}$, invariant.
  This suggests a companion statement: "$\eta$ is the involution invariant; the
  outcome layer is invariant only after the accompanying scale transport." Worth
  a remark alongside the $\kappa\leftrightarrow1/\kappa$ discussion.
- **Fisher–Rao coordinate $\psi$.** Does the envelope band $[0,\text{ceiling}]$ have a
  clean description in $\psi$? The ceiling is monotone decreasing in $d_{\mathrm{rel}}$,
  so its width may map to a simple function of the companion's $\psi$ scale.
- **Partition-function view.** $g(d_{\mathrm{rel}})$ and the majority baseline
  $\Phi(d_{\mathrm{rel}}/\sqrt2)$ are the two "extreme" accuracies; the ceiling is
  their log-ratio-like contrast. Whether this admits a partition-function reading
  ($\log\eta=-\log(1-\rho\,\operatorname{sech}\tau)$ style) is open.

## 4. Reproducibility and cross-references

- Empirical figure and derivation: `pef-empirical/figures/Figure_S4b_idealised_I_vs_dML_overlay.png`
  and Supplementary Note S2, "Validation 4" (`pef-empirical/sections/supplementary.tex`).
- Generator: `pef-empirical/scripts/matlab_figures/regenerate_figure_S4_overlay.m`
  (panel C draws the master surface and both envelopes).
- Simulation: `pef-empirical/scripts/paper_pipeline/run_pef_idealised_probit_sim.m`,
  grid `outputs/idealised_probit_grid.csv`.
- Numerical checks behind this note: analytic $F(d_{\mathrm{rel}},r)$ vs simulated
  $\Delta\mathrm{ML}$ at $r=0.9998$; involution relations $d_{\mathrm{rel}}(\kappa)\ne d_{\mathrm{rel}}(1/\kappa)$
  and $r_B(\kappa)=-r_A(1/\kappa)$.

**Guardrail.** The idealised probit simulation and the $\Delta\mathrm{ML}$ surface are
empirical-owned (submit first). This note exists so the companion can, if useful,
extend its involution/geometry narrative with an *equivariance* remark on outcome-layer
observables — citing `pef-empirical` for provenance — without duplicating the outcome layer.

---

## 5. Detailed inclusion plan (for `pef-mathematics`)

This plan is deliberately conservative: it separates what is **proven and companion-safe**
from what is **empirical-owned** or **conjectural**, and sequences the work so nothing
blocks the empirical submission.

### 5.1 Scope decision (what goes in, what stays out)

**In scope for the companion (pure geometry, no outcome layer):**
- The involution *equivariance* of the two outcome-layer coordinates
  $d_{\mathrm{rel}}$ and $r=\operatorname{corr}(X_A,X)$, as functions of $(\kappa,\rho,\delta/\sigma_A)$.
  These are algebraic identities in $(\kappa,\rho)$ — they need **no** probit link, no $Y$, no ML.
- The scale-transport statement that reconciles the empirical fixed-$\sigma_A$
  parametrisation with a true $A\leftrightarrow B$ relabelling.

**Out of scope (empirical-owned; cite only):**
- The master surface $\Delta\mathrm{ML}=F(d_{\mathrm{rel}},r)$, $\mathrm{acc}_R$, $\mathrm{acc}_A$,
  the envelopes, and Figure S4b. These require the outcome/ML layer and stay in `pef-empirical`.

### 5.2 Precise claims and proof status

| # | Claim | Status |
|---|-------|--------|
| C1 | $\eta(\kappa,\rho)=\eta(1/\kappa,\rho)$ | Already in companion (`canonical_form.tex`) |
| C2 | $\operatorname{Var}_X(1/\kappa,\rho)=\operatorname{Var}_X(\kappa,\rho)/\kappa$ | Proven (one line); **new** |
| C3 | $d_{\mathrm{rel}}(1/\kappa,\rho)=\sqrt{\kappa}\,d_{\mathrm{rel}}(\kappa,\rho)$ at fixed $\delta/\sigma_A$ | Proven (from C2); **new** |
| C4 | $r_B(\kappa,\rho)=-\,r_A(1/\kappa,\rho)$, and $\mathrm{acc}_A$ is even in $r$ | Proven; **new** (even-in-$r$ needs the outcome layer, so state the *algebraic* half here, cite the accuracy half) |
| C5 | Transport $\sigma_A\mapsto\sqrt{\kappa}\,\sigma_A$ (i.e. $A\leftrightarrow B$) restores invariance of $d_{\mathrm{rel}}$ | Proven; **new** |
| C6 | $(d_{\mathrm{rel}},|r|)$ is a natural chart; envelope band has a clean $\psi$-image | **Conjecture** — flag as open |
| C7 | Envelope contrast has a partition-function reading | **Conjecture** — flag as open |

C2–C5 are the safe, provable core. C6–C7 are speculative and must be labelled as such.

### 5.3 Section-by-section placement

1. **`canonical_form.tex` — primary insertion (≈1 short proposition + remark).**
   Immediately after the $\kappa\leftrightarrow1/\kappa$ invariance of $\eta$, add:
   > *Proposition (involution equivariance of the signal coordinate).* Let
   > $\operatorname{Var}(X)=\sigma_A^2(1+\kappa-2\sqrt{\kappa}\rho)$ and
   > $d_{\mathrm{rel}}=\delta/\sqrt{\operatorname{Var}(X)}$. Then
   > $\operatorname{Var}_X(1/\kappa)=\operatorname{Var}_X(\kappa)/\kappa$ and hence
   > $d_{\mathrm{rel}}(1/\kappa)=\sqrt{\kappa}\,d_{\mathrm{rel}}(\kappa)$; the invariant
   > $\eta$ does not fix $d_{\mathrm{rel}}$, which is restored to invariance only under the
   > accompanying transport $\sigma_A\mapsto\sqrt{\kappa}\,\sigma_A$ (the $A\leftrightarrow B$
   > relabelling). Proof: one line from the identity above.
   Add a one-sentence *remark* that, in an outcome model built on the pair
   (cite `pef-empirical`), this equivariance is exactly why efficiency and predictive gain
   decouple on the two sheets. **Length:** ~10–15 lines. **Risk:** low.

2. **`numerical_validation.tex` (§7) — optional analytic check (≈8 lines + tiny table).**
   Add a purely analytic verification of C2–C4 on the *existing* `validation_inputs/`
   $(\kappa,\rho)$ grid (no ML, no new empirical run). Report $d_{\mathrm{rel}}(1/\kappa)/d_{\mathrm{rel}}(\kappa)=\sqrt{\kappa}$
   and $r_B(\kappa)+r_A(1/\kappa)=0$ to machine precision. This keeps §7's "CSV inputs from the
   empirical pipeline" rule intact. **Risk:** low; **Dependency:** confirm the needed columns
   ($\kappa,\rho,\delta/\sigma_A$ or raw variances) are present in `validation_inputs/`.

3. **`fisher_rao.tex` — conjectural paragraph (C6).**
   One flagged-open paragraph: is $(d_{\mathrm{rel}},|r|)$ a natural chart, and does the
   envelope band map simply under $\psi$ / the regime change at $\rho=0$? **Do not** state as
   result. **Length:** ~5 lines. **Risk:** medium (speculative) — gate behind user approval.

4. **`discussion.tex` — one cross-citing sentence.**
   "The companion efficiency invariant $\eta$ is lifted once an outcome layer is attached; see
   `pef-empirical` (Note S2, Fig S4b) for the predictive-gain surface and its envelopes."
   **Risk:** low.

5. **`sphere_realisation.tex` / `partition_function.tex` — defer (C7).**
   Note only; no drafting until C6 resolves. **Risk:** n/a (not drafted).

### 5.4 Figures

- **No new companion figure required** for C2–C5. If a visual is wanted later, a small
  $(\tau,d_{\mathrm{rel}})$ equivariance schematic ($\tau\mapsto-\tau$, $d_{\mathrm{rel}}\mapsto\sqrt{\kappa}d_{\mathrm{rel}}$)
  could live in the companion; the outcome-coloured Fig S4b stays empirical and is cited.

### 5.5 Sequencing and dependencies

1. **Phase 0 (now):** land this note; commit to `pef-mathematics` (no manuscript change yet).
2. **Phase 1 (after empirical submission):** insert §5.3(1) proposition + §5.3(4) sentence.
   Empirical must be submitted first (repo guardrail).
3. **Phase 2:** add §5.3(2) analytic §7 check once `validation_inputs/` columns are confirmed.
4. **Phase 3 (optional):** consider §5.3(3) `fisher_rao` conjecture only if the user wants to
   pursue C6; otherwise leave in this note as an open direction.

### 5.6 Risks and guardrails

- **Do not** import the probit/ML derivation, $\mathrm{acc}_R/\mathrm{acc}_A$, or the envelope
  equations into the companion manuscript (empirical-owned; submit first).
- **Do not** promote C6–C7 to results; they are conjectures.
- Keep C4's *even-in-$r$* half as a citation (it needs the accuracy functional); state only the
  algebraic identity $r_B(\kappa)=-r_A(1/\kappa)$ in the companion.
- Cross-cite `pef-empirical` for all provenance; refresh `validation_inputs/` only if a new
  empirical pipeline run changes the $(\kappa,\rho)$ grid (it does not, for this note).

### 5.7 Open decisions for the author

- **D1:** Include the §7 analytic equivariance check now, or defer? (Recommend: include — cheap, no ML.)
- **D2:** Pursue the Fisher–Rao chart conjecture (C6), or leave as a note-only open direction?
- **D3:** Target the equivariance proposition at `canonical_form.tex` (recommended) or at the
  involution passage wherever it currently sits?
