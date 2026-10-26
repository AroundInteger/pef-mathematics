%% generate_figures_companion_main.m
%
% Ideal main-text theory plates for the PEF mathematics companion:
%   Figure_1_halfstrip_domain.png     §2  fundamental domain + involution
%   Figure_2_mobius_linearisation.png §3  affine reciprocal / iso-eta
%   Figure_3_sphere_theory.png        §4  clean sphere (no KPI cloud)
%   Figure_4_psi_partition.png        §5–6 partition cumulants + psi
%
% Usage (from pef-mathematics root):
%   /Applications/MATLAB_R2025b.app/bin/matlab -batch \
%     "cd('scripts'); run('generate_figures_companion_main.m')"

clear; close all; clc;

repo_root = fileparts(fileparts(mfilename('fullpath')));
fig_dir   = fullfile(repo_root, 'figures');
if ~exist(fig_dir, 'dir'), mkdir(fig_dir); end

col_pos  = [0.18 0.44 0.76];
col_neg  = [0.80 0.18 0.18];
col_line = [0.22 0.22 0.22];
col_psi  = [0.10 0.45 0.55];
col_eta  = [0.85 0.45 0.10];

%% ========================================================================
%  Figure 1 — Fundamental half-strip (§2)
% ========================================================================
fig1 = figure('Units', 'centimeters', 'Position', [1 1 24 11], 'Color', 'w');

% ---- Main: half-strip landscape ----------------------------------------
ax1 = axes('Parent', fig1, 'Position', [0.07 0.14 0.55 0.78]);
hold(ax1, 'on');

tau_d = linspace(0, 1.7, 160);
rho_d = linspace(-0.98, 0.98, 200);
[TT, RR] = meshgrid(tau_d, rho_d);
ETA = cosh(TT) ./ (cosh(TT) - RR);
ETA(~isfinite(ETA) | abs(RR .* sech(TT)) >= 1) = NaN;

levels = [0.55 0.7 0.85 1 1.25 1.5 2 3 5 10];
contourf(ax1, TT, RR, ETA, levels, ...
    'LineColor', [0.55 0.58 0.62], 'LineWidth', 0.35, 'HandleVisibility', 'off');
colormap(ax1, brew_pef());
cb = colorbar(ax1);
cb.Label.String = '\eta';
cb.Label.FontSize = 12;
cb.FontSize = 10;
caxis(ax1, [0.5 5]);

% Explicit iso-eta cosh overlays: rho = (1 - 1/eta) * cosh(tau)
tau_c = linspace(0, 1.7, 200);
eta_iso = [0.6 0.75 2 4];
iso_cols = [0.70 0.35 0.15; 0.65 0.25 0.20; 0.10 0.35 0.65; 0.05 0.20 0.55];
for k = 1:numel(eta_iso)
    e = eta_iso(k);
    c = 1 / e;
    rho_iso = (1 - c) * cosh(tau_c);
    ok = abs(rho_iso) < 0.99;
    plot(ax1, tau_c(ok), rho_iso(ok), '-', 'Color', iso_cols(k,:), ...
        'LineWidth', 1.3, 'HandleVisibility', 'off');
end

yline(ax1, 0, '-', 'Color', col_line, 'LineWidth', 1.8);
plot(ax1, 0.03, 0.93, 'p', 'MarkerSize', 12, ...
    'MarkerFaceColor', [1 0.9 0.2], 'MarkerEdgeColor', [0.1 0.1 0.1], ...
    'LineWidth', 0.9, 'HandleVisibility', 'off');
text(ax1, 0.22, 0.78, 'pole', 'FontSize', 12, 'Color', [0.25 0.25 0.25]);

xlim(ax1, [0 1.65]);
ylim(ax1, [-0.98 0.98]);
xlabel(ax1, '\tau = (1/2) log \kappa', 'FontSize', 12);
ylabel(ax1, '\rho', 'FontSize', 12);
text(ax1, 0.03, 0.04, '(A)', 'Units', 'normalized', ...
    'FontSize', 12, 'FontWeight', 'bold', 'VerticalAlignment', 'bottom');
