clc, clearvars, close all;

data = importdata("physical.txt");
data = data.data; % Actual data (first row removed)

Y = data(:, 1);
X = data(:, 2:end);
n = length(Y); % =22
k = size(X, 2); % =10

% For linear multiple regression:
model = fitlm(X, Y);
b_values = model.Coefficients.Estimate;

e = model.Residuals.Raw;
var_e = 1 / (n - (k + 1)) * sum(e.^2);
% std_e = sqrt(var_e);
% or std_e = model.RMSE
% e_star = e ./ std_e;

R_squared = 1 - (sum(e.^2)) / sum((Y - mean(Y)).^2);
adj_Rsquared = 1 - ((n - 1) / (n - (k + 1))) * (sum(e.^2) / sum((Y - mean(Y)).^2));

% -------------------------------------------------
% For stepwise regression
[b_values_step, ~, ~, model_step, stats_step] = stepwisefit(X, Y, 'display', 'off');
b0_step = stats_step.intercept;

Y_hat_step = zeros(n, 1);
for i = 1:n
    Y_hat_step(i) = b0_step + X(i, model_step) * b_values_step(model_step);
end

e_step = Y - Y_hat_step;
var_e_step = 1 / (n - (sum(model_step) + 1)) * sum(e_step.^2);
% std_e_step = sqrt(var_e_step)
% or std_e_step = stats_step.rmse;
% e_star_step = e_i / sqrt(var_e);

R_squared_step = 1 - (sum(e_step.^2)) / sum((Y - mean(Y)).^2);
adj_Rsquared_step = 1 - ((n - 1) / (n - (sum(model_step) + 1))) * (sum(e_step.^2) / sum((Y - mean(Y)).^2));


fprintf("Linear multiple regression vs Stepwise regression:\n");
fprintf("1. b values (linear):\n");
disp(b_values);
fprintf("b values (stepwise):\n");
disp([b0_step; b_values_step(model_step)]);

fprintf("2. Variance of errors:\n");
fprintf("Linear: %.4f\n", var_e);
fprintf("Stepwise: %.4f\n", var_e_step);

fprintf("\n3. Coefficient of multiple determination (R^2):\n");
fprintf("Linear: %.4f\n", R_squared);
fprintf("Stepwise: %.4f\n", R_squared_step);

fprintf("\n3. Adjusted coefficient of multiple determination (adjR^2):\n");
fprintf("Linear: %.4f\n", adj_Rsquared);
fprintf("Stepwise: %.4f\n", adj_Rsquared_step);



