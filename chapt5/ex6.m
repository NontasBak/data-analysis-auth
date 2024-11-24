clc, clearvars, close all;

X = [2, 3, 8, 16, 32, 48, 64, 80];
Y = [98.2, 91.7, 81.3, 64.0, 36.4, 32.6, 17.1, 11.3];
n = length(X);

% Helper function at the bottom
[e_i_star, b0, b1] = calculateStatistics(X, Y);
Y_leastSquares = b0 + b1*X;

% Scatter plot & regression line
figure(1);
subplot(2, 1, 1);
scatter(X, Y);
hold on;
plot(X, Y_leastSquares)
title("Scatter plot and regression line");

% Display diagnostic plot (to check if linear model is not the best)
subplot(2, 1, 2);
scatter(Y, e_i_star, 'filled');
hold on;
yline(2, '--', 'LineWidth', 1.5);
yline(-2, '--', 'LineWidth', 1.5);
yline(0, 'LineWidth', 1.5);
ylim([-3, 3]);
title('Diagnostic plot');
xlabel('y_i');
ylabel('e_i^*');

% Our data is probably not linear, but it might be intrinsically linear.
% Let's convert it to linear in the order below:
titles = ["Exponential", "Power", "Logarithmic", "Inverse"];
Y_values = [log(Y); log(Y); Y; Y];
X_values = [X; log(X); log(X); 1./X];

for i = 1:4
    [e_i_star, b0, b1] = calculateStatistics(X_values(i, :), Y_values(i, :));

    % Y_line will be used to display the regression line in the original
    % scatter plot
    switch i
        case 1
            Y_line = exp(b0) * exp(b1 * X);
        case 2
            Y_line = exp(b0) * X.^b1;
        case 3
            Y_line = b0 + b1 * log(X);
        case 4
            Y_line = b0 + b1./X;
    end

    % Display the scatter plots and the regression lines
    figure(2);
    subplot(2, 2, i);
    scatter(X, Y);
    hold on;
    plot(X, Y_line);
    title(titles(i) + " regression");

    % Display diagnostic plots
    figure(3);
    subplot(2, 2, i);
    scatter(Y_values(i, :), e_i_star, 'filled');
    hold on;
    yline(2, '--', 'LineWidth', 1.5);
    yline(-2, '--', 'LineWidth', 1.5);
    yline(0, 'LineWidth', 1.5);
    ylim([-3, 3]);
    title('Diagnostic plot: ' + titles(i));
    xlabel('y_i');
    ylabel('e_i^*');
end

function [e_i_star, b0, b1] = calculateStatistics(X, Y)
    n = length(X);
    var_Y = var(Y);
    var_X = var(X);
    cov_XY = cov(X, Y);
    cov_XY = cov_XY(1,2);
    var_e = ((n-1) / (n-2)) * (var_Y - (cov_XY^2 / var_X));
    
    b1 = cov_XY / var_X;
    b0 = mean(Y) - b1 * mean(X);
    Y_leastsquares = b0 + b1*X;
    
    e_i = Y - Y_leastsquares;
    e_i_star = e_i / sqrt(var_e);
end


    






