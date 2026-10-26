%% summarise_validation_inputs.m
% Read validation_inputs/ and write the counts and residuals cited in §7.
%
% Also fits the regime-change comparison on psi_ml_residuals.csv: one slope
% of ML improvement on rho, versus separate slopes on rho>0 and rho<0, with
% the break fixed at rho = 0 and a shared intercept. The likelihood-ratio
% statistic is n*log(RSS_restricted/RSS_full) on 1 degree of freedom.
%
% Output:
%   scripts/outputs/validation_summary.txt
%   scripts/outputs/regime_change_lrt.csv
%
% Usage (from this directory):
%   /Applications/MATLAB_R2025b.app/bin/matlab -batch "run('summarise_validation_inputs.m')"

THIS = fileparts(mfilename('fullpath'));
if isempty(THIS), THIS = pwd; end
REPO = fileparts(THIS);
IN   = fullfile(REPO, 'validation_inputs');
OUT  = fullfile(REPO, 'scripts', 'outputs');
if ~exist(OUT, 'dir'), mkdir(OUT); end

audit = readtable(fullfile(IN, 'kappa_symmetry_audit.csv'));
ns    = readtable(fullfile(IN, 'kappa_symmetry_nonsports.csv'));
land  = readtable(fullfile(IN, 'pef_landscape_2season_geometry.csv'));
psi   = readtable(fullfile(IN, 'psi_per_domain.csv'));
het   = readtable(fullfile(IN, 'psi_heterogeneity.csv'));
ml    = readtable(fullfile(IN, 'psi_ml_residuals.csv'));

fid = fopen(fullfile(OUT, 'validation_summary.txt'), 'w');
cleanup = onCleanup(@() fclose(fid));
pr = @(varargin) fprintf(fid, varargin{:});

%% ---- Counts and symmetry -------------------------------------------------
n_sports = height(audit);
n_ns = sum(ns.n_units);
pr('sports_kpis %d\n', n_sports);
pr('nonsports_units %d\n', n_ns);
pr('total_estimates %d\n', n_sports + n_ns);
pr('level2_fail %d\n', sum(audit.level2_pass ~= 1));
pr('level2p5_fail %d\n', sum(audit.level2p5_pass ~= 1));
pr('max_d_eta %.6e\n', max(audit.d_eta));
pr('max_disc_tau %.6e\n', max(audit.max_disc_tau));
pr('nonsports_fail %d\n', sum(ns.n_fail));
pr('nonsports_max_residual %.6e\n', max(ns.max_residual));

domains = unique(audit.domain, 'stable');
for i = 1:numel(domains)
    m = strcmp(audit.domain, domains{i});
    pr('symmetry_domain %s n %d fail %d max_d_eta %.6e\n', ...
        domains{i}, sum(m), sum(audit.level2_pass(m) ~= 1), max(audit.d_eta(m)));
end

%% ---- Sphere --------------------------------------------------------------
res_s = land.eta_sigma_residual;
pr('sphere_n %d\n', height(land));
pr('sphere_max_abs %.6e\n', max(abs(res_s)));
pr('sphere_n_at_max %d\n', sum(abs(abs(res_s) - max(abs(res_s))) < 1e-18));
pr('sphere_n_above_1e-14 %d\n', sum(abs(res_s) >= 1e-14));
pr('cos_sigma_min %.6f\n', min(land.cos_sigma));
pr('cos_sigma_max %.6f\n', max(land.cos_sigma));

%% ---- Equivariance (same identities as verify_involution_equivariance.m) --
kappa = land.kappa;
rho   = land.rho;
drel  = land.cohens_d_paired;
sk    = sqrt(kappa);
VarN  = 1 + kappa - 2 .* sk .* rho;
delta = land.mean_home - land.mean_away;
VarX  = land.var_home + land.var_away - 2 .* rho .* sqrt(land.var_home .* land.var_away);
anchor_res = max(abs(delta ./ sqrt(VarX) - drel));
kap_i = 1 ./ kappa;
ski = sqrt(kap_i);
VarN_i = 1 + kap_i - 2 .* ski .* rho;
c2_res = max(abs(VarN_i - VarN ./ kappa));
sig_ratio = drel .* sqrt(VarN);
drel_i = sig_ratio ./ sqrt(VarN_i);
c3_res = max(abs(drel_i - sk .* drel));
rA = (1 - rho .* sk) ./ sqrt(VarN);
rB = (rho - sk) ./ sqrt(VarN);
rA_i = (1 - rho .* ski) ./ sqrt(VarN_i);
c4_res = max(abs(rB + rA_i));
eta = (1 + kappa) ./ VarN;
eta_i = (1 + kap_i) ./ VarN_i;
eta_res = max(abs(eta - eta_i));
pr('equiv_anchor %.6e\n', anchor_res);
pr('equiv_eta %.6e\n', eta_res);
pr('equiv_c2 %.6e\n', c2_res);
pr('equiv_c3 %.6e\n', c3_res);
pr('equiv_c4 %.6e\n', c4_res);
pr('sqrt_kappa_min %.6f\n', min(sk));
pr('sqrt_kappa_max %.6f\n', max(sk));

