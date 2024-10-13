clc, clearvars, close all;

n = 100;
N = 10000;
Y = zeros(N, 1);

for i = 1:N
    X = rand(n, 1);
    Y(i) = mean(X);
end

histfit(Y, 30, 'Normal');
