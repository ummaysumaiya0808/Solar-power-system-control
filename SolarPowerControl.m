
% Define system parameters
solar_panel_power = 100; %  Watts
battery_capacity = 500;  %  Watt-hours
charge_rate = 50;       %  Watts
discharge_rate = 25;    %  Watts
max_battery_voltage = 18; %  Volts

% Initialize variables
battery_voltage = max_battery_voltage;
battery_charge = 0; % At the initial point

% Simulate the system for a day
time = 1:24; % Segment them among 24 hours
for hour = time
    % Calculate available solar power during this hour (you can use a more realistic solar power model)
    available_solar_power = solar_panel_power * (1 - 0.1 * (hour - 12)^2);

    % Calculate the battery state of charge (SOC)
    battery_charge = battery_charge + (available_solar_power - discharge_rate);
    
    % Ensure the battery charge doesn't exceed its capacity
    battery_charge = min(battery_charge, battery_capacity);
    
    % Ensure the battery charge doesn't drop below 0
    battery_charge = max(battery_charge, 0);
    
    % Calculate battery voltage based on charge and capacity
    battery_voltage = max_battery_voltage * (battery_charge / battery_capacity);
    
    % Check if the battery is fully charged and limit the charging rate
    if battery_charge == battery_capacity
        charge_rate = 0;
    else
        charge_rate = 50;
    end
    
    % Check if the battery is fully discharged and limit the discharging rate
    if battery_charge == 0
        discharge_rate = 0;
    else
        discharge_rate = 30;
    end
    
    % Print the status at each hour
    fprintf('Hour %d - Battery SOC: %.2f%%, Battery Voltage: %.2fV\n', hour, (battery_charge / battery_capacity) * 100, battery_voltage);
end