%% ---- Cumulant finite differences on rho > 0 ------------------------------
tau = 0.5 * log(kappa);
u = rho .* sech(tau);
pos = rho > 0 & u > 0 & u < 1;
th = log(u(pos));
eta_pos = eta(pos);
h = 1e-4;
A = @(z) -log(1 - exp(z));
d1 = (A(th + h) - A(th - h)) / (2 * h);
d2 = (A(th + h) - 2 * A(th) + A(th - h)) / (h ^ 2);
pr('n_rho_pos %d\n', sum(pos));
pr('n_rho_neg %d\n', sum(rho < 0));
pr('n_rho_zero %d\n', sum(rho == 0));
pr('cumulant_max_dev_d1 %.6e\n', max(abs(d1 - (eta_pos - 1))));
pr('cumulant_max_dev_d2 %.6e\n', max(abs(d2 - eta_pos .* (eta_pos - 1))));

%% ---- psi meta-analysis ---------------------------------------------------
pr('cv_psi %.6f\n', het.cv_psi);
pr('cv_eta %.6f\n', het.cv_eta);
pr('het_ratio %.6f\n', het.het_ratio);
pr('cv_psi_pos %.6f\n', het.cv_psi_pos);
pr('cv_eta_pos %.6f\n', het.cv_eta_pos);
pr('het_ratio_pos %.6f\n', het.het_ratio_pos);

for i = 1:height(psi)
    width = psi.psi_CI_hi(i) - psi.psi_CI_lo(i);
    pr('psi_domain %s n %g mean_psi %.6f mean_eta %.6f ci_width %.6f half_width %.6f\n', ...
        string(psi.domain(i)), psi.n_units(i), psi.mean_psi(i), psi.mean_eta(i), ...
        width, width / 2);
end

%% ---- Regime-change likelihood ratio --------------------------------------
y = ml.acc_improvement;
x = ml.rho;
ok = isfinite(y) & isfinite(x);
y = y(ok);
x = x(ok);
n = numel(y);
X0 = [ones(n, 1), x];
b0 = X0 \ y;
rss0 = sum((y - X0 * b0) .^ 2);
xpos = max(x, 0);
xneg = min(x, 0);
X1 = [ones(n, 1), xneg, xpos];
b1 = X1 \ y;
rss1 = sum((y - X1 * b1) .^ 2);
lr = n * log(rss0 / rss1);
df = 1;
pval = 1 - chi2cdf(lr, df);
n_pos = sum(x > 0);
n_neg = sum(x < 0);
mean_pos = mean(y(x > 0));
mean_neg = mean(y(x < 0));

pr('lrt_n %d\n', n);
pr('lrt_n_pos %d\n', n_pos);
pr('lrt_n_neg %d\n', n_neg);
pr('lrt_mean_pos %.6f\n', mean_pos);
pr('lrt_mean_neg %.6f\n', mean_neg);
pr('lrt_intercept %.6f\n', b1(1));
pr('lrt_slope_neg %.6f\n', b1(2));
pr('lrt_slope_pos %.6f\n', b1(3));
pr('lrt_slope_common %.6f\n', b0(2));
pr('lrt_rss0 %.6f\n', rss0);
pr('lrt_rss1 %.6f\n', rss1);
pr('lrt_stat %.6f\n', lr);
pr('lrt_df %d\n', df);
pr('lrt_p %.6e\n', pval);

lrt = table(n, n_pos, n_neg, mean_pos, mean_neg, ...
    b0(2), b1(1), b1(2), b1(3), rss0, rss1, lr, df, pval, ...
    'VariableNames', {'n','n_pos','n_neg','mean_dml_pos','mean_dml_neg', ...
    'slope_common','intercept','slope_neg','slope_pos','rss_restricted','rss_full', ...
    'lr_stat','df','p_value'});
writetable(lrt, fullfile(OUT, 'regime_change_lrt.csv'));
pr('wrote %s\n', fullfile(OUT, 'regime_change_lrt.csv'));

fprintf('Wrote %s\n', fullfile(OUT, 'validation_summary.txt'));
