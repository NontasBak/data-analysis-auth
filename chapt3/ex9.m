clc, clearvars, close all;

n = 10;
M = 100;
B = 1000;
alpha = 0.05;

X = randn(n, M); % n x M random nums from standard normal dist.

part = 'a'; % Change to 'b' or 'c'
switch part
    case 'a'
        m = 12;
        Y = randn(m, M);
    case 'b'
        m = 10;
        Y = X.^2;
    case 'c'
        m = 12;
        mu = 0.2;
        var = 1;
        Y = normrnd(mu, sqrt(var), m, M);
end

mean_bootstrap_X = zeros(B, M);
mean_bootstrap_Y = zeros(B, M);
ci_bootstrap = zeros(2, M);

lower_k = int64((B + 1) * (alpha / 2)); % Convert to int
upper_k = B + 1 - lower_k;

% Parametric testing
[~, ~, ci_parametric, ~] = ttest2(X, Y);

for sample = 1:M
    for i = 1:B
        random_positions_X = unidrnd(n, n, 1); % n random integers in [1, 10]
        X_star = X(random_positions_X(:), sample); % 1 x n
        mean_bootstrap_X(i, sample) = mean(X_star);

        random_positions_Y = unidrnd(m, m, 1); % m random integers in [1, 12]
        Y_star = Y(random_positions_Y(:), sample); % 1 x n
        mean_bootstrap_Y(i, sample) = mean(Y_star);
    end

    mean_bootstrap_difference = mean_bootstrap_X - mean_bootstrap_Y;
    sorted_means = sort(mean_bootstrap_difference(:, sample));
    ci_bootstrap(:, sample) = [sorted_means(lower_k), sorted_means(upper_k)];
end

figure(1);
histogram(ci_parametric(1,:), 15);
hold on;
histogram(ci_bootstrap(1,:), 15);
hold off;
legend('Lower edge parametric', 'Lower edge bootstrap')
title('Distribution of lower edges of Confidence Interval of mean difference');

figure(2);
histogram(ci_parametric(2,:), 15);
hold on;
histogram(ci_bootstrap(2,:), 15);
legend('Upper edge parametric', 'Upper edge bootstrap');
title('Distribution of upper edges of Confidence Interval of mean difference');

prob_XY_different_parametric = 1 - (sum(ci_parametric(1, :) < 0 & ci_parametric(2, :) > 0) / M); % & = Element wise
prob_XY_different_bootstrap = 1 - (sum(ci_bootstrap(1, :) < 0 & ci_bootstrap(2, :) > 0) / M);

fprintf('Prob. of mean(X) and mean(Y) being different using parametric CI: %.2f\n', prob_XY_different_parametric);
fprintf('Prob. of mean(X) and mean(Y) being different using bootstrap CI: %.2f\n', prob_XY_different_bootstrap);