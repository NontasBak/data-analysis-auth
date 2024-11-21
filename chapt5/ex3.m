clc, clearvars, close all;

temp_data = importdata('tempThes59_97.dat');
rain_data = importdata('rainThes59_97.dat');

m = size(temp_data, 2);
y = size(temp_data, 1);

L = 1000;
alpha = 0.05;
L_lower = round(L * alpha/2);
L_upper = round(L * (1 - alpha/2));

for i = 1:m
    fprintf('Month: %d\n', i);
    temp_values = temp_data(:, i);
    rain_values = rain_data(:, 1);

    % Parametric testing
    [r, p] = corrcoef(temp_values, rain_values);
    r = r(1,2);
    p = p(1,2);

    % OR do this:
    % t = r * sqrt((y-2) / (1 - r^2));
    % p = 2*(1 - tcdf(abs(t), y-2))

    if p < 0.05
        fprintf('X: Hypothesis testing was rejected using parametric method.\n');
    else
        fprintf('✓: Hypothesis testing was not rejected using parametric method.\n');
    end

    % -----------------------------------
    % Random permutation testing
    t_values = zeros(L, 1);
    for j = 1:L
        temp_randomized = temp_values(randperm(y));
        r1 = corrcoef(temp_randomized, rain_values);
        r1 = r1(1,2);
        t_values(j) = r1 * sqrt((y-2) / (1 - r1^2));
    end

    t0 = r * sqrt((y-2) / (1 - r^2));
    t_values_sorted = sort(t_values);

    if t0 < t_values_sorted(L_lower) || t0 > t_values_sorted(L_upper)
        fprintf('X: Hypothesis testing was rejected using random permutation method.\n');
    else
        fprintf('✓: Hypothesis testing was not rejected using random permutation method.\n');
    end

    fprintf('--------------------------\n')
end



