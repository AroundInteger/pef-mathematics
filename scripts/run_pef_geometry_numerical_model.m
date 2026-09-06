%% RUN_PEF_GEOMETRY_NUMERICAL_MODEL
% Complementary numerical model for the mathematics companion.
%
% Scope: fundamental half-strip tau >= 0 and the geometric claims of
% Sections 2--6 (involution, sphere, partition-function cumulants, psi
% variance stabilisation, regime branches at rho = 0).
%
% Deliberately distinct from the empirical idealised probit simulation
% (A1)--(A2) in pef-empirical: no outcome model, no ML, no KPI inventory.
% This script validates the *geometry* under controlled sampling.
%
% Blocks:
%   A  Dense half-strip algebraic checks (involution, sphere, series)
%   B  Latent geometric-family Monte Carlo (cumulant identities)
%   C  Geometric-family MLE Monte Carlo (Var(psi)~1/n; contrast Var(eta))
%   D  BVN plug-in diagnostic (half-strip uniformity of psi vs eta; no 1/n claim)
%
% Outputs (scripts/outputs/):
%   geometry_grid_algebraic.csv
%   geometry_cumulant_mc.csv
%   geometry_psi_sampling.csv
%   geometry_bvn_plugin.csv
%   geometry_numerical_summary.txt
%
% Run from repo root or scripts/:
%   /Applications/MATLAB_R2025b.app/bin/matlab -batch \
%     "cd('scripts'); run('run_pef_geometry_numerical_model.m')"

clear; clc; close all;
RNG_BASE = 20260905;
rng(RNG_BASE, 'twister');

THIS_DIR = fileparts(mfilename('fullpath'));
OUT_DIR  = fullfile(THIS_DIR, 'outputs');
if ~exist(OUT_DIR, 'dir')
    mkdir(OUT_DIR);
end
addpath(fullfile(THIS_DIR, 'lib'));

H = pef_geometry_helpers();

% ---- PRODUCTION_CONFIG (paper-locked) -----------------------------------
PRODUCTION_CONFIG = struct( ...
    'TAU_GRID',        [0, 0.1, 0.25, 0.5, 1.0, 1.5], ...
    'RHO_POS',         [0.05, 0.15, 0.3, 0.5, 0.7, 0.85], ...
    'RHO_NEG',         [-0.85, -0.5, -0.3, -0.15, -0.05], ...
    'RHO_DENSE',       linspace(-0.95, 0.95, 39), ...
    'N_GEO',           50000, ...
    'N_PAIR',          500, ...
    'N_GEO_PSI',       200, ...
    'N_TRIALS',        400, ...
    'SERIES_TERMS',    200);

SMOKE_TEST = false;   % true: tiny grids / trials for a quick sanity check

TAU_GRID     = PRODUCTION_CONFIG.TAU_GRID;
RHO_POS      = PRODUCTION_CONFIG.RHO_POS;
RHO_NEG      = PRODUCTION_CONFIG.RHO_NEG;
RHO_DENSE    = PRODUCTION_CONFIG.RHO_DENSE;
N_GEO        = PRODUCTION_CONFIG.N_GEO;
N_PAIR       = PRODUCTION_CONFIG.N_PAIR;
N_GEO_PSI    = PRODUCTION_CONFIG.N_GEO_PSI;
N_TRIALS     = PRODUCTION_CONFIG.N_TRIALS;
SERIES_TERMS = PRODUCTION_CONFIG.SERIES_TERMS;

if SMOKE_TEST
    TAU_GRID     = [0, 0.5];
    RHO_POS      = [0.3, 0.7];
    RHO_NEG      = [-0.5];
    RHO_DENSE    = linspace(-0.8, 0.8, 9);
    N_GEO        = 5000;
    N_PAIR       = 100;
    N_GEO_PSI    = 80;
    N_TRIALS     = 40;
end

fprintf('=== PEF geometry numerical model (half-strip) ===\n');
if SMOKE_TEST
    fprintf('*** SMOKE_TEST mode ***\n');
end
fprintf('Date: %s\n\n', datestr(now));

log_lines = {};
log_lines{end+1} = '=== PEF geometry numerical model summary ===';
log_lines{end+1} = sprintf('Date: %s', datestr(now));
log_lines{end+1} = sprintf('RNG base: %d', RNG_BASE);
log_lines{end+1} = sprintf('SMOKE_TEST: %d', SMOKE_TEST);
log_lines{end+1} = sprintf('tau grid: %s', mat2str(TAU_GRID));
log_lines{end+1} = sprintf('N_GEO=%d, N_GEO_PSI=%d, N_PAIR=%d, N_TRIALS=%d', ...
    N_GEO, N_GEO_PSI, N_PAIR, N_TRIALS);
