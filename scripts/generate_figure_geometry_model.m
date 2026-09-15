%% generate_figure_geometry_model.m
%
% Figure 5 — half-strip geometry numerical model (§7 controlled witness).
% Complements Figures 1–4 (theory) and Figure 6 (empirical KPI sphere).
%
% Outputs (figures/):
%   Figure_5_halfstrip_geometry.png   2x2 validation panels
%   Figure_5b_psi_stabilisation.png  focused psi vs eta variance
%
% Usage (from pef-mathematics root):
%   /Applications/MATLAB_R2025b.app/bin/matlab -batch \
%     "cd('scripts'); run('generate_figure_geometry_model.m')"

clear; close all; clc;

%% Paths -----------------------------------------------------------------
repo_root = fileparts(fileparts(mfilename('fullpath')));
out_csv   = fullfile(repo_root, 'scripts', 'outputs');
fig_dir   = fullfile(repo_root, 'figures');
if ~exist(fig_dir, 'dir'), mkdir(fig_dir); end

grid_tbl = readtable(fullfile(out_csv, 'geometry_grid_algebraic.csv'));
cum_tbl  = readtable(fullfile(out_csv, 'geometry_cumulant_mc.csv'));
psi_tbl  = readtable(fullfile(out_csv, 'geometry_psi_sampling.csv'));
bvn_tbl  = readtable(fullfile(out_csv, 'geometry_bvn_plugin.csv'));

% Colour language (aligned with Figure 4 / empirical quadrants)
col_pos  = [0.18 0.44 0.76];   % rho > 0 branch
col_neg  = [0.80 0.18 0.18];   % rho < 0 branch
col_eta1 = [0.25 0.25 0.25];
col_psi  = [0.10 0.45 0.55];
col_eta  = [0.85 0.45 0.10];
col_grid = [0.88 0.90 0.93];

%% ========================================================================
%  Figure 5 — four-panel half-strip story
% ========================================================================
fig = figure('Units', 'centimeters', 'Position', [1 1 24 18], 'Color', 'w');

% ---- Panel A: half-strip eta landscape ---------------------------------
axA = subplot(2, 2, 1);
hold(axA, 'on');

% Dense analytic surface for smooth contours
tau_d = linspace(0, 1.6, 120);
rho_d = linspace(-0.95, 0.95, 160);
[TT, RR] = meshgrid(tau_d, rho_d);
UU = RR .* sech(TT);
ETA = cosh(TT) ./ (cosh(TT) - RR);
ETA(~isfinite(ETA) | abs(UU) >= 1) = NaN;

contourf(axA, TT, RR, ETA, [0.5 0.6 0.75 0.9 1 1.25 1.5 2 3 5 10], ...
    'LineColor', [0.55 0.58 0.62], 'LineWidth', 0.4, ...
    'HandleVisibility', 'off');
colormap(axA, brew_pef());
cb = colorbar(axA);
cb.Label.String = '\eta';
cb.Label.FontSize = 9;
caxis(axA, [0.5 5]);

% Overlay MC grid points (algebraic cells)
scatter(axA, grid_tbl.tau, grid_tbl.rho, 8, [0.15 0.15 0.18], ...
    'filled', 'MarkerFaceAlpha', 0.35, 'HandleVisibility', 'off');

% Structural lines
yline(axA, 0, '-', 'Color', col_eta1, 'LineWidth', 1.6, ...
    'DisplayName', '\rho = 0  (regime)');
xline(axA, 0, ':', 'Color', [0.35 0.35 0.35], 'LineWidth', 1.2, ...
    'DisplayName', '\tau = 0  (Fisher)');

% Near-pole marker (tau~0, rho~1) — annotation only (avoid legend ghosts)
plot(axA, 0.02, 0.92, 'p', 'MarkerSize', 11, ...
    'MarkerFaceColor', [1 0.9 0.2], 'MarkerEdgeColor', [0.15 0.15 0.15], ...
    'LineWidth', 0.8, 'HandleVisibility', 'off');
