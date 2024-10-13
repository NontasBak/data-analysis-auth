clc, clearvars, close all;

n = 10;
m = 15;
M = 100;
B = 1000;
alpha = 0.05;

lower_lim = (B + 1) * alpha / 2;
upper_lim = (B + 1) * (1 - alpha / 2);

rejection_rate_param = 0;
rejection_rate_boot = 0;
rejection_rate_rand = 0;

for i = 1:M
    X = randn(1, n);
    Y = randn(1, m);
    obs_mean = mean(X) - mean(Y);

    % Parametric testing
    [~, p_parametric] = ttest2(X, Y);
    if p_parametric < alpha
        rejection_rate_param = rejection_rate_param + 1;
    end

    % Bootstrap testing
    mean_bootstrap = zeros(1, B);
    for j = 1:B
        random_positions = unidrnd(n + m, n + m, 1); % n+m random integers in [1, n+m]
        random_positions_X = random_positions(1:n);
        random_positions_Y = random_positions(n+1:end);
        boot_sample = [X,Y];
        boot_sample_X = boot_sample(random_positions_X(:));
        boot_sample_Y = boot_sample(random_positions_Y(:));

        mean_bootstrap(j) = mean(boot_sample_X) - mean(boot_sample_Y);
    end

    rank_obs_mean = sum(mean_bootstrap <= obs_mean) + 1;
    if rank_obs_mean < lower_lim || rank_obs_mean > upper_lim
        rejection_rate_boot = rejection_rate_boot + 1;
    end

    % Random Permutation testing
    mean_rand = zeros(1, B);
    for j = 1:B
        rand_sample = [X,Y];
        % Randomize rand_sample array without replacement
        rand_sample_randomized = rand_sample(randperm(n+m));
        rand_sample_X = rand_sample_randomized(1:n);
        rand_sample_Y = rand_sample_randomized(n+1:end);

        mean_rand(j) = mean(rand_sample_X) - mean(rand_sample_Y);
    end

    rank_obs_mean = sum(mean_rand <= obs_mean) + 1;
    if rank_obs_mean < lower_lim || rank_obs_mean > upper_lim
        rejection_rate_rand = rejection_rate_rand + 1;
    end
end

fprintf('Rejection perc. using parametric testing: %d%%\n', rejection_rate_param * 100 / M);
fprintf('Rejection perc. using bootstrap testing: %d%%\n', rejection_rate_boot * 100 / M);
fprintf('Rejection perc. using random permutation testing: %d%%\n', rejection_rate_rand * 100 / M);






