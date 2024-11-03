clc, clearvars, close all;

% Part a
% power_std = sqrt(Σ(dP/dX)^2 * std_x^2)
% where P = V*I*cosf
% Write it on a piece of paper ffs

% -----------------------------------------
% Part b
V_mu = 77.78;
V_sigma = 0.71;
I_mu = 1.21;
I_sigma = 0.071;
f_mu = 0.283;
f_sigma = 0.017;
M = 1000;

% Expected values
P_sigma = sqrt((I_mu * cos(f_mu) * V_sigma)^2 + ...
    (V_mu * cos(f_mu) * I_sigma)^2 + ...
    (V_mu * I_mu * (-sin(f_mu)) * f_sigma)^2);
P_mu = V_mu * I_mu * cos(f_mu);

% Random values from normal distribution
V_sample = normrnd(V_mu, V_sigma, M, 1);
I_sample = normrnd(I_mu, I_sigma, M, 1);
f_sample = normrnd(f_mu, f_sigma, M, 1);
P_sample = V_sample .* I_sample .* cos(f_sample);

% Sample mean and std
P_mean = mean(P_sample);
P_std = std(P_sample);

h1 = ttest(P_sample, P_mu);
h2 = vartest(P_sample, P_sigma^2);

if h1 == 0
    fprintf("Power has expected mean %.2f at 95%% c.i. (observed mean %.2f)\n", P_mu, P_mean);
else
    fprintf("Power does not have expected mean %.2f at 95%% c.i. (observed mean %.2f)\n", P_mu, P_mean);
end

if h2 == 0
    fprintf("Power has expected std %.2f at 95%% c.i. (observed std %.2f)\n", P_sigma, P_std);
else
    fprintf("Power does not have expected mean %.2f at 95%% c.i. (observed std %.2f)\n", P_sigma, P_std);
end

% -----------------------------------------
% Part c
r_Vf = 0.5;
sigma_Xf = r_Vf * V_sigma * f_sigma;
Sigma = [V_sigma^2, sigma_Xf;
        sigma_Xf, f_sigma^2];

R = mvnrnd([V_mu, f_mu], Sigma, M);
V_samples = R(:,1);
f_samples = R(:,2);
P_samples = V_samples .* I_sample .* cos(f_samples);

% Sample mean and std
P_mean_new = mean(P_samples);
P_std_new = std(P_samples);

h1 = ttest(P_samples, P_mu);
h2 = vartest(P_samples, P_sigma^2);

fprintf("\nWith correlated V,f:\n")
if h1 == 0
    fprintf("Power has expected mean %.2f at 95%% c.i. (observed mean %.2f)\n", P_mu, P_mean_new);
else
    fprintf("Power does not have expected mean %.2f at 95%% c.i. (observed mean %.2f)\n", P_mu, P_mean_new);
end

if h2 == 0
    fprintf("Power has expected std %.2f at 95%% c.i. (observed std %.2f)\n", P_sigma, P_std_new);
else
    fprintf("Power does not have expected mean %.2f at 95%% c.i. (observed std %.2f)\n", P_sigma, P_std_new);
end
