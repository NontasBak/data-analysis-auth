clc, clearvars, close all;

M = 1000;
n = 20;
mu_X = 0;
mu_Y = 0;
std_X = 1;
std_Y = 1;
rho = [0, 0.5];
alpha = 0.05;

part_c = false;
part_d = true;

if part_c
    n = 200;
end

rho_lower = zeros(length(rho), M);
rho_upper = zeros(length(rho), M);
times_ro_inside_ci = zeros(length(rho), 1);
times_null_hypothesis_rejected = zeros(length(rho), 1);

for i = 1:length(rho)
    Sigma = [std_X^2, rho(i) * std_X * std_Y;
             rho(i) * std_X * std_Y, std_Y^2];
    for sample = 1:M
        R = mvnrnd([mu_X, mu_Y], Sigma, n);

        if part_d
            R = R.^2;
        end

        r = corrcoef(R);
        r = r(1,2);

        w = 0.5 * log((1 + r) / (1 - r));

        z_critical = norminv(1 - alpha/2);
        z_std = sqrt(1 / (n-3));
        z1 = w - z_critical * z_std;
        z2 = w + z_critical * z_std;

        rho_lower(i, sample) = tanh(z1);
        rho_upper(i, sample) = tanh(z2);

        if rho(i) > rho_lower(i, sample) && rho(i) < rho_upper(i, sample)
            times_ro_inside_ci(i) = times_ro_inside_ci(i) + 1;
        end

        % Part b
        t = r * sqrt((n-2) / (1 - r^2));
        p = 2*(1 - tcdf(abs(t), n-2));
        if p < 0.05
            times_null_hypothesis_rejected(i) = times_null_hypothesis_rejected(i) + 1;
        end

    end
end

fprintf('Percentage of times CI included real value rho=0: %.1f\n', times_ro_inside_ci(1) * 100 / M);
fprintf('Percentage of times CI included real value rho=0.5: %.1f\n', times_ro_inside_ci(2) * 100 / M);

fprintf('Percentage of times null hypothesis rejected for rho=0: %.1f%%\n', times_null_hypothesis_rejected(1) * 100 / M);
fprintf('Percentage of times null hypothesis rejected for rho=0.5: %.1f%%\n', times_null_hypothesis_rejected(2) * 100 / M);

figure(1);
subplot(2, 1, 1);
histogram(rho_lower(1, :));
hold on;
histogram(rho_upper(1, :));
xline(rho(1), 'LineWidth', 1.5, 'color', 'r');
title('Confidence interval for rho = 0');
legend('Lower bound', 'Upper bound')

subplot(2, 1, 2);
histogram(rho_lower(2, :));
hold on;
histogram(rho_upper(2, :));
xline(rho(2), 'LineWidth', 1.5, 'color', 'r');
title('Confidence interval for rho = 0.5');
legend('Lower bound', 'Upper bound')





