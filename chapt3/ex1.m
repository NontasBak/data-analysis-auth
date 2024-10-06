clc, clearvars, close all;

lambda = 7;
n = 10000;
samples = 1000;

% Part a
X = poissrnd(lambda, n, 1);

maxLikelihood = mle(X, 'Distribution', 'Poisson')
poissonMean = mean(X)
% maxLikelihood is equal to poissonMean


% Part b
meanAvg = poissonMeans(lambda, samples, n)
% We can see that meanAvg is not always equal to lambda