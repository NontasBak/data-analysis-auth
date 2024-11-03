clc, clearvars, close all;

length_std = 5;
width_std = 5;
length = 500;
width = 300;

% Part a
% Area = Length * Width = L * W
% and L,W independent so we take the formula
% area_std = sqrt(Σ(df/dx)^2 * std_x^2)
area_std = sqrt(width^2 * length_std^2 + length^2 * width_std^2);
fprintf("Uncertainty of area: %.2fm^2\n", area_std)

% There are infinite pairs (length, width) that satisfy the above equation

% -----------------------------------------
% Part b

l_values = 10:40:1000;
w_values = 10:40:1000;

[l_grid, w_grid] = meshgrid(l_values, w_values);
area_std_grid = sqrt(w_grid.^2 * length_std^2 + l_grid.^2 * width_std^2);

surf(l_grid, w_grid, area_std_grid);
xlabel("Length");
ylabel("Width");
zlabel("Uncertainty of area");