clc, clearvars, close all;

N = 1000;
randomNumsUniform = rand(N, 1);
lambda = 1;

randomNumsExp = (-1/lambda)*log(1-randomNumsUniform);

histfit(randomNumsExp, 30, 'exponential');
hold on;

x = linspace(0, max(randomNumsExp));
exp_pdf = lambda*exp(-lambda * x);
plot(x, exp_pdf, 'LineWidth', 2);
