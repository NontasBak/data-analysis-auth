clc, clearvars, close all;

mu = 4;
var = 0.01;

rejectionProb = normcdf(3.9, mu, sqrt(var))

rejectionThreshold = norminv(0.01, mu, sqrt(var))