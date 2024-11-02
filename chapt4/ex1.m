clc, clearvars, close all;

% Part a
h_1 = 100;
h_2 = [60, 54, 58, 60, 56];
e_expected = 0.76;

e = sqrt(h_2 / h_1); % Sample coefficient of restitution

e_mean = mean(e);
systematic_error = e_expected - e_mean;
fprintf("Systematic error: %.4f\n", systematic_error);

alpha = 0.05;
t_critical = tinv(1 - alpha/2, length(e) - 1);
e_std = std(e);

random_error = [-t_critical * e_std, t_critical * e_std];
fprintf("Random error: [%.4f, %.4f]\n\n", random_error(1), random_error(2));

% -----------------------------------------
% Part b
M = 1000;
h2_mu = 58;
h2_sigma = 2;

h2_mean = zeros(1, M);
h2_std = zeros(1, M);
e_mean = zeros(1, M);
e_std = zeros(1, M);
for sample = 1:M
    h2_sample = normrnd(h2_mu, h2_sigma, 1, 5);
    h2_mean(sample) = mean(h2_sample);
    h2_std(sample) = std(h2_sample);

    e_sample = sqrt(h2_sample / h_1);
    e_mean(sample) = mean(e_sample);
    e_std(sample) = std(e_sample);
end

e_mean_expected = sqrt(h2_mu / h_1);

% Error propagation, factorize e = sqrt(h2/h1) first
% and use the following formula
e_std_expected = h2_sigma / (2 * sqrt(h2_mu * h_1));

subplot(2,2,1);
histogram(h2_mean);
xline(h2_mu, 'LineWidth', 1.5, 'Color', 'r');
title("Mean of h_2");

subplot(2,2,2);
histogram(h2_std);
xline(h2_sigma, 'LineWidth', 1.5, 'Color', 'r');
title("Standard deviation of h_2");

subplot(2,2,3);
histogram(e_mean);
xline(e_mean_expected, 'LineWidth', 1.5, 'Color', 'r');
title("Mean of e");

subplot(2,2,4);
histogram(e_std);
xline(e_std_expected, 'LineWidth', 1.5, 'Color', 'r');
title("Standard deviation of e");

% -----------------------------------------
% Part c

h1 = [80, 100, 90, 120, 95];
h2 = [48, 60, 50, 75, 56];

h1_std = std(h1);
h2_std = std(h2);
fprintf("Uncertainty of h1: %f\n", h1_std);
fprintf("Uncertainty of h2: %f\n", h2_std);

e = sqrt(h2 ./ h1);
e_std = std(e);
fprintf("Uncertainty of e: %f\n", e_std);

[h, ~, ci, ~] = ttest(e, e_expected);

if h == 0
    fprintf("The ball is inflated properly (a = 0.05%%)\n");
else
    fprintf("The ball is not inflated properly (a = 0.05%%)\n");
end










