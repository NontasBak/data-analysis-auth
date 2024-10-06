clc, clearvars, close all;

lambda = 10;
n = 10000;
samples = 1000;

% Part a
X = exprnd(1 / lambda, n, 1);

maxLikelihood = mle(X, 'Distribution', 'Exponential')
expMean = mean(X)
% maxLikelihood is equal to poissonMean


% Part b
meanAvg = expMeans(lambda, samples, n)
% We can see that meanAvg is not always equal to lambda