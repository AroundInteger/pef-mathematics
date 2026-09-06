function H = pef_geometry_helpers()
%PEF_GEOMETRY_HELPERS  Companion-owned helpers for the half-strip numerical model.
%
%   Distinct from the mirrored empirical lib (pef_theory_helpers.m), which must
%   not be edited here.  These handles implement the geometry of
%   eta = cosh(tau)/(cosh(tau)-rho) on the fundamental domain tau >= 0.
%
%   Used by run_pef_geometry_numerical_model.m.

    H = struct( ...
        'tau_from_kappa',   @tau_from_kappa, ...
        'kappa_from_tau',   @kappa_from_tau, ...
        'eta_canonical',    @eta_canonical, ...
        'cos_sigma',        @cos_sigma, ...
        'eta_sphere',       @eta_sphere, ...
        'psi_signed',       @psi_signed, ...
        'u_eff',            @u_eff, ...
        'is_physical',      @is_physical, ...
        'sample_geo_N',     @sample_geo_N, ...
        'sample_bvn_tau',   @sample_bvn_tau, ...
        'estimate_pair',    @estimate_pair);
end

% -------------------------------------------------------------------------
function tau = tau_from_kappa(kappa)
    tau = 0.5 * log(kappa);
end

% -------------------------------------------------------------------------
function kappa = kappa_from_tau(tau)
    kappa = exp(2 * tau);
end

% -------------------------------------------------------------------------
function eta = eta_canonical(tau, rho)
% Canonical form: eta = cosh(tau) / (cosh(tau) - rho).
    denom = cosh(tau) - rho;
    if denom <= 0
        eta = NaN;
    else
        eta = cosh(tau) ./ denom;
    end
end

% -------------------------------------------------------------------------
function c = cos_sigma(tau, rho)
% Sphere lift: cos(sigma) = rho * sech(tau).
    c = rho .* sech(tau);
end

% -------------------------------------------------------------------------
function eta = eta_sphere(tau, rho)
% Sphere realisation: eta = 1 / (1 - cos(sigma)).
    c = cos_sigma(tau, rho);
    denom = 1 - c;
    if denom <= 0
        eta = NaN;
    else
        eta = 1 ./ denom;
    end
end

% -------------------------------------------------------------------------
function u = u_eff(tau, rho)
% Effective natural-parameter argument u = rho * sech(tau).
    u = rho .* sech(tau);
end

% -------------------------------------------------------------------------
function psi = psi_signed(tau, rho)
% Signed Fisher-Rao coordinate (eq:psi_signed).
    u = abs(rho) .* sech(tau);
    u = min(max(u, 0), 1 - 1e-15);
    psi = sign(rho) .* 2 .* atanh(sqrt(u));
    psi(rho == 0) = 0;
end

% -------------------------------------------------------------------------
function ok = is_physical(tau, rho)
% Physical domain: |rho| < 1 and |rho*sech(tau)| < 1 (strict).
    u = abs(rho) .* sech(tau);
    ok = (abs(rho) < 1) & (u < 1) & isfinite(tau) & isfinite(rho);
end

% -------------------------------------------------------------------------
function N = sample_geo_N(tau, rho, n)
% Draw n i.i.d. latent counts from the geometric family (thm:exp_family).
% Requires rho > 0 and u = rho*sech(tau) in (0,1).
% Support {0,1,2,...}: number of failures before first success, p = 1-u.
    u = rho * sech(tau);
    if ~(rho > 0 && u > 0 && u < 1)
        error('sample_geo_N:regime', ...
            'Geometric family requires rho>0 and u in (0,1); got rho=%g, u=%g.', ...
            rho, u);
    end
    p = 1 - u;
    N = geornd(p, n, 1);  % MATLAB: failures before first success
end

% -------------------------------------------------------------------------
function [A, B] = sample_bvn_tau(tau, rho, n, sigmaA)
% Bivariate-normal pairs with variance ratio kappa = exp(2*tau).
    if nargin < 4 || isempty(sigmaA)
        sigmaA = 1;
    end
    kappa = kappa_from_tau(tau);
    mu    = [0; 0];
    Sigma = sigmaA^2 * [1, rho * sqrt(kappa); rho * sqrt(kappa), kappa];
    AB = mvnrnd(mu, Sigma, n);
    A  = AB(:, 1);
    B  = AB(:, 2);
end

% -------------------------------------------------------------------------
function est = estimate_pair(A, B)
% Sample (kappa, rho, tau, eta, psi) from paired vectors.
    vA = var(A, 0);
    vB = var(B, 0);
    if vA <= 0 || vB <= 0 || numel(A) < 3
        est = struct('kappa', NaN, 'rho', NaN, 'tau', NaN, ...
            'eta', NaN, 'psi', NaN, 'n', numel(A));
        return
    end
    kappa = vB / vA;
    rmat  = corrcoef(A, B);
    rho   = rmat(1, 2);
    tau   = tau_from_kappa(kappa);
    eta   = eta_canonical(tau, rho);
    psi   = psi_signed(tau, rho);
    est = struct('kappa', kappa, 'rho', rho, 'tau', tau, ...
        'eta', eta, 'psi', psi, 'n', numel(A));
end
