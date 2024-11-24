clc, clearvars, close all;

lightAir_data = importdata('lightair.dat');

X = lightAir_data(:, 1);
Y = lightAir_data(:, 2) + 299000;
M = 1000;
n = length(X);
alpha = 0.05;

b1 = zeros(M, 1);
b0 = zeros(M, 1);

for sample = 1:M
    random_nums = unidrnd(n, n, 1);
    X_star = X(random_nums);
    Y_star = Y(random_nums);

    r = corrcoef(X_star, Y_star);
    r = r(1,2);
    
    % Find b1 and b0
    cov_XY = cov(X_star, Y_star);
    cov_XY = cov_XY(1,2);
    var_X = var(X_star);
    b1(sample) = cov_XY / var_X;
    b0(sample) = mean(Y_star) - b1(sample) * mean(X_star);
end

lower_limit = M * (alpha / 2);
upper_limit = M * (1 - alpha / 2);

b1_sorted = sort(b1);
b0_sorted = sort(b0);

ci_b1 = [b1_sorted(lower_limit), b1_sorted(upper_limit)];
ci_b0 = [b0_sorted(lower_limit), b0_sorted(upper_limit)];

fprintf("95%% bootstrap C.I. for b1: [%.2f, %.2f]\n", ci_b1(1), ci_b1(2));
fprintf("95%% bootstrap C.I. for b0: [%.2f, %.2f]\n", ci_b0(1), ci_b0(2));

fprintf("\nComparing them with ex4:\n");
fprintf("95%% parametric C.I. for b1: [-71.03, -64.09]\n");
fprintf("95%% parametric C.I. for b0: [299787.90, 299795.99]\n");







