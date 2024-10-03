% Set the parameter lambda
lambda = 1;

% Generate 1000 uniformly distributed random numbers between 0 and 1
N = 1000;
uniform_random_numbers = rand(N, 1);

% Use the inverse transform method to generate exponential random numbers
exponential_random_numbers = -log(1 - uniform_random_numbers) / lambda;

% Create the histogram of the random numbers
histogram(exponential_random_numbers, 'Normalization', 'pdf'); % 'Normalization' set to 'pdf' for probability density

% Hold the plot to overlay the theoretical PDF
hold on;

% Define a range of x values for the theoretical PDF
x_values = linspace(0, max(exponential_random_numbers), 100);

% Calculate the theoretical exponential PDF
pdf_values = lambda * exp(-lambda * x_values);

% Plot the theoretical PDF on the same figure
plot(x_values, pdf_values, 'r', 'LineWidth', 2);

% Add labels and title
xlabel('x');
ylabel('Probability Density');
title('Exponential Distribution (\lambda = 1)');

% Add a legend
legend('Histogram of random numbers', 'Theoretical PDF');

% Release the hold on the plot
hold off;
