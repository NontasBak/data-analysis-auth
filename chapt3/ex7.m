clc, clearvars, close all;

n = 10;
M = 100;
B = 1000;
alpha = 0.05;

X = randn(n, M); % n x M random nums from standard normal dist.

part_b = false; % Change to true for part b
if part_b 
    X = X.^2;
end

mean_bootstrap_X = zeros(B, M);
ci_bootstrap_X = zeros(2, M);

lower_k = int64((B + 1) * (alpha / 2)); % Convert to int
upper_k = B + 1 - lower_k;

% Parametric testing
[~, ~, ci_parametric_X, ~] = ttest(X);

for sample = 1:M
    for i = 1:B
        random_positions = unidrnd(n, n, 1); % n random integers in [1, 10]
        X_star = X(random_positions(:), sample); % 1 x n
        mean_bootstrap_X(i, sample) = mean(X_star);
    end

    sorted_means = sort(mean_bootstrap_X(:, sample));
    ci_bootstrap_X(:, sample) = [sorted_means(lower_k), sorted_means(upper_k)];
end

figure(1);
histogram(ci_parametric_X(1,:), 15);
hold on;
histogram(ci_bootstrap_X(1,:), 15);
hold off;
legend('Lower edge parametric', 'Lower edge bootstrap')
title('Distribution of lower edges of Confidence Interval of mean');

figure(2);
histogram(ci_parametric_X(2,:), 15);
hold on;
histogram(ci_bootstrap_X(2,:), 15);
legend('Upper edge parametric', 'Upper edge bootstrap');
title('Distribution of upper edges of Confidence Interval of mean');