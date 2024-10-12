clc, clearvars, close all;

n = 10;
M = 100;
B = 1000;
alpha = 0.05;
mu = [0, 0.5];

X = randn(n, M);

mean_bootstrap_X = zeros(B, M);
p_bootstrap_X = zeros(1, M);

part_b = false;
if part_b 
    mu = [1, 2];
    X = X.^2;
end

for k = 1:length(mu)
    [~, p_parametric] = ttest(X, mu(k)); % Parametric

    % Bootstrap
    for sample = 1:M
        observed_mean = mean(X(:, sample));
        X_wave = X(:, sample) - observed_mean + mu(k);
        
        for i = 1:B
            random_positions = unidrnd(n, n, 1); % n random integers in [1, 10]
            X_star = X_wave(random_positions(:)); % 1 x n
            mean_bootstrap_X(i, sample) = mean(X_star);
        end
        
        sorted_means = sort(mean_bootstrap_X(:, sample));
        rank_obs_mean = sum(sorted_means <= observed_mean);
        p_bootstrap_X(sample) = 2 * min(rank_obs_mean, B + 1 - rank_obs_mean) / (B + 1);
    end

    rejection_perc_parametric = sum(p_parametric < alpha) * 100 / M;
    rejection_perc_bootstrap = sum(p_bootstrap_X < alpha) * 100 / M;

    fprintf('Rejection prob. using parametric testing for mu = %.1f: %.f%%\n', mu(k), rejection_perc_parametric);
    fprintf('Rejection prob. using bootstrap for mu = %.1f: %.f%%\n\n', mu(k), rejection_perc_bootstrap);
end