text(ax1, 1.15, 0.55, '\eta > 1', 'Color', col_pos, 'FontSize', 12, 'FontWeight', 'bold');
text(ax1, 1.15, -0.55, '\eta < 1', 'Color', col_neg, 'FontSize', 12, 'FontWeight', 'bold');
text(ax1, 0.15, 0.08, '\rho = 0', 'FontSize', 12, 'Color', col_line);
ax1.FontSize = 10;
ax1.TickDir = 'out';
ax1.Box = 'off';

% ---- Inset: involution folding -----------------------------------------
ax1b = axes('Parent', fig1, 'Position', [0.70 0.18 0.26 0.68]);
hold(ax1b, 'on');

% Full strip sketch: shade tau<0 pale, tau>=0 bold
fill(ax1b, [-1.5 0 0 -1.5], [-1 -1 1 1], [0.93 0.94 0.96], ...
    'EdgeColor', 'none', 'HandleVisibility', 'off');
fill(ax1b, [0 1.5 1.5 0], [-1 -1 1 1], [0.88 0.92 0.97], ...
    'EdgeColor', 'none', 'HandleVisibility', 'off');

% Sample points and their involution images
rng(1);
n_demo = 12;
tau_s = 0.15 + 1.2 * rand(n_demo, 1);
rho_s = -0.7 + 1.4 * rand(n_demo, 1);
eta_s = cosh(tau_s) ./ (cosh(tau_s) - rho_s);
cols_s = zeros(n_demo, 3);
for i = 1:n_demo
    if rho_s(i) >= 0
        cols_s(i, :) = col_pos;
    else
        cols_s(i, :) = col_neg;
    end
    plot(ax1b, [-tau_s(i), tau_s(i)], [rho_s(i), rho_s(i)], ':', ...
        'Color', [0.65 0.65 0.65], 'LineWidth', 0.8, 'HandleVisibility', 'off');
    plot(ax1b, -tau_s(i), rho_s(i), 'o', 'MarkerSize', 6, ...
        'MarkerFaceColor', cols_s(i,:), 'MarkerEdgeColor', cols_s(i,:)*0.7, ...
        'HandleVisibility', 'off');
    plot(ax1b, tau_s(i), rho_s(i), 'o', 'MarkerSize', 7, ...
        'MarkerFaceColor', cols_s(i,:), 'MarkerEdgeColor', [0.1 0.1 0.1], ...
        'LineWidth', 0.7, 'HandleVisibility', 'off');
end

xline(ax1b, 0, '-', 'Color', col_line, 'LineWidth', 1.4);
yline(ax1b, 0, '-', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.0);
xlim(ax1b, [-1.5 1.5]);
ylim(ax1b, [-1 1]);
xlabel(ax1b, '\tau', 'FontSize', 12);
ylabel(ax1b, '\rho', 'FontSize', 12);
text(ax1b, 0.03, 0.97, '(B)', 'Units', 'normalized', ...
    'FontSize', 12, 'FontWeight', 'bold', 'VerticalAlignment', 'top');
text(ax1b, -0.40, 0.86, '$\tau < 0$', 'Interpreter', 'latex', 'FontSize', 12, 'Color', [0.35 0.35 0.35]);
text(ax1b, 0.40, 0.86, '$\tau \geq 0$', 'Interpreter', 'latex', 'FontSize', 12, 'Color', [0.2 0.35 0.55]);
ax1b.FontSize = 10;
ax1b.TickDir = 'out';
ax1b.Box = 'off';
axis(ax1b, 'square');

export_clean(fig1, fullfile(fig_dir, 'Figure_1_halfstrip_domain.png'));

