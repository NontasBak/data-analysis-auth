clc, clearvars, close all;

eruption = importdata('eruption.dat');

% Part a
hypothesized_std = [10, 1, 10];
date = [1989, 1989, 2006];
data_type = ["waiting", "duration", "waiting"];

for i = 1:length(hypothesized_std)
    [h, ~, ci_mean, ~] = vartest(eruption(:, i), hypothesized_std(i) ^ 2);
    ci_std = sqrt(ci_mean);
    fprintf('Confidence interval for %i %s time std: [%.3f, %.3f]\n', date(i), data_type(i), ci_std(1), ci_std(2))

    if h == 0
        fprintf('Null hypothesis for %i %s time not rejected for hypothesized std %i.\n\n', date(i), data_type(i), hypothesized_std(i))
    else
        fprintf('Null hypothesis for %i %s time rejected for hypothesized std %i.\n\n', date(i), data_type(i), hypothesized_std(i))
    end
end
fprintf('------------------\n\n')

% Part b
hypothesized_mean = [75, 2.5, 75];

for i = 1:length(hypothesized_mean)
    [h, ~, ci_mean, ~] = ttest(eruption(:, i), hypothesized_mean(i));
    fprintf('Confidence interval for %i %s time mean: [%.3f, %.3f]\n', date(i), data_type(i), ci_mean(1), ci_mean(2))

    if h == 0
        fprintf('Null hypothesis for %i %s time not rejected for hypothesized mean %.1f\n\n', date(i), data_type(i), hypothesized_mean(i))
    else
        fprintf('Null hypothesis for %i %s time rejected for hypothesized mean %.1f\n\n', date(i), data_type(i), hypothesized_mean(i))
    end
end
fprintf('------------------\n\n')

% Part c
for i = 1:3
    [h, p] = chi2gof(eruption(:, i));
    fprintf('p value for %i %s time: %e\n', date(i), data_type(i), p)

    if h == 0
        fprintf('Null hypothesis for %i %s time not rejected for goodness of fit in Normal dist\n\n', date(i), data_type(i))
    else
        fprintf('Null hypothesis for %i %s time rejected for goodness of fit in Normal dist\n\n', date(i), data_type(i))
    end
end
fprintf('------------------\n\n')

% Extra
correctness_evaluation = true;

for i = 1:length(eruption)
    if eruption(i, 2) < 2.5
        if eruption(i, 1) < 55 || eruption(i, 1) > 75
            correctness_evaluation = false;
        end
    elseif eruption(i, 2) > 2.5
        if eruption(i, 1) < 81 || eruption(i, 1) > 101
            correctness_evaluation = false;
        end
    end
end

if correctness_evaluation
    disp('Statement is true')
else
    disp('Statement is false')
end