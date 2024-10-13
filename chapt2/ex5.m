clc, clearvars, close all;

mu = 4;
var = 0.01;

rejectionProb = normcdf(3.9, mu, sqrt(var));
fprintf('Probability of iron bar getting destroyed: %.4f%%\n', rejectionProb * 100);

rejectionThreshold = norminv(0.01, mu, sqrt(var));
fprintf('New lower threshold so up to 1%% of iron bars are destoyed: %.4f\n', rejectionThreshold);