text(axA, 0.12, 0.92, 'near pole', 'FontSize', 7, 'Color', [0.25 0.25 0.25], ...
    'VerticalAlignment', 'middle');

xlim(axA, [0 1.55]);
ylim(axA, [-0.95 0.95]);
xlabel(axA, '\tau = (1/2) log \kappa', 'FontSize', 9);
ylabel(axA, '\rho', 'FontSize', 9);
title(axA, 'A  Fundamental half-strip', 'FontSize', 10, ...
    'FontWeight', 'normal', 'HorizontalAlignment', 'left');
legend(axA, {'\rho = 0  (regime)', '\tau = 0  (Fisher)'}, ...
    'Location', 'southwest', 'FontSize', 7, 'Box', 'off');
axA.FontSize = 8;
axA.TickDir = 'out';
axA.Box = 'off';
text(axA, 1.05, 0.55, '\eta > 1', 'Color', col_pos, 'FontSize', 8, ...
    'FontWeight', 'bold');
text(axA, 1.05, -0.55, '\eta < 1', 'Color', col_neg, 'FontSize', 8, ...
    'FontWeight', 'bold');

% ---- Panel B: cumulant recovery ----------------------------------------
axB = subplot(2, 2, 2);
hold(axB, 'on');

% Mean: theory vs MC
scatter(axB, cum_tbl.mean_theory, cum_tbl.mean_mc, 36, col_pos, ...
    'filled', 'MarkerEdgeColor', col_pos*0.7, 'DisplayName', 'E[N]');
% Variance on secondary visual scale via markers
scatter(axB, cum_tbl.var_theory, cum_tbl.var_mc, 36, col_eta, ...
    'filled', '^', 'MarkerEdgeColor', col_eta*0.7, 'DisplayName', 'Var(N)');

lim_max = max([cum_tbl.mean_theory; cum_tbl.mean_mc; ...
    cum_tbl.var_theory; cum_tbl.var_mc]) * 1.05;
plot(axB, [0 lim_max], [0 lim_max], '-', 'Color', [0.4 0.4 0.4], ...
    'LineWidth', 1.2, 'HandleVisibility', 'off');

xlim(axB, [0 lim_max]);
ylim(axB, [0 lim_max]);
axis(axB, 'square');
xlabel(axB, 'Theory  (\eta−1  or  \eta(\eta−1))', 'FontSize', 9);
ylabel(axB, 'Monte Carlo (n = 50000)', 'FontSize', 9);
title(axB, 'B  Geometric-family cumulants', 'FontSize', 10, ...
    'FontWeight', 'normal', 'HorizontalAlignment', 'left');
legend(axB, 'Location', 'northwest', 'FontSize', 7.5, 'Box', 'off');
grid(axB, 'on');
axB.GridAlpha = 0.15;
axB.FontSize = 8;
axB.TickDir = 'out';
axB.Box = 'off';

% ---- Panel C: psi MLE variance stabilisation ---------------------------
axC = subplot(2, 2, 3);
hold(axC, 'on');

% Order cells by psi for a readable walk across the half-strip
[~, ord] = sort(psi_tbl.psi);
x = (1:height(psi_tbl))';
n_var = psi_tbl.n_times_var_psi(ord);
eta_ratio = psi_tbl.var_eta_ratio(ord);

yyaxis(axC, 'left');
axC.YColor = col_psi;
plot(axC, x, n_var, '-o', 'Color', col_psi, 'LineWidth', 1.5, ...
    'MarkerSize', 4.5, 'MarkerFaceColor', col_psi, ...
    'DisplayName', 'n Var(\psî)');
yline(axC, 1, '--', 'Color', col_psi*0.7, 'LineWidth', 1.3, ...
    'DisplayName', 'target = 1');
ylabel(axC, 'n Var(\psî)', 'FontSize', 9);
ylim(axC, [0.7 1.35]);

