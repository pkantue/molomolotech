## Key Concepts
- Variables and arrays in MATLAB.
- Basic mathematical operations and sine functions.
- Plotting and visualizing data.
- Saving data for future use.

## Code
% Define time (in hours) over a 24-hour period
time = 0:0.1:24; % Time vector in increments of 0.1 hours

% Simulate solar intensity (kW/m^2)
% The sine function is shifted to peak at noon (12 PM) and clipped to zero at night
solar_intensity = max(0, sin((pi/12) * time - pi/2)); % Peaks at 1 kW/m^2

% Scale solar intensity to a realistic maximum value
max_intensity = 1; % Assume max solar intensity is 1 kW/m^2
solar_intensity = solar_intensity * max_intensity;

% Plot the solar intensity curve
figure;
plot(time, solar_intensity, 'LineWidth', 2);
xlabel('Time (hours)');
ylabel('Solar Intensity (kW/m^2)');
title('Simulated Solar Intensity Over a 24-Hour Period');
grid on;

% Display the solar intensity vector
disp('Solar Intensity (kW/m^2):');
disp(solar_intensity);