%% ========================================================================
%  Figure 2 — Möbius linearisation (§3)
% ========================================================================
fig2 = figure('Units', 'centimeters', 'Position', [1 1 24 10], 'Color', 'w');

% Left: iso-eta as cosh curves in (tau, rho)
ax2a = subplot(1, 2, 1);
hold(ax2a, 'on');
tau_c = linspace(0, 1.8, 300);
eta_list = [0.55 0.7 0.85 1 1.25 1.5 2 3 5];
cmap_iso = brew_pef();
for k = 1:numel(eta_list)
    e = eta_list(k);
    c = 1 / e;
    rho_iso = (1 - c) * cosh(tau_c);
    ok = abs(rho_iso) < 0.99;
    col = interp1(linspace(0.5, 5, size(cmap_iso,1)), cmap_iso, min(max(e, 0.5), 5));
    lw = 1.0 + 1.2 * (e == 1);
    if e == 1
        plot(ax2a, tau_c, zeros(size(tau_c)), '-', 'Color', col_line, ...
            'LineWidth', 2.0, 'HandleVisibility', 'off');
    else
        plot(ax2a, tau_c(ok), rho_iso(ok), '-', 'Color', col, ...
            'LineWidth', lw, 'HandleVisibility', 'off');
        if e >= 3
            tau_lab = 0.12;
        else
            tau_lab = 0.45;
        end
        [~, jlab] = min(abs(tau_c - tau_lab));
        if ok(jlab) && abs(rho_iso(jlab)) < 0.88
            text(ax2a, tau_c(jlab) + 0.04, rho_iso(jlab), sprintf('%.2g', e), ...
                'FontSize', 10, 'Color', col*0.75, ...
                'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
                'Clipping', 'on');
        end
    end
end
xlim(ax2a, [0 1.75]);
ylim(ax2a, [-0.95 0.95]);
xlabel(ax2a, '\tau', 'FontSize', 12);
ylabel(ax2a, '\rho', 'FontSize', 12);
text(ax2a, 0.90, 0.96, '(A)', 'Units', 'normalized', ...
    'FontSize', 12, 'FontWeight', 'bold', 'VerticalAlignment', 'top', ...
    'HorizontalAlignment', 'right');
text(ax2a, 1.35, 0.08, '\eta = 1', 'FontSize', 12, 'Color', col_line);
ax2a.FontSize = 10;
ax2a.TickDir = 'out';
ax2a.Box = 'off';
grid(ax2a, 'on');
ax2a.GridAlpha = 0.12;

% Right: affine in rho at fixed tau — 1/eta vs rho
ax2b = subplot(1, 2, 2);
hold(ax2b, 'on');
rho_line = linspace(-0.9, 0.9, 200);
tau_fixed = [0 0.5 1.0 1.5];
cols_tau = [0.15 0.15 0.15; 0.18 0.44 0.76; 0.10 0.55 0.45; 0.75 0.35 0.10];
for k = 1:numel(tau_fixed)
    t = tau_fixed(k);
    inv_eta = 1 - rho_line * sech(t);
    plot(ax2b, rho_line, inv_eta, '-', 'Color', cols_tau(k,:), ...
        'LineWidth', 1.6, 'DisplayName', sprintf('\\tau = %.1f', t));
end
yline(ax2b, 1, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.0, 'HandleVisibility', 'off');
xline(ax2b, 0, ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.0, 'HandleVisibility', 'off');
xlabel(ax2b, '\rho', 'FontSize', 12);
ylabel(ax2b, '1/\eta', 'FontSize', 12);
text(ax2b, 0.03, 0.97, '(B)', 'Units', 'normalized', ...
    'FontSize', 12, 'FontWeight', 'bold', 'VerticalAlignment', 'top');
