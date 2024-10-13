clc, clearvars, close all;

n = 10;
m = 15;
M = 100;
B = 1000;
alpha = 0.05;
mu = 0;
std_X = 0.5;
std_Y = 1;

lower_lim = (B + 1) * alpha / 2;
upper_lim = (B + 1) * (1 - alpha / 2);

rejection_rate_param = 0;
rejection_rate_boot = 0;
rejection_rate_rand = 0;

for i = 1:M
    X = normrnd(mu, std_X,  1, n);
    Y = normrnd(mu, std_Y, 1, m);
    obs_mean = mean(X) - mean(Y);

    % Parametric testing
    [~, p_parametric] = ttest2(X, Y, 'Vartype', 'unequal');
    if p_parametric < alpha
        rejection_rate_param = rejection_rate_param + 1;
    end

    % Bootstrap testing
    mean_bootstrap = zeros(1, B);
    mean_XY = mean([X, Y]);
    X_wave = X(:) - mean(X) + mean_XY;
    Y_wave = Y(:) - mean(Y) + mean_XY;
    for j = 1:B
        random_positions = unidrnd(n + m, n + m, 1); % n+m random integers in [1, n+m]
        random_positions_X = random_positions(1:n);
        random_positions_Y = random_positions(n+1:end);
        boot_sample = [X_wave; Y_wave];
        boot_sample_X = boot_sample(random_positions_X(:));
        boot_sample_Y = boot_sample(random_positions_Y(:));

        mean_bootstrap(j) = mean(boot_sample_X) - mean(boot_sample_Y);
    end

    rank_obs_mean = sum(mean_bootstrap <= obs_mean) + 1;
    if rank_obs_mean < lower_lim || rank_obs_mean > upper_lim
        rejection_rate_boot = rejection_rate_boot + 1;
    end
end

fprintf('Rejection perc. using parametric testing: %d%%\n', rejection_rate_param * 100 / M);
fprintf('Rejection perc. using bootstrap testing: %d%%\n', rejection_rate_boot * 100 / M);






