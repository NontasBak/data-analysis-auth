clc, clearvars, close all;

X = [41 46 47 47 48 50 50 50 50 50 50 50 48 50 50 50 50 50 50 50 52 52 53 55 50 50 50 50 52 52 53 53 53 53 53 57 52 52 53 53 53 53 53 53 54 54 55 68];

% Part a
[~, ~, ci_var, ~] = vartest(X, var(X)) % Confidence interval

% Part b
hypothesized_std = 5;
hypothesized_var = hypothesized_std ^ 2;

h_var = vartest(X, hypothesized_var);

if h_var == 0
    fprintf('Null hypothesis not rejected for hypothesized var %i.\n\n', hypothesized_var)
else
    fprintf('Null hypothesis rejected for hypothesized var %i.\n\n', hypothesized_var)
end
disp('--------------')

% Part c
[~, ~, ci_mean, ~] = ttest(X) % Confidence interval

% Part d
hypothesized_mean = 52;
h_mean = ttest(X, hypothesized_mean);

if h_mean == 0
    fprintf('Null hypothesis not rejected for hypothesized mean %i.\n\n', hypothesized_mean)
else
    fprintf('Null hypothesis rejected for hypothesized mean %i.\n\n', hypothesized_mean)
end
disp('--------------')

% Part e
[h_goodnessOfFit, p] = chi2gof(X);
p_goodnessOfFit = p

if h_goodnessOfFit == 0
    fprintf('Null hypothesis not rejected for goodness of fit in Normal dist\n\n')
else
    fprintf('Null hypothesis rejected for goodness of fit in Normal dist\n\n')
end