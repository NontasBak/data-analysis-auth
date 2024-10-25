clc, clearvars, close all;

n = 10;
M = 100;
B = 1000;
alpha = 0.05;
part_b = false; % Change to true for part b

ci_bootstrap = zeros(2, M);
ci_parametric = zeros(2, M);

lower_k = int64((B + 1) * (alpha / 2)); % Convert to int
upper_k = B + 1 - lower_k;

for sample = 1:M
    X = randn(1, n); % n random nums from standard normal dist.

    if part_b 
        X = X.^2;
    end

    % Parametric testing
    [~, ~, ci_parametric(:, sample)] = ttest(X);

    % Bootstrap testing
    mean_bootstrap = zeros(1, B);
    for i = 1:B
        random_positions = unidrnd(n, n, 1); % n random integers in [1, 10]
        X_star = X(random_positions); % Create bootstrap sample
        mean_bootstrap(i) = mean(X_star); % Find mean
    end

    sorted_means = sort(mean_bootstrap);
    ci_bootstrap(:, sample) = [sorted_means(lower_k), sorted_means(upper_k)];
end

figure(1);
histogram(ci_parametric(1,:), 15);
hold on;
histogram(ci_bootstrap(1,:), 15);
hold off;
legend('Lower edge parametric', 'Lower edge bootstrap')
title('Distribution of lower edges of Confidence Interval of mean');

figure(2);
histogram(ci_parametric(2,:), 15);
hold on;
histogram(ci_bootstrap(2,:), 15);
legend('Upper edge parametric', 'Upper edge bootstrap');
title('Distribution of upper edges of Confidence Interval of mean');