log_lines{end+1} = '';

%% Block A --- algebraic half-strip grid ----------------------------------
fprintf('Block A: algebraic half-strip checks...\n');

rows_A = [];
for it = 1:numel(TAU_GRID)
    tau = TAU_GRID(it);
    for ir = 1:numel(RHO_DENSE)
        rho = RHO_DENSE(ir);
        if ~H.is_physical(tau, rho)
            continue
        end
        eta_p  = H.eta_canonical(tau, rho);
        eta_m  = H.eta_canonical(-tau, rho);          % involution
        eta_s  = H.eta_sphere(tau, rho);              % sphere
        u      = H.u_eff(tau, rho);
        % Truncated geometric series (converges for |u|<1)
        series = 0;
        uk = 1;
        for k = 0:SERIES_TERMS
            series = series + uk;
            uk = uk * u;
        end
        % Parabolic blow-up residual near pole (tau~0, rho~1)
        eta_parab = 1 / ((1 - rho) + 0.5 * tau^2);
        rows_A = [rows_A; tau, rho, eta_p, eta_m, eta_s, series, ...
            abs(eta_p - eta_m), abs(eta_p - eta_s), abs(eta_p - series), ...
            abs(eta_p - eta_parab), u]; %#ok<AGROW>
    end
end

grid_tbl = array2table(rows_A, 'VariableNames', { ...
    'tau', 'rho', 'eta', 'eta_neg_tau', 'eta_sphere', 'eta_series', ...
    'resid_involution', 'resid_sphere', 'resid_series', ...
    'resid_parabolic', 'u'});

max_inv = max(grid_tbl.resid_involution);
max_sph = max(grid_tbl.resid_sphere);
% Series residual: exclude |u| near 1 where truncation converges slowly
series_mask = abs(grid_tbl.u) < 0.85;
max_ser = max(grid_tbl.resid_series(series_mask));

fprintf('  involution max |eta(tau)-eta(-tau)| = %.3e  (%d cells)\n', ...
    max_inv, height(grid_tbl));
fprintf('  sphere     max |eta - 1/(1-cos sigma)| = %.3e\n', max_sph);
fprintf('  series     max |eta - sum u^k| (|u|<0.85, K=%d) = %.3e\n', ...
    SERIES_TERMS, max_ser);

log_lines{end+1} = '--- Block A: algebraic ---';
log_lines{end+1} = sprintf('cells: %d', height(grid_tbl));
log_lines{end+1} = sprintf('max involution residual: %.3e', max_inv);
log_lines{end+1} = sprintf('max sphere residual: %.3e', max_sph);
log_lines{end+1} = sprintf('max series residual (|u|<0.85): %.3e', max_ser);
log_lines{end+1} = '';

writetable(grid_tbl, fullfile(OUT_DIR, 'geometry_grid_algebraic.csv'));

%% Block B --- geometric-family cumulant Monte Carlo ----------------------
fprintf('Block B: geometric-family cumulant MC...\n');

rows_B = [];
for it = 1:numel(TAU_GRID)
    tau = TAU_GRID(it);
    for ir = 1:numel(RHO_POS)
        rho = RHO_POS(ir);
        if ~H.is_physical(tau, rho)
            continue
        end
        eta = H.eta_canonical(tau, rho);
        mu_th  = eta - 1;
        var_th = eta * (eta - 1);
        N = H.sample_geo_N(tau, rho, N_GEO);
        mu_hat  = mean(N);
        var_hat = var(N, 0);
        rows_B = [rows_B; tau, rho, eta, mu_th, mu_hat, abs(mu_hat - mu_th), ...
            var_th, var_hat, abs(var_hat - var_th)]; %#ok<AGROW>
    end
end

cum_tbl = array2table(rows_B, 'VariableNames', { ...
    'tau', 'rho', 'eta', 'mean_theory', 'mean_mc', 'abs_err_mean', ...
    'var_theory', 'var_mc', 'abs_err_var'});

rel_mean = max(cum_tbl.abs_err_mean ./ max(cum_tbl.mean_theory, 1e-12));
rel_var  = max(cum_tbl.abs_err_var  ./ max(cum_tbl.var_theory, 1e-12));

fprintf('  cumulant cells: %d\n', height(cum_tbl));
fprintf('  max relative |mean - (eta-1)| = %.3e\n', rel_mean);
fprintf('  max relative |var - eta(eta-1)| = %.3e\n', rel_var);

log_lines{end+1} = '--- Block B: geometric family MC ---';
log_lines{end+1} = sprintf('cells: %d, n=%d', height(cum_tbl), N_GEO);
log_lines{end+1} = sprintf('max rel mean error: %.3e', rel_mean);
log_lines{end+1} = sprintf('max rel var error: %.3e', rel_var);
log_lines{end+1} = '';