legend(ax2b, 'Location', 'northeast', 'FontSize', 12, 'Box', 'off');
xlim(ax2b, [-0.9 0.9]);
ylim(ax2b, [0 2.2]);
ax2b.FontSize = 10;
ax2b.TickDir = 'out';
ax2b.Box = 'off';
grid(ax2b, 'on');
ax2b.GridAlpha = 0.12;

export_clean(fig2, fullfile(fig_dir, 'Figure_2_mobius_linearisation.png'));

fprintf('Done: Figures 1--2 written to %s\n', fig_dir);
return

%% Unpublished plates (not inputs of the reduced note) -----------------

%% ========================================================================
%  Figure 3 — Clean sphere theory plate (§4)
% ========================================================================
fig3 = figure('Units', 'centimeters', 'Position', [1 1 22 16], 'Color', 'w');
ax3 = axes('Parent', fig3);
hold(ax3, 'on');

[SX, SY, SZ] = sphere(90);
surf(ax3, SX, SY, SZ, ...
    'FaceAlpha', 0.07, 'FaceColor', [0.85 0.90 0.95], ...
    'EdgeColor', [0.82 0.86 0.92], 'EdgeAlpha', 0.10, ...
    'LineWidth', 0.25, 'HandleVisibility', 'off');

phi = linspace(0, 2*pi, 361);
% Equator rho=0
plot3(ax3, zeros(size(phi)), cos(phi), sin(phi), ...
    'Color', col_line, 'LineWidth', 1.6, 'DisplayName', '\rho = 0  (equator)');
% Fisher meridian tau=0
plot3(ax3, cos(phi), sin(phi), zeros(size(phi)), ...
    'Color', [0.35 0.35 0.35], 'LineWidth', 1.0, 'LineStyle', ':', ...
    'DisplayName', '\kappa = 1  (Fisher meridian)');

iso_eta = [0.55 0.75 1 2 4 10];
iso_styles = {'--', '--', '-', '--', '-', '--'};
iso_lw = [1.0 0.9 2.0 0.9 1.3 0.9];
iso_cols = [0.70 0.25 0.15; 0.75 0.40 0.15; 0.25 0.25 0.25; ...
            0.12 0.40 0.70; 0.08 0.25 0.55; 0.02 0.12 0.40];
for k = 1:numel(iso_eta)
    e = iso_eta(k);
    cos_s = 1 - 1/e;
    if abs(cos_s) >= 1, continue; end
    sin_s = sqrt(1 - cos_s^2);
    plot3(ax3, cos_s*ones(size(phi)), sin_s*cos(phi), sin_s*sin(phi), ...
        'Color', iso_cols(k,:), 'LineWidth', iso_lw(k), ...
        'LineStyle', iso_styles{k}, ...
        'DisplayName', sprintf('\\eta = %g', e));
end

% Pole / antipole
scatter3(ax3, 1, 0, 0, 140, 'p', ...
    'MarkerFaceColor', [1 0.9 0.2], 'MarkerEdgeColor', [0.1 0.1 0.1], ...
    'LineWidth', 1.2, 'DisplayName', 'pole  (\eta \rightarrow \infty)');
scatter3(ax3, -1, 0, 0, 90, 'd', ...
    'MarkerFaceColor', [0.85 0.85 0.85], 'MarkerEdgeColor', [0.4 0.4 0.4], ...
    'LineWidth', 1.0, 'DisplayName', 'antipole  (\eta = 1/2)');

% Hemisphere labels
text(ax3, 0.05, 0, 1.15, '\tau > 0', 'FontSize', 9, 'Color', [0.3 0.3 0.3]);
text(ax3, 0.05, 0, -1.18, '\tau < 0', 'FontSize', 9, 'Color', [0.3 0.3 0.3]);
text(ax3, 1.18, 0, 0.08, 'pole', 'FontSize', 8, 'Color', [0.25 0.25 0.25]);
text(ax3, -1.35, 0, 0.08, 'antipole', 'FontSize', 8, 'Color', [0.45 0.45 0.45]);
text(ax3, 0.08, 0, 0.08, {'\rho > 0', 'hemisphere'}, 'FontSize', 8, ...
    'Color', col_pos, 'FontWeight', 'bold');
