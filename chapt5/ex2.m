clc, clearvars, close all;

M = 100;
n = 20;
mu_X = 0;
mu_Y = 0;
std_X = 1;
std_Y = 1;
rho = [0, 0.5];
alpha = 0.05;
L = 1000;

squared = false;

L_lower = round(L * alpha/2);
L_upper = round(L * (1 - alpha/2));

times_null_hypothesis_rejected = zeros(length(rho), 1);
t_values = zeros(1, L);

for i = 1:length(rho)
    Sigma = [std_X^2, rho(i) * std_X * std_Y;
             rho(i) * std_X * std_Y, std_Y^2];
    for sample = 1:M
        R = mvnrnd([mu_X, mu_Y], Sigma, n);

        if squared
            R = R.^2;
        end

        X = R(:,1);
        Y = R(:,2);

        for j = 1:L
            X_randomized = X(randperm(n));
            r = corrcoef(X_randomized, Y);
            r = r(1,2);

            t_values(j) = r * sqrt((n-2) / (1 - r^2));
        end
 
        r0 = corrcoef(R);
        r0 = r0(1,2);
        t0 = r0 * sqrt((n-2) / (1 - r0^2));

        t_values_sorted = sort(t_values);

        if t0 < t_values_sorted(L_lower) || t0 > t_values_sorted(L_upper)
            times_null_hypothesis_rejected(i) = times_null_hypothesis_rejected(i) + 1;
        end

    end
end

fprintf('Percentage of times null hypothesis rejected for rho=0: %.1f%%\n', times_null_hypothesis_rejected(1) * 100 / M);
fprintf('Percentage of times null hypothesis rejected for rho=0.5: %.1f%%\n', times_null_hypothesis_rejected(2) * 100 / M);





