clc, clearvars, close all;

lightAir_data = importdata('lightair.dat');

X = lightAir_data(:, 1);
Y = lightAir_data(:, 2) + 299000;

% -------------------------------------------
% Part a
r = corrcoef(X, Y);
r = r(1,2);

figure(1);
scatter(X, Y);
title("Scatter plot with r = " + num2str(r));
xlabel("Air density (kg/m^3)");
ylabel("Speed of light (km/sec)");

% -------------------------------------------
% Part b
% Find b1 and b0
cov_XY = cov(X, Y);
cov_XY = cov_XY(1,2);
var_X = var(X);
b1 = cov_XY / var_X;
b0 = mean(Y) - b1 * mean(X);

% Find var_e (s_e ^2)
var_Y = var(Y);
n = length(X);
var_e = ((n-1)/(n-2)) * var_Y * (1 - r^2);

% Find std_b1 and std_b0
S_xx = var_X * (n-1);
std_b1 = sqrt(var_e) / sqrt(S_xx);
std_b0 = sqrt(var_e) * sqrt((1 / n) + mean(X)^2 / S_xx);

% Find c.i.
alpha = 0.05;
t_critical = tinv(1 - alpha/2, n-2);
ci_b1 = [b1 - t_critical * std_b1, b1 + t_critical * std_b1];
ci_b0 = [b0 - t_critical * std_b0, b0 + t_critical * std_b0];
fprintf("95%% C.I. for b1: [%.2f, %.2f]\n", ci_b1(1), ci_b1(2));
fprintf("95%% C.I. for b0: [%.2f, %.2f]\n", ci_b0(1), ci_b0(2));

% -------------------------------------------
% Part c
X = X';
x_mean = mean(X);
prediction_limits_yMean = [(b0+b1*X) - t_critical*sqrt(var_e)*sqrt((1/n) + (X-x_mean).^2 / S_xx);
                            (b0+b1*X) + t_critical*sqrt(var_e)*sqrt((1/n) + (X-x_mean).^2 / S_xx)];
prediction_limits_yValue = [(b0+b1*X) - t_critical*sqrt(var_e)*sqrt(1+(1/n) + (X-x_mean).^2 / S_xx);
                             (b0+b1*X) + t_critical*sqrt(var_e)*sqrt(1+(1/n) + (X-x_mean).^2 / S_xx)];
x0 = 1.29;
y_hat = b0 + b1*x0;
prediction_limits_yMean_x0 = [(b0+b1*x0) - t_critical*sqrt(var_e)*sqrt((1/n) + (x0-x_mean).^2 / S_xx);
                            (b0+b1*x0) + t_critical*sqrt(var_e)*sqrt((1/n) + (x0-x_mean).^2 / S_xx)];
prediction_limits_yValue_x0 = [(b0+b1*x0) - t_critical*sqrt(var_e)*sqrt(1+(1/n) + (x0-x_mean).^2 / S_xx);
                             (b0+b1*x0) + t_critical*sqrt(var_e)*sqrt(1+(1/n) + (x0-x_mean).^2 / S_xx)];

fprintf("\nFor x = 1.29, y mean C.I.: [%.2f, %.2f]\n", prediction_limits_yMean_x0(1), prediction_limits_yMean_x0(2));
fprintf("For x = 1.29, y observation C.I.: [%.2f, %.2f]\n", prediction_limits_yValue_x0(1), prediction_limits_yValue_x0(2));

hold on;
plot(X, b0+b1*X);
plot(X, prediction_limits_yMean);
plot(X, prediction_limits_yValue);
plot(x0, prediction_limits_yMean_x0, 'd', 'Color', 'r', 'LineWidth', 2);
plot(x0, prediction_limits_yValue_x0, 'd', 'Color', 'magenta', 'LineWidth', 2);

% -------------------------------------------
% Part d
b0_real = 299792.458;
b1_real = -299792.458 * 0.00029 / 1.29;

if b0_real < ci_b0(1) || b0_real > ci_b0(2)
    fprintf("\nReal b0 not accepted.\n");
else
    fprintf("\nReal b0 accepted.\n");
end

if b1_real < ci_b1(1) || b1_real > ci_b1(2)
    fprintf("Real b1 not accepted.\n");
else
    fprintf("Real b1 accepted.\n");
end

y_real = b0_real + b1*X;

hold on;
plot(X, y_real, 'Color', 'black', 'LineWidth', 1);
% ✓ The line is between the prediction limits of yMean






