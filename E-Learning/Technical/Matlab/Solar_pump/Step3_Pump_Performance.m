% Load contour data from Video 2
load('electrical_power_contour_data.mat'); % Contains time, panel_area_range, and electrical_power_matrix

% Define pump parameters
pump_efficiency = 0.6; % 60% efficiency
flow_rate_per_kW = 50; % 50 liters per kWh

% Introduce random noise to the electrical power matrix
rng(1); % Set random seed for reproducibility
noise = 0.1 * randn(size(electrical_power_matrix)); % Add Gaussian noise
electrical_power_noisy = max(0, electrical_power_matrix + noise); % Ensure no negative power

% Calculate water flow rate matrix
water_flow_rate_matrix = electrical_power_noisy * pump_efficiency * flow_rate_per_kW; % liters per hour

% Visualize water flow rate for a specific panel area using plotyy
specific_area_index = 5; % Select a panel area index (e.g., panel_area_range(5))
specific_area = panel_area_range(specific_area_index);

% Extract data for the selected panel area
power_at_area = electrical_power_noisy(specific_area_index, :); % Electrical power over time
flow_rate_at_area = water_flow_rate_matrix(specific_area_index, :); % Water flow rate over time

% Create dual-axis plot
figure;
[ax, h1, h2] = plotyy(time, power_at_area, time, flow_rate_at_area);

% Customize appearance for electrical power
set(h1, 'LineWidth', 2, 'Color', 'r');
ylabel(ax(1), 'Electrical Power (kW)');
set(ax(1), 'YColor', 'r');

% Customize appearance for water flow rate
set(h2, 'LineWidth', 2, 'Color', 'b');
ylabel(ax(2), 'Water Flow Rate (L/h)');
set(ax(2), 'YColor', 'b');

% Add common labels and title
xlabel('Time (hours)');
title(['Electrical Power vs Water Flow Rate (Panel Area = ', num2str(specific_area), ' m^2)']);
grid on;

% Save final simulation data
save('water_flow_contour_based_data.mat', 'time', 'panel_area_range', 'water_flow_rate_matrix', 'electrical_power_noisy');