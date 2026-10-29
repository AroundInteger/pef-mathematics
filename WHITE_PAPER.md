# Statistics paper: questions and flags (draft 2)

This branch starts from the `gandalf-grey` tag. That tag is the geometry manuscript. It is not this paper. Do not restore \(\psi\), the sphere, or the partition function into the submission, including as an appendix. One remark on \(\tau = \tfrac12\log\kappa\) is enough if a referee asks for the canonical form.

Author is Rowan Brown alone. Prose rewrites come after this file. A paragraph that answers none of the questions below is deleted. A paragraph that answers the sports paper's questions is deleted.

## Questions

1. When is the paired difference a linearly sufficient feature for a binary outcome?
2. What does \(\eta\) decide instead?
3. What does the redundant coefficient cost in a finite sample?
4. Which of those statements survive a non-Gaussian margin?

## What may be shown

The definition of \(\eta\), properties P1–P5, and P6 (\(\eta=1/(1-u)\) with \(u=2\sigma_{AB}/(\sigma_A^2+\sigma_B^2)\)). The alignment identity \(R^2_D/R^2_{(A,B)} = \cos^2\theta\). Short proofs. The general ratio \(R^2_D/R^2_A\), and its reduction to \(2\eta\) only when \(\kappa_S = \kappa_N = b_{\mathrm{ratio}} = 1\). The reliability law \(1/(1+\nu\,\eta_S/\eta_N)\). Under joint normality, log-loss, Brier score, AUC and mutual information depend on \((z, r^2)\) only; outside that case say linearly sufficient, not sufficient. The expansion \(1/(2n)\) as a classical proposition, plus a crossover approximation with fitted \(\gamma \approx 16.6\) on three aligned Gaussian designs. Related work, discussion, conclusion, a design appendix, and one algebraic figure.

Numerical illustrations from the existing simulations only: the three \(\eta = 2\) designs with \(\Sigma_S\), \(\Sigma_N\), \(b\); the crossover table; the reframed stress table. One sentence may point at the sports paper for the matches.

## Stress wording

Alignment and reliability hold by construction for finite second moments. The Monte Carlo stress column is the Gaussian \((z,r^2)\) map. Do not claim the three predictive stress questions (logistic bridge, nonlinear OOS gap, Takeuchi correction) were tested. The repeated-team reliability discrepancy is an estimation issue under dependence, not a failure of the population identity.

## Flags that fail this file

- A match likelihood ratio, a milli-nat gap, or a confirmatory exemplar reported as a result of this paper.
- An instruction to an analyst about which column to build.
- \(\psi\), the partition function, or the sphere in the submission text.
- \(\gamma\) (or former \(c\)) called universal, or the second-order crossover given without saying \(\gamma\) was fitted on A1–A3.
- \(b_A = b_B\) said to imply alignment, with asymmetric covariances unmentioned.
- \(R^2_D/R^2_A = 2\eta\) with no exchangeability restriction.
- A single value of \(\eta\) said to fix \(R^2_D\) or to decide reliability. Reliability is decided by \(\eta_S/\eta_N\). The stored \(\eta=2\) cases are \(0.80\), \(0.33\) and \(0\).
- Log-loss said to depend only on \((z, r^2)\) for counts, skew, or an ordinal cut.
- ``Sufficient'' used for non-Gaussian margins where only linear sufficiency holds.
- A block of KPIs, a time window, or a finance alignment test treated as a result.
- New Monte Carlo for predictive stress questions presented as draft-2 results.

## Oracles

`pef-empirical/Alternative Pipeline/pef_numerics/results/`, in particular `E5_eta2_counterexample.csv`, `E5_stress.csv`, `E3` as summarised in `SUMMARY.md`, and `E5_repeated_measures_summary.csv`. Design parameters live in the matching `experiments/*.py` scripts.