writetable(cum_tbl, fullfile(OUT_DIR, 'geometry_cumulant_mc.csv'));

%% Block C --- geometric-family MLE: Var(psi) ~ 1/n ----------------------
% Matches prop:psi / eq:psi_clt: MLE of the latent geometric family mapped
% to psi has asymptotic variance 1/n uniformly on the positive-rho branch.
fprintf('Block C: geometric-family MLE (Var(psi)~1/n)...\n');

rows_C = [];
for it = 1:numel(TAU_GRID)
    tau = TAU_GRID(it);
    for ir = 1:numel(RHO_POS)
        rho = RHO_POS(ir);
        if ~H.is_physical(tau, rho) || rho <= 0
            continue
        end
        eta0 = H.eta_canonical(tau, rho);
        psi0 = H.psi_signed(tau, rho);
        u0   = H.u_eff(tau, rho);

        eta_s = nan(N_TRIALS, 1);
        psi_s = nan(N_TRIALS, 1);
        for t = 1:N_TRIALS
            rng(RNG_BASE + 200000*it + 1000*ir + t, 'twister');
            N = H.sample_geo_N(tau, rho, N_GEO_PSI);
            % MLE: E[N]=eta-1 => eta_hat = 1 + mean(N); u_hat = 1 - 1/eta_hat
            eta_hat = 1 + mean(N);
            u_hat = 1 - 1 / eta_hat;
            u_hat = min(max(u_hat, 0), 1 - 1e-15);
            psi_hat = 2 * atanh(sqrt(u_hat));
            eta_s(t) = eta_hat;
            psi_s(t) = psi_hat;
        end

        var_eta = var(eta_s, 0);
        var_psi = var(psi_s, 0);
        var_psi_th = 1 / N_GEO_PSI;
        var_eta_th = (eta0^2 * (eta0 - 1)) / N_GEO_PSI;

        rows_C = [rows_C; tau, rho, eta0, psi0, u0, var_eta, var_psi, ...
            var_eta_th, var_psi_th, ...
            N_GEO_PSI * var_psi, ...
            var_eta / var_eta_th]; %#ok<AGROW>
    end
end

psi_tbl = array2table(rows_C, 'VariableNames', { ...
    'tau', 'rho', 'eta', 'psi', 'u', 'var_eta_mc', 'var_psi_mc', ...
    'var_eta_theory', 'var_psi_theory', ...
    'n_times_var_psi', 'var_eta_ratio'});

n_var_psi = psi_tbl.n_times_var_psi;
med_n_var_psi = median(n_var_psi);
cv_psi = std(n_var_psi) / mean(n_var_psi);
cv_eta_ratio = std(psi_tbl.var_eta_ratio) / mean(psi_tbl.var_eta_ratio);

fprintf('  MLE cells: %d (n=%d, trials=%d)\n', ...
    height(psi_tbl), N_GEO_PSI, N_TRIALS);
fprintf('  median n*Var(psi) = %.3f (target 1)\n', med_n_var_psi);
fprintf('  CV of n*Var(psi) = %.3f\n', cv_psi);
fprintf('  CV of Var(eta)/theory = %.3f (eta scale is non-uniform)\n', ...
    cv_eta_ratio);

log_lines{end+1} = '--- Block C: geometric-family MLE psi ---';
log_lines{end+1} = sprintf('cells: %d, n=%d, trials=%d', ...
    height(psi_tbl), N_GEO_PSI, N_TRIALS);
log_lines{end+1} = sprintf('median n*Var(psi): %.4f (target 1)', med_n_var_psi);
log_lines{end+1} = sprintf('CV n*Var(psi): %.4f', cv_psi);
log_lines{end+1} = sprintf('CV Var(eta)/theory: %.4f', cv_eta_ratio);
log_lines{end+1} = '';

writetable(psi_tbl, fullfile(OUT_DIR, 'geometry_psi_sampling.csv'));

%% Block D --- BVN plug-in diagnostic (uniformity only) -------------------
% Plug-in estimators under bivariate-normal pairing do *not* inherit the
% geometric-family 1/n law; this block only checks that n*Var(psi_hat) is
% more stable across the half-strip than raw Var(eta_hat).
fprintf('Block D: BVN plug-in uniformity diagnostic...\n');

