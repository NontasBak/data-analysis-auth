clc, clearvars, close all;

n = round(linspace(10, 10000));
%n = [10, 100, 1000 10000];
intervals = [1, 2; 0, 1; -1, 1];
E_oneOverX = zeros(length(n), length(intervals));
oneOverEX = zeros(length(n), length(intervals));

for i = 1:length(intervals)
    interval_start = intervals(i, 1);
    interval_end = intervals(i, 2);
    
    for j = 1:length(n)
        X = interval_start + (interval_end - interval_start) * rand(n(j), 1);

        E_oneOverX(j, i) = mean(1./X);
        oneOverEX(j, i) = 1 / mean(X);
    end
end

for i = 1:length(intervals)
    subplot(length(intervals), 1, i);
    plot(n, E_oneOverX(:, i), 'LineWidth', 1.5);
    hold on;
    plot(n, oneOverEX(:, i), 'LineWidth', 1.5);

    title(['Interval [', num2str(intervals(i, 1)), ', ', num2str(intervals(i, 2)), ']']);
    xlabel('n');
    legend('E[1/X]', '1/E[X]')
end

