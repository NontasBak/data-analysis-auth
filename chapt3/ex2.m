clc, clearvars, close all;

lambda = 10;
n = 1000;
M = 100;

% Part a
X = exprnd(1 / lambda, n, 1);

maxLikelihood = mle(X, 'Distribution', 'Exponential');
expMean = mean(X);
fprintf('Exp. mean: %.4f and max likelihood estimate: %.4f\n', expMean, maxLikelihood);

% Part b
meanAvg = expMeans(lambda, M, n);
fprintf('For n = %d, M = %d, lambda = %d, mu = %.1f we have mean average = %.4f\n', n, M, lambda, 1/lambda, meanAvg);
% We can see that meanAvg is not always equal to lambda

function meanAvg = expMeans(lambda, M, n)
    X = exprnd(1 / lambda, M, n);
    Xmeans = zeros(M, 1);
    
    for i = 1:M
        Xmeans(i) = mean(X(i));
    end

    histogram(Xmeans)
    xlabel('mean')
    hold on;
    
    meanAvg = mean(Xmeans);
    xline(meanAvg, 'r', 'LineWidth', 1.5);
    legend('mean(X)', 'Mean Average');
end