yyaxis(axC, 'right');
axC.YColor = col_eta;
plot(axC, x, eta_ratio, '-s', 'Color', col_eta, 'LineWidth', 1.2, ...
    'MarkerSize', 4, 'MarkerFaceColor', col_eta, ...
    'DisplayName', 'Var(\etâ) / theory');
ylabel(axC, 'Var(\etâ) / [\eta²(\eta−1)/n]', 'FontSize', 9);
ylim(axC, [0 1.6]);

xlabel(axC, 'Half-strip cells (ordered by \psi)', 'FontSize', 9);
title(axC, 'C  Fisher–Rao: Var(\psî) ≈ 1/n', 'FontSize', 10, ...
    'FontWeight', 'normal', 'HorizontalAlignment', 'left');
legend(axC, 'Location', 'south', 'FontSize', 7, 'Box', 'off', ...
    'NumColumns', 2);
xlim(axC, [0.5 height(psi_tbl)+0.5]);
axC.FontSize = 8;
axC.TickDir = 'out';
axC.Box = 'off';

med_n = median(psi_tbl.n_times_var_psi);
cv_n  = std(psi_tbl.n_times_var_psi) / mean(psi_tbl.n_times_var_psi);
text(axC, 0.04, 0.96, sprintf('median = %.3f,  CV = %.3f', med_n, cv_n), ...
    'Units', 'normalized', 'FontSize', 7.5, 'Color', col_psi, ...
    'VerticalAlignment', 'top');

% ---- Panel D: BVN plug-in uniformity (diagnostic) ----------------------
axD = subplot(2, 2, 4);
hold(axD, 'on');

pos = bvn_tbl.rho > 0;
neg = bvn_tbl.rho < 0;

scatter(axD, bvn_tbl.n_times_var_eta(pos), bvn_tbl.n_times_var_psi(pos), ...
    42, col_pos, 'filled', 'MarkerEdgeColor', col_pos*0.65, ...
    'DisplayName', '\rho > 0');
scatter(axD, bvn_tbl.n_times_var_eta(neg), bvn_tbl.n_times_var_psi(neg), ...
    42, col_neg, 'filled', 'MarkerEdgeColor', col_neg*0.65, ...
    'DisplayName', '\rho < 0');

set(axD, 'XScale', 'log', 'YScale', 'log');
xlabel(axD, 'n Var(\etâ)  (BVN plug-in)', 'FontSize', 9);
ylabel(axD, 'n Var(\psî)  (BVN plug-in)', 'FontSize', 9);
title(axD, 'D  Plug-in diagnostic (not 1/n law)', 'FontSize', 10, ...
    'FontWeight', 'normal', 'HorizontalAlignment', 'left');
legend(axD, 'Location', 'northwest', 'FontSize', 7.5, 'Box', 'off');
grid(axD, 'on');
axD.GridAlpha = 0.15;
axD.FontSize = 8;
axD.TickDir = 'out';
axD.Box = 'off';

cv_psi = std(bvn_tbl.n_times_var_psi) / mean(bvn_tbl.n_times_var_psi);
cv_eta = std(bvn_tbl.n_times_var_eta) / mean(bvn_tbl.n_times_var_eta);
text(axD, 0.96, 0.06, sprintf('CV_\\psi = %.2f   CV_\\eta = %.2f', cv_psi, cv_eta), ...
    'Units', 'normalized', 'FontSize', 7.5, 'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'bottom', 'Interpreter', 'tex', ...
    'Color', [0.25 0.25 0.25]);

sgtitle(fig, {'Half-strip geometry numerical model', ...
    'Controlled witness of Sections 2--6 (no outcome / ML layer)'}, ...
    'FontSize', 11, 'FontWeight', 'normal');

out5 = fullfile(fig_dir, 'Figure_5_halfstrip_geometry.png');
set(fig, 'ToolBar', 'none');
axs = findall(fig, 'Type', 'axes');
for ia = 1:numel(axs)
    if isprop(axs(ia), 'Toolbar') && ~isempty(axs(ia).Toolbar)
        axs(ia).Toolbar.Visible = 'off';
    end
