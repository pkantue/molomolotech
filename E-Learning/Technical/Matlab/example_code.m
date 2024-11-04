% Load data from a website (e.g., a CSV with climate data)
url = 'https://example.com/climate_data.csv';
opts = detectImportOptions(url);
x = readtable(url, opts);

% Extract data for rainfall, temperature, and humidity
r = x{:, 2}; % Rainfall data
t = x{:, 3}; % Temperature data
h = x{:, 4}; % Humidity data

% Predict crop yield using a basic linear model
a = 0.5;
b = 1.2;
c = 0.8;

y = a*r + b*t + c*h; % Crop yield prediction

% Plot the predicted yield
figure;
plot(y);
title('Predicted Crop Yield');
xlabel('Time');
ylabel('Yield');
