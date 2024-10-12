clc, clearvars, close all;

n = 10;
B = 1000;

X = randn(1, n); % 10 random nums from standard normal dist.

% Part a
X_star = zeros(1, n);
mean_bootstrap_X = zeros(1, B);

for i = 1:B
    random_positions = unidrnd(n, 1, n); % 10 random integers in [1, 10]
    for j = 1:n
        X_star(j) = X(random_positions(j));
    end

    mean_bootstrap_X(i) = mean(X_star);
end

figure(1);
histogram(mean_bootstrap_X);
xline(mean(X), 'r', 'LineWidth', 1.5);
legend('Mean(X*)', 'Mean(X)');


% Part b
se_bootstrap_X = std(mean_bootstrap_X);
se_X = std(X) / sqrt(n);

fprintf('se_B(mean(X)) = %.4f and se(mean(X)) = %.4f\n', se_bootstrap_X, se_X)


% Part c
Y = exp(X);

Y_star = zeros(1, n);
mean_bootstrap_Y = zeros(1, B);

for i = 1:B
    random_positions = unidrnd(n, 1, n); % 10 random integers in [1, 10]
    for j = 1:n
        Y_star(j) = Y(random_positions(j));
    end

    mean_bootstrap_Y(i) = mean(Y_star);
end

figure(2);
histogram(mean_bootstrap_Y);
xline(mean(Y), 'r', 'LineWidth', 1.5);
legend('Mean(Y*)', 'Mean(Y)');

se_bootstrap_Y = std(mean_bootstrap_Y);
se_Y = std(Y) / sqrt(n);

fprintf('se_B(mean(Y)) = %.4f and se(mean(Y)) = %.4f\n', se_bootstrap_Y, se_Y);