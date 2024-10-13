clc, clearvars, close all;

n = 10;
M = 100;
B = 1000;
alpha = 0.05;
part_b = false; % Change to true for part b

ci_bootstrap_X = zeros(2, M);
ci_var_parametric = zeros(2, M);
ci_std_parametric = zeros(2, M);

lower_k = int64((B + 1) * (alpha / 2));
upper_k = B + 1 - lower_k;

for sample = 1:M
    X = randn(1, n); % n random nums from standard normal dist.

    if part_b 
        X = X.^2;
    end

    % Parametric testing
    [~, ~, ci_var_parametric(:, sample)] = vartest(X, 1);
    ci_std_parametric(:, sample) = sqrt(ci_var_parametric(:, sample));

    % Bootstrap testing
    std_bootstrap = zeros(1, B);
    for i = 1:B
        random_positions = unidrnd(n, n, 1); % n random integers in [1, 10]
        X_star = X(random_positions); % Create bootstrap sample
        std_bootstrap(i) = std(X_star); % Find standard deviation
    end

    sorted_stds = sort(std_bootstrap);
    ci_bootstrap_X(:, sample) = [sorted_stds(lower_k), sorted_stds(upper_k)];
end

figure(1);
histogram(ci_std_parametric(1,:), 15);
hold on;
histogram(ci_bootstrap_X(1,:), 15);
hold off;
legend('Lower edge parametric', 'Lower edge bootstrap')
title('Distribution of lower edges of Confidence Interval of std');

figure(2)
histogram(ci_std_parametric(2,:), 15);
hold on;
histogram(ci_bootstrap_X(2,:), 15);
hold off;
legend('Lower edge parametric', 'Lower edge bootstrap')
title('Distribution of upper edges of Confidence Interval of std');