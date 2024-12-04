% Load solar intensity data
load('solar_intensity_data.mat');

% Define solar panel efficiency (constant)
panel_efficiency = 0.2; % 20% efficiency

% Define a range of panel areas for analysis
panel_area_range = 1:0.5:10; % Panel areas from 1 m² to 10 m² in 0.5 m² steps

% Initialize a matrix for electrical power output
electrical_power_matrix = zeros(length(panel_area_range), length(time));

% Compute electrical power for each panel area
for i = 1:length(panel_area_range)
    electrical_power_matrix(i, :) = solar_intensity * panel_efficiency * panel_area_range(i);
end

% Create a contour plot
figure;
contourf(time, panel_area_range, electrical_power_matrix, 20, 'LineColor', 'none');
colorbar; % Add a color bar to indicate power levels
xlabel('Time (hours)');
ylabel('Panel Area (m^2)');
title('Contour Plot of Electrical Power Output');
colormap('jet'); % Use a visually distinct colormap

% Save the data for use in the next video
save('electrical_power_contour_data.mat', 'time', 'panel_area_range', 'electrical_power_matrix');
