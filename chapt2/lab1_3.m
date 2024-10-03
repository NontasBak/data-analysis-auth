clc, clearvars, close all;

mu = [1, 2];
Sigma = [1, 0.5; 0.5, 1];

R = mvnrnd(mu, Sigma, 100000);

X = R(:, 1);
Y = R(:, 2);

var_X = var(X) % Approx. equal to 1
var_Y = var(Y) % Approx. equal to 1
var_XY = var(X + Y) % Approx. equal to 3

% Var_XY != Var_X + Var_Y



