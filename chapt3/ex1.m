clc, clearvars, close all;

lambda = 7;
n = 1000;
M = 100;

% Part a
X = poissrnd(lambda, n, 1);

maxLikelihood = mle(X, 'Distribution', 'Poisson');
poissonMean = mean(X);
fprintf('Poisson mean: %.4f and max likelihood estimate: %.4f\n', poissonMean, maxLikelihood);

% Part b
meanAvg = poissonMeans(lambda, M, n);
fprintf('For n = %d, M = %d and lambda = %d we have mean average = %.4f\n', n, M, lambda, meanAvg);
% We can see that meanAvg is not always equal to lambda

function meanAvg = poissonMeans(lambda, M, n)
    X = poissrnd(lambda, M, n);
    Xmeans = zeros(M, 1);
    
    for i = 1:M
        Xmeans(i) = mean(X(i, :));
    end

    histogram(Xmeans)
    xlabel('mean')
    hold on;
    
    meanAvg = mean(Xmeans);
    xline(meanAvg, 'r', 'LineWidth', 1.5);
    legend('mean(X)', 'Mean Average');
end