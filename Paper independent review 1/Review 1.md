Here is the geometry-paper review as Markdown, followed by corrected LaTeX for the passages with errors, and then answers to your two questions.

## 1. The review as a Markdown file

Copy everything inside the block into `PEF_geometry_presubmission_review.md`.

````markdown
# Pre-submission Review: "The Geometry of Paired Efficiency: Canonical Form, Information-Geometric Structure, and Cross-Domain Pooling for Fisher's Generalised Formula"

**Manuscript:** PEF-geometry companion (R. Brown)
**Review date:** 25 October 2026
**Files reviewed:** `main.tex`, `abstract.tex`, `introduction.tex`, `canonical_form.tex`, `mobius_chebyshev.tex`, `sphere_realisation.tex`, `partition_function.tex`, `fisher_rao.tex`, `numerical_validation.tex`, `discussion.tex`, `appendix.tex`, Figures 1–6 (incl. 5b)
**Not available to reviewer:** `references.bib`, data/code availability statement, compiled PDF
**Read alongside:** `PEF_presubmission_review.md` (empirical paper)

---

## Overall assessment

Several identities are correct and worth keeping:

- the canonical form η = cosh τ/(cosh τ − ρ);
- the affine reciprocal 1/η = 1 − ρ sech τ;
- invariance under κ ↔ 1/κ;
- the back-transform η = cosh²(ψ/2), with η − 1 = sinh²(ψ/2).

In its current form, however, the paper is unlikely to survive review at a statistics or mathematics journal, for three reasons:

1. **Errors.** There are mathematical errors in ∂η/∂τ, the Poisson-kernel ratio, the harmonicity claim, the delta-method variance of η̂, the mutual-information statements, and the sign of the Fisher information.
2. **Novelty.** Everything depends on the single scalar u = ρ sech τ, which is a classical statistic (the pairwise ICC, equivalently Lin's concordance coefficient with zero location shift). Several "structures" relabel u rather than establish results about it.
3. **Validation.** The headline practical claim, that ψ is variance-stabilising and the natural meta-analytic scale, holds only for a latent distribution that does not generate the data. For the real plug-in estimator, the paper's own Block D and real-data CVs contradict it.

There are also direct contradictions with the empirical paper (Part D).

**Recommendation:** Major revision on a slower timeline than the empirical submission.

---

## Part A: Mathematical errors

### A1. Sign error in ∂η/∂τ, and the wrong conclusion drawn from it
Correct: ∂η/∂τ = −ρ sinh τ/(cosh τ − ρ)². The paper has +ρ sinh τ and concludes that η increases with |τ| for ρ > 0. The truth is the reverse: η decreases towards 1. This is consistent with the paper's own limit η → 1 as κ → 0, ∞ and with Figure 2. Reverse the accompanying text.

### A2. Poisson-kernel ratio: wrong sign and a false equality claim
- With r = e^τ, η/P_r = (1 + r²)/(1 − r²) = **−coth τ**, not +coth τ. The intermediate expression does not parse.
- For τ > 0 (the fundamental domain), r > 1 and P_r < 0. The disc kernel applies only for r < 1.
- "η ≥ P_r with equality only as τ → 0" is false: the ratio diverges as τ → 0.
- **Fix:** Use the involution to write η = coth τ · P_{e^{−τ}}(φ) for τ > 0 (see the corrected text).

### A3. The harmonic-analysis claims are incorrect
f(z) = (1 + |z|²)/|1 − z|² is not harmonic. η is not a bounded analytic function, and it does not extend to a meromorphic function: it is real-valued in (z, z̄). Remove §3.4, the Hardy-space/Toeplitz remarks, and future direction (iii).

### A4. The delta-method variance of η̂ is wrong by a factor of η
Since dη/dθ = η(η − 1), Var(η̂) ≈ **η(η − 1)/n**, not η²(η − 1)/n. Figure 5b (right) confirms this: the plotted ratio tracks 1/η (≈1 at η ≈ 1, 0.5 at η = 2, ≈0.16 at η ≈ 6.5). Redo the figure, the CV = 0.42 statistic and the caption.

### A5. The mutual-information statements are wrong, and contradict the empirical paper
- −½ log(1 − ρ²) is the Gaussian MI between X_A and X_B. It is scale-invariant, so it holds for **all** κ, not only κ = 1.
- The empirical paper's I(X;Y) is between the difference and the match outcome, and depends on δ. It is **not** a specialisation of the partition function. Even at κ = 1, log η = −log(1 − ρ) ≠ −½ log(1 − ρ²).
- Remove or rewrite §5.4, the corresponding passage in the Introduction ("Relation to the Empirical Companion"), and Discussion item (iii).

### A6. Fisher information cannot "change sign"
Fisher information is non-negative. For ρ < 0 the geometric family does not exist (θ = log u is undefined): there is no MLE and no 1/n law. Signed ψ is an ad hoc extension; say so. Also, the dual (expectation) coordinate is E[N] = η − 1, not η (Discussion §8.2).

### A7. Smaller slips
- **Canonical-form derivation (main text):** the intermediate line is garbled. Use the appendix derivation.
- **Logarithmic series:** −log(1 − e^θ) is the *normaliser* of the log-series distribution, not its log-partition function. Delete the sentence.
- **Geometric series:** "|w| < 1 (equivalently |ρ| < √κ)" is incorrect. In the physical domain the condition always holds.
- **Möbius section:** "horizontal plane" should read "line".
- **Sphere §4.3(ii):** the involution pairs Q1↔Q2 and Q3↔Q4, not Q1/Q2 with Q4/Q3.
- **Q4 description:** "ρ < 0, κ ≈ 1, high-asymmetry" is self-contradictory. Q4 is κ > 1.
- **Fisher's z comparison:** the bullet ("≈ 2z/√z") is muddled. Simply state that the two transforms differ.
- **Cumulant proof (main text):** the step "uη = η − 1/η·η" is garbled. The appendix version is fine.

---

## Part B: Novelty and conceptual framing

### B1. u = ρ sech τ is a classical statistic
u = 2σ_AB/(σ²_A + σ²_B), which is:
- the pairwise (double-entry) intraclass correlation;
- Lin's (1989) concordance coefficient with zero location shift, since C_b = sech τ.

Var(X_A − X_B) = (σ²_A + σ²_B)(1 − u) is standard, so η = 1/(1 − ICC).

- The introduction's description of the lift as "the Pearson correlation of variance-normalised margins" is incorrect; that correlation is ρ.
- Engage with Lin (1989), Fisher's intraclass correlation, and the method-comparison literature before claiming novelty.

### B2. Most "structures" are relabellings of one scalar
- **Sphere:** any number in (−1, 1) is a cosine, and the longitude φ is unspecified ("for any φ"). So (κ, ρ) is not mapped to a point. Iso-η latitudes hold by construction, and "Riemann sphere" implies unused complex structure.
- **Partition function:** any u ∈ (0, 1) parameterises a geometric distribution. The latent N has no link to the data, so "distribution-free signal and information" overstates what is a function of η.
- **Fisher–Rao metric:** the metric "on the (τ, ρ)-plane" is a rank-1 pull-back, not a metric on the plane.
- **Reframe:** state that the structure is one-dimensional in u, and present the sphere and partition-function readings as remarks.

### B3. The "regime change at ρ = 0" has no mathematical basis
η = 1/(1 − u) is analytic at u = 0. The branch structure is an artefact of θ = log u. The LRT did not reject (p = 0.087), so present this as "prediction not supported". Remove the claim that this is the "mathematical origin of the efficiency–power tension".

### B4. The quadrant "artefact" claim holds for η only
Level 3 shows that d_rel and r_A are **not** invariant under the swap (they differ by up to 24%). The quadrant distinction therefore matters for prediction, because the empirical comparator is X_A. Restrict Discussion item (i) to "for efficiency".

---

## Part C: Numerical validation

### C1. Implementation checks presented as validation
The Level 2, Level 3, sphere and cumulant finite-difference checks evaluate algebraic identities. Machine-precision residuals confirm the code; they cannot falsify theorems. Relabel them as implementation checks, compress them, and revise the framing of the falsifiability table.

### C2. Level 2.5 is uninformative as specified
- If the test compares (τ̂, ρ̂), the two clouds are mirror images and should differ whenever τ ≠ 0.
- If it compares (|τ̂|, ρ̂) with the same resamples, the clouds are identical by construction.

State which was done. Non-rejection is not evidence of equality.

### C3. Variance stabilisation fails for the real (plug-in) estimator
- Block C confirms standard MLE asymptotics for the **latent** geometric family only.
- Block D: plug-in n·Var(ψ̂) ranges from ≈0.3 to ≈45. For ρ < 0, ψ is one to two orders of magnitude *less* stable than η.
- Real data: CV_ψ 1.86 vs CV_η 0.52 overall, and 0.40 vs 0.32 for positive ρ. Both are the wrong way round.
- dψ/du = 1/(√u(1 − u)) → ∞ as u → 0, while Var(û) stays positive. ψ̂ is therefore most unstable near independence, which is where most sports KPIs sit.
- Under bivariate normality (to be verified): Var(û) ≈ (sech²τ − u²)(1 − u²)/n. This depends on τ, not on u alone, so **no transform of u can exactly stabilise the plug-in**. At τ = 0 the correct transform is Fisher's z = arctanh(ρ), not 2 arctanh √ρ.
- **Action:** Withdraw or restrict "Var(ψ̂) ≈ 1/n uniformly" and "natural meta-analytic scale", and the recipe in §6.4.

### C4. The ψ-stabilisation test doesn't test stabilisation
CIs for cross-unit **means** reflect the number of units and the between-unit spread, not per-unit sampling variance. A CV of a signed quantity near zero is not meaningful. **Correct test:** bootstrap games within each KPI and compare n·Var(ψ̂_unit) with n·Var(η̂_unit).

### C5. LRT details
- KPIs from the same matches are dependent and some are near-duplicates, so OLS errors are not independent.
- State the units of the slopes and of ΔML.
- The appendix contains raw "rho_i".

---

## Part D: Consistency with the empirical paper

### D1. The quadrants
The empirical paper gives distinct Q3/Q4 recommendations and Q1/Q2 information labels; this paper calls those distinctions artefacts. The unified position: η is label-invariant; ΔML is not; so quadrant distinctions beyond sign(ρ) must be justified via (d_rel, r_A). (Cf. empirical review A4–A5.)

### D2. ΔML sign for ρ < 0
Here the mean ΔML is **+0.37%** across 62 KPIs with ρ < 0 (mostly Q3). The empirical paper claims Q3 relativisation is **harmful**. Either the pipeline versions differ (folds, units), or the empirical claim rests on one exemplar against an opposite average. Report the full Q3 ΔML distribution in the empirical paper.

### D3. Cross-citations that don't exist
Table 8.1 and the Introduction claim the empirical paper uses the involution, the ψ recipe, the partition function and the regime change. None appears in it, and its bibliography has no entry for this paper. Align the two papers.

### D4. Shared data issues
- **Manufacturing:** same likely misidentification ("Bosch CNC", probably the DELVE puma robot-arm simulation), and ρ estimated from 5–6 axes per row.
- **Signal measure:** `cohens_d_paired` inherits the δ problem (empirical review A3).
- **"Six hundred thousand paired observations"** (Discussion closing): unsupported. The datasets table totals 19,989 units.
- **"Validates the formula":** an algebraic identity cannot be validated empirically.

### D5. Smaller checks
- **Rugby games:** n = 283 here; check against `\PEFrugbyNgames`.
- **KPI counts:** 22 rugby / 64 football; check against the empirical macros.
- **Author name:** "Rowan Brown" here vs "M. R. Brown" in the empirical paper. Make them consistent.
- **Timing:** "around the same time" (`main.tex` comment) vs "shortly afterwards" (Discussion).

---

## Part E: Figures

| Figure | Issues |
|---|---|
| 1 (half-strip) | Suptitle overlaps subplot title; "τ = 0 (Fisher)" label points to an invisible line |
| 2 (Möbius) | Contour labels clipped or overlapping the title; most contours unlabelled; legend on a curve |
| 3 (sphere theory) | "ρ > 0 hemisphere" label ambiguous; implies a longitude rule the text says is arbitrary |
| 4 (ψ/partition) | Raw MATLAB text "psi = sign(rho)*2 arctanh sqr(\|u\|)" (typo "sqr"); render or remove |
| 5 (half-strip model) | Panel A title collides with colour bar; "near pole" overlaps star; panel D title clipped; panel C orange series inherits A4 |
| 5b (stabilisation) | Legend overlaps bars; right panel must be redone (A4) |
| 6 (sphere empirical) | "ρ = 0" and "η = 1" listed as separate circles (same set); labels overlap markers |

**Numbering:** in print order, `Figure_6` → Fig. 5, `Figure_5` → Fig. 6, `Figure_5b` → Fig. 7. Never refer to figures by file name in the text.

---

## Part F: Presentation, LaTeX and administration

- **Abstract structure count:** "four structures" / "all five structures" in the abstract vs six contributions in the Introduction. Make consistent.
- **Abstract LRT:** report it as "prediction not supported".
- **Title:** "Fisher's Generalised Formula" attributes the generalisation to Fisher; "a generalisation of Fisher's paired efficiency" is safer.
- **Contribution (ii):** remove the "distinct Poisson-kernel representation" claim.
- **Hard-coded section numbers:** replace "§7", "§7.2.2", "§7.5", "§7.6" (appendix, Table 8.1) with `\cref`.
- **Unused macros:** `\Real`, `\ind`.
- **Missing front/back matter:** affiliation, email, data/code availability (state where `validation_inputs/` and the manifests live), funding, competing interests, CRediT.
- **Bibliography (not seen):**
  - `brownPEFempirical` cited as submitted/preprint;
  - Székely and Rizzo rendered with accents (the key `szekeleyRizzo2013` is misspelled);
  - all cited keys present;
  - add Lin (1989) and an ICC reference.

---

## Part G: Venue and strategy

Not ready for submission. Once corrected, two routes:

1. **Short note.** η = 1/(1 − ICC), the involution, the affine reciprocal, and a correct BVN sampling theory for û/η̂ with an interval method. Suitable venues: *The American Statistician*, *Stat*, *Statistics & Probability Letters*.
2. **Fold into the empirical SI.** The invariance and Level 3 equivariance results (η invariant; d_rel and r_A equivariant) directly support empirical review A5.

Do not let the empirical paper cite the current ψ meta-analysis or regime-change claims.

---

## Prioritised action plan

**This week (protect the empirical submission):**
1. Ensure the empirical paper does not rely on ψ, regime-change or partition-function claims (D3).
2. Reconcile the quadrant message across both papers (D1, B4).
3. Investigate the +0.37% mean ΔML for ρ < 0 vs the Q3-harm claim (D2).

**Geometry paper (major revision):**
1. Fix A1–A7.
2. Engage with the ICC/concordance literature; rescope novelty (B1, B2).
3. Drop or rewrite the regime-change narrative (B3).
4. Derive the plug-in sampling theory for û, η̂, ψ̂; redo stabilisation per unit (C3, C4).
5. Relabel algebraic checks as implementation checks (C1, C2).
6. Fix the manufacturing description, the "six hundred thousand" figure, and the figures (D4, E).
````

## 2. Corrected LaTeX passages

**A1, the τ-derivative** (replaces eq. `deta_dtau` and the paragraph after it in `canonical_form.tex`):

```latex
\begin{align}
  \frac{\partial\eta}{\partial\rho}
  &= \frac{\cosh\tau}{(\cosh\tau-\rho)^{2}} > 0,
  \label{eq:deta_drho}\\[4pt]
  \frac{\partial\eta}{\partial\tau}
  &= \frac{\sinh\tau\,(\cosh\tau-\rho) - \cosh\tau\,\sinh\tau}{(\cosh\tau-\rho)^{2}}
   = -\,\frac{\rho\,\sinh\tau}{(\cosh\tau-\rho)^{2}}.
  \label{eq:deta_dtau}
\end{align}
Thus $\eta$ is strictly increasing in $\rho$ for all $\tau$.  In $\tau$, the sign of
$\partial\eta/\partial\tau$ is opposite to the sign of $\rho\,\tau$: for $\rho>0$,
$\eta$ decreases towards $1$ as $|\tau|$ grows, and for $\rho<0$ it increases towards $1$.
Variance asymmetry therefore dilutes the effect of correlation in both regimes, pulling
$\eta$ towards the correlation-free baseline, consistent with the limit
$\eta\to1$ as $|\tau|\to\infty$ in \cref{tab:special_values}.  The critical set
$\partial\eta/\partial\tau=0$ is the union of the lines $\tau=0$ and $\rho=0$.
```

**A2, the Poisson-kernel form** (replaces the subsection from eq. `poisson_decomposition` onwards in `mobius_chebyshev.tex`). It uses the involution to move to the inner radius, where the kernel is positive and the coth τ factor becomes correct:

```latex
The classical Poisson kernel $P_{s}(\varphi)=(1-s^{2})/|1-s\,e^{i\varphi}|^{2}$ is
positive and harmonic only for $0\le s<1$.  On the fundamental domain $\tau>0$ we
have $r=e^{\tau}>1$, so we first apply the involution (\cref{thm:involution}),
$\eta(r,\varphi)=\eta(1/r,\varphi)$, and set $s=1/r=e^{-\tau}\in(0,1)$:
\begin{equation}
  \eta(\tau,\rho)
  = \frac{1+s^{2}}{|1-s\,e^{i\varphi}|^{2}}
  = \frac{1+s^{2}}{1-s^{2}}\,P_{s}(\varphi)
  = \coth\tau\;P_{e^{-\tau}}(\varphi),
  \qquad \tau>0,\ \rho=\cos\varphi.
  \label{eq:eta_poisson_ratio}
\end{equation}
Since $\coth\tau>1$ for $\tau>0$, $\eta>P_{e^{-\tau}}(\varphi)$ throughout the open
half-strip, with $\eta/P_{e^{-\tau}}(\varphi)\to1$ only as $\tau\to\infty$.  As
$\tau\to0^{+}$, $\coth\tau\to\infty$ while $P_{e^{-\tau}}(\varphi)\to0$ for
$\varphi\neq0$, and the product tends to Fisher's value $1/(1-\rho)$.  Note that
$\eta$ itself is not harmonic: it is a harmonic function multiplied by the radial
factor $\coth\tau$.
```

**A4, the variance of η̂ under the latent family** (replaces the final sentence of the paragraph containing eq. `psi_clt` in `fisher_rao.tex`):

```latex
By contrast, since $\mathrm{d}\eta/\mathrm{d}\theta=\eta(\eta-1)$, the delta method
applied to $\hat\eta$ gives
$\Var(\hat\eta)\approx[\eta(\eta-1)]^{2}/\bigl(n\,\eta(\eta-1)\bigr)=\eta(\eta-1)/n$,
which is near zero when $\eta\approx1$ and grows without bound as $\eta\to\infty$.
```

**A5, distribution-free scope** (replaces the bullet list in `partition_function.tex`, §5.4):

```latex
The cumulant identities of \cref{prop:cumulants} are algebraic consequences of the
form of $\eta$ and hold for any $(\kappa,\rho)$ with $\rho\,\sech\tau\in(0,1)$.  They
are properties of the latent family of \cref{thm:exp_family}, not of the sampling
distribution of $(X_{\mathrm{A}},X_{\mathrm{B}})$, and they carry no information about
the match outcome.  In particular, they are unrelated to the outcome-information
quantity $I(X;Y)$ of \textcite{brownPEFempirical}, which concerns the relative feature
and the binary outcome and depends on the mean separation $\delta$.  (The Gaussian
mutual information between the two margins, $-\tfrac12\log(1-\rho^{2})$, is
scale-invariant and therefore independent of $\kappa$; it is also distinct from
$\log\eta$, which equals $-\log(1-\rho)$ at $\kappa=1$.)
```

**A6, the regime boundary** (replaces the second paragraph of §6.3 in `fisher_rao.tex`):

```latex
The signed coordinate is continuous at $\rho=0$, but its derivative
$\mathrm{d}\psi/\mathrm{d}u=1/\bigl(\sqrt{|u|}\,(1-|u|)\bigr)$ diverges there.  For
$\rho<0$ the geometric family of \cref{thm:exp_family} does not exist, because
$\theta=\log u$ is undefined; there is accordingly no Fisher information, no maximum-
likelihood estimator and no $1/n$ variance law on that branch.  The negative branch of
\cref{eq:psi_signed} is a symmetric extension adopted for display, not a consequence of
the information geometry.
```

**C3, a proposition on the plug-in sampling theory.** This is new material for the reframed paper. I derived it by hand, so please confirm it by simulation before relying on it (the existing Block D code can be reused).

```latex
\begin{proposition}[Plug-in sampling variance under bivariate normality]
\label{prop:plugin}
Let $(X_{\mathrm{A}},X_{\mathrm{B}})$ be bivariate normal and let $\hat\rho$ and
$\hat\tau=\tfrac14\log(s_{\mathrm{B}}^{2}/s_{\mathrm{A}}^{2})\cdot2$ be computed from
$n$ pairs.  Then, asymptotically,
$\Var(\hat\rho)\approx(1-\rho^{2})^{2}/n$, $\Var(\hat\tau)\approx(1-\rho^{2})/n$ and
$\Cov(\hat\rho,\hat\tau)=o(1/n)$, so that for $u=\rho\,\sech\tau$,
\begin{equation}
  \Var(\hat u)\;\approx\;\frac{(\sech^{2}\tau-u^{2})(1-u^{2})}{n}.
  \label{eq:var_u_plugin}
\end{equation}
\end{proposition}

\begin{proof}[Sketch]
$\hat\rho$ and $\hat\tau-\tau$ depend only on the standardised pairs, whose joint law is
exchangeable; the swap $\mathrm{A}\leftrightarrow\mathrm{B}$ fixes $\hat\rho$ and
reverses the sign of $\hat\tau-\tau$, so their asymptotic covariance vanishes.  The
variances are standard ($\Var\log s^{2}\approx2/n$,
$\Cov(\log s_{\mathrm{A}}^{2},\log s_{\mathrm{B}}^{2})\approx2\rho^{2}/n$).  The delta
method with $\partial u/\partial\rho=\sech\tau$ and
$\partial u/\partial\tau=-u\tanh\tau$ gives
$\Var(\hat u)\approx\sech^{2}\tau\,(1-\rho^{2})(1-u^{2})/n$, and
$\sech^{2}\tau\,(1-\rho^{2})=\sech^{2}\tau-u^{2}$.
\end{proof}

Because \cref{eq:var_u_plugin} depends on $\tau$ and not on $u$ alone, no transformation
of $u$ can stabilise the plug-in variance exactly.  At $\tau=0$ it reduces to
$(1-\rho^{2})^{2}/n$, whose stabilising transform is Fisher's $z=\arctanh\rho$, not
$2\arctanh\sqrt{\rho}$.  The delta method also gives
$\Var(\hat\eta)\approx\eta^{4}(\sech^{2}\tau-u^{2})(1-u^{2})/n$ and
$\Var(\hat\psi)\approx(\sech^{2}\tau-u^{2})(1+u)/\bigl(n\,u(1-u)\bigr)$; the latter
diverges as $u\to0$, which is consistent with the plug-in diagnostic (Block~D).
```

**One correction to the proposition's wording:** I wrote the definition of τ̂ awkwardly. It should simply read `\hat\tau=\tfrac12\log(s_{\mathrm{B}}^{2}/s_{\mathrm{A}}^{2})`; please make that substitution. The result is also useful in a positive way. η depends on (κ, ρ) only through u, but its *sampling* behaviour depends on τ as well, so the second coordinate matters statistically even though it disappears from η. That gives the reframed note a genuine result to lead with.

For A3, I recommend deleting §3.4 rather than replacing it.