% place text in positive cos-sigma region
text(ax3, 0.55, 0.15, 0.55, '\eta > 1', 'FontSize', 9, 'Color', col_pos, 'FontWeight', 'bold');
text(ax3, -0.35, 0.15, 0.55, '\eta < 1', 'FontSize', 9, 'Color', col_neg, 'FontWeight', 'bold');

axis(ax3, 'equal');
axis(ax3, 'off');
view(ax3, 210, 16);
camlight(ax3, 'headlight');
lighting(ax3, 'gouraud');
material(ax3, 'dull');
legend(ax3, 'Location', 'northwest', 'FontSize', 7.5, 'Box', 'on', ...
    'Color', [0.98 0.98 0.98], 'EdgeColor', [0.75 0.75 0.75]);
title(ax3, {'\eta as inverse spherical chord', ...
    '\eta = 1/(1 - cos \sigma),   cos \sigma = \rho sech \tau'}, ...
    'FontSize', 11, 'FontWeight', 'normal');

% Inset: eta vs sigma curve
ax3i = axes('Parent', fig3, 'Position', [0.72 0.08 0.24 0.28]);
hold(ax3i, 'on');
sig = linspace(0.15, pi-0.05, 400);
eta_sig = 1 ./ (1 - cos(sig));
plot(ax3i, sig, eta_sig, 'k-', 'LineWidth', 1.6);
xline(ax3i, pi/2, '--', 'Color', [0.4 0.4 0.4], 'LineWidth', 0.9);
yline(ax3i, 1, '--', 'Color', [0.4 0.4 0.4], 'LineWidth', 0.9);
ylim(ax3i, [0.4 8]);
xlim(ax3i, [0 pi]);
xticks(ax3i, [0 pi/2 pi]);
xticklabels(ax3i, {'0', '\pi/2', '\pi'});
xlabel(ax3i, '\sigma', 'FontSize', 8);
ylabel(ax3i, '\eta', 'FontSize', 8);
title(ax3i, '\eta = 1/(1-cos\sigma)', 'FontSize', 8, 'FontWeight', 'normal');
grid(ax3i, 'on');
ax3i.GridAlpha = 0.15;
ax3i.FontSize = 7;
ax3i.Box = 'off';

export_clean(fig3, fullfile(fig_dir, 'Figure_3_sphere_theory.png'));

%% ========================================================================
%  Figure 4 — Partition function + psi (§5–6)
% ========================================================================
fig4 = figure('Units', 'centimeters', 'Position', [1 1 24 10], 'Color', 'w');

% Left: cumulants vs eta
ax4a = subplot(1, 2, 1);
hold(ax4a, 'on');
eta_g = linspace(1.02, 8, 300);
plot(ax4a, eta_g, eta_g - 1, '-', 'Color', col_pos, 'LineWidth', 1.8, ...
    'DisplayName', 'E[N] = \eta - 1');
plot(ax4a, eta_g, eta_g .* (eta_g - 1), '-', 'Color', col_eta, 'LineWidth', 1.8, ...
    'DisplayName', 'Var(N) = \eta(\eta - 1)');
xline(ax4a, 1, ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.0, 'HandleVisibility', 'off');
xlabel(ax4a, '\eta', 'FontSize', 10);
ylabel(ax4a, 'Cumulant', 'FontSize', 10);
title(ax4a, 'Geometric-family cumulants (\rho > 0)', ...
    'FontSize', 10, 'FontWeight', 'normal');
