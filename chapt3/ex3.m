clc, clearvars, close all;

mu = 15; % mean
n = [5, 100]; % sample size
M = 1000; % samples

% 1st method
count = zeros(2, 1);
for i = 1:length(n)
    for j = 1:M
        X = exprnd(mu, n(i), 1);
        h = ttest(X, mu);
        
        if h == 0
            count(i) = count(i) + 1;
        end
    end

    output = 'Percent true mean inside 95%% confidence interval for n = %i: %.1f%%\n';
    fprintf(output, n(i), count(i) * 100 / M)
end

fprintf('\nDifference between n = 100 and n = 5: %.1f%%\n', (count(2) - count(1)) * 100 / M)


% % 2nd method
% alpha = 0.05;              
% t = tinv([alpha/2  1-alpha/2], n_small - 1);     
% ci = mean(X) + t * (std(X) / sqrt(n_small)) % Confidence Interval
% 
% if mu > ci(1) && mu < ci(2)
%     disp('Null hypothesis not rejected')
% else
%     disp('Null hypothesis rejected')
% end


% % 3rd method
% alpha = 0.05;            
% t = tinv([alpha/2  1-alpha/2], n_small - 1)     
% t_sample = (mean(X) - mu) / (std(X) / sqrt(n_small))
% 
% if t_sample > t(1) && t_sample < t(2)
%     disp('Null hypothesis not rejected')
% else
%     disp('Null hypothesis rejected')
% end