rho_samp = [RHO_NEG, RHO_POS];
rows_D = [];
for it = 1:numel(TAU_GRID)
    tau = TAU_GRID(it);
    for ir = 1:numel(rho_samp)
        rho = rho_samp(ir);
        if ~H.is_physical(tau, rho)
            continue
        end
        eta0 = H.eta_canonical(tau, rho);
        psi0 = H.psi_signed(tau, rho);

        eta_s = nan(N_TRIALS, 1);
        psi_s = nan(N_TRIALS, 1);
        for t = 1:N_TRIALS
            rng(RNG_BASE + 300000*it + 1000*ir + t, 'twister');
            [A, B] = H.sample_bvn_tau(tau, rho, N_PAIR, 1);
            est = H.estimate_pair(A, B);
            eta_s(t) = est.eta;
            psi_s(t) = est.psi;
        end

        rows_D = [rows_D; tau, rho, eta0, psi0, ...
            var(eta_s, 0), var(psi_s, 0), ...
            N_PAIR * var(psi_s, 0), ...
            N_PAIR * var(eta_s, 0)]; %#ok<AGROW>
    end
end

bvn_tbl = array2table(rows_D, 'VariableNames', { ...
    'tau', 'rho', 'eta', 'psi', 'var_eta_mc', 'var_psi_mc', ...
    'n_times_var_psi', 'n_times_var_eta'});

cv_bvn_psi = std(bvn_tbl.n_times_var_psi) / mean(bvn_tbl.n_times_var_psi);
cv_bvn_eta = std(bvn_tbl.n_times_var_eta) / mean(bvn_tbl.n_times_var_eta);

fprintf('  BVN cells: %d (n=%d, trials=%d)\n', height(bvn_tbl), N_PAIR, N_TRIALS);
fprintf('  CV n*Var(psi_plug-in) = %.3f\n', cv_bvn_psi);
fprintf('  CV n*Var(eta_plug-in) = %.3f\n', cv_bvn_eta);

log_lines{end+1} = '--- Block D: BVN plug-in diagnostic ---';
log_lines{end+1} = sprintf('cells: %d, n=%d, trials=%d', ...
    height(bvn_tbl), N_PAIR, N_TRIALS);
log_lines{end+1} = sprintf('CV n*Var(psi_plug-in): %.4f', cv_bvn_psi);
log_lines{end+1} = sprintf('CV n*Var(eta_plug-in): %.4f', cv_bvn_eta);
log_lines{end+1} = '';

writetable(bvn_tbl, fullfile(OUT_DIR, 'geometry_bvn_plugin.csv'));

%% Pass / fail summary ----------------------------------------------------
TOL_ALG = 1e-10;
TOL_SER = 1e-6;
TOL_CUM_REL = 0.05;
PASS_A = (max_inv < TOL_ALG) && (max_sph < TOL_ALG) && (max_ser < TOL_SER);
PASS_B = (rel_mean < TOL_CUM_REL) && (rel_var < TOL_CUM_REL);
% Geometric-family psi: median n*Var within [0.7, 1.4]; CV modest
PASS_C = (med_n_var_psi > 0.7) && (med_n_var_psi < 1.4) && (cv_psi < 0.35);
% BVN diagnostic is informational (no hard fail on absolute level)
PASS_D = isfinite(cv_bvn_psi) && isfinite(cv_bvn_eta);

log_lines{end+1} = '--- Pass/fail ---';
log_lines{end+1} = sprintf('Block A (algebraic): %s', tern(PASS_A, 'PASS', 'FAIL'));
log_lines{end+1} = sprintf('Block B (cumulants): %s', tern(PASS_B, 'PASS', 'FAIL'));
log_lines{end+1} = sprintf('Block C (psi MLE): %s', tern(PASS_C, 'PASS', 'FAIL'));
log_lines{end+1} = sprintf('Block D (BVN diagnostic): %s', tern(PASS_D, 'PASS', 'FAIL'));
log_lines{end+1} = sprintf('Overall: %s', ...
    tern(PASS_A && PASS_B && PASS_C && PASS_D, 'PASS', 'FAIL'));

fprintf('\nPass/fail: A=%s  B=%s  C=%s  D=%s  overall=%s\n', ...
    tern(PASS_A, 'PASS', 'FAIL'), ...
    tern(PASS_B, 'PASS', 'FAIL'), ...
    tern(PASS_C, 'PASS', 'FAIL'), ...
    tern(PASS_D, 'PASS', 'FAIL'), ...
    tern(PASS_A && PASS_B && PASS_C && PASS_D, 'PASS', 'FAIL'));

summary_path = fullfile(OUT_DIR, 'geometry_numerical_summary.txt');
fid = fopen(summary_path, 'w');
for i = 1:numel(log_lines)
    fprintf(fid, '%s\n', log_lines{i});
end
fclose(fid);
fprintf('Wrote %s\n', summary_path);
fprintf('Done.\n');

% -------------------------------------------------------------------------
function s = tern(cond, a, b)
    if cond, s = a; else, s = b; end
end
