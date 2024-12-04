% Solar Energy Simulation
clc; clear; close all;

% Define time (hours in a day)
time = 0:0.1:24; % 0 to 24 hours in increments of 0.1

% Simulate solar intensity using a sine wave
solar_intensity = max(0, sin((pi/12) * time - pi/2)); % Peaks at noon

% Plot solar intensity
figure;
plot(time, solar_intensity, 'LineWidth', 2);
xlabel('Time (hours)');
ylabel('Solar Intensity (kW/m^2)');
title('Simulated Solar Intensity Over a Day');
grid on;

% Save data for later use
save('solar_intensity_data.mat', 'time', 'solar_intensity');