legend(ax4a, 'Location', 'northwest', 'FontSize', 8, 'Box', 'off');
xlim(ax4a, [1 8]);
ylim(ax4a, [0 55]);
ax4a.FontSize = 9;
ax4a.TickDir = 'out';
ax4a.Box = 'off';
grid(ax4a, 'on');
ax4a.GridAlpha = 0.12;
text(ax4a, 0.55, 0.15, {'log \eta = -log(1 - u)', 'u = \rho sech \tau'}, ...
    'Units', 'normalized', 'FontSize', 8, 'Color', [0.3 0.3 0.3]);

% Right: signed psi vs u = rho sech tau
ax4b = subplot(1, 2, 2);
hold(ax4b, 'on');
u_pos = linspace(1e-4, 0.98, 300);
u_neg = -fliplr(u_pos);
psi_pos = 2 * atanh(sqrt(u_pos));
psi_neg = -2 * atanh(sqrt(abs(u_neg)));
plot(ax4b, u_pos, psi_pos, '-', 'Color', col_pos, 'LineWidth', 2.0, ...
    'DisplayName', '\rho > 0');
plot(ax4b, u_neg, psi_neg, '-', 'Color', col_neg, 'LineWidth', 2.0, ...
    'DisplayName', '\rho < 0');
plot(ax4b, 0, 0, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6, ...
    'DisplayName', '\rho = 0');
xline(ax4b, 0, '-', 'Color', col_line, 'LineWidth', 1.2, 'HandleVisibility', 'off');
yline(ax4b, 0, '-', 'Color', [0.5 0.5 0.5], 'LineWidth', 0.9, 'HandleVisibility', 'off');

% Fisher z comparison at tau=0: psi = 2 atanh sqrt(rho), z = atanh(rho)
rho_f = linspace(-0.95, 0.95, 200);
z_f = atanh(rho_f);
plot(ax4b, rho_f, z_f, '--', 'Color', [0.55 0.55 0.55], 'LineWidth', 1.1, ...
    'DisplayName', 'Fisher z = arctanh \rho  (\tau = 0)');

xlabel(ax4b, 'u = \rho sech \tau', 'FontSize', 10);
ylabel(ax4b, '\psi  (signed)', 'FontSize', 10);
title(ax4b, 'Fisher–Rao arc length from independence', ...
    'FontSize', 10, 'FontWeight', 'normal');
legend(ax4b, 'Location', 'southeast', 'FontSize', 7.5, 'Box', 'off');
xlim(ax4b, [-1 1]);
ylim(ax4b, [-3.2 3.2]);
ax4b.FontSize = 9;
ax4b.TickDir = 'out';
ax4b.Box = 'off';
grid(ax4b, 'on');
ax4b.GridAlpha = 0.12;
text(ax4b, 0.05, 0.92, 'psi = sign(rho)*2 arctanh sqrt(|u|)', ...
    'Units', 'normalized', 'FontSize', 8, 'Color', col_psi, 'Interpreter', 'none');

sgtitle(fig4, 'Partition function and the \psi coordinate', ...
    'FontSize', 12, 'FontWeight', 'normal');
export_clean(fig4, fullfile(fig_dir, 'Figure_4_psi_partition.png'));

fprintf('Done: Figures 1–4 written to %s\n', fig_dir);

%% Helpers ----------------------------------------------------------------
function export_clean(fig, path)
    set(fig, 'ToolBar', 'none');
    axs = findall(fig, 'Type', 'axes');
    for ia = 1:numel(axs)
        if isprop(axs(ia), 'Toolbar') && ~isempty(axs(ia).Toolbar)
            axs(ia).Toolbar.Visible = 'off';
        end
    end
    exportgraphics(fig, path, 'Resolution', 300);
    fprintf('Saved: %s\n', path);
end

function cmap = brew_pef()
    n = 256;
    stops = [0.95 0.96 0.97; 0.55 0.72 0.82; 0.12 0.38 0.55; ...
             0.85 0.55 0.18; 0.72 0.22 0.14];
    xi = linspace(1, size(stops, 1), n);
    cmap = interp1(1:size(stops, 1), stops, xi);
end
