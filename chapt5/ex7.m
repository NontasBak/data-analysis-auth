clc, clearvars, close all;

data = importdata("thermostat.dat");
R = data(:, 1); % Resistance
T = data(:, 2); % Temperature

X = log(R);
Y = 1./(T + 273.15);

% Part a
max_K = 4;
n = length(X);

for k = 1:max_K 
    p = polyfit(X, Y, k);
    Y_hat = polyval(p, X);

    e_i = Y - Y_hat;
    var_e = 1 / (n - (k + 1)) * sum(e_i.^2);
    e_i_star = e_i / sqrt(var_e);

    R_squared = 1 - (sum(e_i.^2)) / sum((Y - mean(Y)).^2);
    adj_Rsquared = 1 - ((n - 1) / (n - (k + 1))) * (sum(e_i.^2) / sum((Y - mean(Y)).^2));
    fprintf("For k = %d:\n", k)
    fprintf("R^2 = %.8f and adjR^2 = %.8f\n\n", R_squared, adj_Rsquared);

    figure(1);
    sgtitle("Diagnostic plots");
    subplot(2, 2, k);
    scatter(Y, e_i_star, 'filled');
    hold on;
    yline(2, '--', 'LineWidth', 1.5);
    yline(-2, '--', 'LineWidth', 1.5);
    yline(0, 'LineWidth', 1.5);
    ylim([-3, 3]);
    title("k = " + k);
    xlabel('y_i');
    ylabel('e_i^*');

    figure(2);
    sgtitle("Scatter plots and polynomial regression lines");
    subplot(2, 2, k);
    scatter(X, Y);
    hold on;
    plot(X, Y_hat);
    title("k = " + k);
end

fprintf("The best regression model seems to be k = 3\n");
fprintf("by taking into account the diagnostic plot, R^2 and adjR^2\n");

% --------------------------------------
% Part b

% Steinhart-Hart model:
k = 3;
p = polyfit(X, Y, k);
Y_hat_Hart = p(1)*(X.^3) + p(3)*X + p(4);

e_i_Hart = Y - Y_hat_Hart;
var_e = 1 / (n - (k + 1)) * sum(e_i_Hart.^2);
e_i_star_Hart = e_i_Hart / sqrt(var_e);

% Polynomial regression with k = 3 (best model):
p = polyfit(X, Y, k);
Y_hat = polyval(p, X);

e_i = Y - Y_hat;
n = length(X);
var_e = 1 / (n - (k + 1)) * sum(e_i.^2);
e_i_star = e_i / sqrt(var_e);

% Plot everything
figure(3);
sgtitle("Comparison between Steinhart-Hart and k = 3 polynomial");
subplot(2, 2, 1);
scatter(X, Y);
hold on;
plot(X, Y_hat_Hart);
title("Steinhart scatter plot");

subplot(2, 2, 2);
scatter(X, Y);
hold on;
plot(X, Y_hat);
title("k = 3");

subplot(2, 2, 3);
scatter(Y, e_i_star_Hart, 'filled');
hold on;
yline(2, '--', 'LineWidth', 1.5);
yline(-2, '--', 'LineWidth', 1.5);
yline(0, 'LineWidth', 1.5);
ylim([-3, 3]);
title("Steinhart diagnostic plot");
xlabel('y_i');
ylabel('e_i^*');

subplot(2, 2, 4);
scatter(Y, e_i_star, 'filled');
hold on;
yline(2, '--', 'LineWidth', 1.5);
yline(-2, '--', 'LineWidth', 1.5);
yline(0, 'LineWidth', 1.5);
ylim([-3, 3]);
title("k = 3 diagnostic plot");
xlabel('y_i');
ylabel('e_i^*');