end
exportgraphics(fig, out5, 'Resolution', 220);
fprintf('Saved: %s\n', out5);

%% ========================================================================
%  Figure 5b — focused psi vs eta story (single clean panel pair)
% ========================================================================
fig2 = figure('Units', 'centimeters', 'Position', [1 1 22 9], 'Color', 'w');

% Left: n*Var(psi) histogram + target
axL = subplot(1, 2, 1);
hold(axL, 'on');
histogram(axL, psi_tbl.n_times_var_psi, 10, ...
    'FaceColor', col_psi, 'FaceAlpha', 0.75, 'EdgeColor', 'w', ...
    'DisplayName', 'n Var(\psî)');
xline(axL, 1, '-', 'Color', [0.15 0.15 0.15], 'LineWidth', 1.8, ...
    'DisplayName', 'asymptotic target');
xline(axL, med_n, '--', 'Color', col_psi*0.8, 'LineWidth', 1.4, ...
    'DisplayName', sprintf('median = %.3f', med_n));
xlabel(axL, 'n Var(\psî)', 'FontSize', 10);
ylabel(axL, 'Half-strip cells', 'FontSize', 10);
title(axL, 'Geometric-family MLE', 'FontSize', 10, 'FontWeight', 'normal');
legend(axL, 'Location', 'northwest', 'FontSize', 8, 'Box', 'off');
axL.FontSize = 9;
axL.TickDir = 'out';
axL.Box = 'off';
xlim(axL, [0.7 1.35]);

% Right: eta ratio spread (same MLE trials)
axR = subplot(1, 2, 2);
hold(axR, 'on');
scatter(axR, psi_tbl.eta, psi_tbl.var_eta_ratio, 50, psi_tbl.psi, ...
    'filled', 'MarkerEdgeColor', [0.3 0.3 0.3], 'LineWidth', 0.4);
colormap(axR, brew_pef());
cb2 = colorbar(axR);
cb2.Label.String = '\psi';
cb2.Label.FontSize = 9;
yline(axR, 1, '--', 'Color', [0.3 0.3 0.3], 'LineWidth', 1.2);
xlabel(axR, '\eta', 'FontSize', 10);
ylabel(axR, 'Var(\etâ) / theory', 'FontSize', 10);
title(axR, '\eta-scale is non-uniform', 'FontSize', 10, 'FontWeight', 'normal');
axR.FontSize = 9;
axR.TickDir = 'out';
axR.Box = 'off';
grid(axR, 'on');
axR.GridAlpha = 0.12;

sgtitle(fig2, 'Variance stabilisation on the half-strip (\rho > 0 branch)', ...
    'FontSize', 11, 'FontWeight', 'normal');

out5b = fullfile(fig_dir, 'Figure_5b_psi_stabilisation.png');
set(fig2, 'ToolBar', 'none');
axs2 = findall(fig2, 'Type', 'axes');
for ia = 1:numel(axs2)
    if isprop(axs2(ia), 'Toolbar') && ~isempty(axs2(ia).Toolbar)
        axs2(ia).Toolbar.Visible = 'off';
    end
end
exportgraphics(fig2, out5b, 'Resolution', 220);
fprintf('Saved: %s\n', out5b);

fprintf('Done.\n');

%% Local colormap (cool slate → warm amber; avoids purple default) -------
function cmap = brew_pef()
    n = 256;
    c1 = [0.95 0.96 0.97];
    c2 = [0.55 0.72 0.82];
    c3 = [0.12 0.38 0.55];
    c4 = [0.85 0.55 0.18];
    c5 = [0.72 0.22 0.14];
    stops = [c1; c2; c3; c4; c5];
    xi = linspace(1, size(stops, 1), n);
    cmap = interp1(1:size(stops, 1), stops, xi);
end
