%% generate_figure_geometry_model.m
%
% Figure 3 of the reduced note: bivariate-normal plug-in variance.
%   (A) Monte Carlo Var(u_hat) against the delta-method formula
%   (B) n*Var(psi_hat) against u, largest near independence
%
% Requires scripts/outputs/geometry_bvn_plugin.csv from
% run_pef_geometry_numerical_model.m.
%
% Usage (from pef-mathematics root):
%   /Applications/MATLAB_R2025b.app/bin/matlab -batch \
%     "cd('scripts'); run('generate_figure_geometry_model.m')"

clear; close all; clc;

repo_root = fileparts(fileparts(mfilename('fullpath')));
out_csv   = fullfile(repo_root, 'scripts', 'outputs');
fig_dir   = fullfile(repo_root, 'figures');
if ~exist(fig_dir, 'dir'), mkdir(fig_dir); end

bvn = readtable(fullfile(out_csv, 'geometry_bvn_plugin.csv'));

col_pos = [0.12 0.47 0.71];
col_neg = [0.80 0.20 0.18];
pos = bvn.rho > 0;
neg = bvn.rho < 0;

fig = figure('Units', 'centimeters', 'Position', [1 1 24 10], 'Color', 'w');

% ---- (A) plug-in variance of u ------------------------------------------
axA = subplot(1, 2, 1);
hold(axA, 'on');
scatter(axA, bvn.var_u_theory(pos), bvn.var_u_mc(pos), 36, col_pos, ...
    'filled', 'MarkerEdgeColor', col_pos * 0.7, 'HandleVisibility', 'off');
scatter(axA, bvn.var_u_theory(neg), bvn.var_u_mc(neg), 36, col_neg, ...
    'filled', 'MarkerEdgeColor', col_neg * 0.7, 'HandleVisibility', 'off');
lim = max([bvn.var_u_theory; bvn.var_u_mc]) * 1.08;
plot(axA, [0 lim], [0 lim], '-', 'Color', [0.25 0.25 0.25], ...
    'LineWidth', 1.2, 'HandleVisibility', 'off');
xlim(axA, [0 lim]);
ylim(axA, [0 lim]);
axis(axA, 'square');
xlabel(axA, 'Formula for Var(u)', 'FontSize', 12);
ylabel(axA, 'Monte Carlo Var(u)', 'FontSize', 12);
text(axA, 0.04, 0.96, '(A)', 'Units', 'normalized', ...
    'FontSize', 12, 'FontWeight', 'bold', 'VerticalAlignment', 'top');
axA.FontSize = 10;
axA.GridAlpha = 0.15;
axA.TickDir = 'out';
axA.Box = 'off';
grid(axA, 'on');
axA.GridAlpha = 0.15;

% ---- (B) plug-in psi is least stable near u = 0 -------------------------
axB = subplot(1, 2, 2);
hold(axB, 'on');
scatter(axB, bvn.u(pos), bvn.n_times_var_psi(pos), 36, col_pos, ...
    'filled', 'MarkerEdgeColor', col_pos * 0.7, 'HandleVisibility', 'off');
scatter(axB, bvn.u(neg), bvn.n_times_var_psi(neg), 36, col_neg, ...
    'filled', 'MarkerEdgeColor', col_neg * 0.7, 'HandleVisibility', 'off');
xlabel(axB, 'u = \rho sech \tau', 'FontSize', 12);
ylabel(axB, 'n Var(psi)', 'FontSize', 12);
set(axB, 'YScale', 'log');
text(axB, 0.04, 0.96, '(B)', 'Units', 'normalized', ...
    'FontSize', 12, 'FontWeight', 'bold', 'VerticalAlignment', 'top');
axB.FontSize = 10;
axB.TickDir = 'out';
axB.Box = 'off';
grid(axB, 'on');
axB.GridAlpha = 0.15;

set(fig, 'ToolBar', 'none');
axs = findall(fig, 'Type', 'axes');
for ia = 1:numel(axs)
    if isprop(axs(ia), 'Toolbar') && ~isempty(axs(ia).Toolbar)
        axs(ia).Toolbar.Visible = 'off';
    end
end

out3 = fullfile(fig_dir, 'Figure_3_plugin_variance.png');
exportgraphics(fig, out3, 'Resolution', 300);
fprintf('Saved: %s\n', out3);
