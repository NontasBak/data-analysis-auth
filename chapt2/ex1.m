clc, clearvars, close all;

coinTosses = linspace(10, 100000, 1000);
probability = zeros(length(coinTosses), 1);

for i = 1:length(coinTosses)
    successCount = 0;
    for j = 1:coinTosses(i)
        if(rand() >= 0.5)
            successCount = successCount + 1;
        end
    end

    probability(i) = successCount / coinTosses(i);
end

plot(coinTosses, probability, '*')
xlabel('coin tosses')
ylabel('probability')
