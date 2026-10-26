# Statistics paper: questions and flags

This branch starts from the `gandalf-grey` tag. That tag is the geometry manuscript. It is not this paper. Do not restore \(\psi\), the sphere, or the partition function into the submission, including as an appendix. One remark on \(\tau = \tfrac12\log\kappa\) is enough if a referee asks for the canonical form.

Prose rewrites come after this file. A paragraph that answers none of the questions below is deleted. A paragraph that answers the sports paper's questions is deleted.

## Questions

1. When is the paired difference a sufficient feature for a binary outcome?
2. What does \(\eta\) decide instead?
3. What does the redundant coefficient cost in a finite sample?
4. Which of those statements survive a non-Gaussian margin?

## What may be shown

The definition of \(\eta\) and its five properties, in one short block. The alignment identity \(R^2_D/R^2_{(A,B)} = \cos^2\theta\). The general ratio \(R^2_D/R^2_A\), and its reduction to \(2\eta\) only when \(\kappa_S = \kappa_N = b_{\mathrm{ratio}} = 1\). The reliability law \(1/(1+\Lambda\,\eta_S/\eta_N)\). The statement that, under joint normality, log-loss, Brier score, AUC and mutual information depend on \((z, r^2)\) only. The expansion \(1/(2n)\) plus a remainder of order \(1/n^2\), with \(c \approx 16.6\) labelled as fitted on three aligned Gaussian designs.

Numerical illustrations from the simulations only: the three \(\eta = 2\) cases, the crossover table, and the stress table. One sentence may point at the sports paper for the matches.

## Flags that fail this file

- A match likelihood ratio, a milli-nat gap, or a confirmatory exemplar reported as a result of this paper.
- An instruction to an analyst about which column to build.
- \(\psi\), the partition function, or the sphere in the submission text.
- \(c\) called universal, or the second-order crossover given without saying \(c\) was fitted.
- \(b_A = b_B\) said to imply alignment, with asymmetric covariances unmentioned.
- \(R^2_D/R^2_A = 2\eta\) with no exchangeability restriction.
- A single value of \(\eta\) said to fix \(R^2_D\). The stored cases are \(0.80\), \(0.33\) and \(0\).
- Log-loss said to depend only on \((z, r^2)\) for counts, skew, or an ordinal cut. Alignment and reliability may be stated as second-moment results for those laws.
- A block of KPIs, a time window, or a finance alignment test treated as a result. Those extensions are not on this card.

## Oracles

`pef-empirical/Alternative Pipeline/pef_numerics/results/`, in particular `E5_eta2_counterexample.csv`, `E5_stress.csv`, `E3` as summarised in `SUMMARY.md`, and `E5_repeated_measures_summary.csv`.
