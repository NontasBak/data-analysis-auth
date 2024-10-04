function meanAvg = expMeans(lambda, samples, n)
    X = exprnd(lambda, samples, n);
    Xmeans = zeros(samples, 1);
    
    for i = 1:samples
        Xmeans(i) = mean(X(i));
    end

    histogram(Xmeans)
    xlabel('mean')
    hold on;
    
    meanAvg = mean(Xmeans);
    xline(meanAvg, 'r', 'LineWidth', 1.5);
    legend('mean(X)', 'Mean Average');
end

