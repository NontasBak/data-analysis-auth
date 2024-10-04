clc, clearvars, close all;

lambda = 7;
n = 10000;
samples = 1000;

% PART a
X = exprnd(lambda, n, 1);

maxLikelihood = mle(X, 'Distribution', 'Exponential')
expMean = mean(X)
% maxLikelihood is equal to poissonMean


% PART b
meanAvg = expMeans(lambda, samples, n)
% We can see that meanAvg is not always equal to lambda