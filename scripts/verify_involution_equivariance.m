%% verify_involution_equivariance.m
% Level 3 symmetry check (companion, analytic; no ML, no outcome layer).
%
% The involution kappa <-> 1/kappa leaves eta invariant (Levels 1-2). This
% script shows that the outcome-layer SIGNAL coordinate is not invariant but
% equivariant, with a clean closed-form law, using only (kappa, rho) and the
% paired effect size already in the empirical landscape CSV.
%
% Coordinates (sigma_A = 1):
%   VarN  = 1 + kappa - 2 sqrt(kappa) rho            ( = (1+kappa)/eta )
%   d_rel = (delta/sigma_A) / sqrt(VarN)             ( = cohens_d_paired )
%   r_A   = corr(X_A, X) = (1 - rho sqrt(kappa)) / sqrt(VarN)
%   r_B   = corr(X_B, X) = (rho - sqrt(kappa))    / sqrt(VarN)
%
% Checks on the sports KPI grid in the landscape CSV:
%   C2  VarN(1/kappa)          = VarN(kappa) / kappa
%   C3  d_rel(1/kappa)         = sqrt(kappa) * d_rel(kappa)   (delta/sigma_A fixed)
%   C4  r_B(kappa)             = - r_A(1/kappa)
% and an anchor that cohens_d_paired reproduces d_rel from the raw moments.
%
% Input : validation_inputs/pef_landscape_2season_geometry.csv
% Output: scripts/outputs/involution_equivariance_check.csv (+ console summary)

THIS = fileparts(mfilename('fullpath'));
if isempty(THIS), THIS = pwd; end
REPO = fileparts(THIS);
CSV  = fullfile(REPO, 'validation_inputs', 'pef_landscape_2season_geometry.csv');
OUT  = fullfile(REPO, 'scripts', 'outputs');
if ~exist(OUT, 'dir'), mkdir(OUT); end

T = readtable(CSV);
kappa = T.kappa;
rho   = T.rho;
drel  = T.cohens_d_paired;          % = delta / sqrt(Var(X))

sk    = sqrt(kappa);
VarN  = 1 + kappa - 2 .* sk .* rho;

% Anchor: cohens_d_paired equals delta / sqrt(Var(X)) from raw moments.
delta   = T.mean_home - T.mean_away;
VarX    = T.var_home + T.var_away - 2 .* rho .* sqrt(T.var_home .* T.var_away);
drel_raw = delta ./ sqrt(VarX);
anchor_res = max(abs(drel_raw - drel));

% Involuted parameters.
kap_i  = 1 ./ kappa;
ski    = sqrt(kap_i);
VarN_i = 1 + kap_i - 2 .* ski .* rho;

% C2: VarN(1/kappa) = VarN(kappa)/kappa.
c2_res = max(abs(VarN_i - VarN ./ kappa));

% C3: d_rel(1/kappa) = sqrt(kappa) d_rel(kappa), holding delta/sigma_A fixed.
sig_ratio = drel .* sqrt(VarN);          % = delta/sigma_A (invariant to relabelling of parameters)
drel_i    = sig_ratio ./ sqrt(VarN_i);   % d_rel evaluated at 1/kappa
c3_res    = max(abs(drel_i - sk .* drel));

% C4: r_B(kappa) = - r_A(1/kappa).
rA   = (1 - rho .* sk)  ./ sqrt(VarN);
rB   = (rho - sk)       ./ sqrt(VarN);
rA_i = (1 - rho .* ski) ./ sqrt(VarN_i);
c4_res = max(abs(rB + rA_i));

% eta invariance re-confirmed from the same columns (sanity).
eta   = (1 + kappa) ./ VarN;
eta_i = (1 + kap_i) ./ VarN_i;
eta_res = max(abs(eta - eta_i));

fprintf('=== Involution equivariance check (n = %d KPIs) ===\n', height(T));
fprintf('anchor  cohens_d_paired = delta/sqrt(VarX) : max resid %.2e\n', anchor_res);
fprintf('eta invariance   eta(k)=eta(1/k)           : max resid %.2e\n', eta_res);
fprintf('C2  VarN(1/k)=VarN(k)/k                     : max resid %.2e\n', c2_res);
fprintf('C3  d_rel(1/k)=sqrt(k) d_rel(k)             : max resid %.2e\n', c3_res);
fprintf('C4  r_B(k) = -r_A(1/k)                       : max resid %.2e\n', c4_res);
fprintf('ranges: kappa [%.3f, %.3f]  d_rel [%.3f, %.3f]  |r_A| [%.3f, %.3f]\n', ...
    min(kappa), max(kappa), min(drel), max(drel), min(abs(rA)), max(abs(rA)));
fprintf('equivariance factor sqrt(kappa) spans [%.3f, %.3f]\n', min(sk), max(sk));

res = table(kappa, rho, eta, VarN, drel, drel_i, sk, rA, rB, rA_i, ...
    'VariableNames', {'kappa','rho','eta','VarN','d_rel','d_rel_inv', ...
                      'sqrt_kappa','r_A','r_B','r_A_inv'});
writetable(res, fullfile(OUT, 'involution_equivariance_check.csv'));
fprintf('Wrote %s\n', fullfile(OUT, 'involution_equivariance_check.csv'));
