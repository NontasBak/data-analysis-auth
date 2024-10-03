clc, clearvars, close all;

n = 100;
N = 10000;
Y = zeros(N, 1);

for i = 1:N
    Y(i) = mean(rand(n, 1));
end

histogram(Y, 'Normalization', 'pdf')
hold on;

x = [min(Y) : .001 : max(Y)];
y = normpdf(x, mean(Y), sqrt(var(Y)));
plot(x, y, 'LineWidth', 2);
